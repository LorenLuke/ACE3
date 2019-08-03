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

private _list = [];
private _meanpoint = [0,0,0];
private _meancount = 0;

// Attempt to scan using multiple rayscasts - This is expensive (n^2) and care should be given to balance accuracy vs speed

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
	_list pushBack [];
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
        if (_distance > 0) then {
			_meanpoint = _meanpoint vectorAdd ((_intersectionsToCursorTarget select 0) select 0);
			_meancount = _meancount + 1;
			(_list select ((count _list)-1)) pushBack ((_intersectionsToCursorTarget select 0) select 0);

		} else {
		    (_list select ((count _list)-1)) pushBack (_testPosASL);
		};
    };
};

_meanpoint = _meanpoint vectorMultiply (1/(1 max _meancount));

_maxdist = 0;

_distList = +_list;
{
    _y = _x;
	_y_0 = +_y
    {
	    _dis = _x distance _meanpoint;
		_y set [_y find _x, _dis];
	} forEach _y;
//	_disList set [_distList find _y, _dis];
} forEach _distList;

private _coord = [0,0];
while {_coord select 0 < _step} do {

	if(_coord select 1 >= _step) then {
	    _coord set [0, (_coord select 0) + 1];
		_coord set [1, 0];
	} else {
        _loc = (_list select (_coord select 0)) select (_coord select 1);
        drawIcon3D ["\A3\ui_f\data\map\markers\military\dot_CA.paa", [0,1,0,1], (ASLToAGL _loc), 0.25, 0.25, 0, "", 0.5, 0.025, "TahomaB"];
        _coord set [1, (_coord select 1) + 1];
	};
}
