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

if(!hasPilotCamera _vehicle) exitWith {false};
if(!(getPilotCameraTarget _vehicle select 0)) exitWith {false};


private _waypoints = _unit getVariable [QEGVAR(microdagr,waypoints), []];
private _waypointName = format ["Pilot Camera Point: %1", date];

_waypoints pushBack [_waypointName, getPilotCameraTarget _vehicle select 0];
_unit setVariable [QEGVAR(microdagr,waypoints), _waypoints];
