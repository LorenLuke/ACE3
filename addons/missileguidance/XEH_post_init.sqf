#include "script_component.hpp"

[QGVAR(handoff), {_this call FUNC(handleHandoff)}] call CBA_fnc_addEventHandler;

["ACE3 Weapons", QGVAR(cycleFireMode), localize LSTRING(CycleFireMode),
{
    [] call FUNC(cycleAttackProfileKeyDown);
    false
},
{
    false
},
[15, [false, true, false]], false] call CBA_fnc_addKeybind;  //Ctrl+Tab Key

//if (!hasInterface) exitWith {};

GVAR(pfID) = -1;

["ace_settingsInitialized", {
	["weapon", LINKFUNC(preGuidanceAssign), true] call CBA_fnc_addPlayerEventHandler;
	["turret", LINKFUNC(preGuidanceAssign), true] call CBA_fnc_addPlayerEventHandler;
	["vehicle", LINKFUNC(preGuidanceAssign), true] call CBA_fnc_addPlayerEventHandler;
}] call CBA_fnc_addEventHandler;
