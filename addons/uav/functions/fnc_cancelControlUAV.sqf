/*
 * Author: LorenLuke
 * Cancels a unit's control of a UAV.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"]; 


private _args = _unit getVariable QGVAR(controllingUAV);
_args params ["_connected", "_seat"];

if(!isNil _connected && !isNull _connected) then {
    if(_seat == "driver") then {
        objNull remoteControl driver _connected;
    } else {
        objNull remoteControl gunner _connected;
    };
    _unit setVariable [QGVAR(controllingUAV), []];
};
