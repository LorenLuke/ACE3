#include "script_component.hpp"

params ["_shooter","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile", "_instigator"];

private _weaponOriginPos = [0,0,0];
if((typeOf _shooter) isKindOf "Man") then {
    _this set [7, _shooter];
    _weaponOriginPos = _shooter modelToWorldVisualWorld (_shooter selectionPosition "righthand");
} else {
    private _turretPath = [_shooter, _weapon] call CBA_fnc_turretPathWeapon;
    private _turretConfig = [_shooter, _turretPath] call CBA_fnc_getTurret;
    private _memoryPointGunnerOptics = getText(_turretConfig >> "memoryPointGunnerOptics");
    private _weaponOriginPos = _shooter modelToWorldVisualWorld (_shooter selectionPosition _memoryPointGunnerOptics);
    _this set [7, _shooter turretUnit _turretPath];
};

private _cursorTarget = objNull;

if(_instigator == player) then {
    _cursorTarget = cursortarget;
};

private _weaponDirection = _shooter weaponDirection _weapon;
private _weaponTargetPos = (_weaponOriginPos) vectorAdd (_weaponDirection vectorMultiply 10000);
private _weaponLineArray = lineIntersectsSurfaces [_weaponOriginPos, _weaponTargetPos, _shooter];
if(count _weaponLineArray > 0) then {
    _weaponTargetPos = _weaponLineArray select 0 select 0;
};

private _eyeDirection = eyeDirection _instigator;
private _eyeTargetPos = (eyePos _instigator) vectorAdd (_eyeDirection vectorMultiply 10000);
private _eyeLineArray = lineIntersectsSurfaces [eyePos _instigator, _eyeTargetPos, _shooter, _instigator];
if(count _eyeLineArray > 0) then {
    _eyeTargetPos = _eyeLineArray select 0 select 0;
};

private _pilotCameraTargetPos = [0,0,0];
if(hasPilotCamera _shooter) then {
    private _pilotCameraPosition = _shooter modelToWorldVisualWorld (getPilotCameraPosition _shooter);
    private _pilotCameraVector = (_shooter modelToWorldVisualWorld [0,0,0]) vectorFromTo (_shooter modelToWorldVisualWorld (getPilotCameraDirection _shooter));
    _pilotCameraTargetPos = _pilotCameraPosition vectorAdd (_pilotCameraVector vectorMultiply 10000);
    private _cameraLineArray = lineIntersectsSurfaces [_pilotCameraPosition, _pilotcameraTargetPos, _shooter, _instigator];
    if(count _cameraLineArray > 0) then {
        _pilotcameraTargetPos = _cameraLineArray select 0 select 0;
    };
};


//cursorTarget, _pilotCameraTarget, _pilotCameraTargetPos, _weaponTargetPos, _eyeTargetPos];
[_cursorTarget, (getPilotCameraTarget _shooter) select 2, _pilotCameraTargetPos, _weaponTargetPos, _eyeTargetPos];
