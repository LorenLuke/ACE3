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
_args params ["_firedEH"];
_firedEH params ["_shooter","","","","","","_projectile"];

if (_seekerTargetPos isEqualTo [0,0,0]) exitWith {_seekerTargetPos};

private _shooterPos = getPosASL _shooter;
private _projectilePos = getPosASL _projectile;

private _distanceToTarget = _projectilePos vectorDistance _seekerTargetPos;
private _distanceToShooter = _projectilePos vectorDistance _shooterPos;
private _distanceShooterToTarget = _shooterPos vectorDistance _seekerTargetPos;

//Need way to track from PFH the target and angle to tracked target

private _returnTargetPos = _seekerTargetPos;

TRACE_2("Adjusted target position",_returnTargetPos,_addHeight);
_returnTargetPos;
