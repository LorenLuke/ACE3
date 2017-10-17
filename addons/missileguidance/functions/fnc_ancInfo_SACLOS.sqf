/*
 * Author: LorenLuke
 * Ancillary information: SALH (Laser info)
 *
 * Arguments:
 * 1: Shooter <Object>
 * 2: Target/PosASL <Object/ARRAY>
 *
 * Return Value:
 * [Laser search code, default laser wavelength, default laser wavelength] <ARRAY>
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_seekerType_AA;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_shooter", "_target"];

private _veh = vehicle _shooter;
private _weapon = currentWeapon _veh;

[_shooter, _weapon]