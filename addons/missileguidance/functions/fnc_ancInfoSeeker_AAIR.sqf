/*
 * Author: LorenLuke
 * Ancillary information: AA (MANPAD InfraRed/AIM)
 *
 * Arguments:
 * 1: Shooter <Object>
 * 2: Target/PosASL <Object/ARRAY>
 *
 * Return Value:
 * Vector offset from weapon <ARRAY>
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_ancInfo_AAIR;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_shooter", "_target"];

_weaponDir = (vehicle _shooter) weaponDirection (currentWeapon (_shooter));
private _toTarget = _weaponDir; 

//hint format ["%1\n%2",isNil "_shooter", isNil "_target"];


if(!(isNull _target)) then {
	_toTarget = (getPosASL _shooter) vectorFromTo (getPosASL _target);
};


private _returnInfo = _toTarget vectorDiff _weaponDir;

_returnInfo;