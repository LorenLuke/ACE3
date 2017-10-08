class CfgWeapons {
    class missiles_DAGR;

    class GVAR(dagr): missiles_DAGR {
        canLock = 0;
        magazines[] = {"6Rnd_ACE_Hydra70_DAGR","12Rnd_ACE_Hydra70_DAGR","24Rnd_ACE_Hydra70_DAGR"};
        lockingTargetSound[] = {"",0,1};
        lockedTargetSound[] = {"",0,1};
    };


    class Mk82BombLauncher;
    class ACE_Mk82BombLauncher: Mk82BombLauncher {
        displayName = "ACE Mk82";
//        GVAR(enabled) = 1; // show attack profile / lock on hud
//        EGVAR(laser,canSelect) = 1; // can ace_laser lock (allows switching laser code)
        magazines[] = {"PylonMissile_1Rnd_ACE_Mk82", "PylonRack_2Rnd_ACE_Mk82"};
    };

    class ACE_GBU12BombLauncher: ACE_Mk82BombLauncher {
        displayName = "ACE GBU-12";
//        GVAR(enabled) = 1; // show attack profile / lock on hud
//        EGVAR(laser,canSelect) = 1; // can ace_laser lock (allows switching laser code)
        magazines[] = {"PylonMissile_1Rnd_ACE_GBU12", "PylonRack_2Rnd_ACE_GBU12"};
    };

    class ACE_GBU38BombLauncher: ACE_Mk82BombLauncher {
        displayName = "ACE GBU-38";
//        GVAR(enabled) = 1; // show attack profile / lock on hud
//        EGVAR(laser,canSelect) = 1; // can ace_laser lock (allows switching laser code)
        magazines[] = {"PylonMissile_1Rnd_ACE_GBU38", "PylonRack_2Rnd_ACE_GBU38"};
    };
	
    class ACE_Mk83BombLauncher: ACE_Mk82BombLauncher {
        displayName = "ACE Mk83";
//        GVAR(enabled) = 1; // show attack profile / lock on hud
//        EGVAR(laser,canSelect) = 1; // can ace_laser lock (allows switching laser code)
        magazines[] = {"PylonMissile_1Rnd_ACE_Mk83", "PylonRack_2Rnd_ACE_Mk83"};
    };

    class ACE_GBU16BombLauncher: ACE_Mk83BombLauncher {
        displayName = "ACE GBU-16";
//        GVAR(enabled) = 1; // show attack profile / lock on hud
//        EGVAR(laser,canSelect) = 1; // can ace_laser lock (allows switching laser code)
        magazines[] = {"PylonMissile_1Rnd_ACE_GBU16", "PylonRack_2Rnd_ACE_GBU16"};
    };

    class ACE_GBU32BombLauncher: ACE_Mk82BombLauncher {
        displayName = "ACE GBU-32";
//        GVAR(enabled) = 1; // show attack profile / lock on hud
//        EGVAR(laser,canSelect) = 1; // can ace_laser lock (allows switching laser code)
        magazines[] = {"PylonMissile_1Rnd_ACE_GBU32", "PylonRack_2Rnd_ACE_GBU32"};
    };

    class ACE_Mk84BombLauncher: ACE_Mk82BombLauncher {
        displayName = "ACE Mk84";
//        GVAR(enabled) = 1; // show attack profile / lock on hud
//        EGVAR(laser,canSelect) = 1; // can ace_laser lock (allows switching laser code)
        magazines[] = {"PylonMissile_1Rnd_ACE_Mk84"};
    };
	
    class ACE_GBU10BombLauncher: ACE_Mk84BombLauncher {
        displayName = "ACE GBU-10";
//        GVAR(enabled) = 1; // show attack profile / lock on hud
//        EGVAR(laser,canSelect) = 1; // can ace_laser lock (allows switching laser code)
        magazines[] = {"PylonMissile_1Rnd_ACE_GBU10"};
    };
	
    class ACE_GBU31BombLauncher: ACE_Mk82BombLauncher {
        displayName = "ACE GBU-31";
//        GVAR(enabled) = 1; // show attack profile / lock on hud
//        EGVAR(laser,canSelect) = 1; // can ace_laser lock (allows switching laser code)
        magazines[] = {"PylonMissile_1Rnd_ACE_GBU31"};
    };
	
	
	
};
