#include "script_component.hpp"




params ["_EHshooter", "_EHweapon", "_EHmuzzle", "_EHmode", "_EHammo", "_EHmagazine", "_EHprojectile", "_EHinstigator"];

if ((getNumber (configFile >> "CfgAmmo" >> _EHammo >> QUOTE(ADDON) >> "enabled")) < 1) exitWith {};
if ( !isPlayer _EHshooter && { GVAR(enabled) < 2 } ) exitWith {};


private _guidanceArray = _EHshooter getVariable [QGVAR(guidanceArray), nil];

_guidanceArray params ["_args", "_pfID"];
_args params ["_eh", "_timeArray", "_targetArray", "_seekerArray", "_sensorArray", "_profileArray", "_launchArray", "_flightArray"];
_eh params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_instigator"];
_eh set [6, _EHprojectile];
//hint format ["%1\nEh:%2\nTime:%3\nTarget:%4\nSeek:%5\nSensors:%6\nProf:%7\nLaunch:%8\nFlight:%9", _pfID, _eh, _timeArray, _targetArray, _seekerArray, _sensorArray, _profileArray, _launchArray, _flightArray];

