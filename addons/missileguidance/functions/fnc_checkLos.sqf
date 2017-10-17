/*
 * Author: jaynus
 * Returns whether the seeker object can see the target position with lineIntersect
 *
 * Arguments:
 * 0: Seeker <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * Has LOS <BOOL>
 *
 * Example:
 * [player, cursorTarget] call ace_missileguidance_fnc_checkLOS;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_seekerPos", "_targetPos", "_seeker", "_target"];

if ((isNil "_seeker") || {isNil "_target"}) exitWith {
    ERROR_2("nil",_seeker,_target);
    false
};

private _return = true;

if (!(terrainIntersectASL [_seekerPos, _targetPos])) then {
    if (lineIntersects [_seekerPos, _targetPos, _seeker, _target]) then {
        _return = false;
    };
} else {
    _return = false;
};

_return;
