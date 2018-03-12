/*
 * Author: LorenLuke
 * Connects a unit to a UAV.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: UAV <OBJECT>
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

params ["_unit", "_uav"]; 

_unit setVariable [QGVAR(connectedUAV), [_uav]];
private _list = _uav getVariable QGVAR(connectedUnits);

if(isNil "_list") then {
    _list = [];
};
if(!_unit in _list) then {
    _list = _list + [_unit]
};
_uav setVariable [QGVAR(connectedUnits), _list];
