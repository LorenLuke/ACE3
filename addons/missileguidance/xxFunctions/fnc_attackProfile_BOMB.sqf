/*
 * Author: jaynus / nou
 * Attack profile: MID
 * TODO: falls back to Linear
 *
 * Arguments:
 * 0: Seeker Target PosASL <ARRAY>
 * 1: Guidance Arg Array <ARRAY>
 * 2: Attack Profile State <ARRAY>
 *
 * Return Value:
 * Missile Aim PosASL <ARRAY>
 *
 * Example:
 * [[1,2,3], [], []] call ace_missileguidance_fnc_attackProfile_BOMB;
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
_deflectionParameters params ["_minDeflection", "_maxDeflection", "incDeflection", "dlyDeflection"];
_lastPosState params ["_seekLastTargetPos", "_lastKnownTargetPos"];

_ancInfo params ["_ancInfoSeeker", "_ancInfoAttackProfile"];



params ["_seekerTargetPos", "_args", "", "_feedback"];
_args params ["_firedEH", "", "", "", "_stateParams"];
_firedEH params ["_shooter","","","","_ammo","","_projectile"];
_feedback params ["_timeParams", "_seekerTypeName", "_attackProfileName", "_seekerFeedbackArray", "_attackProfileFeedbackArray"];
_timeParams = ["_timeDelta", "_timeModulus", "_timeModulusThreshold"];






private _projectile = _source;
private _projectilePos = getPosASL _projectile;

//if(isNil _glideratio || _glideratio isEqualTo 0) then {
//	_glideratio = 5; //Paveway II. Source: https://books.google.com/books?id=exm7JCR6DNsC&pg=PT203&lpg=PT203#v=onepage&q&f=false
//};

private _glideratio = 2;

private _g = -9.80665;

private _velocity = velocity _projectile;
private _vectordir = vectorDir _projectile;

private _pitch = ((_vectordir) select 2) atan2 sqrt(((_vectordir) select 0)^2 + ((_vectordir) select 1)^2);
private _optimalAngle = -atan(1/_glideratio);


private _acc_y = _timeDelta * _g * cos(_pitch - _optimalAngle)/(_glideratio);
private _acc_x = _acc_y * _glideratio;

private _friction = getNumber (configFile >> "CfgAmmo" >> _ammo >> "airFriction");
private _drag = _timeDelta * _friction * (vectorMagnitude _velocity)^2;

_velocity = _velocity vectorAdd [_acc_x * ((vectorNormalized _velocity) select 0), _acc_x * ((vectorNormalized _velocity) select 1), _acc_y];
_velocity = _velocity vectorAdd [((vectorNormalized _velocity) select 0) * _drag, ((vectorNormalized _velocity) select 1) * _drag, ((vectorNormalized _velocity) select 2) * _drag];


_maxGlideAngleAtVelocity = (vectorNormalized _velocity select 2) atan2 sqrt((_velocity select 0)^2 + (_velocity select 1)^2);
_maxGlideAngleAtVelocity = _maxGlideAngleAtVelocity + abs(_maxGlideAngleAtVelocity * 0.02);

if (_seekerTargetPos isEqualTo [0,0,0]) then {
_seekerTargetPos = _projectilePos vectorAdd _velocity;
};



private _targetVector = _projectilePos vectorFromTo _seekerTargetPos;
_targetVector2 = [_targetVector select 0, _targetVector select 1, (_targetVector select 2) min (sqrt((_targetVector select 0)^2 + (_targetVector select 1)^2) * sin(_maxGlideAngleAtVelocity))];
//sqrt((_targetVector select 0)^2 + (_targetVector select 1)^2) * sin(_maxGlideAngleAtVelocity)
private _returnTargetPos = _projectilePos vectorAdd (_targetVector2);

// height at x: y = y_0 + x tan (theta) - [(gx^2)/2(vcos(theta))]
// x = x_o + vt + 1/2at^2
// a_drag = (coef +- sqrt ((1/coef)^2 - 4(v_o^2 + (v_o/coef))))/2
/// R_coef = 10
// a_y = g/sqrt(R_glide + 1)
// a_x = ay * R_glide
// R_glide = R_coef * cos(pitch)
// 


if (!((count _attackProfileFeedbackArray) > 0)) then {
	_attackProfileFeedbackArray pushBack 0;
	_attackProfileFeedbackArray pushBack _returnTargetPos;
};

TRACE_2("Adjusted target position",_returnTargetPos,_addHeight);
_returnTargetPos;
