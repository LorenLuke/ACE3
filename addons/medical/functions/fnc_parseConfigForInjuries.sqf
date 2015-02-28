/*
 * Author: Glowbal
 * Parse the ACE_Medical_Advanced config for all injury types.
 *
 * Arguments:
 *
 * ReturnValue:
 * <NIL>
 *
 * Public: No
 */

#include "script_component.hpp"

private ["_injuriesRootConfig", "_woundsConfig", "_allWoundClasses", "_amountOf", "_entry","_classType", "_selections", "_bloodLoss", "_pain","_minDamage","_causes", "_allTypes", "_damageTypesConfig", "_thresholds", "_typeThresholds", "_selectionSpecific", "_selectionSpecificType"];

_injuriesRootConfig = (configFile >> "ACE_Medical_Advanced" >> "Injuries");
_allTypes = ["stab", "grenade", "bullet", "explosive", "shell", "punch", "vehiclecrash", "backblast", "falling", "bite", "ropeburn"];

_allFoundDamageTypes = [];
_configDamageTypes = (_injuryRouteConfig >> "damageTypes");
for "_i" from 0 to (count _configDamageTypes -1) /* step +1 */ do {
	if (isClass(_configDamageTypes select _i)) then {
		_allFoundDamageTypes pushback (configName (_configDamageTypes select _i));
	};
};
GVAR(allAvailableDamageTypes) = _allFoundDamageTypes;

_parseForSubClassWounds = {
	_subClass = _this select 0;
	if (isClass (_entry >> _subClass)) exitwith {
		_subClassConfig = (_entry >> _subClass);
		_subClasstype = _classType + (configName _subClassConfig);
		_subClassselections = if (isArray(_subClassConfig >> "selections")) then { getArray(_subClassConfig >> "selections");} else { _selections };
		_subClassbloodLoss = if (isNumber(_subClassConfig >> "bleedingRate")) then { getNumber(_subClassConfig >> "bleedingRate");} else { _bloodLoss };
		_subClasspain = if (isNumber(_subClassConfig >> "pain")) then { getNumber(_subClassConfig >> "pain");} else { _pain };
		_subClassminDamage = if (isNumber(_subClassConfig >> "minDamage")) then { getNumber(_subClassConfig >> "minDamage");} else { _minDamage };
		_subClasscauses = if (isArray(_subClassConfig >> "causes")) then { getArray(_subClassConfig >> "causes");} else { _causes };
		if (count _selections > 0 && count _causes > 0) then {
			_allWoundClasses pushback [_subClasstype, _subClassselections, _subClassbloodLoss, _subClasspain, _subClassminDamage, _subClasscauses];
		};
		true;
	};
	false;
};

// TODO classTypes are strings currently. Convert them to unqiue IDs instead.
_woundsConfig = (_injuriesRootConfig >> "wounds");
_allWoundClasses = [];
if (isClass _woundsConfig) then {
	_amountOf = count _woundsConfig;
	for "_i" from 0 to (_amountOf -1) /* step +1 */ do {
		_entry = _woundsConfig select _i;
		if (isClass _entry) then {
			_classType = (ConfigName _entry);
			_selections = if (isArray(_entry >> "selections")) then { getArray(_entry >> "selections");} else {[]};
			_bloodLoss = if (isNumber(_entry >> "bleedingRate")) then { getNumber(_entry >> "bleedingRate");} else {0};
			_pain = if (isNumber(_entry >> "pain")) then { getNumber(_entry >> "pain");} else {0};
			_minDamage = if (isNumber(_entry >> "minDamage")) then { getNumber(_entry >> "minDamage");} else {0};
			_causes = if (isArray(_entry >> "causes")) then { getArray(_entry >> "causes");} else {[]};

			if (["Minor"] call _parseForSubClassWounds || ["Medium"] call _parseForSubClassWounds || ["Large"] call _parseForSubClassWounds) exitwith {}; // continue to the next one

			// There were no subclasses, so we will add this one instead.
			if (count _selections > 0 && count _causes > 0) then {
				_allWoundClasses pushback [_classType, _selections, _bloodLoss, _pain, _minDamage, _causes];
			};
			true;
		};
	};
};
GVAR(AllWoundInjuryTypes) = _allWoundClasses;

_damageTypesConfig = (configFile >> "ACE_Medical_Advanced" >> "Injuries" >> "damageTypes");
_thresholds = getArray(_damageTypesConfig >> "thresholds");
_selectionSpecific = getNumber(_damageTypesConfig >> "selectionSpecific");

{
	_varName = format[QGVAR(woundInjuryType_%1),_x];
	_woundTypes = [];
	_type = _x;
	{
		if (_type in (_x select 4)) then {
			_woundTypes pushback _x;
		};
	}foreach _allWoundClasses;
	_typeThresholds = _thresholds;
	_selectionSpecificType = _selectionSpecific;
	if (isClass(_damageTypesConfig >> _x)) then {
		if (isArray(_damageTypesConfig >> _x >> "thresholds")) then { _typeThresholds = getArray(_damageTypesConfig >> _x >> "thresholds");};
		if (isNumber(_damageTypesConfig >> _x >> "selectionSpecific")) then { _selectionSpecificType = getNumber(_damageTypesConfig >> _x >> "selectionSpecific");};
	};
	missionNamespace setvariable [_varName, [_typeThresholds, _selectionSpecificType > 0, _woundTypes]];
}foreach _allTypes;
