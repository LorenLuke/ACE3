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

params ["_seekerTargetPos", "_args"];
_args params ["_firedEH", "", "", "", "_stateParams"];
_firedEH params ["_shooter","","","","_ammo","","_projectile"];

if (_seekerTargetPos isEqualTo [0,0,0]) exitWith {_seekerTargetPos};

private _shooterPos = getPosASL _shooter;
private _projectilePos = getPosASL _projectile;

private _distanceToTarget = _projectilePos vectorDistance _seekerTargetPos;
private _distanceToShooter = _projectilePos vectorDistance _shooterPos;
private _distanceShooterToTarget = _shooterPos vectorDistance _seekerTargetPos;

TRACE_2("", _distanceToTarget, _distanceToShooter);


private _glideratio = getNumber (configFile >> "CfgAmmo" >> _ammo >> "ace_missileguidance" >> "glideRatio");

if(_glideratio == 0) then {
	_glideratio = 5; //Paveway II. Source: https://books.google.com/books?id=exm7JCR6DNsC&pg=PT203&lpg=PT203#v=onepage&q&f=false
};

private _g = -9.80665;

private _velocity = velocity _projectile;
private _vectordir = vectorDir _projectile;
private _pitch = ((_vectordir) select 2) atan2 sqrt(((_vectordir) select 0)^2 + ((_vectordir) select 1)^2);
private _optimalAngle = -atan(1/_glideratio);


//assuming dt = ~ 1/60s
private _dt = 1/60;
private _acc_y = _dt * _g *cos(_pitch - _optimalAngle)/(_glideratio);
private _acc_x = _acc_y * _glideratio;

private _friction = getNumber (configFile >> "CfgAmmo" >> _ammo >> "airFriction");
private _drag = _dt * _friction * (vectorMagnitude _velocity)^2;

_velocity = _velocity vectorAdd [_acc_x * (vectorNormalized _velocity select 0), _acc_x * (vectorNormalized _velocity select 1), _acc_y];
_velocity = _velocity vectorAdd [(vectorNormalized _velocity select 0) * _drag, (vectorNormalized _velocity select 1) * _drag, (vectorNormalized _velocity select 2) * _drag];

_maxGlideAngleAtVelocity = (vectorNormalized _velocity select 2) atan2 sqrt((_velocity select 0)^2 + (_velocity select 1)^2);
_maxGlideAngleAtVelocity = _maxGlideAngleAtVelocity + abs(_maxGlideAngleAtVelocity * 0.02);



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

drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0,0,1,1], ASLtoAGL _returnTargetPos, 0.5, 0.5, 0, "BOMB", 1, 0.025, "TahomaB"];
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [1,0,0,1], ASLtoAGL _projectilePos, 0.5, 0.5, 0, "BOMB", 1, 0.025, "TahomaB"];
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0,1,0,1], ASLtoAGL _seekerTargetPos, 0.5, 0.5, 0, "BOMB", 1, 0.025, "TahomaB"];
drawLine3D [(ASLtoAGL _projectilePos), (ASLtoAGL _seekerTargetPos), [0,1,1,1]];


TRACE_2("Adjusted target position",_returnTargetPos,_addHeight);
_returnTargetPos;
