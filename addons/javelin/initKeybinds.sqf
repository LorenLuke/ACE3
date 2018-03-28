// by commy2

["ACE3 Weapons", QGVAR(lockTarget), localize LSTRING(LockTarget),
{
    if (GETGVAR(isLockKeyDown,false)) exitWith {false};

    GVAR(isLockKeyDown) = true;
    TRACE_1("lock key down",GVAR(isLockKeyDown));
    GVAR(gateDistanceY) = .50;
    GVAR(gateDistanceX) = .50;
    // Return false so it doesn't block the rest weapon action
    false
},
{
    // prevent holding down
    GVAR(isLockKeyDown) = false;
    TRACE_1("lock key up",GVAR(isLockKeyDown));
    false
},
[15, [false, false, false]], false] call CBA_fnc_addKeybind;  //Tab Key



//Init gate controls
["ACE3 Weapons", QGVAR(moveGatesUp), QGVAR(moveGatesUp),
{
    if (!(GETGVAR(isLockKeyDown,false))) exitWith {false};

    ["up"] call FUNC(moveGates);

    true
},
{
    false
},
[17, [false, false, false]], false] call CBA_fnc_addKeybind;  //W Key

["ACE3 Weapons", QGVAR(moveGatesLeft), QGVAR(moveGatesLeft),
{
    if (!(GETGVAR(isLockKeyDown,false))) exitWith {false};

    ["left"] call FUNC(moveGates);

    true
},

{
    false
},
[30, [false, false, false]], false] call CBA_fnc_addKeybind;  //A Key

["ACE3 Weapons", QGVAR(moveGatesDown), QGVAR(moveGatesDown),
{
    if (!(GETGVAR(isLockKeyDown,false))) exitWith {false};

    ["down"] call FUNC(moveGates);

    true
},
{
    false
},
[31, [false, false, false]], false] call CBA_fnc_addKeybind;  //S Key

["ACE3 Weapons", QGVAR(moveGatesRight), QGVAR(moveGatesRight),
{
    if (!(GETGVAR(isLockKeyDown,false))) exitWith {false};

    ["right"] call FUNC(moveGates);

    true
},
{
    false
},
[32, [false, false, false]], false] call CBA_fnc_addKeybind;  //D Key
