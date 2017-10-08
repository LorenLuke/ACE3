/*
 * Author: jaynus / nou
 * Seeker Type: GPS (GPS/INS guidance for JDAM bombs)
 *
 * Arguments:
 * 1: Guidance Arg Array <ARRAY>
 * 2: Seeker State <ARRAY>
 *
 * Return Value:
 * Missile Aim PosASL <ARRAY>
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_seekerType_GPS;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["", "_args"];
_args params ["_firedEH", "_launchParams"];
_firedEH params ["","","","","","","_projectile"];
_launchParams params ["","","","","","","_gpsInfo"];


private _seekerTargetPos = _gpsInfo;

if (_seekerTargetPos isEqualTo [0,0,0]) exitWith {_seekerTargetPos};

_seekerTargetPos;