/*
 * Author: LorenLuke
 * Initializes a named UAV network.
 *
 * Arguments:
 * 0: Network Name <STRING>
 *
 * Return Value:
 * New network created <BOOL>
 *
 * Example:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_networkName"]; 

private _networkString = format ["ACE_uavNetwork_%1",_networkName];
if (!isNil (missionNamespace getVariable _networkString)) exitWith {
    false;
};

GVAR(ACE_uavNetworks) = GVAR(ACE_uavNetworks) + [_networkString];
missionNamespace setVariable [_networkString, []];
