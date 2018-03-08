/*
 * Author: jaynus / nou, PabstMirror
 * Do attack profile with a valid seeker target location
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
 * [[1,2,3], [], []] call ace_missileguidance_fnc_doAttackProfile;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
// #define DRAW_GUIDANCE_INFO
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

hint format ["[%1]", _attackProfileName];

private _attackProfileFunction = getText (configFile >> QGVAR(AttackProfiles) >> _attackProfileName >> "functionName");

private _attackProfilePos = _this call (missionNamespace getVariable _attackProfileFunction);


if ((isNil "_attackProfilePos") || {_attackProfilePos isEqualTo [0,0,0]}) exitWith {
    ERROR_1("attack profile returned bad pos",_attackProfilePos);
    [0,0,0]
};

#ifdef DRAW_GUIDANCE_INFO
drawLine3D [(ASLtoAGL _attackProfilePos), (ASLtoAGL _seekerTargetPos), [0,1,1,1]];
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0,0,1,1], ASLtoAGL _attackProfilePos, 0.5, 0.5, 0, _attackProfileName, 1, 0.025, "TahomaB"];
#endif

TRACE_2("return",_attackProfilePos,_attackProfileName);
_attackProfilePos;
