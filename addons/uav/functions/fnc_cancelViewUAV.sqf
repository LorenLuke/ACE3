/*
 * Author: LorenLuke
 * Connects a unit to a UAV.
 *
 * Arguments:
 * 0: Unit <OBJECT>
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

params ["_unit", "_UAV", "_seat"]; 
if (_unit == ACE_player) then {
    switchCamera ACE_player;
    //add provision for closing PIP;
};
_unit setVariable [GVAR(viewingUAV), []];