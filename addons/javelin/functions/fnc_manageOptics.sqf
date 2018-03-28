/*
 * Author: LorenLuke
 * Manages the handling of the optic mode when utilising the Javelin.
 *
 * Arguments:
 * 0: Last Target (seeds the scan) <OBJECT>
 * 1: Max Range (meters) <NUMBER>
 *
 * Return Value:
 * Target <OBJECT>
 *
 * Example:
 * [bob, 5] call ace_javelin_fnc_getTarget
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"
//hint "managing optic";

if( !(GETGVAR(inOptic,false))) exitWith {
	if(!(isNull (GVAR(opticCamera)))) then {
		false setCamUseTi 0;
		camUseNVG false;
		ACE_player switchCamera "Internal"; 
		detach GVAR(opticCamera);
		deleteVehicle GVAR(opticCamera);
		GVAR(opticCamera) = objNull;
	};
};
if(isNull (GVAR(opticCamera))) then {
	GVAR(opticCamera) = "camera" createVehicleLocal [0,0,0];
	GVAR(opticCamera) hideObject true;
	GETGVAR(opticCamera,objNull) switchCamera "Internal"
};

private _cam = GVAR(opticCamera);

//atan(FOV)*2
//desired FOV = 6.2deg, 2.8deg
//0.10821,0.0488692191 -rads
//0.19674545454,0.08885312563 -100/55
//0.09837272727,0.08077556875 -(100/55)/2
//0.09869128439,0.08095170704


switch (GETGVAR(opticMode,0)) do {
	case 0: { //Day camera
		false setCamUseTi 0;
		camUseNVG false;
		_cam camSetFov 0.09869128439;
	};
	case 1: { //NVS WFOV
		false setCamUseTi 0;
		camUseNVG true;
		_cam camSetFov 0.09869128439;
	};
	case 2: { //NVS NFOV
		false setCamUseTi 0;
		camUseNVG true;
		_cam camSetFov 0.08095170704;
		};
	case 3: { //SEEKER
		true setCamUseTi 2;
		camUseNVG false;
		_cam camSetFov 0.08095170704;
	};
};
private _weaponDir = ACE_player weaponDirection (currentWeapon ACE_player);
_cam setPosASL ((getPosASL ACE_player) vectorAdd _weaponDir);
_cam camSetTarget ( ASLToATL((getPosASL ACE_player) vectorAdd (_weaponDir vectorMultiply 100)) );
_cam camCommit 0;

/*
findDisplay 46 displayAddEventHandler ["MouseButtonDown", {
	if (_this select 1 == 0) then {
		player forceWeaponFire [currentMuzzle player, currentWeaponMode player];
	};
	false
}];
findDisplay 46 displayAddEventHandler ["KeyDown", {
	if (_this select 1 in actionKeys "ReloadMagazine") then {
		reload player;
	};
	false
}];
*/

params ["_lastTarget", "_maxRange"];

