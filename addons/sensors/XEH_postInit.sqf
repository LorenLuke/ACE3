#include "script_component.hpp"

["AllVehicles", "init", {
    params ["_vehicle"];

    if (hasPilotCamera _vehicle) then {
        //Lock to current Target
        private _actionCurrentTarget =  ["camToCurrentTarget", "lock cam to target", "", {[_this select 0] call FUNC(lockPilotCameraCursorTarget)}, {driver (_this select 0) == ACE_Player}] call ace_interact_menu_fnc_createAction;
        [_vehicle, 1, ["ACE_SelfActions"], _actionCurrentTarget] call ace_interact_menu_fnc_addActionToObject;        
        
        //Lock to look direction
        private _actionLookDirection =  ["camToCurrentTarget", "lock cam to eyelook", "", {[_this select 0, driver (_this select 0)] call FUNC(lockPilotCameraEyeDirection)}, {driver (_this select 0) == ACE_Player}] call ace_interact_menu_fnc_createAction;
        [_unit, 1, ["ACE_SelfActions"], _actionLookDirection] call ace_interact_menu_fnc_addActionToObject;
        
        
    };
}, true, [], true] call CBA_fnc_addClassEventHandler;
