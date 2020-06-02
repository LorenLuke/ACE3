#include "script_component.hpp"

params ["_pos", "_eh", "_sensorArray", "_seekerArray", "_targetArray", "_profileArray", "_launchArray", "_flightArray"];
_eh params ["_shooter", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_instigator"];
//_sensorParams params ["_sensorName", "_sensorFunction", "_active", "_activeOnRail", "_terminal", "_lookDirection", "_angle", "_range", "_priority", "_sensorMisc"];
_seekerArray params ["_seekerName", "_seekerFunction", "_tracking", "_trackObject", "_trackPoint", "_trackDirection", "_terminalRange", "_terminalAngle", "_seekerMisc"];
_targetArray params ["_cursorTarget", "_pilotCameraTarget", "_pilotCameraTargetPos", "_weaponTargetPos", "_eyeTargetPos"];
_profileArray params ["_profileName", "_profileFunction", "_profileMisc"];
_launchArray params ["_launched", "_launchTime", "_launchPos", "_launchVehicle", "_launchProjectileVector", "_launchWeaponVector", "_launchInstigatorEyeVector"];
_flightArray params ["_degreesPerSecond", "_lastFlightVector"];


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

_returns
