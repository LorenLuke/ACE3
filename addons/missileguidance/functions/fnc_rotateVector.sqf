/*
 * Author: LorenLuke
 * Rotates the first vector around the second, clockwise by theta
 *
 * Arguments:
 * 0: Vector <ARRAY>
 * 1: Rotation Axis <ARRAY>
 * 2: Angle <NUMBER>
 *
 * Return Value:
 * Transformed Vector <ARRAY>
 *
 * Example:
 * [eyeDirection player, weaponDirection (currentWeapon player), 45] call ace_common_fnc_rotateVector;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_vector1", "_vector2", "_theta"];
_vector1 params ["_vx", "_vy", "_vz"];

private _normalVector = vectorNormalized _vector2;
_normalVector params ["_ux", "_uy", "_uz"];

private _rotationMatrix = [
	[cos(_theta) + ((_ux^2) * (1 - cos(_theta))), (_ux * _uy * (1-cos(_theta))) - (_uz * sin(_theta)), (_ux * _uz * (1 - cos(_theta))) + (_uy * sin (_theta))],
	[(_uy * _ux * (1-cos(_theta))) + (_uz * sin(_theta)), cos(_theta) + ((_uy^2) * (1 - cos(_theta))), (_uy * _uz * (1 - cos(_theta))) - (_ux * sin (_theta))],
	[(_uz * _ux * (1-cos(_theta))) - (_uy * sin(_theta)), (_uz * _uy * (1 - cos(_theta))) + (_ux * sin (_theta)), cos(_theta) + ((_uz^2) * (1 - cos(_theta)))]
];

private _vxp = (_vx * ((_rotationMatrix select 0) select 0)) + (_vy * ((_rotationMatrix select 0) select 1)) + (_vz * ((_rotationMatrix select 0) select 2));
private _vyp = (_vx * ((_rotationMatrix select 1) select 0)) + (_vy * ((_rotationMatrix select 1) select 1)) + (_vz * ((_rotationMatrix select 1) select 2));
private _vzp = (_vz * ((_rotationMatrix select 2) select 0)) + (_vy * ((_rotationMatrix select 2) select 1)) + (_vz * ((_rotationMatrix select 2) select 2));

private _returnVector = [_vxp, _vyp, _vzp];

[_vxp, _vyp, _vzp];

/*
vector1 = [0,1,0];
vector2 = [0,0,1];
theta = 45;

vx = vector1 select 0;
vy = vector1 select 1;
vz = vector1 select 2;

vector2 = vectorNormalized vector2;
ux = vector2 select 0;
uy = vector2 select 1;
uz = vector2 select 2;

rotationmatrix = [
 [cos (theta) + ((ux^2) * (1 - cos(theta))), (ux * uy * (1-cos(theta))) - (uz * sin(theta)), (ux * uz * (1 - cos(theta))) + (uy * sin (theta))], 
 [(uy* ux * (1-cos(theta))) + (uz * sin(theta)), cos (theta) + ((uy^2) * (1 - cos(theta))), (uy * uz * (1 - cos(theta))) - (ux * sin (theta))], 
 [(uz* ux * (1-cos(theta))) - (uy * sin(theta)), (uz * uy * (1 - cos(theta))) + (ux * sin (theta)), cos (theta) + ((uz^2) * (1 - cos(theta)))]
];

vxp = (vx * ((rotationmatrix select 0) select 0)) + (vy * ((rotationmatrix select 1) select 0)) + (vz * ((rotationmatrix select 2) select 0)); 
vyp = (vx * ((rotationmatrix select 0) select 1)) + (vy * ((rotationmatrix select 1) select 1)) + (vz * ((rotationmatrix select 2) select 1)); 
vzp = (vz * ((rotationmatrix select 0) select 2)) + (vy * ((rotationmatrix select 1) select 2)) + (vz * ((rotationmatrix select 2) select 2)); 

hint format ["%1\n%2\n%3", vxp, vyp, vzp];	
*/
