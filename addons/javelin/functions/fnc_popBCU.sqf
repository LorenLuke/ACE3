/*
 * Author: PabstMirror
 * Find a target within the optic range
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


private _mag = currentMagazineDetail ACE_player;

if(isNil (missionNamespace getVariable QGVAR(poppedBCUs))) then {
    missionNamespace setVariable [QGVAR(poppedBCUs), [], true];
};

missionNamespace setVariable [QGVAR(poppedBCUs), (missionNamespace getVariable QGVAR(poppedBCUs)) + [_mag, time], true];
