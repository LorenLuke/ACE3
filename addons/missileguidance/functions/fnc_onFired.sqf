/*
 * Author: jaynus / nou
 * Fired event handler, starts guidance if enabled for ammo
 *
 * Arguments:
 * 0: Shooter (Man/Vehicle) <OBJECT>
 * 4: Ammo <STRING>
 * 6: Projectile <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "", "", "", "ACE_Javelin_FGM148", "", theMissile] call ace_missileguidance_fnc_onFired;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_shooter","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile"];
private _feedback = +GVAR(feedbackArray);
//private _feedback = call compile format ["+GVAR(feedbackArray_%1",ACE_player];

// Bail on not missile; need support for other ammo types tho.
if (!((_ammo isKindOf "MissileBase") || (_ammo isKindOf "LaserBombCore"))) exitWith {};

// Bail if guidance is disabled for this ammo
if ((getNumber (configFile >> "CfgAmmo" >> _ammo >> "ace_missileguidance" >> "enabled")) != 1) exitWith {
	hint format ["%1 \n%2", getNumber (configFile >> "CfgAmmo" >> _ammo >> "ace_missileguidance" >> "enabled"),_ammo];
};

// Bail on locality of the projectile, it should be local to us
if (GVAR(enabled) < 1 || {!local _projectile} ) exitWith {};

// Bail if shooter isn't player AND system not enabled for AI:
if ( !isPlayer _shooter && { GVAR(enabled) < 2 } ) exitWith {};

// MissileGuidance is enabled for this shot
// Uncage seeker, if not
if ((!isNil "_feedback") && (count _feedback) > 0) then {
    ((_feedback select 1) select 5) set [2, true];
};


// If we didn't get a target, try to fall back on tab locking
// may always be the case, oh well.
if (isNil "_target") then {
    if (!isPlayer _shooter) then {        // This was an AI shot, lets still guide it on the AI target
        _target = _shooter getVariable [QGVAR(vanilla_target), nil];
        TRACE_1("Detected AI Shooter!", _target);
    } else {
        private _canUseLock = getNumber (_config >> "canVanillaLock");
        // @TODO: Get vanilla target
        if (_canUseLock > 0 || difficulty < 1) then {
            private _vanillaTarget = cursorTarget;

            TRACE_1("Using Vanilla Locking", _vanillaTarget);
            if (!isNil "_vanillaTarget") then {
                _target = _vanillaTarget;
            };
        };
    };
};

private _args = [_this, _feedback];

// Run the "onFired" function passing the full guidance args array
private _onFiredFunc = getText (_config >> "onFired");
TRACE_1("",_onFiredFunc);

if (_onFiredFunc != "") then {
    _args call (missionNamespace getVariable _onFiredFunc);
};

_this set [7, _shooter weaponDirection _weapon];
[FUNC(guidancePFH), 0, _args] call CBA_fnc_addPerFrameHandler;


// Clears locking settings
/*
(vehicle _shooter) setVariable [QGVAR(target), nil];
(vehicle _shooter) setVariable [QGVAR(seekerType), nil];
(vehicle _shooter) setVariable [QGVAR(attackProfile), nil];
(vehicle _shooter) setVariable [QGVAR(lockMode), nil];
 */
