/*
 * Author: LorenLuke
 * Adds a device capable of accessing a UAV network;
 *
 * Arguments:
 * 0: Network Name <STRING>
 * 1: UAV <STRING>
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

params ["_networkName", "_uav", "_uavName"]; 

for "_i" from 0 to (count GVAR(networks)) do {
    if(GVAR(networks) select _i select 0 == "_networkName") then {
        private _listed = GVAR(networks) select _i select 2;
        _listed = _listed + [_uav];
    };
};

