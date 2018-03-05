/*
 * Author: LorenLuke
 * Ancillary information: SACLOS
 *
 * Arguments:
 * 1: Shooter <Object>
 * 2: Target/PosASL <Object/ARRAY>
 *
 * Return Value:
 * [Shooter, weapon] <ARRAY>
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_ancInfo_SACLOS;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_shooter", "_target"];

private _veh = vehicle _shooter;
private _weapon = currentWeapon _veh;

[_shooter, _weapon]