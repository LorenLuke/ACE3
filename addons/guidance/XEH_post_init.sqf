#include "script_component.hpp"
/*
if (hasInterface) then {
    #include "initKeybinds.sqf";
}
*/

["weaponmode", {
    params ["_unit"];
    [_unit] call FUNC(checkPreGuidance);
}, true] call CBA_fnc_addPlayerEventHandler;