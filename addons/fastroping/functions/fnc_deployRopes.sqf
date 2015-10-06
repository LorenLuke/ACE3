/*
 * Author: BaerMitUmlaut
 * Deploy ropes from the helicopter.
 *
 * Arguments:
 * 0: Unit occupying the helicopter <OBJECT>
 * 1: The helicopter itself <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_player, _vehicle] call ace_fastroping_deployRopes
 *
 * Public: No
 */

#include "script_component.hpp"
params ["_unit", "_vehicle"];
private ["_ropeOrigins", "_deployedRopes", "_origin", "_dummy", "_anchor", "_hook", "_ropeTop", "_ropeBottom"];

_ropeOrigins = getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> QGVAR(ropeOrigins));
_deployedRopes = [];
{
    _origin = AGLtoASL (_vehicle modelToWorld _x);

    _dummy = QGVAR(helper) createVehicle [0, 0, 0];
    _dummy allowDamage false;
    _dummy setPosASL (_origin vectorAdd [0, 0, -1]);

    _anchor = QGVAR(helper) createVehicle [0, 0, 0];
    _anchor allowDamage false;
    _anchor setPosASL (_origin vectorAdd [0, 0, -2.5]);

    _hook = QGVAR(helper) createVehicle [0, 0, 0];
    _hook allowDamage false;
    if (typeName _x == "ARRAY") then {
        _hook attachTo [_vehicle, _x];
    } else {
        _hook attachTo [_vehicle, [0,0,0], _x];
    };

    _ropeTop = ropeCreate [_hook, [0, 0, 0], _dummy, [0, 0, 0], 2];
    _ropeBottom = ropeCreate [_dummy, [0, 0, 0], _anchor, [0, 0, 0], 33];

    //deployedRopes format: attachment point, top part of the rope, bottom part of the rope, attachTo helper object, anchor helper object, occupied
    _deployedRopes pushBack [_x, _ropeTop, _ropeBottom, _dummy, _anchor, _hook, false];
    true
} count _ropeOrigins;

_vehicle setVariable [QGVAR(deployedRopes), _deployedRopes, true];
