/*
 * Author: PabstMirror
 * Find a target within the optic range
 *
 * Arguments:
 * 0: Last Target (seeds the scan) <OBJECT>
 * 1: Max Range (meters) <NUMBER>
 *
 * Return Value:
 * Target <OBJECT>
 *
 * Example:
 * [bob, 5] call ace_javelin_fnc_getTarget
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_maxRange"];

scopeName "main";

private _viewASL = AGLtoASL positionCameraToWorld [0,0,0];
private _viewDir = _viewASL vectorFromTo (AGLtoASL positionCameraToWorld [0,0,1]);

// Attempt to scan using multiple rayscasts - This is expensive (n^2) and care should be given to balance accuracy vs speed
private _masterList = [];
private _objList = [];
private _distanceList = [];
private _workingList = [];
private _sigma_avg = 0;
private _sigma = 0;
private _zList = [];
private _sigma2_avg;
private _sigma2 = 0;
private _zList2 = [];
private _unit = objNull;

private _count = 0;
private _sum = 0;
private _median = 0;
private _average = 0;

private _step = 10;
private _lockThreshold = 0.2;


if(isNil QGVAR(pointData)) then {
    GVAR(pointData) = [time, [], []];
    hint "ding";
    hint format ["%1", GVAR(pointData)];
};

if ( (time - (GVAR(pointData) select 0)) > 0.2 ) then {
    GVAR(pointData) = [time, [], []];    
};

for "_xOffset" from (-0.5 * GVAR(gateDistanceX)) to (0.5 * GVAR(gateDistanceX)) step (GVAR(gateDistanceX)/_step) do {
    for "_yOffset" from (-0.5 * GVAR(gateDistanceY)) to (0.5 * GVAR(gateDistanceY)) step (GVAR(gateDistanceY)/_step) do {

        private _testPosASL = AGLtoASL (positionCameraToWorld [tan(_xOffset) * _maxRange, tan(_yOffset) * _maxRange, _maxRange]);
        private _intersectionsToCursorTarget = lineIntersectsSurfaces [_viewASL, _testPosASL, ace_player, vehicle ace_player, true, 1];
        _distance = 0;
        if(count _intersectionsToCursorTarget == 0) then {
            _intersectionsToCursorTarget = [[_testPosASL, [0,0,0], objNull, objNull]];
            _objList = _objList + [objNull];
        } else {
            _distance = abs vectorMagnitude (((_intersectionsToCursorTarget select 0) select 0) vectorDiff _viewASL);
            _objList = _objList + [((_intersectionsToCursorTarget select 0) select 2)] ;
        };
        _masterList = _masterList + [_intersectionsToCursorTarget select 0];
        
        _distanceList = _distanceList + [_distance];
        _sum = _sum + _distance;
        if (_distance > 0) then {_count = _count + 1};
    };
};

if (_count == 0) then {
    _count = 1;
};

_sigma_avg = _sum / _count;
_sum = 0;
{
    if(_x > 0) then {
        _sum = _sum + ((_x - _sigma_avg)^2);
    };
} forEach _distanceList;
_sigma = sqrt(_sum / _count);

if (_sigma == 0) then {
    _sigma = 1;
};

_sum = 0;
{
    _z = -99;
    if (_x > 0) then {
        _z = (_x - _sigma_avg) / _sigma;
        _sum = _sum + _z;
    };
    _zList = _zList + [_z];
} forEach _distanceList;

_sigma2_avg = _sum / _count;
_sum = 0;
{
    if(_x != -99) then {
        _sum = _sum + ((_x - _sigma2_avg)^2);
    };
} forEach _zList;
_sigma2 = sqrt(_sum /_count);

{
    _z = -99;
    if (_x > 0) then {
        _z = (_x - _sigma2_avg) / _sigma2;
    };
    _zList2 = _zList2 + [_z];
} forEach _zList;


hint format ["%1\n%2\n%3\n%4", _sigma_avg, _sigma2_avg, _sigma, _sigma2];


_listFar = [];
_listNear = [];
_listTol = [];
_far_avg = [0,0,0];
_near_avg = [0,0,0];
_tol_avg = [0,0,0];

for "_i" from (0) to (count (_masterList) - 1) do {
    _x = _masterList select _i;
    _d = _distanceList select _i;

    _tolerance = 0.6;    
    if (count (_zList) > 0) then {
        _z = _zList select _i;    
        _red = ((_tolerance - abs(_z)) min 1) max 0; 
        _green = if(!(isNull _o) && ( ((typeOf _o) isKindOf "AllVehicles") || ((typeOf _o) isKindOf "Man")) ) then {1} else {0};
        if (_d != 0) then {
            if((abs(_z - _sigma2_avg)) > _tolerance) then {
                if(_z - _sigma2_avg > 0) then {
                    _listFar = _listFar + [_z];
                    _far_avg = _far_avg vectorAdd [floor(_i/_step),_i%_step, 0];
                } else {
                    _listNear = _listNear + [_z];
                    _near_avg = _near_avg vectorAdd [floor(_i/_step),_i%_step, 0];
                };
            } else {
                _listTol = _listTol + [_z];
                _tol_avg = _tol_avg vectorAdd [floor(_i/_step),_i%_step, 0];
            };
        };
    };
};

_far_avg = _far_avg vectorMultiply (1/(1 max (count _listFar)));
_near_avg = _near_avg vectorMultiply (1/(1 max (count _listNear)));
_tol_avg = _tol_avg vectorMultiply (1/(1 max (count _listTol)));

_sigma_far = [0,0,0];
_sigma_near = [0,0,0];
_sigma_tol = [0,0,0];

hint format ["%1\n%2\n%3", _far_avg, _near_avg, _tol_avg];

/*
if(count _listFar > 0) then {
    _sigma_sum = [0,0,0];
    {
        _matrix = _x vectorDiff _far_avg;
        _matrix set [0, (_matrix select 0)^2];
        _matrix set [1, (_matrix select 1)^2];
        _sigma_sum = _sigma_sum vectorAdd _matrix;
    } forEach _listFar;
    _sigma_sum = _sigma_sum vectorMultiply (1/(count _listFar));
    _sigma_sum set [0, sqrt(_sigma_sum select 0)];
    _sigma_sum set [1, sqrt(_sigma_sum select 1)];
    _sigma_far = _sigma_sum;
};

if(count _listNear > 0) then {
    _sigma_sum = [0,0,0];
    {
        _matrix = _x vectorDiff _near_avg;
        _matrix set [0, (_matrix select 0)^2];
        _matrix set [1, (_matrix select 1)^2];
        _sigma_sum = _sigma_sum vectorAdd _matrix;
    } forEach _listNear;
    _sigma_sum = _sigma_sum vectorMultiply (1/(count _listNear));
    _sigma_sum set [0, sqrt(_sigma_sum select 0)];
    _sigma_sum set [1, sqrt(_sigma_sum select 1)];
    _sigma_near = _sigma_sum;
};

if(count _listTol > 0) then {
    _sigma_sum = [0,0,0];
    {
        _matrix = _x vectorDiff _tol_avg;
        _matrix set [0, (_matrix select 0)^2];
        _matrix set [1, (_matrix select 1)^2];
        _sigma_sum = _sigma_sum vectorAdd _matrix;
    } forEach _listTol;
    _sigma_sum = _sigma_sum vectorMultiply (1/(count _listTol));
    _sigma_sum set [0, sqrt(_sigma_sum select 0)];
    _sigma_sum set [1, sqrt(_sigma_sum select 1)];
    _sigma_tol = _sigma_sum;
};


_different = [0,0,0];
_count = 0;
{
    _list = _x;
    {
        if(_x % _step > 1 && _x > _step && _x < ((_step^2) - _step)) then {
//            if(!((_x + 1) in _list) || !((_x-1) in _list) || ((_x + _step) in _list) || ((_x - _step) in _list)) then {
            if(!((_x + 1) in _list) || !((_x-1) in _list) || !((_x + _step) in _list) || !((_x - _step) in _list)) then {
                _count = _count + 1;
//                _different set [0, (_different select 0) + (_x % step)];
//                _different set [1, (_different select 0) + floor(_x/step)];
            };
        };
    } forEach _list;
} forEach [_listFar, _listAir, _listNear, _listTol];

//hint format ["%1\n%2\n%3",_different, _step, _count];

objNull;
*/



