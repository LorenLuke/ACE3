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
_firedEH params ["_shooter","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile","_flyVector"];
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

//Attack profile ancillary info- unique to each profile;
//AA
//seeker active-
//target angle offset polar
//target angle offset mag;
//
//

private _projectileDir = vectorDir _projectile;
private _projectileBearing = (_projectileDir select 0) atan2 (_projectileDir select 1);
private _projectilePitch = (_projectileDir select 2) atan2 sqrt((_projectileDir select 0)^2 + (_projectileDir select 1)^2);

private _dotProduct = (vectorNormalized _projectileDir) vectorDotProduct (vectorNormalized _flyVector);
private _angleDif = acos _dotProduct;
//off-boresight capability

//if no seeker, no problem!

if (_angleDif >=0.15 || _seekerHeadUncaged) exitWith {
    private _flyVectorBearing = (_flyVector select 0) atan2 (_flyVector select 1);
    private _flyVectorPitch = (_flyVector select 2) atan2 sqrt((_flyVector select 0)^2 + (_flyVector select 1)^2); 
    private _flyVectorPolar = _flyVectorBearing atan2 _flyVectorPitch;
    
    private _vectDiffBearing = _projectileBearing - _flyVectorBearing;
    private _vectDiffPitch = _flyVectorPitch - _projectilePitch;
    
    hint format ["%1\n%2", _vectDiffBearing, _vectDiffPitch];

    [_vectDiffBearing,_vectDiffPitch]


};

_firedEH set [7, _projectileDir];
_seekerHead set [2, true];



if (_seekerTargetPos isEqualTo [0,0,0]) exitWith {
    [0,0];
};

//
private _projectilePos = getPosASL _projectile;
private _projectileUp = vectorUp _projectile;
private _vectorToTarget = _projectilePos vectorFromTo _seekerTargetPos;

_vectorToTarget = [_vectorToTarget, _projectileUp, _projectileBearing] call FUNC(vectorRotate);
_vectorToTarget = [_vectorToTarget, _vectorToTarget vectorCrossProduct _projectileUp, _projectilePitch] call FUNC(vectorRotate);

private _toTargetBearing = (_vectorToTarget select 1) atan2 (_vectorToTarget select 0); 
private _toTargetPitch = (_vectorToTarget select 2) atan2 sqrt((_vectorToTarget select 0)^2 + (_vectorToTarget select 1)^2);

//Boundary protection
if(sqrt((_toTargetBearing ^ 2) + (_toTargetPitch ^ 2)) > 0) then {
    private _toTargetPolar = _toTargetBearing atan2 _toTargetPitch;
    //_toTargetBearing = sin(_toTargetPolar) * _value;
    //_toTargetPitch = cos(_toTargetPolar) * _value;
};

_lastDeviation set [0, _toTargetBearing - _deviationX];
_lastDeviation set [1, _toTargetPitch - _deviationY];
_angleToTarget set [0, _toTargetBearing];
_angleToTarget set [1, _toTargetPitch];

//return [_x,_y];
//angle stabilisation;
[_deviationX,_deviationY];