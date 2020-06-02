#include "script_component.hpp"

params ["_eh", "_sensorArray", "_seekerArray", "_selectedTargetArray"];

_eh params ["_shooter", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_instigator"];
_sensorArray params ["_sensorName", "_sensorFunction", "_active", "_activeOnRail", "_terminal", "_lookDirection", "_angle", "_range", "_priority", "_sensorMisc"];
_seekerArray params ["_seekerName", "_tracking", "_trackObject", "_trackPoint", "_trackDirection", "_terminalRange", "_terminalAngle"];
_selectedTargetArray params ["_target", "_targetPos", "_targetVector"];

private _return = [];
switch (_sensorName) do {
    case "SALH" : {_return pushBack (_shooter getVariable [QEGVAR(laser,code), ACE_DEFAULT_LASER_CODE])};
    case "GPS" : {
        if(_tracking) then {
            _return pushBack _trackPoint;
        } else {
            if( !isNull "_targetPos") then {
                _return pushBack _targetPos;
            };
        };
    };
    case "INS" : {
        if(_tracking) then {
            _return pushBack _trackPoint;
        } else {
            if( !isNull "_targetPos") then {
                _return pushBack _targetPos;
            };
        };
    };
    case "EO_contrast" : {};
    case "EO_image" : {};
};

_return;
