/*
 * Author: LorenLuke
 * Connects a unit to a UAV.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Gunner Seat <BOOL>
 * 2: PiP view <BOOL>
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

params ["_unit", "_seat", "_pip"]; 

private _connected = _unit getVariable QGVAR(connectedUAV);

if(!isNil _connected && !isNull _connected) then {
    if(_seat) then {
        (gunner _uav) switchCamera "Internal";
    } else {
        (_uav) switchCamera "Internal";
    };
};
