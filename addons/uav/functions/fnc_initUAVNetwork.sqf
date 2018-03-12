/*
 * Author: LorenLuke
 * Initializes a named UAV network.
 *
 * Arguments:
 * 0: Network Name <STRING>
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

params ["_networkName"]; 

GVAR(networks) = GVAR(networks) + [_networkName, [], []];
