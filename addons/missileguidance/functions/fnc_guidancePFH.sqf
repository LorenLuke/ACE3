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

params ["_args", "_pfID"];
_args params ["_firedEH", "_feedback"];
_firedEH params ["_shooter","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile","_weaponDirection"];
private _veh = vehicle _shooter;

if (isNull _projectile) then {
    [_pfID] call CBA_fnc_removePerFrameHandler;
};

if (!((count (_feedback)) > 0) ) then {
	_feedback pushBack []; //0- time params
	_feedback pushBack []; //1- seeker params
	_feedback pushBack []; //2- attack profile params
	_feedback pushBack []; //3- ancillary info
};
_feedback params ["_timeParams", "_seekerParams", "_attackProfileParams", "_ancInfo"];

if (!((count (_timeParams)) > 0) ) then {
	_timeParams pushBack 0; //0- lastRunTime
    _timeParams pushBack 0; //1- lastTime
	_timeParams pushBack 0; //2- time delta
	_timeParams pushBack 0; //3- time modulus
	_timeParams pushBack 0; //4- time modulus threshold
};
_timeParams params ["_lastFrameTime", "_lastTime", "_timeDelta", "_timeModulus", "_timeModulusThreshold"];

if (!((count (_seekerParams)) > 0) ) then {
	_seekerParams pushBack "";         //0- seeker name 
	_seekerparams pushBack 0;          //1- seeker angle
	_seekerParams pushBack 0;          //2- seeker max range
	_seekerParams pushBack 0;          //3- seeker head max angle
	_seekerParams pushBack 0;          //4- seeker head max traverse
	_seekerParams pushBack [0,0,false]; //5- seeker head
};
_seekerParams params ["_seekerName", "_seekerAngle", "_seekerMaxRange", "_seekerHeadMaxAngle", "_seekerHeadMaxTraverse", "_seekerHead"];
_seekerHead params ["_seekerHeadX", "_seekerHeadY", "_seekerHeadUncaged"];

if (!((count (_attackProfileParams)) > 0) ) then {
	_attackProfileParams pushBack "";          //0- attack profile name
	_attackProfileParams pushBack [false, [0,0,0]]; //1- last pos state 
	_attackProfileParams pushBack [0,0,0,0,0];   //2- deflection parameters
	_attackProfileParams pushBack [];          //x- attackProfile miscellany
};
_attackProfileParams params ["_attackProfileName", "_lastPosState", "_deflectionParameters", "_attackProfileMisc"];
_lastPosState params ["_seekLastTargetPos", "_lastKnownTargetPos"];
_deflectionParameters params ["_minDeflection", "_maxDeflection", "_incDeflection", "_dlyDeflection", "_curDeflection"];

if (!((count _attackProfileMisc) > 0) ) then {
	_attackprofileMisc pushBack [0,0]; //0-angle to target (from missile boresight)
	_attackprofileMisc pushBack [0,0]; //1-deviation of target last frame (from previous)
    _attackProfileMisc pushBack []; //2-guidance command queue
};
_attackProfileMisc params ["_angleToTarget", "_lastDeviation","_guidanceCommandQueue"];
_angleToTarget params ["_angleX", "_angleY"];
_lastDeviation params ["_deviationX", "_deviationY"];


if (!((count (_ancInfo)) > 0) ) then {
	_ancInfo pushBack [];  //0- Ancillary seeker info
	_ancInfo pushBack [];  //1- Ancillary attack profile info
};
_ancInfo params ["_ancInfoSeeker", "_ancInfoAttackProfile"];
//arrays made

//set our seeker values
private _config = configFile >> "CfgAmmo" >> _ammo >> "ace_missileguidance";

private _seekerType = _unit getVariable [QGVAR(seekerType), nil];
if (isNil "_seekerType" || {!(_seekerType in (getArray (_config >> "seekerTypes")))}) then {
    _seekerType = getText (_config >> "defaultSeekerType");
};
_seekerParams set [0, _seekerType];
_seekerparams set [1, getNumber ( _config >> "seekerAngle" )];
_seekerparams set [2, getNumber ( _config >> "seekerMaxRange" )];
_seekerparams set [3, getNumber ( _config >> "seekerMaxAngle")];
//_seekerparams set [4, getNumber ( _config >> "seekerMaxTraverse")];

//DEBUG!
//STINGER = 11, Javelin = 29.4 (~14.7 down);
_seekerParams set [4, 29.4];
_seekerHead set [2, false];

