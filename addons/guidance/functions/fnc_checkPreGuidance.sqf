#include "script_component.hpp"


params ["_unit"];



_unit = vehicle _unit;
_weapon = currentWeapon _unit;
_mode = currentWeaponMode _unit;
_muzzle = currentMuzzle _unit;
_magazine = currentMagazine _unit;
private _ammo = getText (configFile >> "CfgMagazines" >> _magazine >> "ammo");
private _addonConfig = (configFile >> "CfgAmmo" >> _ammo >> QUOTE(ADDON));
private _enabled = getNumber (_addonConfig >> "enabled");
_unit setVariable [QGVAR(guidanceArray), nil];
if (_enabled < 1) exitWith {};

if ( !isPlayer _unit && { (_enabled < 2) } ) exitWith {};



private _eh = [_unit, _weapon, _muzzle, _mode, _ammo, _magazine, objNull, _unit];
private _timeArray = [0, time, diag_tickTime]; //runtimeDelta, lastTime, lastTickTime

_targetArray = _eh call FUNC(updateTargets);

_targetArray params ["_cursorTarget", "_pilotCameraTarget", "_pilotCameraTargetPos", "_weaponTargetPos", "_eyeTargetPos"];

private _extractedInfo = _eh call FUNC(extractInfo);
_extractedInfo params ["_seekerArray", "_sensorArray"];

//private _seekerArray = [_seekername, seekerFunction, _tracking, _trackObject, _trackPoint, _trackDirection, _terminalRange, _terminalAngle];
//private _sensorParams [_sensorname, sensorFunction, _active, _activeOnRail, _terminal, _lookDirection, _angle, _range, _priority, _misc] forEach _sensorArray;

private _profileName = getText (_addonConfig >> "attackProfile");
private _profileFunction = configFile >> QGVAR(AttackProfiles) >> "functionName";
//private _profileArray  = [_profileName, _profileFunction, _profileMisc];
private _profileArray  = [_profileName, _profileFunction, []];

//private _launchArray = [_launched, _launchTime, _launchPos, _launchVehicle, _launchProjectileVector, _launchWeaponVector, _launchInstigatorEyeVector];
private _launchArray = [false, nil, [0,0,0] , objNull, [0,0,0], [0,0,0], [0,0,0]];

//50d/s for high maneuvering projectiles;
//20d/s for normal missiles;
//10d/s for rockets;
//3d/s for bombs;
//1d/s for shells;
private _degreesPerSecond = getNumber (_addonConfig >> "degreesPerSecond");
//private _flightArray = [_degreesPerSecond, _lastFlightVector];
private _flightArray = [_degreesPerSecond, [0,0,0]];
private _args = [_eh, _timeArray, _targetArray, _seekerArray, _sensorArray, _profileArray, _launchArray, _flightArray];
private _pfID = [FUNC(guidancePFH), 0, _args] call CBA_fnc_addPerFrameHandler;
hint format ["%1", _degreesPerSecond];
_unit setVariable [QGVAR(guidanceArray), [_args, _pfID]];
