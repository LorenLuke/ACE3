/*
 * Author: LorenLuke
 * Handles the drawing of indicators in the Javelin display.
 * (Based on javelin_fnc_showFireMode.sqf by Jaynus)
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_javelin_fnc_drawIndicators;
 *
 * Public: No
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _currentShooter = if (ACE_player call CBA_fnc_canUseWeapon) then {ACE_player} else {vehicle ACE_player};
private _currentFireMode = _currentShooter getVariable ["ace_missileguidance_attackProfile", "JAV_TOP"];
TRACE_1("showFireMode", _currentFireMode);

if (!(GVAR(inOptic))) exitWith {};




if (_currentFireMode == "JAV_TOP") then {
    __JavelinIGUITop ctrlSetTextColor __ColorGreen;
    __JavelinIGUIDir ctrlSetTextColor __ColorGray;
} else {
    __JavelinIGUITop ctrlSetTextColor __ColorGray;
    __JavelinIGUIDir ctrlSetTextColor __ColorGreen;
};

__JavelinIGUIDay_indicator ctrlSetTextColor __ColorGray;
__JavelinIGUIWFOV_indicator ctrlSetTextColor __ColorGray;
__JavelinIGUINFOV_indicator ctrlSetTextColor __ColorGray;
__JavelinIGUISeek_indicator ctrlSetTextColor __ColorGray;
__JavelinIGUIFLTR_indicator ctrlSetTextColor __ColorGray;
__JavelinIGUITargeting ctrlShow true;
__JavelinIGUIDay_group ctrlShow false;
__JavelinIGUIWFOV_group ctrlShow false;
__JavelinIGUINFOV_group ctrlShow false;
__JavelinIGUITargetingConstrains ctrlShow false;
__JavelinIGUITargetingGate ctrlShow false;
__JavelinIGUITargetingLines ctrlShow false;

switch (GVAR(opticMode)) do {
	case (0): {
		__JavelinIGUIDay_indicator ctrlSetTextColor __ColorGreen;
		__JavelinIGUIDay_group ctrlShow true;
	};
	case (1): {
		__JavelinIGUIWFOV_indicator ctrlSetTextColor __ColorGreen;
		__JavelinIGUIFLTR_indicator ctrlSetTextColor __ColorGreen;
		__JavelinIGUIWFOV_group ctrlShow true;
	};
	case (2): {
		__JavelinIGUINFOV_indicator ctrlSetTextColor __ColorGreen;
		__JavelinIGUIFLTR_indicator ctrlSetTextColor __ColorGreen;
		__JavelinIGUINFOV_group ctrlShow true;
	};
	case (3): {
		private _offsetX = 0.5 * safeZoneW - safeZoneX - 0.5;
		private _offsetY = 0.5 * safeZoneH - safeZoneY - 0.5;
		private _centerpointX = 0.5 - (0.0125 * 3/4);
		private _centerPointY = 0.5 - (0.0125);
		private _gateMaxX = 0.11; //in units away from centerpoint
		private _gateMinX = 0.005; //in units away from centerpoint
		private _gateMaxY = 0.125; //in units away from centerpoint
		private _gateMinY = 0.004; //in units away from centerpoint
		private _blink = true;
		if(((diag_frameno mod 20) < 10) && isNull (_newTarget)) then {
			_blink = false;
		};
		__JavelinIGUISeek_indicator ctrlSetTextColor __ColorGreen;
		__JavelinIGUITargetingConstrains ctrlShow true;
		if(_blink) then {
			__JavelinIGUITargetingGate ctrlShow true;
			if(GVAR(isLockKeyDown))	then {
				__JavelinIGUITargetingLines ctrlShow true;
			} else {
				__JavelinIGUITargetingLines ctrlShow false;
			}
		} else {
			__JavelinIGUITargetingGate ctrlShow false;
			__JavelinIGUITargetingLines ctrlShow false;
		};

		private _xScale = linearConversion [0,1,(GETGVAR(gateDistanceX,0.9)),_gateMinX,_gateMaxX,true];
		private _yScale = linearConversion [0,1,(GETGVAR(gateDistanceY,0.9)),_gateMinY,_gateMaxY,true];	
		
//			if ((_centerpointX - _xScale < __ConstraintLeft) || (_centerpointX + _xScale > __ConstraintRight) || (_centerpointY - _yScale < __ConstraintTop) || (_centerpointY + _yScale > __ConstraintBottom)) then {
//				_currentShooter setVariable ["ace_missileguidance_target", nil, false];
//			};
		
		__JavelinIGUITargetingGateTL ctrlSetPosition [(_centerpointX - _xScale)*safeZoneW - safeZoneX, (_centerpointY - _yScale)*safeZoneH - safeZoneY];
		__JavelinIGUITargetingGateTR ctrlSetPosition [(_centerpointX + _xScale)*safeZoneW - safeZoneX, (_centerpointY - _yScale)*safeZoneH - safeZoneY];
		__JavelinIGUITargetingGateBL ctrlSetPosition [(_centerpointX - _xScale)*safeZoneW - safeZoneX, (_centerpointY + _yScale)*safeZoneH - safeZoneY];
		__JavelinIGUITargetingGateBR ctrlSetPosition [(_centerpointX + _xScale)*safeZoneW - safeZoneX, (_centerpointY + _yScale)*safeZoneH - safeZoneY];
		
		{_x ctrlCommit __TRACKINTERVAL} forEach [__JavelinIGUITargetingGateTL, __JavelinIGUITargetingGateTR, __JavelinIGUITargetingGateBL, __JavelinIGUITargetingGateBR];

	};
};