/*
 * Author: jaynus / nou; rewrite by LorenLuke
 * Seeker Type: SALH (Laser)
 * Wrapper for ace_laser_fnc_seekerFindLaserSpot
 *
 * Arguments:
 * 1: Guidance Arg Array <ARRAY>
 * 2: Seeker State <ARRAY>
 *
 * Return Value:
 * Missile Aim PosASL <ARRAY>
 *
 * Example:
 * [[], [], []] call ace_missileguidance_fnc_seekerType_SALH;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_args", "_feedback"];
_args params ["_source", "_posASL", "_dir", "_focusDir"];
_feedback params ["_timeParams", "_seekerParams", "_attackProfileParams", "_ancInfo"];
_timeParams params ["_lastRunTime", "_timeDelta", "_timeModulus", "_timeModulusThreshold"];
_seekerParams params ["_seekerName", "_seekerAngle", "_seekerMaxRange", "_seekerHeadMaxAngle", "_seekerHeadMaxTraverse", "_seekerHead"];
_seekerHead params ["_seekerHeadX", "_seekerHeadY", "_seekerHeadUncaged"];

_attackProfileParams params ["_attackProfileName", "_lastPosState", "_deflectionParameters", "_attackProfileMisc"];
_deflectionParameters params ["_minDeflection", "_maxDeflection", "_incDeflection", "_dlyDeflection", "_curDeflection"];
_lastPosState params ["_seekLastTargetPos", "_lastKnownTargetPos"];

_ancInfo params ["_ancInfoSeeker", "_ancInfoAttackProfile"];

private _code = _ancInfoSeeker select 0;
private _wavelengthMin = _ancInfoSeeker select 1;
private _wavelengthMax = _ancInfoSeeker select 2;


private _laserResult = [_posASL, _focusDir, _seekerAngle, _seekerMaxRange, [_wavelengthMin, _wavelengthMax], _code, _source] call EFUNC(laser,seekerFindLaserSpot);
private _foundTargetPos = [];

{
	private _angleCheck = [_posASL, _dir, getPosASL _x, _seekerAngle] call FUNC(checkSeekerAngle); 
	if(_angleCheck) then {
		private _losCheck = [_posASL, getPosASL _x, _source, _x] call FUNC(checkLos); 
		if(_losCheck) exitWith {
			_foundTargetPos = getPosASL _x;
		};
	};
} forEach _laserResult;

if (!(count _foundTargetPos) > 0) then {};
	_foundTargetPos = [0,0,0];
};

_foundTargetPos;
