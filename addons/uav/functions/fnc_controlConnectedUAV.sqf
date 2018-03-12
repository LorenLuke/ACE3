/*
 * Author: LorenLuke
 * Connects a unit to a UAV.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Gunner Seat <BOOL>
 *
 * Return Value:
 * Success? <BOOL>
 *
 * Example:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_seat"]; 


private _connected = _unit getVariable QGVAR(connectedUAV);

if(!isNil _connected && !isNull _connected) then {
    _connected setVariable QGVAR(controllerUAV);
    private _success = false;
    if(_seat == "gunner") then {
        _success = _unit remoteControl (gunner _connected);
    } else {
        _succecss = _unit remoteControl (_connected);
    };
    if (_success) then {
        _unit setVariable [QGVAR(controllingUAV), [_connected, _seat]];
    };
};

