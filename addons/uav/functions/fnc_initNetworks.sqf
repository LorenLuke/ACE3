/*
 * Author: LorenLuke
 * Initializes UAV networks.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

GVAR(networks) = [];

["networkWEST"] call FUNC(initUAVNetwork);
["networkEAST"] call FUNC(initUAVNetwork);
["networkGUER"] call FUNC(initUAVNetwork);
["networkCIV"]  call FUNC(initUAVNetwork);

["networkWEST", ["B_UavTerminal", true, true, true]] call FUNC(addDeviceToUAVNetwork);
["networkEAST", ["O_UavTerminal", true, true, true]] call FUNC(addDeviceToUAVNetwork);
["networkGUER", ["I_UavTerminal", true, true, true]] call FUNC(addDeviceToUAVNetwork);
["networkCIV",  ["C_UavTerminal", true, true, true]] call FUNC(addDeviceToUAVNetwork);

