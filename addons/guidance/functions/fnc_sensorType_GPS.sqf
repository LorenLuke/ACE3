#include "script_component.hpp"


params ["_pos", "_normalLookDirection", "_angle", "_range", "_eh", "_seekerArray", "_targetArray", "_sensorMisc"];
_eh params ["_shooter", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_instigator"];
_seekerArray params ["_seekerName", "_tracking", "_trackObject", "_trackPoint", "_trackDirection", "_terminalRange", "_terminalAngle"];
_targetArray params ["_target", "_targetPos", "_targetVector"];
_sensorMisc params ["_overridePos"];

private _returnPos = [0,0,0]; 
if(isNil "_overridePos") then {
    if (_tracking) then {
        _returnPos = _trackPoint;
    } else {
        _returnPos = _targetPos;
    };
} else {
//    _returnPos = _overridePos;
    if (_tracking) then {
        _returnPos = _trackPoint;
    } else {
        _returnPos = _targetPos;
    };
};

_targetPos;
