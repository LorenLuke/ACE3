#include "script_component.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_instigator"];

private _ammoConfig = configFile >> "CfgAmmo" >> _ammo >> QUOTE(ADDON);
private _seekerName = getText (_ammoConfig >> "seekerType");

private _seekerConfig = configFile >> QGVAR(SeekerTypes) >> _seekerName;

private _sensorList = getArray (_seekerConfig >> "sensors");
private _sensorArray = [];
{
    //sensor name, range, angle, terminal sensor, activeOnRail, data linked; -1 for ignore/use default;
    _x params ["_sensorName", "_sensorRange", "_sensorAngle", "_isTerminalSensor", "_activeOnRail", "_isDataLinked"];

    private _sensorConfig = configFile >> QGVAR(SensorTypes) >> _sensorName;
    private _sensorFunction = getText (_sensorConfig >> "functionName");
    if (_sensorRange == -1) then {
        _sensorRange = getNumber (_sensorConfig >> "range");
    };
    if (_sensorAngle == -1) then {
        _sensorAngle = getNumber (_sensorConfig >> "angle");
    };
    if (_isTerminalSensor == -1) then {
        _isTerminalSensor = 0;
    };
    if (_activeOnRail == -1) then {
        _activeOnRail = 0;
    };
    if (_isDataLinked == -1) then {
        _sensorRange = getNumber (_sensorConfig >> "datalinked");
    };

    private _function = getText (_sensorConfig >> "functionName");
    private _priority = getNumber (_sensorConfig >> "priority");

    //private _sensorParams [_name, _function, _active, _activeOnRail, _terminal, _lookDirection, _angle, _range, _priority, _misc];
    _sensorArray pushback [_sensorName, _function, _activeOnRail > 0, _activeOnRail > 0, _isTerminalSensor > 0, _unit weaponDirection _weapon, _sensorAngle, _sensorRange, _priority, []];
} forEach _sensorList;

private _seekerTerminalRange = getNumber (_seekerConfig >> "terminalRange");
private _seekerTerminalAngle = getNumber (_seekerConfig  >> "terminalAngle");
//private _seekerArray = [_name, _tracking, _trackDirection, _trackPoint, _terminalRange, _terminalAngle, _seekerMisc];
private _seekerArray = [_seekerName, _seekerFunction, false, [0,0,0], [0,0,0], _terminalRange, _terminalAngle, []];

[_seekerArray, _sensorArray];
