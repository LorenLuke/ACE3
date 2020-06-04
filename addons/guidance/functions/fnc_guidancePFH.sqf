#include "script_component.hpp"

params ["_args", "_pfID"];
_args params ["_eh", "_timeArray", "_targetArray", "_seekerArray", "_sensorArray", "_profileArray", "_launchArray", "_flightArray"];

_eh params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_instigator"];

_timeArray params ["_runtimeDelta", "_lastRunTime", "_lastTickTime"];
_targetArray params ["_cursorTarget", "_pilotCameraTarget", "_pilotCameraTargetPos", "_weaponTargetPos", "_eyeTargetPos"];
//_sensorParams params ["_sensorName", "_sensorFunction", "_active", "_activeOnRail", "_terminal", "_lookDirection", "_angle", "_range", "_priority", "_sensorMisc"];
_seekerArray params ["_seekerName", "_seekerFunction", "_tracking", "_trackObject", "_trackPoint", "_trackDirection", "_terminalRange", "_terminalAngle", "_seekerMisc"];
_profileArray params ["_profileName", "_profileFunction", "_profileMisc"];
_launchArray params ["_launched", "_launchTime", "_launchPos", "_launchVehicle", "_launchProjectileVector", "_launchWeaponVector", "_launchInstigatorEyeVector"];
_flightArray params ["_degreesPerSecond", "_lastFlightVector"];


if (_lastRunTime == time) exitWith {
    _runtimeDelta = 0;
    _args set [1, [_runtimeDelta, time, diag_tickTime]];
};

_runtimeDelta = accTime * (diag_tickTime - _lastTickTime);
_args set [1, [_runtimeDelta, time, diag_tickTime]];

if ( (isNull _projectile) && _launched) exitWith {
    [_pfID] call CBA_fnc_removePerFrameHandler;
    _variableString = format ["%1_%2", QGVAR(guidanceArray), _pfID];
    _unit setVariable [_variableString, nil];    
};

if ( !(isNull _projectile) && !(_launched) ) then {
    if(isNil "_instigator") then {
        _instigator = (getShotParents _projectile) select 0;
    };
    _launchArray = [true, time, getPosASLVisual _projectile, _unit, vectorNormalized (velocity _projectile), vectorNormalized (velocity _projectile), eyeDirection _instigator];
    _args set [6, _launchArray];
    _variableString = format ["%1_%2", QGVAR(guidanceArray), _pfID];
    _unit setVariable [_variableString, [_args,_pfID]];    
    _unit setVariable [QGVAR(guidanceArray), nil];
    if ( (_unit ammo _weapon) != 0 ) then {
        [_unit] call FUNC(checkPreGuidance);
    };
};


if ( !_launched && ((_magazine != currentMagazine _unit) || (_weapon != currentWeapon _unit)) ) exitWith {
    [_pfID] call CBA_fnc_removePerFrameHandler;
};

private _selectedTargetArray = [];
private _pos = _projectile modelToWorldVisualWorld [0,0,0];
if ( !(_launched)) then {
    _targetArray = _eh call FUNC(updateTargets);
    _args set [2, _targetArray];
    _unit setVariable [QGVAR(guidanceArray), [_args,_pfID]];    

    if((typeOf _unit) isKindOf "Man") then {
        _pos = _unit modelToWorldVisualWorld (_unit selectionPosition "righthand");
    } else {
        private _turretPath = [_unit, _weapon] call CBA_fnc_turretPathWeapon;
        private _turretConfig = [_unit, _turretPath] call CBA_fnc_getTurret;
        private _memoryPointGunnerOptics = getText(_turretConfig >> "memoryPointGunnerOptics");
        _pos = _unit modelToWorldVisualWorld (_unit selectionPosition _memoryPointGunnerOptics);
    };
};    

if( !(_pilotCameraTargetPos isEqualTo [0,0,0])) then {
    if( !(isNull _pilotCameraTarget)) then {
        _selectedTargetArray = [_pilotCameraTarget, _pilotCameraTargetPos, _pos vectorFromTo _pilotCameraTargetPos];
    } else {
        _selectedTargetArray = [_cursorTarget, _pilotCameraTargetPos, _pos vectorFromTo _pilotCameraTargetPos];
    };
} else {
    if( !(isNull _cursorTarget)) then {
        _selectedTargetArray = [_cursorTarget, getPosASLVisual _cursorTarget, _pos vectorFromTo getPosASLVisual _cursorTarget];
    } else {
        if(_unit == _instigator) then {
            _selectedTargetArray = [objNull, _eyeTargetPos, _pos vectorFromTo _eyeTargetPos];
        } else {
            _selectedTargetArray = [objNull, _weaponTargetPos, _pos vectorFromTo _weaponTargetPos];
        };
    };
};


if (_tracking) then {
    _seekerArray set [3, _selectedTargetArray select 0];
    _seekerArray set [4, _selectedTargetArray select 1];
    _seekerArray set [5, _selectedTargetArray select 2];
};



   
private _sensorTargetPosition = [0,0,0];
private _sensorTargetVector = [0,0,0];
private _divisor = 0;
private _returns = [];
{
    _x params ["_sensorName", "_sensorFunction", "_active", "_activeOnRail", "_terminal", "_lookDirection", "_angle", "_range", "_priority", "_sensorMisc"];
    _sensorMisc = [_eh, _x, _seekerArray, _selectedTargetArray] call FUNC(generateSensorMisc);
    _x set [9, _sensorMisc];
    private _returnArray = ([_pos, _eh, _x, _seekerArray, _selectedTargetArray] call FUNC(runSensorSearch));
    _returnArray pushBack _priority;
    _returns pushback _returnArray;
} forEach _sensorArray;

