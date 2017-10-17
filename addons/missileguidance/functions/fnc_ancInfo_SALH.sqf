/*
 * Author: LorenLuke
 * Ancillary information: SALH (Laser info)
 *
 * Arguments:
 * 1: Shooter <Object>
 * 2: Target/PosASL <Object/ARRAY>
 *
 * Return Value:
 * [Laser search code, minimum laser wavelength, maximum laser wavelength] <ARRAY>
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_seekerType_AA;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_shooter", "_target"];

private _laserCode = _shooter getVariable [QEGVAR(laser,code), ACE_DEFAULT_LASER_CODE];
private _laserInfo = [_laserCode, ACE_DEFAULT_LASER_WAVELENGTH, ACE_DEFAULT_LASER_WAVELENGTH];

_laserInfo;



