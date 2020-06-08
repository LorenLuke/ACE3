#include "script_component.hpp"
/*
 * Author: LorenLuke
 * Locks the pilot camera to the current target;
 *
 * Arguments:
 * 0: vehicle <OBJECT>
 * 1: unit <OBJECT>
 *
 * Return Value:
 * Did it lock? <BOOL>
 *
 * Example:
 * [vehicle player] call ace_sensors_fnc_lockPilotCameraToDagr.sqf
 *
 * Public: No
 */

params ["_vehicle", "_unit"];

if(!hasPilotCamera _vehicle) exitWith{false};

private _waypoints = _unit getVariable [QEGVAR(microdagr,waypoints), []];
if((count _waypoints < 1) || (_unit getvariable QEGVAR(microdagr,currentWaypoint) == -1)) exitWith {};

private _pos = _waypoints select (_unit getvariable QEGVAR(microdagr,currentWaypoint)) select 1;

_vehicle setPilotCameraTarget _pos; 

