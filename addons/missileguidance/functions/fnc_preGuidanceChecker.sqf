/*
 * Author: LorenLuke
 * Loop, checks for PreGuidance-enabled weapons and assigns a PFH
 *
 * Arguments:
 * 0: Args <ARRAY>
 * 0-0: Unit <OBJECT>
 * 1: Per frame handler ID <NUMBER>
 *
 * Return Value:
 * PFH handler <NUMBER>
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_ancInfo_UNGUIDED;
 *
 * Public: No
 */
 
 #include "script_component.hpp";

params ["_args","_pfID"];
_args params ["_unit"];

if (_unit != ACE_player) exitWith {
    hint "unit not ace!";
    [_pfID] call CBA_fnc_removePerFrameHandler;
};

private _veh = vehicle _unit;
private _vehString = format ["GVAR(%1_preGuidancePFH)", _veh];

if(isNil {missionNamespace getVariable _vehString} ) then {
    missionNamespace setVariable [_vehString, []];
};
private _arr  = (missionNamespace getVariable _vehString);

if(count _arr > 0) exitWith {
    hint "already running preguidance!";
    [_pfID] call CBA_fnc_removePerFrameHandler;
};

//Now to the juicy config extrapolation;
private _weapon = (currentWeapon _veh);
private _magazine = (currentMagazine _veh);
private _ammo = getText (configFile >> "CfgMagazines" >> _magazine >> "ammo");

//hint "ding2";

if ((getNumber (configFile >> "CfgAmmo" >> _ammo >> "ace_missileguidance" >> "enabled")) == 1) then {
	private _pfh = [FUNC(preGuidancePFH), 0, [_veh, _weapon, _magazine, _ammo]] call CBA_fnc_addPerFrameHandler;
    missionNamespace setVariable [_vehString, [_pfh]];
};
