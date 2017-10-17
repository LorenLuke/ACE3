/*
 * Author: jaynus / nou
 * Attack profile: AIR
 * TODO: falls back to Linear
 *
 * Arguments:
 * 0: Seeker Target PosASL <ARRAY>
 * 1: Guidance Arg Array <ARRAY>
 * 2: Seeker State <ARRAY>
 *
 * Return Value:
 * Missile Aim PosASL <ARRAY>
 *
 * Example:
 * [[1,2,3], [], []] call ace_missileguidance_fnc_attackProfile_AIR;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_seekerTargetPos", "_args"];
_args params ["_firedEH", "_feedback"];
_firedEH params ["_shooter","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile"];
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


//if no seeker, no problem!
if (_seekerTargetPos isEqualTo [0,0,0]) exitWith {_seekerTargetPos};

//
private _projectilePos = getPosASL _projectile;
private _projectileDir = vectorDir _projectile;
private _projectileUp = vectorUp _projectile;
private _vectorToTarget = _projectilePos vectorFromTo _seekerTargetPos;
private _projectileBearing = (_projectileDir select 1) atan2 (_projectileDir select 0); 
private _projectilePitch = asin((_projectileVector) select 2);

_vectorToTarget = [_vectorToTarget, _projectileUp, _projectileBearing] call FUNC(vectorRotate);
_vectorToTarget = [_vectorToTarget, _vectorToTarget vectorCrossProduct _projectileUp, _projectilePitch] call FUNC(vectorRotate);

private _toTargetBearing = (_vectorToTarget select 1) atan2 (_vectorToTarget select 0); 
private _toTargetPitch = asin((_vectorToTarget) select 2);

_angleToTarget set [0, _toTargetBearing];
_angleToTarget set [1, _toTargetPitch];
_lastDeviation set [0, _toTargetBearing - _deviationX];
_lastDeviation set [1, _toTargetPitch - _deviationY];

//return [X,Y];
_angleToTarget;