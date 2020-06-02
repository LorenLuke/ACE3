
["ACE3 Weapons", QGVAR(keyMF1), localize LSTRING(keyMF1),
{
    [] call FUNC(keyDown);
    false
},
{
    false
},
[15, [false, false, false]], false] call CBA_fnc_addKeybind;  //Tab

["ACE3 Weapons", QGVAR(keyMF2), localize LSTRING(keyMF2),
{
    [] call FUNC(keyDown);
    false
},
{
    false
},
[15, [false, true, false]], false] call CBA_fnc_addKeybind;  //Ctrl+Tab Key

["ACE3 Weapons", QGVAR(keyMFUp), localize LSTRING(keyMFUp),
{
    [] call FUNC(keyDown);
    false
},
{
    false
},
[200, [false, false, false]], false] call CBA_fnc_addKeybind;  //Up

["ACE3 Weapons", QGVAR(keyMFDown), localize LSTRING(keyMFDown),
{
    [] call FUNC(keyDown);
    false
},
{
    false
},
[208, [false, false, false]], false] call CBA_fnc_addKeybind;  //Down

["ACE3 Weapons", QGVAR(keyMFLeft), localize LSTRING(keyMFLeft),
{
    [] call FUNC(keyDown);
    false
},
{
    false
},
[203, [false, false, false]], false] call CBA_fnc_addKeybind;  //Left

["ACE3 Weapons", QGVAR(keyMFRight), localize LSTRING(keyMFRight),
{
    [] call FUNC(keyDown);
    false
},
{
    false
},
[205, [false, false, false]], false] call CBA_fnc_addKeybind;  //Right
