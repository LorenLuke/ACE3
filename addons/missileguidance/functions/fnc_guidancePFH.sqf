/*
 * Author: jaynus / nou
 * Guidance Per Frame Handler
 *
 * Arguments:
 * 0: Guidance Arg Array <ARRAY> 
 * 0-0: Fired Event Handler <ARRAY>
 * 0-1: Feedback Array <ARRAY>
 * 1: PFID <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[], 0] call ace_missileguidance_fnc_guidancePFH;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
// #define DRAW_GUIDANCE_INFO
#include "script_component.hpp"
#define NEWTON-METERS 1/0.0980665


BEGIN_COUNTER(guidancePFH);

#define TIMESTEP_FACTOR 0.01

params ["_args", "_feedback", "_pfID"];
_args params ["_firedEH", "_feedback"];
_firedEH params ["_shooter","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile"];
private _veh = vehicle _shooter;

if (!((count (_feedback)) > 0) ) then {
	_feedback pushBack []; //0- time params
	_feedback pushBack []; //1- seeker params
	_feedback pushBack []; //2- attack profile params
	_feedback pushBack []; //3- ancillary info
};
_feedback params ["_timeParams", "_seekerParams", "_attackProfileParams", "_ancInfo"];

if (!((count (_timeParams)) > 0) ) then {
	_timeParams pushBack 0; //0- lastRunTime
	_timeParams pushBack 0; //1- time delta
	_timeParams pushBack 0; //2- time modulus
	_timeParams pushBack 0; //3- time modulus threshold
};
_timeParams params ["_lastRunTime", "_timeDelta", "_timeModulus", "_timeModulusThreshold"];


if (!((count (_seekerParams)) > 0) ) then {
	_seekerParams pushBack "";    //0- seeker name 
	_seekerparams pushBack 0;     //1- seeker angle
	_seekerParams pushBack 0;     //2- seeker max range
	_seekerParams pushBack 0;     //3- seeker head max angle
	_seekerParams pushBack 0;     //4- seeker head max traverse
	_seekerParams pushBack [0,0]; //5- seeker head
};
_seekerParams params ["_seekerName", "_seekerAngle", "_seekerMaxRange", "_seekerHeadMaxAngle", "_seekerHeadMaxTraverse", "_seekerHead"];
_seekerHead params ["_seekerHeadX", "_seekerHeadY"];


if (!((count (_attackProfileParams))> 0) ) then {
	_attackProfileParams pushBack "";          //0- attack profile name
	_attackProfileParams pushBack [false, []]; //1- last pos state 
	_attackProfileParams pushBack [0,0,0,0,[0,0]];   //2- deflection parameters
	_attackProfileParams pushBack [];          //x- attackProfile miscellany
};
_attackProfileParams params ["_attackProfileName", "_lastPosState", "_deflectionParameters", "_attackProfileMisc"];
_lastPosState params ["_seekLastTargetPos", "_lastKnownTargetPos"];
_deflectionParameters params ["_minDeflection", "_maxDeflection", "_incDeflection", "_dlyDeflection", "_curDeflection"];
_curDeflection params ["_curDeflectionX", "_curDeflectionY"];

if (!((count _attackProfileMisc) > 0) ) then {
	_attackprofileMisc pushBack [0,0]; //0-angle to target (from missile boresight)
	_attackprofileMisc pushBack [0,0]; //1-deviation of target last frame (from previous)
};
_attackProfileMisc params ["_angleToTarget", "_lastDeviation"];
_angleToTarget params ["_angleX", "_angleY"];
_lastDeviation params ["_deviationX", "_deviationY"];//if no seeker, no problem!


if (!((count (_ancInfo))>0) ) then {
	_ancInfo pushBack [];  //0- Ancillary seeker info
	_ancInfo pushBack [];  //1- Ancillary attack profile info
};
_ancInfo params ["_ancInfoSeeker", "_ancInfoAttackProfile"];
//Arrays made

if (!alive _projectile || isNull _projectile || isNull _shooter) exitWith {
    [_pfID] call CBA_fnc_removePerFrameHandler;
    END_COUNTER(guidancePFH);
};


//time params
if(_lastRunTime == 0) then {
	_lastRunTime = diag_tickTime;
	_timeParams set [0, _lastRunTime];
};

private _adjustTime = 1;

if (accTime > 0) then {
    _adjustTime = 1/accTime;
    _adjustTime = _adjustTime *  (_runtimeDelta / TIMESTEP_FACTOR);
    TRACE_4("Adjust timing", 1/accTime, _adjustTime, _runtimeDelta, (_runtimeDelta / TIMESTEP_FACTOR) );
} else {
    _adjustTime = 0;
};

private _runtimeDelta = 0;
if (accTime > 0) then {_runtimeDelta = ((diag_tickTime - _lastRunTime) * 1/accTime);};

_timeParams set [0, diag_tickTime];
_timeParams set [1, _runtimeDelta];
_timeParams set [2, _timeModulus + _timeDelta];


//get projectile parameters
private _projectilePos = getPosASL _projectile;
private _projectileDir = vectorDir _projectile;
private _projectileUp = vectorUp _projectile;

//seekerDir
private _seekerDir = [_projectileDir, _projectileUp, -deg (_seekerHeadX)] call FUNC(rotateVector);
_seekerDir = [_projectileDir, _projectileDir vectorCrossProduct _projectileUp, -deg (_seekerHeadY)] call FUNC(rotateVector);

//Call seeker Function
private _seekerTargetPos = [[_projectile, _projectilePos, _projectileDir, _seekerDir], _feedback] call FUNC(doSeekerSearch);

//do attack profile
private _controlCommands = [_seekerTargetPos, _args] call FUNC(doAttackProfile);

private _polar = (_controlCommands select 0) atan2 (_controlCommands select 1);

// If we have no seeker target, then do not change anything
if (!(_profileAdjustedTargetPos isEqualTo [0,0,0]) && (_timeModulus > _timeModulusThreshold)) then {

	_unitScalar = _incDeflection * _timeDelta;
	
	_controlX = _curDeflectionX - ((abs(_curDeflectionX) / _curDeflectionX) * _minDeflection);
	_controlY = _curDeflectionY - ((abs(_curDeflectionY) / _curDeflectionY) * _minDeflection);

	_controlX = _controlX + (sin(_polar) * _unitScalar);
	_controlY = _controlY + (cos(_polar) * _unitScalar);

	_controlX = _curDeflectionX + ((abs(_curDeflectionX) / _curDeflectionX) * _minDeflection);
	_controlY = _curDeflectionY + ((abs(_curDeflectionY) / _curDeflectionY) * _minDeflection);

	_controlX = ((abs(_curDeflectionX) / _curDeflectionX) * _minDeflection) * abs(_controlX min _maxDeflection);
	_controlY = ((abs(_curDeflectionY) / _curDeflectionY) * _minDeflection) * abs(_controlY min _maxDeflection);

	private _newDir = [_projectileDir, _projectileUp, _controlX] call FUNC(rotateVector);
	_newDir = [_projectileDir, _projectileUp vectorCrossProduct _projectileDir, _controlY] call FUNC(rotateVector);


    if (accTime > 0) then {
        [_projectile, _newDir] call FUNC(changeMissileDirection);
    };
	
	_timeParams set [1, _timeModulus % _timeModulusThreshold];
//	hint format ["%1", _feedback];
	
};

#ifdef DRAW_GUIDANCE_INFO
TRACE_3("",_projectilePos,_seekerTargetPos,_profileAdjustedTargetPos);
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [1,0,0,1], ASLtoAGL _projectilePos, 0.75, 0.75, 0, _ammo, 1, 0.025, "TahomaB"];

private _ps = "#particlesource" createVehicleLocal (ASLtoAGL _projectilePos);
_PS setParticleParams [["\A3\Data_f\cl_basic", 8, 3, 1], "", "Billboard", 1, 3.0141, [0, 0, 2], [0, 0, 0], 1, 1.275, 1, 0, [1, 1], [[1, 0, 0, 1], [1, 0, 0, 1], [1, 0, 0, 1]], [1], 1, 0, "", "", nil];
_PS setDropInterval 3.0;
#endif

_stateParams set [0, diag_tickTime];

END_COUNTER(guidancePFH);

