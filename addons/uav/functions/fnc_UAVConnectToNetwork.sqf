/*
 * Author: LorenLuke
 * Initializes a UAV.
 *
 * Arguments:
 * 0: UAV <UNIT>
 * 1: Network Name (optional) <STRING>
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

params ["_UAV", "_network"];

_list = _UAV getVariable QGVAR(networks);
if(isNil "_list") then {
    _list = [];
};
if(!(_network in list)) then {
    _list = _list + [_network];
};
_UAV setVariable [QGVAR(networks), _list];