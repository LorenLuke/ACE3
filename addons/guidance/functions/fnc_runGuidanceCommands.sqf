#include "script_component.hpp"

params [_command, _args];
_args params ["_eh", "_sensorArray", "_seekerArray", "_targetArray", "_profileArray", "_launchArray", "_flightArray"];
_eh params ["_shooter", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_instigator"];
//_sensorParams params ["_sensorName", "_sensorFunction", "_active", "_activeOnRail", "_terminal", "_lookDirection", "_angle", "_range", "_priority", "_sensorMisc"];
_seekerArray params ["_seekerName", "_seekerFunction", "_tracking", "_trackObject", "_trackPoint", "_trackDirection", "_terminalRange", "_terminalAngle", "_seekerMisc"];
_targetArray params ["_cursorTarget", "_pilotCameraTarget", "_pilotCameraTargetPos", "_weaponTargetPos", "_eyeTargetPos"];
_profileArray params ["_profileName", "_profileFunction", "_profileMisc"];
_launchArray params ["_launched", "_launchTime", "_launchPos", "_launchVehicle", "_launchProjectileVector", "_launchWeaponVector", "_launchInstigatorEyeVector"];
_flightArray params ["_degreesPerSecond", "_lastFlightVector"];
