#include "script_component.hpp"

params ["_pos", "_eh", "_sensorParams", "_seekerArray", "_selectedTargetArray"];

_eh params ["_shooter", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_instigator"];
_sensorParams params ["_sensorName", "_sensorFunction", "_active", "_activeOnRail", "_terminal", "_lookDirection", "_angle", "_range", "_priority", "_sensorMisc"];
_seekerArray params ["_seekerName", "_tracking", "_trackObject", "_trackPoint", "_trackDirection", "_terminalRange", "_terminalAngle"];
_selectedTargetArray params ["_target", "_targetPos", "_targetVector"];

private _normalLookDirection = _shooter weaponDirection _weapon;
if( !(isNull _projectile)) then {
    _normalLookDirection = vectorNormalized (velocity _projectile);
};

private _sensorTargetPoint = [0,0,0];
private _sensorTargetVector = [0,0,0];
private _divisor = 0;

if ( !(_active && (_priority > 0)) ) exitWith {
    [[0,0,0],[0,0,0]];
};
if ( !(_targetVector isEqualTo [0,0,0]) ) then {
    _lookDirection = _targetVector;
};
if (_tracking) then {
    _lookDirection = _trackDirection;
};

_seekerArray set [4, _lookDirection];
private _sensorTargetReturnPos = [_pos, _normalLookDirection, _angle/2, _range, _eh, _seekerArray, _selectedTargetArray, _sensorMisc] call (missionNamespace getVariable _sensorFunction);
//private _sensorTargetReturnPos = [_pos, _normalLookDirection, _lookDirection, _angle/2, _range] call _sensorFunction;

_sensorTargetVector = _pos vectorFromTo _sensorTargetReturnPos;

drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0,0,1,1], ASLtoAGL _sensorTargetReturnPos, 0.75, 0.75, 0, _sensorFunction, 1, 0.025, "TahomaB"];

//return pos, return vector
[_sensorTargetReturnPos, _sensorTargetVector];
