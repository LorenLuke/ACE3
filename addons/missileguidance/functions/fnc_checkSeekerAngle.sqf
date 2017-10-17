/*
 * Author: jaynus / LorenLuke
 * Returns whether the target position is within the maximum angle FOV of the provided seeker
 * objects current direction.
 *
 * Arguments:
 * 0: Seeker PosASL <ARRAY>
 * 1: Seeker Direction (vector) <ARRAY> 
 * 2: Target PosASL <ARRAY>
 * 3: Max Angle (degrees) <NUMBER>
 *
 * Return Value:
 * Can See <BOOL>
 *
 * Example:
 * [getposASL player, weaponDirection (currentWeapon player), cursorTarget, 45] call ace_missileguidance_fnc_checkSeekerAngle;
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_seekerPos", "_seekerVector", "_targetPos", "_seekerMaxAngle"];

private _testDifVector = (_targetPos vectorDiff _seekerPos);
private _testPointVector = vectorNormalized (_testDifVector);
private _testDotProduct = (vectorNormalized _seekerVector) vectorDotProduct _testPointVector;

if ((acos _testDotProduct) > (_seekerMaxAngle/2)) exitWith {
    false;
};


true;