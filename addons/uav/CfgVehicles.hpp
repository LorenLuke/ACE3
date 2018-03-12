
class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_UAV {
                displayName = "UAV";
                condition = QUOTE([] call FUNC(canPlayerAccessNetwork));
                statement = "";
                exceptions[] = {"isNotDragging", "notOnMap", "isNotSwimming"};
                showDisabled = 1;
                icon = QPATHTOF(UI\Place_Explosive_ca.paa);
                priority = 1;
                class ACE_CancelUAVView {
                    displayName = "Cancel UAV View";
                    condition = QUOTE([] call FUNC(isPlayerViewingUAV));
                    statement = QUOTE([_player] call FUNC(cancelViewUAV));
                    showDisabled = 0;
                    priority = 0;
                };
                class ACE_CancelUAVControl {
                    displayName = "Cancel UAV Control";
                    condition = QUOTE([] call FUNC(isPlayerControllingUAV));
                    statement = QUOTE([_player] call FUNC(cancelControlUAV));
                    showDisabled = 0;
                    priority = 0;
                };
                class ACE_DisconnectFromUAV {
                    displayName = "Disconnect from UAV";
                    condition = QUOTE([] call FUNC(isPlayerConnectedUAV));
                    statement = QUOTE([_player] call FUNC(disconnectFromUAV));
                    showDisabled = 0;
                    priority = 0;
                };
                class ACE_ControlConnectedUAVPilot {
                    displayName = "Control Connected UAV (pilot)";
                    condition = QUOTE([] call FUNC(canControlUAV));
                    statement = QUOTE([_player,"driver"] call FUNC(controlConnectedUAV));
                    showDisabled = 0;
                    priority = 0;
                };
                class ACE_ControlConnectedUAVGunner {
                    displayName = "Control Connected UAV (gunner)";
                    condition = QUOTE([] call FUNC(canControlUAV));
                    statement = QUOTE([_player,"gunner"] call FUNC(controlConnectedUAV));
                    showDisabled = 0;
                    priority = 0;
                };
                class ACE_CancelUAVControl {
                    displayName = "Cancel UAV Control";
                    condition = QUOTE([] call FUNC(isPlayerControllingUAV));
                    statement = QUOTE([_player] call FUNC(cancelControlUAV));
                    showDisabled = 0;
                    priority = 0;
                };
                class ACE_OpenUAVDevice {
                    displayName = "Open UAV Network";
                    condition = "true";
                    statement = QUOTE(GVAR(mapGpsShow) = true; [GVAR(mapGpsShow)] call FUNC(openMapGps));
                    showDisabled = 0;
                    priority = 0;
                };
            };
        };
    };


/*
    class LandVehicle;
    class StaticWeapon: LandVehicle {
        class Turrets {
            class MainTurret;
        };
    };
    class StaticMortar: StaticWeapon {
        class Turrets: Turrets {
            class MainTurret: MainTurret {};
        };
        class ACE_Actions;
    };
    class Mortar_01_base_F: StaticMortar {
        class Turrets: Turrets {
            class MainTurret: MainTurret {
                turretInfoType = "ACE_Mk6_RscWeaponRangeArtillery";
                discreteDistance[] = {};
                discreteDistanceInitIndex = 0;
            };
        };
        class ACE_Actions: ACE_Actions {
            class GVAR(unloadMagazine) {
                displayName = CSTRING(unloadMortar);
                distance = 2;
                condition = QUOTE(_this call FUNC(canUnloadMagazine));
                statement = QUOTE([ARR_3(_target,_player,5)] call FUNC(unloadMagazineTimer));
                icon = "";
                selection = "usti hlavne";
            };
        };
    };
*/
    
};