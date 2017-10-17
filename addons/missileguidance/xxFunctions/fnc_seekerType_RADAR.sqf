/*
 * Author: LorenLuke
 * Seeker Type: AA (MANPAD InfraRed)
 *
 * Arguments:
 * 1: Guidance Arg Array <ARRAY>
 * 2: Seeker State <ARRAY>
 *
 * Return Value:
 * Missile Aim PosASL <ARRAY>
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_seekerType_AA;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["", "_args"];
_args params ["_firedEH", "_launchParams", "", "_seekerParams", "_stateParams"];
_firedEH params ["","","","","","","_projectile"];
_launchParams params ["", "_targetParams"];
_targetParams params ["_target"];
_seekerParams params ["_seekerAngle", "", "_seekerMaxRange"];

hintSilent "AA!";
_targetsList = [];
{
	private _xPos = aimPos _x;
	private _angleOkay = [_projectile, _xPos, _seekerAngle] call FUNC(checkSeekerAngle);

	private _losOkay = false;
	if (_angleOkay) then {
		_losOkay = [_projectile, _x] call FUNC(checkLos);
	};
	if (_angleOkay && _losOkay && isEngineOn _x) then {
		_targetsList = _targetsList + [_x]
	};
	
} forEach (_projectile nearEntities ["Air", _seekerMaxRange]);


private _seekerTargetsList = [];
private _angleThreshold = 1;

if (count _targetsList == 0) exitWith {[0,0,0]};

While {count _seekerTargetsList < 1} do {
	{
		private _xPos = aimPos _x;
    	if ([_projectile, _xPos, _angleThreshold] call FUNC(checkSeekerAngle)) then {
	        _seekerTargetsList = _seekerTargetsList + [_x];
	    };

	} forEach _targetsList;
	_angleThreshold = _angleThreshold + 1;
};


private _foundTargetPos = aimPos (_seekerTargetsList select 0);
TRACE_1("Search", _foundTargetPos);

_foundTargetPos;



