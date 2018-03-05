/*
 * Author: jaynus / nou, PabstMirror; rewrite- LorenLuke
 * Do seeker search
 * Handles a nil/bad return and will attempt to use last known position if enabled on ammo
 *
 * Arguments:
 * 0: Args <ARRAY>
 * 0-0: Unit <OBJECT>
 * 0-1: starting pos(ASL) <ARRAY> 
 * 0-2: weapon/launcher vector <ARRAY>
 * 0-3: sensor focus vector <ARRAY>
 * 1: feedbackArray <NUMBER>
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

params ["_args", "_feedback"];
_args params ["_source", "_posASL", "_dir", "_focusDir"];

//feedback parameters
//should all be defined from preGuidance PFH
_feedback params ["_timeParams", "_seekerParams", "_attackProfileParams", "_ancInfo", "_shooterParams"];
_timeParams params ["_lastFrameTime", "_lastTime", "_timeDelta", "_timeModulus", "_timeModulusThreshold"];
_seekerParams params ["_seekerName", "_seekerAngle", "_seekerMaxRange", "_seekerHeadMaxAngle", "_seekerHeadMaxTraverse", "_seekerHead"];
_seekerHead params ["_seekerHeadX", "_seekerHeadY", "_seekerHeadUncaged"];

_attackProfileParams params ["_attackProfileName", "_lastPosState", "_deflectionParameters", "_attackProfileMisc"];
_lastPosState params ["_seekLastTargetPos", "_lastKnownTargetPos"];
_deflectionParameters params ["_minDeflection", "_maxDeflection", "_incDeflection", "_dlyDeflection", "_curDeflection"];
_attackProfileMisc params ["_angleToTarget", "_lastDeviation"];
_angleToTarget params ["_angleX", "_angleY"];
_lastDeviation params ["_deviationX", "_deviationY"];

_ancInfo params ["_ancInfoSeeker", "_ancInfoAttackProfile"];

_shooterParams params ["_shooterUnit", "_shooterVehicle", "_shooterWeapon", "_shooterMagazine", "_flyVector"];

private _seekerFunction = getText (configFile >> QGVAR(SeekerTypes) >> _seekerName >> "functionName");

//Adjusted vector = seeker direction vector

private _adjustedVector = [_dir, [0,0,1], -_seekerHeadX] call FUNC(rotateVector);
_adjustedVector = [_adjustedVector, _adjustedVector vectorCrossProduct [0,0,1], _seekerHeadY] call FUNC(rotateVector);

//private _adjustedVector = [_dir, [0,0,1], -_angleX] call FUNC(rotateVector);
//hint format ["%1", _dir];
//_adjustedVector = [_adjustedVector, _adjustedVector vectorCrossProduct [0,0,1], _angleY] call FUNC(rotateVector);

//
//NEEEEEED PROVISIONS FOR WHEN SEEKER FOCUS VECTOR ISN'T IN SEEKER SCOPE
//

private _seekerTargetPos = ([[_source, _posASL, _adjustedVector, _focusDir], _feedback] call (missionNamespace getVariable _seekerFunction));
//private _seekerTargetPos = _this call (missionNamespace getVariable _seekerFunction);

if ((isNil "_seekerTargetPos") || {_seekerTargetPos isEqualTo [0,0,0]}) then { 
// A return of nil or [0,0,0] indicates the seeker has no target

    if (_seekLastTargetPos && {!(_lastKnownTargetPos isEqualTo [0,0,0])}) then { 
    // if enabled for the ammo, use last known position if we have one stored

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
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [1,0,0,1], ASLtoAGL (_posASL vectorAdd (_dir vectorMultiply (_posASL distance _seekerTargetPos))) , 0.5, 0.5, 0, "aimPos", 1, 0.025, "TahomaB"];
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0,1,0,1], ASLtoAGL _seekerTargetPos, 0.5, 0.5, 0, "target", 1, 0.025, "TahomaB"];
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0,0,1,1], ASLtoAGL (_posASL vectorAdd (_adjustedVector vectorMultiply (_posASL distance _seekerTargetPos))) , 0.5, 0.5, 0, "seeker", 1, 0.025, "TahomaB"];

#endif

TRACE_2("return",_seekerTargetPos,_seekerTypeName);

private _newSeekerHeadX = 0;
private _newSeekerHeadY = 0;

//turn seeker head towards target if we can.
private _unitScalar = ((_timeDelta) * _seekerHeadMaxTraverse);
//if ( (_seekerHeadMaxAngle > 0) && (_seekerHeadUncaged) && (!(_seekerTargetPos isEqualTo [0,0,0])) ) then {
if ( (_seekerHeadMaxAngle > 0) && (!(_seekerTargetPos isEqualTo [0,0,0])) ) then {
	_adjBearing = (_adjustedVector select 0) atan2 (_adjustedVector select 1);
    _adjPitch = (_adjustedVector select 2) atan2 sqrt((_adjustedVector select 0)^2 + (_adjustedVector select 1)^2);

    _toTarget = _seekerTargetPos vectorDiff _posASL;
	private _toTargetBearing = (_toTarget select 0) atan2 (_toTarget select 1);
	private _toTargetPitch = (_toTarget select 2) atan2 sqrt((_toTarget select 0)^2 + (_toTarget select 1)^2);
    
    private _rotBearing = _toTargetBearing - _adjBearing;  
    private _rotPitch = _toTargetPitch - _adjPitch;

    private _rotPolar = _rotBearing atan2 _rotPitch;
    
	_newSeekerHeadX = _seekerHeadX + ((_rotBearing ) min (sin(_rotPolar) * _unitScalar));
	_newseekerHeadY = _seekerHeadY + ((_rotPitch ) min (cos(_rotPolar) * _unitScalar));

    if( sqrt( ((_newSeekerHeadX)^2) + ((_newSeekerHeadY)^2) ) > (_seekerHeadMaxAngle - (_seekerAngle / 2)) ) then {
        _newSeekerheadX = (_seekerHeadMaxAngle - (_seekerAngle / 2)) * sin(_rotPolar);
        _newSeekerHeadY = (_seekerHeadMaxAngle - (_seekerAngle / 2)) * cos(_rotPolar);
    };
   
    if (abs(_newSeekerHeadX + _newseekerHeadY) > 0) then {

	    _lastDeviation set [0, _newSeekerHeadX - _angleX];
	    _lastDeviation set [1, _newseekerHeadY - _angleY];
        _angleToTarget set [0, _newSeekerHeadX];
        _angleToTarget set [1, _newseekerHeadY];

    };

};

//    hint format ["%1, %2\n%3, %4\n%5, %6\n%7, %8", _lastDeviation select 0, _lastDeviation select 1, _angleToTarget select 0, _angleToTarget select 1, _seekerHeadX, _seekerHeadY];
_seekerHead set [0, _newSeekerHeadX];
_seekerHead set [1, _newSeekerHeadY];


_seekerTargetPos;

