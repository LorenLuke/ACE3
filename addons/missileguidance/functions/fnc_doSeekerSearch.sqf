/*
 * Author: jaynus / nou, PabstMirror; rewrite- LorenLuke
 * Do seeker search
 * Handles a nil/bad return and will attempt to use last known position if enabled on ammo
 *
 * Arguments:
 * 1: Guidance Arg Array <ARRAY>
 * 3: Last known pos state array <ARRAY>
 *
 * Return Value:
 * Missile Aim PosASL <ARRAY>
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_seekerType_Optic;
 *
 * Public: No
 */
 

 ///Seeker Feedback array [_seekerHeadX, _seekerHeadY]
 ///_attackProfileFeedbackArray = []
 
// #define DEBUG_MODE_FULL
#define DRAW_GUIDANCE_INFO
#include "script_component.hpp"

//parameters
//should all be defined from pre/Guidance PFH

params ["_args", "_feedback"];
_args params ["_source", "_posASL", "_dir", "_focusDir"];
_feedback params ["_timeParams", "_seekerParams", "_attackProfileParams", "_ancInfo"];
_timeParams params ["_lastRunTime", "_timeDelta", "_timeModulus", "_timeModulusThreshold"];
_seekerParams params ["_seekerName", "_seekerAngle", "_seekerMaxRange", "_seekerHeadMaxAngle", "_seekerHeadMaxTraverse", "_seekerHead"];
_seekerHead params ["_seekerHeadX", "_seekerHeadY", "_seekerHeadUncaged"];

_attackProfileParams params ["_attackProfileName", "_lastPosState", "_deflectionParameters", "_attackProfileMisc"];
_lastPosState params ["_seekLastTargetPos", "_lastKnownTargetPos"];
_deflectionParameters params ["_minDeflection", "_maxDeflection", "_incDeflection", "_dlyDeflection", "_curDeflection"];
_attackProfileMisc params ["_angleToTarget", "_lastDeviation"];
_angleToTarget params ["_angleX", "_angleY"];
_lastDeviation params ["_deviationX", "_deviationY"];

_ancInfo params ["_ancInfoSeeker", "_ancInfoAttackProfile"];

hintSilent format ["%1\n%2\n%3\n%4",_timeParams, _seekerParams, _attackProfileParams, _ancInfo];
_seekerhead set [0, -2];
_seekerhead set [1, 0];

private _seekerFunction = getText (configFile >> QGVAR(SeekerTypes) >> _seekerName >> "functionName");


//Adjusted vector = seeker direction vector
private _adjustedVector = [_dir, [0,0,1], -_seekerHeadX] call FUNC(rotateVector);
_adjustedVector = [_adjustedVector, _adjustedVector vectorCrossProduct [0,0,1], -_seekerHeadY] call FUNC(rotateVector);


private _seekerTargetPos = ([[_source, _posASL, _adjustedVector, _focusDir], _feedback] call (missionNamespace getVariable _seekerFunction));
//private _seekerTargetPos = _this call (missionNamespace getVariable _seekerFunction);


if ((isNil "_seekerTargetPos") || {_seekerTargetPos isEqualTo [0,0,0]}) then { // A return of nil or [0,0,0] indicates the seeker has no target
    if (_seekLastTargetPos && {!(_lastKnownTargetPos isEqualTo [0,0,0])}) then { // if enabled for the ammo, use last known position if we have one stored
        _seekerTargetPos = _lastKnownTargetPos;
        #ifdef DRAW_GUIDANCE_INFO
//        drawIcon3D ["\A3\ui_f\data\map\markers\military\unknown_CA.paa", [1,1,0,1], ASLtoAGL _lastKnownPos, 0.25, 0.25, 0, "LastKnownPos", 1, 0.02, "TahomaB"];
        #endif
    } else {
        _seekerTargetPos = [0,0,0];
    };
} else {
    _lastPosState set [1, _seekerTargetPos];
};

#ifdef DRAW_GUIDANCE_INFO
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0,1,0,1], ASLtoAGL _seekerTargetPos, 0.5, 0.5, 0, _seekerName, 1, 0.025, "TahomaB"];
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0,0,1,1], ASLtoAGL (_seekerTargetPos vectorAdd (_dir vectorMultiply (_posASL distance _seekerTargetPos))) , 0.5, 0.5, 0, _seekerName, 1, 0.025, "TahomaB"];
#endif

TRACE_2("return",_seekerTargetPos,_seekerTypeName);



//turn seeker head
private _unitScalar = ((_timeDelta) * _seekerHeadMaxTraverse);
if ( (_seekerHeadMaxAngle > 0) && (_seekerHeadUncaged) && (!(_seekerTargetPos isEqualTo [0,0,0])) ) then {

	private _adjBearing = (_adjustedVector select 0) atan2 (_adjustedVector select 1);
	private _adjPitch = asin((vectorNormalized _adjustedVector) select 2);

	private _toTarget = _posASL vectorFromTo _seekerTargetPos;
	_toTarget = [_toTarget, [0,0,1], _adjBearing] call FUNC(rotateVector);
	_toTarget = [_toTarget, _toTarget vectorCrossProduct [0,0,1], _adjPitch] call FUNC(rotateVector);

	private _toTargetBearing = (_toTarget select 0) atan2 (_toTarget select 1);
	private _toTargetPitch = (asin((vectorNormalized _toTarget) select 2)) -_seekerHeadY;
	_lastDeviation set [0, _angleX];
	_lastDeviation set [1, _angleY];
	_angleToTarget set [0, _toTargetBearing];
	_angleToTarget set [1, _toTargetPitch];
	
	private _toTargetPolar = _toTargetBearing atan2 _toTargetPitch;

	hint format ["adj: %1\ntotarget: %2\nseeker: %3",_adjPitch,_toTargetPitch, _seekerheadY];	
	
	_seekerHeadX = _seekerHeadX + ((_toTargetBearing ) min (sin(_toTargetPolar) * _unitScalar));
	_seekerHeadY = _seekerHeadY + ((_toTargetPitch ) min (cos(_toTargetPolar) * _unitScalar));

	//seekerhead has x field of view, or x/2 to one side, so total angle should be max traverse + x/2


};

if ((_angleX + _angleY) > 0) then {
	_seekerHeadX = _seekerHeadX + (_angleX * _unitScalar / 3);
	_seekerHeadY = _seekerHeadY + (_angleY * _unitScalar / 3);
	_lastDeviation set [0, 0];
	_lastDeviation set [1, 0];
	
};


if( sqrt( ((_seekerHeadX)^2) + ((_seekerHeadY)^2) ) > (_seekerHeadMaxAngle - (_seekerAngle / 2)) ) then {
	private _polarAngle = _seekerHeadX atan2 _seekerHeadY;
	_seekerheadX = (_seekerHeadMaxAngle - (_seekerAngle / 2)) * sin(_polarAngle);
	_seekerHeadY = (_seekerHeadMaxAngle - (_seekerAngle / 2)) * cos(_polarAngle);
};



_seekerHead set [0, _seekerHeadX];
_seekerHead set [1, _seekerHeadY];


_seekerTargetPos;
