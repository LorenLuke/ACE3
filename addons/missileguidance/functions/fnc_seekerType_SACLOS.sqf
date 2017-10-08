/*
 * Author: LorenLuke
 * Seeker Type: Unguided
  *
 * Arguments:
 * 1: Guidance Arg Array <ARRAY>
 * 2: Seeker State <ARRAY>
 *
 * Return Value:
 * Missile Aim PosASL <ARRAY>
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_seekerType_UNGUIDED;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["", "_args"];
_args params ["_firedEH", "", "", "_seekerParams"];
_firedEH params ["","","","","","","_projectile"];
_seekerParams params ["_seekerAngle", "", "_seekerMaxRange"];

[0,0,0];