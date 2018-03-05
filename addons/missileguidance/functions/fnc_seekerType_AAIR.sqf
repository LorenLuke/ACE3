/*
 * Author: LorenLuke
 * Seeker Type: AA (MANPAD/AIM InfraRed)
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

params ["_args", "_feedback"];
_args params ["_source", "_posASL", "_dir", "_focusDir"];
_feedback params ["_timeParams", "_seekerParams", "_attackProfileParams", "_ancInfo"];
//_timeParams params ["_lastRunTime", "_timeDelta", "_timeModulus", "_timeModulusThreshold"];
_seekerParams params ["_seekerName", "_seekerAngle", "_seekerMaxRange", "_seekerHeadMaxAngle", "_seekerHeadMaxTraverse", "_seekerHead"];
_seekerHead params ["_seekerHeadX", "_seekerHeadY", "_seekerHeadUncaged"];

//_attackProfileParams params ["_attackProfileName", "_lastPosState", "_deflectionParameters", "_attackProfileMisc"];
//_deflectionParameters params ["_minDeflection", "_maxDeflection", "_incDeflection", "_dlyDeflection", "_curDeflection"];
//_lastPosState params ["_seekLastTargetPos", "_lastKnownTargetPos"];

//_ancInfo params ["_ancInfoSeeker", "_ancInfoAttackProfile"];


//Get Target
_targetsList = [];
{
	private _xPos = getPosASL _x;
	private _angleOkay = [_posASL, _dir, _xPos, _seekerAngle] call FUNC(checkSeekerAngle);

	private _losOkay = false;
	if (_angleOkay) then {
		_losOkay = [_posASL, _xPos, _source, _x] call FUNC(checkLos);
	};
	if (_angleOkay && _losOkay && isEngineOn _x) then {
		_targetsList = _targetsList + [_x]
	};
} forEach ((ASLToAGL _posASL) nearEntities [["Air"], _seekerMaxRange]);

//Get Countermeasures
{
	private _xPos = getPosASL _x;
	private _angleOkay = [_posASL, _dir, _xPos, _seekerAngle] call FUNC(checkSeekerAngle);

	private _losOkay = false;
	if (_angleOkay) then {
		_losOkay = [_posASL, _xPos, _source, _x] call FUNC(checkLos);
	};
	if (_angleOkay && _losOkay && isEngineOn _x) then {
		_targetsList = _targetsList + [_x];
	};
} forEach ((ASLToAGL _posASL) nearObjects ["CMflareAmmo", _seekerMaxRange]);

if (!(count _targetsList > 0) ) exitWith {[0,0,0]};

//find best target
private _seekerTargetsList = [];
private _angleThreshold = 0.1;

While {count _seekerTargetsList < 1} do {
	{
		private _xPos = aimPos _x;
		private _checkAngleThreshold = _angleThreshold;
		if (_x isKindOf "CMflareAmmo") then {
			_checkAngleThreshold = _checkAngleThreshold/4;
		};
    	if ([_posASL, _focusDir, _xPos, _checkAngleThreshold] call FUNC(checkSeekerAngle)) then {
	        _seekerTargetsList = _seekerTargetsList + [_x];
	    };

	} forEach _targetsList;
	_angleThreshold = _angleThreshold + 0.1;
};

//get engine position, if none, center of the model isn't bad either. :P
private _foundTargetPos = AGLToASL ((_seekerTargetsList select 0) modelToWorld ((_seekerTargetsList select 0) selectionPosition ["HitEngine","HitPoints"]));

_foundTargetPos;