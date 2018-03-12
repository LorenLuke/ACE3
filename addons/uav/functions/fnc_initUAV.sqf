/*
 * Author: LorenLuke
 * Initializes a UAV.
 *
 * Arguments:
 * 0: UAV <UNIT>
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

params ["_uav"]; 

private _networkString = format ["network%1", side _uav);

[_networkString, _uav] call FUNC(addUAVToNetwork);

// UGV_01_base_F
// UAV_01_base_F

