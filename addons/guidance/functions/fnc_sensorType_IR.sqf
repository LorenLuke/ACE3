#include "script_component.hpp"


params ["_pos", "_normalLookDirection", "_angle", "_range", "_eh", "_seekerArray", "_targetArray", "_sensorMisc"];
_eh params ["_shooter", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_instigator"];
_seekerArray params ["_seekerName", "_tracking", "_trackObject", "_trackPoint", "_trackDirection", "_terminalRange", "_terminalAngle"];
_targetArray params ["_target", "_targetPos", "_targetVector"];
_sensorMisc params ["_vectorTo"];

private _object = _shooter;
if( !isNull _projectile) then {
    _object = _projectile;
};
//Get Targets and Countermeasures
_targetsList = [];
{
    private _xPos = getPosASL _x;
    private _angleOkay = acos((_pos vectorFromTo _xPos) vectorCos _normalLookDirection) < _angle;

    private _losOkay = false;
    if (_angleOkay) then {
        _losOkay = [_pos, _xPos, true, _object, _x] call FUNC(checkLOS);
    };
    if (_angleOkay && _losOkay && isEngineOn _x && (_x != _shooter)) then {
        _targetsList pushBack _x;
        drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [1,0.5,1,1], ASLtoAGL _xPos, 0.75, 0.75, 0, str(_x), 1, 0.025, "TahomaB"];
    } else {
        drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [1,0.5,0,1], ASLtoAGL _xPos, 0.75, 0.75, 0, str(_x), 1, 0.025, "TahomaB"];
    };
} forEach ((ASLToAGL _pos) nearEntities [["Air"], _range]);

//Get Countermeasures
private _countermeasuresTargetsList = [];
{
    _y = _x;
    {
        if ((_targetsList find _x) < 0) then {
            private _xPos = getPosASL _x;
            private _angleOkay = acos((_pos vectorFromTo _xPos) vectorCos _normalLookDirection) < _angle;

            private _losOkay = false;
            if (_angleOkay) then {
                _losOkay = [_pos, _xPos, true, _object, _x] call FUNC(checkLOS);
            };
            if (_angleOkay && _losOkay) then {
                _countermeasuresTargetsList pushBack _x;
                drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0,1,1,1], ASLtoAGL _xPos, 0.75, 0.75, 0, str(_x), 1, 0.025, "TahomaB"];
            } else {
                drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [0,1,0,1], ASLtoAGL _xPos, 0.75, 0.75, 0, str(_x), 1, 0.025, "TahomaB"];
            };
        };
    } forEach ((getPos _y) nearObjects ["CMflareAmmo", 50]);
} forEach _targetsList;

_targetsList = _targetsList + _countermeasuresTargetsList;

if (!(count _targetsList > 0) ) exitWith {
    [0,0,0];
};


//find best target
_foundTargetPos = [0,0,0];
_seekerTargetsList = [];
private _angleThreshold = 0.1;
private _flareCoeff = 1.5; //treats a flare of having an angle (1/x) times its actual angle
while {(count _seekerTargetsList) < 1 && (_angleThreshold < _angle)} do {
    {
        private _xPos = getPosASL _x;
        private _checkAngleThreshold = _angleThreshold - (0.5 + (random 0.8)); // add a bit of jitter
        if (_x isKindOf "CMflareAmmo") then {
            _checkAngleThreshold = _checkAngleThreshold * _flareCoeff;
        };

        if (
            (acos((_pos vectorFromTo _xPos) vectorCos _targetVector) < _angleThreshold) &&
            [_pos, _xPos, true, _object, _x] call FUNC(checkLOS);
        ) then {
            _seekerTargetsList pushBack _x;
        };

    } forEach _targetsList;

    _angleThreshold = _angleThreshold + 0.1;
};

if ((count _seekerTargetsList) < 1) exitWith {
    [0,0,0];
}; 

//get engine position, if none, center of the model isn't bad either. :P
private _foundTargetPos = AGLToASL ((_seekerTargetsList select 0) modelToWorldWorld ((_seekerTargetsList select 0) selectionPosition ["HitEngine","HitPoints"]));

_foundTargetPos = getPosASL (_seekerTargetsList select 0);
_sensorMisc set [0, _pos vectorFromTo _foundTargetPos];

_foundTargetPos;