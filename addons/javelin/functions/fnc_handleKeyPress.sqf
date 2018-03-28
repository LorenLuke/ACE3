/*
 * Author: LorenLuke
 * Handles a tap versus a press of the Tab key, and functions associated with it.
 *
 * Arguments:
 * 0: Last Target (seeds the scan) <OBJECT>
 * 1: Max Range (meters) <NUMBER>
 *
 * Return Value:
 * Target <OBJECT>
 *
 * Example:
 * [bob, 5] call ace_javelin_fnc_getTarget
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_lastTarget", "_maxRange"];

scopeName "main";
