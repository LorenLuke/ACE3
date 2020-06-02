#include "script_component.hpp"


params ["_pos", "_normalLookDirection", "_angle", "_range", "_eh", "_seekerArray", "_targetArray", "_sensorMisc"];
_eh params ["_shooter", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_instigator"];
_seekerArray params ["_seekerName", "_tracking", "_trackObject", "_trackPoint", "_trackDirection", "_terminalRange", "_terminalAngle"];
_targetArray params ["_target", "_targetPos", "_targetVector"];
_sensorMisc params ["_seekerCode"];


private _spots = [];

// Go through all lasers in EGVAR(laser,laserEmitters)

{
    _x params ["_laserObject", "_owner", "_hash", "_laserCode"];

    if (alive _laserObject) then {
        if(_laserCode == _seekerCode) then {
            _laserPos = getPosASLVisual _laserObject;
            private _angleTo = acos((_pos vectorFromTo _laserPos) vectorCos _normalLookDirection);
            private _distance = _pos distance _laserPos;

            if ( ( _angleTo < _angle) && (_distance < _range) ) then {
                _spots pushBack [_laserPos, _owner];
            };
        };
    };
} forEach EGVAR(laser,trackedLaserTargets); // Go through all values in hash
private _minPoint = [0,0,0];
private _angle = 90;
{
    private _toVector = _pos vectorFromTo (_x select 0);
    private _checkAngle = acos(_toVector vectorCos _lookDirection);
    if (_checkAngle < _angle) then {
        
        _minPoint = (_x select 0);
        _angle = _checkAngle;
    };
} forEach _spots;


_minPoint;
