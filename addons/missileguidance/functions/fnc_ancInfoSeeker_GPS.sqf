/*
 * Author: LorenLuke
 * Ancillary information: GPS (JDAM)
 *
 * Arguments:
 * 1: Shooter <Object>
 * 2: Target/PosASL <Object/ARRAY>
 *
 * Return Value:
 * GPS position coord (ASL) <ARRAY>
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_ancInfo_GPS;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_shooter", "_target"];

private _gpsInfo = _shooter getVariable [QGVAR(gpsTarget), [0,0,0]];

if(_gpsInfo isEqualTo [0,0,0]) then {
	_gpsInfo = (getPilotCameraTarget (vehicle _shooter)) select 1;
};

_gpsInfo;

