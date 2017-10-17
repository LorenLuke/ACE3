/*
 * Author: LorenLuke
 * Seeker Type: SACLOS
  *
 * Arguments:
 * 1: Guidance Arg Array <ARRAY>
 * 2: Seeker State <ARRAY>
 *
 * Return Value:
 * Missile Aim PosASL <ARRAY>
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_seekerType_UNGUIDED;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_args", "_feedback"];
_args params ["_source", "_posASL", "_dir", "_focusDir"];
_feedback params ["_timeParams", "_seekerParams", "_attackProfileParams", "_ancInfo"];
_timeParams params ["_lastRunTime", "_timeDelta", "_timeModulus", "_timeModulusThreshold"];
_seekerParams params ["_seekerName", "_seekerAngle", "_seekerMaxRange", "_seekerHeadMaxAngle", "_seekerHeadMaxTraverse", "_seekerHead"];
_seekerHead params ["_seekerHeadX", "_seekerHeadY", "_seekerHeadUncaged"];

_attackProfileParams params ["_attackProfileName", "_lastPosState", "_deflectionParameters", "_attackProfileMisc"];
_deflectionParameters params ["_minDeflection", "_maxDeflection", "_incDeflection", "_dlyDeflection", "_curDeflection"];
_lastPosState params ["_seekLastTargetPos", "_lastKnownTargetPos"];

_ancInfo params ["_ancInfoSeeker", "_ancInfoAttackProfile"];

//doing things a bit wonky here:
//_source = _projectile;
//_posASL = getPosASL _projectile;
//_dir = vectorDir _projectile;
//_focusDir = vectorDir _projectile;

//_ancInfoSeeker = [
//_shooter,
//_weapon = currentWeapon (vehicle _shooter), (time of firing)
//];


private _projectile = _source;
private _projectilePos = getPosASL _projectile;

private _shooter = _ancInfoSeeker select 0;
private _weapon = _ancInfoSeeker select 1;

private _veh = vehicle _shooter,
private _aimVector = _veh weaponDirection _weapon;
private _dist = _veh distance _projectile;
private _opticPos = _veh selectionPosition (getText (([_veh, [0]] call CBA_fnc_getTurret) >> "memoryPointGunnerOptics"));

if (_opticPos isEqualTo [0,0,0]) then {
	_opticPos = _veh selectionPosition (getText (configfile >> "CfgWeapons" >> _weapon >> "muzzleEnd"));
};

private _aimPos = AGLToASL (_veh modelToWorld _opticPos);

if(hasPilotCamera (_veh)) then {
	private _dirs = [_veh, "pod"] call FUNC(getDirs);
	_aimpos = _dirs select 0;
	_aimVector = _dirs select 1;
};

private _seekerTarget =  _aimPos vectorAdd (_aimVector vectorMultiply (8 + (_dist)));


if( ([_projectilePos, _aimVector vectorMultiply -1, eyePos ACE_player, 30] call FUNC(checkSeekerAngle))) then {
	drawIcon3D ["\a3\weapons_f\acc\data\collimdot_red_ca.paa", 
		[1,0.25,0.25,0.85],
		ASLToAGL _projectilePos,
		0.85,
		0.85,
		45
	];
};

if( !([getPosASL _shooter, _aimVector, _projectilePos, _seekerAngle] call FUNC(checkSeekerAngle)) ) exitWith {[0,0,0];};


_seekerTarget;