{
    if (!((_x select 0) isEqualTo [0,0,0])) then {
        private _priority = (_x select 2);
        _sensorTargetPosition = _sensorTargetPosition vectorAdd ((_x select 0) vectorMultiply _priority);
        _sensorTargetVector = _sensorTargetVector vectorAdd ((_x select 1) vectorMultiply _priority);
        _divisor = _divisor + _priority;
    };
} forEach _returns;





if(_divisor == 0) exitWith {};

_sensorTargetPosition = _sensorTargetPosition vectorMultiply (1/_divisor);
_sensorTargetVector = _sensorTargetVector vectorMultiply (1/_divisor);


[_pos, [_sensorTargetPosition, _sensorTargetVector],_args] call FUNC(runSeeker);

drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0.7,0.7,0.7,1], ASLtoAGL _pos, 0.75, 0.75, 0, _ammo, 1, 0.025, "TahomaB"];
if ( !((_selectedTargetArray select 1) isEqualTo [0,0,0]) ) then {
    drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0.9,0.6,0.6,1], ASLtoAGL (_pos vectorAdd (_selectedTargetArray select 2)), 0.75, 0.75, 0, "vector", 1, 0.025, "TahomaB"];
    drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [1,0.7,0.7,1], ASLtoAGL (_selectedTargetArray select 1), 0.75, 0.75, 0, "TargetPos", 1, 0.025, "TahomaB"];
    drawLine3D [ASLToAGL (_pos),  ASLtoAGL (_selectedTargetArray select 1), [1,0,0,1]];
    if( !(isNull (_selectedTargetArray select 0)) ) then {
        drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0.9,0.2,0.2,1], getPos (_selectedTargetArray select 0), 0.75, 0.75, 0, "Target", 1, 0.025, "TahomaB"];
    };
};

if (! ((_sensorTargetPosition select 0) isEqualTo [0,0,0]) ) then {
    drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0.6,0.9,0.6,1], ASLtoAGL (_pos vectorAdd (_sensorTargetVector)), 0.75, 0.75, 0, "vector", 1, 0.025, "TahomaB"];
    drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0.7,1,0.7,1], ASLtoAGL (_sensorTargetPosition), 0.75, 0.75, 0, "sensor", 1, 0.025, "TahomaB"];
    drawLine3D [ASLToAGL (_pos),  ASLtoAGL (_sensorTargetPosition), [0,1,0,1]];
};

if (_launched) then {
    private _velocityVector = velocity _projectile;
    private _vectorToFlyPos = _pos vectorFromTo _sensorTargetPosition;
    if(!(_sensorTargetPosition isEqualTo [0,0,0])) then {

        private _vectorToFlyPos = _pos vectorFromTo _sensorTargetPosition;
        private _crossVector = vectorNormalized (_velocityVector vectorCrossProduct _vectorToFlyPos);
        private _angleTo = acos(_velocityVector vectorCos _vectorToFlyPos);
        
        private _angleToTurn = (_degreesPerSecond * _runtimeDelta) min _angleTo;

        if(_angleToTurn != 0) then {
            private _vector = [velocity _projectile, _crossVector, _angleToTurn] call CBA_fnc_vectRotate3D;
            private _v = vectorNormalized _vector;
            _projectile setVelocity ( (_vector vectorMultiply (1- (0.0025 * _angleToTurn)) ) vectorAdd [0,0,-9.80665 * _runtimeDelta] );
            private _l = sqrt ((_v select 0) ^ 2 + (_v select 1) ^ 2);
            if(_l == 0) then {
                _projectile setVectorDirAndUp [ _v, [0, 1, 0] ];
            } else {
                private _r = -(_v select 2);
                _projectile setVectorDirAndUp [ _v, [(_v select 0) * _r,(_v select 1) * _r, _l] ];
            };
        };
    };
};



/*
private _v = [vectorNormalized(velocity _projectile), _crossVector, _angleToTurn] call CBA_fnc_vectRotate3D;


private _l = sqrt ((_v select 0) ^ 2 + (_v select 1) ^ 2);
if(_l == 0) then {
    _projectile setVectorDirAndUp [ _v, [0,_v,0] ];
} else {
    private _r = -(_v select 2) / _l;
    _projectile setVectorDirAndUp [ _v, [(_v select 0) * _r,(_v select 1) * _r, _l] ];

_projectile setVelocity ((_v vectorMultiply (vectorMagnitude (velocity _projectile))) vectorAdd ([0,0,-9.80665 * _runtimeDelta]) );
*/


private _guidanceArray = _unit getVariable [QGVAR(guidanceArray), _this];

/*
if( !(isNull _projectile)) then {

    if (
        (acos((velocity _projectile) vectorCos _sensorTargetVector) < _terminalAngle) || 
        ((_pos distance _launchPos) > _terminalRange)
    ) then {
        {
            _x params ["", "", "_active", "_terminal"];
            _x set [2, ([false, true] select _terminal];
        } forEach _sensorArray;
    };

    [_pos, _sensorTargetPosition, _sensorArray, _seekerArray, _launchArray] call _seekerFunction;
    private _profileTargetPosition = [_pos, _sensorTargetPosition] call _profileFunction;

    private _velocityVector = velocity _projectile;
    private _vectorToFlyPos = _pos vectorFromTo _profileTargetPosition;
    private _crossVector = _velocityVector vectorCrossProduct _vectorToFlyPos;
    private _angleTo = acos(_velocityVector vectorCos _vectorToFlyPos);
    
};
*/


