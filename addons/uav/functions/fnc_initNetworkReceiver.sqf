/*
 * Author: LorenLuke
 * Initializes a named UAV network.
 *
 * Arguments:
 * 0: Network Name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_networkName"]; 

GVAR(ACE_uavNetworks) = GVAR(ACE_uavNetworks) + [_networkName];