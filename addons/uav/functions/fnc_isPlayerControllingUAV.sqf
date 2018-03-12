/*
 * Author: LorenLuke
 * Connects a unit to a UAV.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Gunner Seat <BOOL>
 *
 * Return Value:
 * Success? <BOOL>
 *
 * Example:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

(ACE_player getVariable QGVAR(controllingUAV)) >  0;