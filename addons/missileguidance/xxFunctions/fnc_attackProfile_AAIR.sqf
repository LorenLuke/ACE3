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

params ["_seekerTargetPos", "_args", "", "_feedback"];
_args params ["_firedEH", "_launchParams"];
_firedEH params ["_shooter","","","","","","_projectile"];
_launchParams params ["","","","","","_ancInfo"];
_feedback params ["_timeDelta", "_seekerTypeName", "_attackProfileName", "_seekerFeedbackArray", "_attackProfileFeedbackArray"];

if (_seekerTargetPos isEqualTo [0,0,0]) exitWith {_seekerTargetPos};

private _shooterPos = getPosASL _shooter;
private _projectilePos = getPosASL _projectile;

private _distanceToTarget = _projectilePos vectorDistance _seekerTargetPos;
private _distanceToShooter = _projectilePos vectorDistance _shooterPos;
private _distanceShooterToTarget = _shooterPos vectorDistance _seekerTargetPos;

//Need way to track from PFH the target and angle to tracked target

private _returnTargetPos = _seekerTargetPos;

// Always climb an arc on initial launch if we are close to the round
if ((((ASLtoAGL _projectilePos) select 2) < 5) && {_distanceToShooter < 15}) then {
    _returnTargetPos = _projectilePos vectorAdd [vectorDir _projectile select 0, vectorDir _projectile select 1, vectorDir _projectile select 2];
    TRACE_1("climb - near shooter",_addHeight);
};


TRACE_2("Adjusted target position",_returnTargetPos,_addHeight);
_returnTargetPos;
