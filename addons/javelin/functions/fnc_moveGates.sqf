/*
 * Author: LorenLuke
 * Adjusts seeker gates
 *
 * Arguments:
 * 0: direction
 *
 * Return Value:
 * None
 *
 * Example:
 * ["up"] call ace_javelin_fnc_moveGates
 *
 * Public: No
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_gateDirection"];

private _currentShooter = if (ACE_player call CBA_fnc_canUseWeapon) then {ACE_player} else {vehicle ACE_player};

switch (_gateDirection) do {
	case ("up"): {
		GVAR(gateDistanceY) = (GVAR(gateDistanceY) + 0.05) min (0.9);
	};
	case ("down"): {
		GVAR(gateDistanceY) = (GVAR(gateDistanceY) - 0.05) max (0.1);
	};
	case ("right"): {
		GVAR(gateDistanceX) = (GVAR(gateDistanceX) + 0.05) min (0.9);
	};
	case ("left"): {
		GVAR(gateDistanceX) = (GVAR(gateDistanceX) - 0.05) max (0.1);
	};
};