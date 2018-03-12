/*
 * Author: LorenLuke
 * Adds a device capable of accessing a UAV network;
 *
 * Arguments:
 * 0: Network Name <STRING>
 * 1: Connect-Capable device parameters <ARRAY>
 * 1-0: Device Name <STRING>
 * 1-1: Can connect to UAVs on network <BOOL>
 * 1-2: can view UAV feeds on network <BOOL>
 * 1-3: can control UAVs on network <BOOL>
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

params ["_networkName", "_deviceParams"]; 

private _listedDevices = [];

for "_i" from 0 to (count GVAR(networks)) do {
    if(GVAR(networks) select _i select 0 == "_networkName") then {
        _listedDevices = GVAR(networks) select _i select 1;
        _listedDevices = _listedDevices + [_deviceParams];
    };
};

