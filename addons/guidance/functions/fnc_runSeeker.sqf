#include "script_component.hpp"

params ["_pos", "_sensorTargetArray", "_args"];

_sensorTargetArray params ["_sensorTargetPosition", "_sensorTargetVector"];
_args params ["_eh", "_timeArray", "_targetArray", "_seekerArray", "_sensorArray", "_profileArray", "_launchArray", "_flightArray"];
_eh params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_instigator"];
_timeArray params ["_runtimeDelta", "_lastRunTime", "_lastTickTime"];
//_sensorParams params ["_sensorName", "_sensorFunction", "_active", "_activeOnRail", "_terminal", "_lookDirection", "_angle", "_range", "_priority", "_sensorMisc"];


//private _seekerArray = [_name, seekerFunction, _tracking, _trackObject, _trackPoint, _trackDirection, _terminalRange, _terminalAngle, _seekerMisc];
_seekerArray params ["_seekerName", "_seekerFunction", "_tracking", "_trackObject", "_trackPoint", "_trackDirection", "_terminalRange", "_terminalAngle", "_seekerMisc"];
_targetArray params ["_cursorTarget", "_pilotCameraTarget", "_pilotCameraTargetPos", "_weaponTargetPos", "_eyeTargetPos"];
_profileArray params ["_profileName", "_profileFunction", "_profileMisc"];
_launchArray params ["_launched", "_launchTime", "_launchPos", "_launchVehicle", "_launchProjectileVector", "_launchWeaponVector", "_launchInstigatorEyeVector"];
_flightArray params ["_degreesPerSecond", "_lastFlightVector"];

if(! _launched) exitWith {};
if(count _sensorArray <= 1) exitWith {};

{
    _x params ["_sensorName", "_sensorFunction", "_active", "_activeOnRail", "_terminal", "_lookDirection", "_angle", "_range", "_priority", "_sensorMisc"];
    hint format ["%1", _x];
    if(count _seekerMisc <= 0) then {
        private _seekAngle = acos(vectorNormalized (velocity _projectile) vectorDotProduct _sensorTargetVector);
        private _seekRange = _pos distance _launchPos;
        if((_seekAngle <= _terminalAngle) || ((_seekRange >= _terminalRange) && (_terminalRange > -1))) then {
            _seekerArray set [8, [true]];
        } else {
            if(_terminal) then {
                _x set [2, false];
            } else {
                _x set [2, true];
            };
        };
    } else {
        if(_terminal) then {
            _x set [2, true];
        } else {
            _x set [2, false];
        };
    };
}forEach _sensorArray;


/*
//seekerWrapper
{

    private _guidanceCommands = _shooter getVariable [QGVAR(guidanceCommands), []];
    if(count _guidanceCommands > 0) then { //pop!
        [_guidanceCommands select 0] call FUNC(runGuidanceCommand);
        _guidanceCommands deleteAt 0;
        _shooter setVariable [QGVAR(guidanceCommands)];
    };

    private _seekerReturns = _this call _seekerFunction;
    
    
    _seekerReturns params ["_selectedTargetArray"];
    if( (! isNull _projectile) && !(_launched)) then {
        _tracking = true;
        _launched = true;
    };
    
    call FUNC(runSensorSearch);
    
    call FUNC(runAttackProfile);
    
};
*/

_returns