if (isNil "_attackProfile" || {!(_attackProfile in (getArray (_config >> "attackProfiles")))}) then {
    _attackProfileParams set [0, getText (_config >> "defaultAttackProfile")];
};

//get projectile parameters
private _projectilePos = getPosASL _projectile;
private _projectileDir = vectorDir _projectile;
private _projectileUp = vectorUp _projectile;

_vectDiff = _flyVector vectorDiff _projectileDir;


private _projectileBearing = (_projectileDir select 0) atan2 (_projectileDir select 1);
private _projectilePitch = (_projectileDir select 2) atan2 sqrt((_projectileDir select 0)^2 + (_projectileDir select 1)^2);




//private _flyVectorBearing = (_flyVector select 0) atan2 (_flyVector select 1);
//private _flyVectorPitch (_flyVector select 2) atan2 sqrt((_flyVector select 0)^2 + (_flyVector select 1)^2); 


//seekerDir
//private _seekerDir = [_projectileDir, _projectileUp, -(_seekerHeadX)] call FUNC(rotateVector);
//_seekerDir = [_projectileDir, _projectileDir vectorCrossProduct _projectileUp, (_seekerHeadY)] call FUNC(rotateVector);

private _seekerDir = [_projectileDir, [0,0,1], -(_seekerHeadX)] call FUNC(rotateVector);
_seekerDir = [_projectileDir, _seekerDir vectorCrossProduct [0,0,1], (_seekerHeadY)] call FUNC(rotateVector);


//Call seeker Function
private _seekerTargetPos = [[_projectile, _projectilePos, _projectileDir, _seekerDir], _feedback] call FUNC(doSeekerSearch);


//do attack profile
private _controlCommands = [_seekerTargetPos, _args] call FUNC(doAttackProfile);


//need way to push back guidance commands;





// If we have no seeker target, then do not change anything
if (_timeModulus > _timeModulusThreshold) then {

    _unitScalar = _incDeflection * _timeDelta;
    _controlX = _controlCommands select 0;
    _controlY = _controlCommands select 1;

    /*
	_controlX = _curDeflectionX - ((abs(_curDeflectionX) / _curDeflectionX) * _minDeflection);
	_controlY = _curDeflectionY - ((abs(_curDeflectionY) / _curDeflectionY) * _minDeflection);

	_controlX = _controlX + (sin(_polar) * _unitScalar);
	_controlY = _controlY + (cos(_polar) * _unitScalar);

	_controlX = _curDeflectionX + ((abs(_curDeflectionX) / _curDeflectionX) * _minDeflection);
	_controlY = _curDeflectionY + ((abs(_curDeflectionY) / _curDeflectionY) * _minDeflection);

	_controlX = ((abs(_curDeflectionX) / _curDeflectionX) * _minDeflection) * abs(_controlX min _maxDeflection);
	_controlY = ((abs(_curDeflectionY) / _curDeflectionY) * _minDeflection) * abs(_controlY min _maxDeflection);
    */
    
	private _newDir = [_projectileDir, _projectileUp, _controlX/2] call FUNC(rotateVector);
	_newDir = [_newDir, _newDir vectorCrossProduct _projectileUp, _controlY/2] call FUNC(rotateVector);

    if (accTime > 0) then {
        [_projectile, _newDir] call FUNC(changeMissileDirection);
    };
	
	//_timeParams set [3, _timeModulus % _timeModulusThreshold];
	
};

_timeParams set [3, _timeModulus + _timeDelta];


#ifdef DRAW_GUIDANCE_INFO
TRACE_3("",_projectilePos,_seekerTargetPos,_profileAdjustedTargetPos);
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [1,0,0,1], ASLtoAGL _projectilePos, 0.75, 0.75, 0, _ammo, 1, 0.025, "TahomaB"];

private _ps = "#particlesource" createVehicleLocal (ASLtoAGL _projectilePos);
_PS setParticleParams [["\A3\Data_f\cl_basic", 8, 3, 1], "", "Billboard", 1, 3.0141, [0, 0, 2], [0, 0, 0], 1, 1.275, 1, 0, [1, 1], [[1, 0, 0, 1], [1, 0, 0, 1], [1, 0, 0, 1]], [1], 1, 0, "", "", nil];
_PS setDropInterval 3.0;
#endif

_stateParams set [0, diag_tickTime];



END_COUNTER(guidancePFH);

