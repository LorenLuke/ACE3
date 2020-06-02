#include "script_component.hpp"

params ["_pos", "_eh", "_sensorArray", "_seekerArray", "_targetArray", "_profileArray", "_launchArray", "_flightArray"];
_eh params ["_shooter", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_instigator"];
//_sensorParams params ["_sensorName", "_sensorFunction", "_active", "_activeOnRail", "_terminal", "_lookDirection", "_angle", "_range", "_priority", "_sensorMisc"];
_seekerArray params ["_seekerName", "_seekerFunction", "_tracking", "_trackObject", "_trackPoint", "_trackDirection", "_terminalRange", "_terminalAngle", "_seekerMisc"];
_targetArray params ["_cursorTarget", "_pilotCameraTarget", "_pilotCameraTargetPos", "_weaponTargetPos", "_eyeTargetPos"];
_profileArray params ["_profileName", "_profileFunction", "_profileMisc"];
_launchArray params ["_launched", "_launchTime", "_launchPos", "_launchVehicle", "_launchProjectileVector", "_launchWeaponVector", "_launchInstigatorEyeVector"];
_flightArray params ["_degreesPerSecond", "_lastFlightVector"];

private _selectedTarget = objNull;
private _selectedTargetPos = [0,0,0];
private _selectedTargetVector [0,0,0];
if(! _launched) then {
    if(! isNull _cursorTarget) then {
        _selectedTarget = _cursorTarget;
        _selectedTargetPos = _cursorTarget modelToWorldVisualWorld [0,0,0];
        _selectedTargetVector = _pos vectorFromTo _selectedTargetPos;
    };
} else {

};



private _selectedTargetArray = [_selectedTarget, _selectedTargetPos, _selectedTargetVector];