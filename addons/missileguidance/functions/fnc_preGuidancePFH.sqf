/*
 * Author: LorenLuke
 * PreGuidance Per Frame Handler
 * Governs target guidance and locks with weapon still in tube
 *
 * Arguments:
 * 0: player <OBJECT>
 * 1: PFID <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_Player, 0] call ace_missileguidance_fnc_guidancePFH;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
 #define DRAW_GUIDANCE_INFO
#include "script_component.hpp"

BEGIN_COUNTER(preGuidancePFH);

#define TIMESTEP_FACTOR 0.01

params ["_unit", "_pfID"];

if (_unit != ACE_player) exitWith {
    [_pfID] call CBA_fnc_removePerFrameHandler;
    END_COUNTER(preGuidancePFH);
	GVAR(feedbackArray) = [];
};

private _feedback = [];
if(!(isNil QGVAR(feedbackArray))) then {
	_feedback = GVAR(feedbackArray);
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
	_timeParams pushBack 0; //1- time delta
	_timeParams pushBack 0; //2- time modulus
	_timeParams pushBack 0; //3- time modulus threshold
};
_timeParams params ["_lastRunTime", "_timeDelta", "_timeModulus", "_timeModulusThreshold"];

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
};
_attackProfileMisc params ["_angleToTarget", "_lastDeviation"];
_angleToTarget params ["_angleX", "_angleY"];
_lastDeviation params ["_deviationX", "_deviationY"];

if (!((count (_ancInfo)) > 0) ) then {
	_ancInfo pushBack [];  //0- Ancillary seeker info
	_ancInfo pushBack [];  //1- Ancillary attack profile info
};
_ancInfo params ["_ancInfoSeeker", "_ancInfoAttackProfile"];
//Arrays made




//Now to the juicy config extrapolation;
private _veh = vehicle _unit;
private _weapon = (currentWeapon _veh);
private _magazine = (currentMagazine _veh);
private _ammo = getText (configFile >> "CfgMagazines" >> _magazine >> "ammo");

//Exit if no guidance
if ((getNumber (configFile >> "CfgAmmo" >> _ammo >> "ace_missileguidance" >> "enabled")) != 1) exitWith {
//    [_pfID] call CBA_fnc_removePerFrameHandler;
//    END_COUNTER(preGuidancePFH);
	GVAR(feedbackArray) = [];
};

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
_seekerParams set [4, 11];
_seekerHead set [2, true];


private _target = _unit getVariable [QGVAR(target), objNull];
private _targetPos = _unit getVariable [QGVAR(targetPosition), nil];
private _lockMode = _unit getVariable [QGVAR(lockMode), nil];

private _laserCode = _shooter getVariable [QEGVAR(laser,code), ACE_DEFAULT_LASER_CODE];
private _laserInfo = [_laserCode, ACE_DEFAULT_LASER_WAVELENGTH, ACE_DEFAULT_LASER_WAVELENGTH];

private _ancInfoSeekerFunction = getText (configFile >> QGVAR(AncInfo) >> _seekerType >> "functionName");
if(isNil _ancInfoSeekerFunction) then {
	_ancInfoFunction = getText (configFile >> QGVAR(AncInfo) >> "UNGUIDED" >> "functionName");
};

_ancInfo = [_veh,_target] call (missionNamespace getVariable _ancInfoSeekerFunction);
_ancInfo set [0, _ancInfoSeeker];


if (isNil "_lockMode" || {!(_lockMode in (getArray (_config >> "seekerLockModes")))}) then {
    _lockMode = getText (_config >> "defaultSeekerLockMode");
};

if (isNull _unit || _weapon != currentWeapon _veh || _ammo != getText (configFile >> "CfgMagazines" >> (currentMagazine _veh) >> "ammo") ) exitWith {
//    [_pfID] call CBA_fnc_removePerFrameHandler;
//    END_COUNTER(preGuidancePFH);
	GVAR(feedbackArray) = [];
};

//get attack profile values
_deflectionParameters set [0, getNumber ( _config >> "minDeflection" )];
_deflectionParameters set [1, getNumber ( _config >> "maxDeflection" )];
_deflectionParameters set [2, getNumber ( _config >> "incDeflection" )];
_deflectionParameters set [3, getNumber ( _config >> "dlyDeflection" )];

private _seekLastTargetPos = ((getNumber ( _config >> "seekLastTargetPos")) == 1);
_lastPosState set [0, _seekLastTargetPos];

private _ancInfoAttackProfileFunction = getText (configFile >> QGVAR(AncInfo) >> _attackProfileName >> "functionName");
if(isNil _ancInfoSeekerFunction) then {
	_ancInfoFunction = getText (configFile >> QGVAR(AncInfo) >> "UNGUIDED" >> "functionName");
};
_ancInfo = [_veh,_target] call (missionNamespace getVariable _ancInfoAttackProfileFunction);
_ancInfo set [1, _ancInfoAttackProfile];



//get weapon and optic positions
private _weaponDir = _veh weaponDirection _weapon;
private _muzzlePos = _veh selectionPosition (getText (configFile >> "CfgWeapons" >> _weapon >> "muzzleEnd"));
private _opticDir = _veh weaponDirection _weapon;
private _opticPos = _veh selectionPosition (getText (([vehicle player, [0]] call CBA_fnc_getTurret) >> "memoryPointGunnerOptics"));

/*
if(hasPilotCamera _veh) {
	_opticPos = getPilotCameraPosition _veh;
	_opticDir = [vectorDir _veh, vectorUp _veh, -deg ((getPilotCameraRotation _veh) select 0)] call FUNC(rotateVector)];
	_opticDir = [_opticDir, (vectorUp _veh) vectorCrossProduct (vectorDir _vec), -deg ((getPilotCameraRotation _veh) select 1)] call FUNC(rotateVector)];
	
};
*/

if(_veh == _unit) then {
	_opticDir = eyeDirection _unit;
	_opticPos = _veh worldToModel (ASLtoAGL (eyePos _unit));
	_muzzlePos = _opticPos;
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


//Argument Handling
private _useMissileForLook = getNumber ( _config >> "useOpticLock");

private _searchVector = _weaponDir;
private _searchPos = AGLToASL (_veh modelToWorld _muzzlePos);

if(_useMissileForLook == 1) then {
	_searchVector = _opticDir;
	_searchPos = AGLToASL (_veh modelToWorld _opticPos);
};

//Call seeker Function
private _seekerTargetPos = [[_veh, _searchPos, _weaponDir, _searchVector], _feedback] call FUNC(doSeekerSearch);

GVAR(feedbackArray) = _feedback;


#ifdef DRAW_GUIDANCE_INFO
if(! (_seekerTargetPos isEqualTo [0,0,0]) ) then {
//	drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [1,0,0,1], (ASLToAGL _seekerTargetPos), 0.75, 0.75, 0];
//	drawLine3D [(getPos _unit), (ASLtoAGL _seekerTargetPos), [1,0,0,1]];
};
//private _ps = "#particlesource" createVehicleLocal (ASLtoAGL _projectilePos);
//_PS setParticleParams [["\A3\Data_f\cl_basic", 8, 3, 1], "", "Billboard", 1, 3.0141, [0, 0, 2], [0, 0, 0], 1, 1.275, 1, 0, [1, 1], [[1, 0, 0, 1], [1, 0, 0, 1], [1, 0, 0, 1]], [1], 1, 0, "", "", nil];
//_PS setDropInterval 3.0;
#endif


END_COUNTER(guidancePFH);

