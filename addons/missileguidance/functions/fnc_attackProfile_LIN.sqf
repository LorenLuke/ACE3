/*
 * Author: jaynus / nou
 * Attack profile: Linear (used by DAGR)
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
 * [[1,2,3], [], []] call ace_missileguidance_fnc_attackProfile_LIN;
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

if (_seekerTargetPos isEqualTo [0,0,0]) exitWith {_seekerTargetPos};

_seekerTargetPos;
