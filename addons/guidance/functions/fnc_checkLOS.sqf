#include "script_component.hpp"

params ["_pos1", "_pos2", ["_checkVisibilityTest", true], ["_ignore1", objNull], ["_ignore2", objNull]];

// Boolean checkVisibilityTest so that if the seeker type is one that ignores smoke we revert back to raw LOS checking.
if (_checkVisibilityTest) exitWith {
    private _visibility = [_ignore1, "VIEW", _ignore2] checkVisibility [_pos1, _pos2];
    _visibility > 0.001
};
if ((isNil "_pos1") || {isNil "_pos2"}) exitWith {
    false
};

private _return = true;

if (!((terrainIntersectASL [_pos1, _pos2]) && {terrainIntersectASL [_pos1, _pos2]})) then {
    if (lineIntersects [_pos1, _pos2, _ignore1, _ignore2]) then {
        _return = false;
    };
} else {
    _return = false;
};

_return;
