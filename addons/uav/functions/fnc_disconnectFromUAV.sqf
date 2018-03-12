/*
 * Author: LorenLuke
 * Connects a unit from its connected UAV.
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

private _UAV = _unit getVariable QGVAR(connectedUAV);
_unit setVariable [QGVAR(connectedUAV), []];

if(!isNil "_UAV") then {
    private _list = _UAV getVariable QGVAR(connectedUnits);
    _UAV setVariable [QGVAR(connectedUnits), _list - [_unit]];
};

