#include "script_component.hpp"
/*
 * Author: jaynus / nou
 * Seeker Type: Optic
 *
 * Arguments:
 * 0: Projectile <OBJ>
 * 1: Seeker Search Direction <NUMBER>
 * 2: Seeker Max Angle <NUMBER>
 * 3: Seeker Misc <ARRAY>
 *
 * Return Value:
 * Vector to target position <ARRAY>
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_seekerType_INS;
 *
 * Public: No
 */

params ["_projectile", "_shooter","_extractedInfo"];
_extractedInfo params ["_seekerType", "_attackProfile", "_target", "_targetPos", "_targetVector", "_launchPos", "_launchTime", "_miscManeuvering", "_miscSensor", "_miscSeeker", "_miscProfile"];
_miscManeuvering params ["_degreesPerSecond", "_glideAngle", "_lastTickTime", "_lastRunTime"];
_miscSensor params ["_seekerAngle", "_seekerMinRange", "_seekerMaxRange"];
_miscSeeker params ["_active","_canUpdate","_gpsTargetPos", "_gpsAttackAngle"];

private _projPos = getPosASL _projectile;

_seekerTargetPos = _targetPos;
if(!(isNil "_gpsTargetPos")) then {
    _seekerTargetPos = _gpsTargetPos;
};

if(!_active) exitWith {_gpsTargetPos};

if(_canUpdate) then {
    if(!(_gpsTargetPos isEqualTo [0,0,0])) then {
        _seekerTargetPos = _gpsTargetPos;
    };
    
    _miscSeeker set [2, _gpsTargetPos];
    _targetInfo set [6, _miscSeeker];
    _targetInfo set [2, _gpsTargetPos];
};

if(!(isNil "_gpsAttackAngle")) then {
    private _newTargetPos = [_seekerTargetPos select 0, _seekerTargetPos select 1, _projPos select 2];
    private _ang = acos((_projPos vectorFromTo _newTargetPos) vectorCos (_projPos vectorFromTo _seekerTargetPos));
    if((_ang + 2) > _gpsAttackAngle) then {
        _seekerTargetPos = _newTargetPos;
    };
};

_targetInfo set [4, (getPosASL _projectile) vectorFromTo _seekerTargetPos];

_seekerTargetPos;