for "_i" from (0) to (count (_masterList) - 1) do {
    _x = _masterList select _i;
    _d = _distanceList select _i;
    _o = _objList select _i;
    

    _o = _objList select _i;
    if(!(_o in _objs)) then {
        (_objs select 0) pushBack [_o];
        (_objs select 1) pushBack [(count (_masterList))];
    } else {
        _index = (_objs select 0) find _o;
        (_objs select 1) set [_index, ((_objs select 1) select _index) + (1/(count (_masterList)))];
    };

    _red = 0;
    _green = 1;
    _blue = 0;
    if (count (_zList) > 0) then {
        _z = _zList select _i;    
        _tolerance = 0.6;
        _red = ((_tolerance - abs(_z)) min 1) max 0; 
        _green = if(!(isNull _o) && ( ((typeOf _o) isKindOf "AllVehicles") || ((typeOf _o) isKindOf "Man")) ) then {1} else {0};
        if (_d == 0) then {
            _red = 1;
            _blue = 1;
            _listAir = _listAir + [_i];
        } else {
            if((abs(_z - _sigma2_avg)) > _tolerance) then {
                if(_z - _sigma2_avg > 0) then {
                    _listFar = _listFar + [_i];
                    _red = 1;
                    _green = 0;
                    _blue = 0;

                } else {
                    _listNear = _listNear + [_i];
                    _red = 0;
                    _green = 0;
                    _blue = 1;
                };
            } else {
                //_blue = 0;
                _listTol = _listTol + [_i];
            };
        };
        //hintSilent format ["%1\n%2\n\n%3\n%4\n%5", _z, _zList2 select _i, _red, _green, _blue];

    };
    _color = [_red,_green,_blue,1];
//    _color = [1,1,1,1];
    
    drawIcon3D ["\A3\ui_f\data\map\markers\military\dot_CA.paa", _color, (ASLToAGL (_x select 0)), 0.25, 0.25, 0, "", 0.5, 0.025, "TahomaB"];
};
