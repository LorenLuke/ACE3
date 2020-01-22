#include "script_component.hpp"
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

params ["_projectile", "_shooter","_extractedInfo","_seekerTargetPos"];
_extractedInfo params ["_seekerType", "_attackProfile", "_target", "_targetPos", "_targetVector", "_launchPos", "_launchTime", "_miscManeuvering", "_miscSensor", "_miscSeeker", "_miscProfile"];
_miscManeuvering params ["_degreesPerSecond", "_glideAngle", "_lastTickTime", "_lastRunTime"];
_miscSensor params ["_seekerAngle", "_seekerMinRange", "_seekerMaxRange"];

private _projPos = getPosASL _projectile;

hint format ["%1\n%2\%3", _seekerAngle, _seekerMinRange, _seekerMaxRange];

_extractedInfo set [4,vectorNormalized (velocity _projectile)];

if (_seekerTargetPos isEqualTo [0,0,0]) exitWith {[0,0,0]};

hint format ["%1", acos((_projPos vectorFromTo _seekerTargetPos) vectorCos vectorNormalized (velocity _projectile))];

_seekerTargetPos;
