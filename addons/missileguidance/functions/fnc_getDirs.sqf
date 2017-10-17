/*
 * Author: LorenLuke
 * Returns a seeker vector from a projectile vector based on the angles given.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Type of direction <STRING> (see below
 *
 * Return Value:
 * Absolute world posASL <ARRAY>
 * Direction vector <ARRAY>
 *
 * Example:
 * [player, "weapon"] call ace_common_fnc_rotateVector;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_object", "_type"];

private _direction = [];
private _pos = [];

switch (_type) do {

	case "weapon" : {
		_direction = _object weaponDirection (currentWeapon _object);
		_pos = _object selectionPosition (getText (configFile >> "CfgWeapons" >> (currentWeapon _object) >> "muzzleEnd"));
		_pos = AGLToASL (_object modelToWorld _pos);
	};
	
	case "eye" : {
		_direction = eyeDirection _object;
		_pos = eyePos _object;
	};
	
	case "optic" : {
		_direction = _object weaponDirection (currentWeapon _object); //I DON'T LIKE THISSSSSS :S
		_pos = _object selectionPosition (getText (([_object, [0]] call CBA_fnc_getTurret) >> "memoryPointGunnerOptics"));
		_pos = AGLToASL (_object modelToWorld _pos);	
	};
	
	case "pod" : {
		if (!(hasPilotCamera _object)) then {
			_pos = [0,0,0];
			_direction = [0,0,0];
		} else {
			_pos = AGLToASL (_object modelToWorld (getPilotCameraPosition _object));
			_direction = [vectorDir _object, vectorUp _object, -deg ((getPilotCameraRotation _object) select 0)] call FUNC(rotateVector)];
			_direction = [_opticDir, (vectorUp _object) vectorCrossProduct (vectorDir _object), -deg ((getPilotCameraRotation _object) select 1)] call FUNC(rotateVector)];
	};

};

[_pos, _direction];
