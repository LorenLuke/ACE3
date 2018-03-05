/*
 * Author: LorenLuke
 * Assigns a PFH to a unit to check pre-guidance;
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Null
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_ancInfo_UNGUIDED;
 *
 * Public: No
 */
 
 #include "script_component.hpp"
 
params ["_unit"];

private _unitString = format ["GVAR(%1_preGuidanceCheckerPFH)", _unit];

//hint format ["%1", (count (missionNamespace getVariable _unitString))];

if(isNil {missionNamespace getVariable _unitString} ) then {
    private _pfh = [FUNC(preGuidanceChecker), 0.75, [_unit]] call CBA_fnc_addPerFrameHandler;
    missionNamespace setVariable [_unitString, [_pfh]];
} else {

    if( (count (missionNamespace getVariable _unitString)) <= 0) then {
        private _pfh = [FUNC(preGuidanceChecker), 0.75, [_unit]] call CBA_fnc_addPerFrameHandler;
        missionNamespace setVariable [_unitString, [_pfh]];
    };
};
