#include "script_component.hpp"
/*
 * Author: LorenLuke
 * Locks the pilot camera to the current target;
 *
 * Arguments:
 * vehicle <OBJECT>
 *
 * Return Value:
 * Did it lock? <BOOL>
 *
 * Example:
 * [vehicle player] call ace_sensors_fnc_lockPilotCameraCursorTarget
 *
 * Public: No
 */

params ["_unit"];
hint "ding";
if(!hasPilotCamera _unit) exitWith{false};
if(driver _unit != ACE_player) exitWith{false};
private _cursorTarget = cursorTarget;

if(cursorTarget != objNull) exitWith {
    _unit setPilotCameraTarget (_cursorTarget);
    private _pct = getPilotCameraTarget _unit;
    if(((_pct#2) != (_cursorTarget)) && !((_pct#1 distance _cursorTarget < 2) && (_pct#0))) then {
        true
    } else {
        false
    };
};

false
