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
 * [vehicle player] call ace_sensors_fnc_lockPilotCameraEyeDirection.sqf
 *
 * Public: No
 */

params ["_vehicle", "_unit"];

if(!hasPilotCamera _vehicle) exitWith {false};
if(getPilotCameraTarget _vehicle select 0) exitWith {false};
if(cameraView == "GUNNER" && _unit in crew _vehicle) exitWith {false};

private _pos = _vehicle modelToWorldVisualWorld [0,0,0];
private _eyeDir = eyeDirection _unit;
_pos = _pos vectorAdd _eyeDir;

private _vector = _vehicle worldToModelVisual _pos;
_vehicle setPilotCameraDirection _vector;

true
