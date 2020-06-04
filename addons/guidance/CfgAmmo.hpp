class CfgAmmo {
    class MissileBase;

    class M_PG_AT: MissileBase {
        
        irLock = 0;
        laserLock = 0;
        manualControl = 0;
        class ADDON {
            enabled = 1;
            degreesPerSecond = 20;
            // Guidance type for munitions
            seekerType = "SALH_generic";
            attackProfile = "LIN";
        };
    };

    class ACE_Hydra70_DAGR: M_PG_AT {
        displayName = CSTRING(Hydra70_DAGR);
        displayNameShort = CSTRING(Hydra70_DAGR_Short);

        description = CSTRING(Hydra70_DAGR_Desc);
        descriptionShort = CSTRING(Hydra70_DAGR_Desc);

        maxSpeed = 300;

        EGVAR(rearm,caliber) = 70;

        class ADDON {
            enabled = 1;
            degreesPerSecond = 20;
            // Guidance type for munitions
            seekerType = "SALH_generic";
            attackProfile = "LIN";
        };
    };

    class BulletBase;
    class Gatling_30mm_DEBUG: BulletBase {
        hit = 70; // default: 180
        indirectHit = 12; // default: 4
        indirectHitRange = 4; // default: 3
        caliber = 1.4; // default: 5
        deflecting = 3; // default: 5
        fuseDistance = 3; // default: 10
        tracerStartTime = 0.02; // default: 0.1
        timeToLive = 40; // default: 6
        class ADDON {
            enabled = 1;
            degreesPerSecond = 1;
            // Guidance type for munitions
            seekerType = "SALH_generic";
            attackProfile = "LIN";
        };
    };
    
    class Sh_82mm_AMOS;
    class Sh_82mm_DEBUG: Sh_82mm_AMOS {
        class ADDON {
            enabled = 1;
            degreesPerSecond = 2;
            // Guidance type for munitions
            seekerType = "SALH_generic";
            attackProfile = "INDIRECT";
        };
    };

    class G_40mm_HE;
    class G_40mm_DEBUG: G_40mm_HE {
        timeToLive = 60;
        class ADDON {
            enabled = 1;
            degreesPerSecond = 2;
            // Guidance type for munitions
            seekerType = "SALH_generic";
            attackProfile = "INDIRECT";
        };
    };

    class ammo_Missile_Cruise_01;
    class ammo_Missile_Cruise_DEBUG: ammo_Missile_Cruise_01 {
        class ADDON {
            enabled = 1;
            degreesPerSecond = 5;
            // Guidance type for munitions
            seekerType = "INS_generic";
            attackProfile = "SSBM";
        };
    };


    class M_Titan_AT: MissileBase {};
    class M_Titan_AP: M_Titan_AT {
        class ADDON {
            enabled = 1;
            degreesPerSecond = 10;
            // Guidance type for munitions
            seekerType = "MCLOS_generic";
            attackProfile = "ASM";
        };
    };
    
    
    class M_Titan_AA: MissileBase {
        class ADDON {
            enabled = 1;
            degreesPerSecond = 10;
            // Guidance type for munitions
            seekerType = "IR_generic";
            attackProfile = "AIM";
        };
    };

    class Missile_AGM_02_F : MissileBase {
        class ADDON {
            enabled = 1;
            degreesPerSecond = 10;
            // Guidance type for munitions
            seekerType = "EO_image_generic";
            attackProfile = "ASM";
        };
    };

    class Missile_AA_04_F: MissileBase {
        class ADDON {
            enabled = 1;
            degreesPerSecond = 30;
            // Guidance type for munitions
            seekerType = "Sidewinder";
            attackProfile = "AIM";
        };
    };

    class ammo_Missile_ShortRangeAABase: MissileBase {
        class ADDON {
            enabled = 1;
            degreesPerSecond = 30;
            // Guidance type for munitions
            seekerType = "Sidewinder";
            attackProfile = "AIM";
        };
    };
    
    class ammo_Missile_BIM9X: ammo_Missile_ShortRangeAABase {
        class ADDON {
            enabled = 1;
            degreesPerSecond = 35;
            // Guidance type for munitions
            seekerType = "SidewinderX";
            attackProfile = "AIM";
        };
    };

    class M_Air_AA: MissileBase {
        class ADDON {
            enabled = 1;
            degreesPerSecond = 30;
            // Guidance type for munitions
            seekerType = "Sidewinder";
            attackProfile = "AIM";
        };
    };

    class ammo_Missile_MediumRangeAABase: MissileBase {
        class ADDON {
            enabled = 1;
            degreesPerSecond = 20;
            // Guidance type for munitions
            seekerType = "Sidewinder";
            attackProfile = "AIM";
        };
    };

    class ammo_Missile_AntiRadiationBase: MissileBase {};
    class ammo_Missile_HARM: ammo_Missile_AntiRadiationBase {
        class ADDON {
            enabled = 1;
            degreesPerSecond = 10;
            // Guidance type for munitions
            seekerType = "PRH_generic";
            attackProfile = "ASM";
        };
    };

    class BombCore;
    class LaserBombCore: BombCore {};
    class ammo_Bomb_LaserGuidedBase: LaserBombCore {};
    class Bomb_04_F: ammo_Bomb_LaserGuidedBase {
        class ADDON {
            enabled = 1;
            degreesPerSecond = 5;
            // Guidance type for munitions
            seekerType = "SALH_generic";
            attackProfile = "GBU";
        };
    };
    
    class ammo_Bomb_SmallDiameterBase: ammo_Bomb_LaserGuidedBase {};
    class ammo_Bomb_SDB: ammo_Bomb_SmallDiameterBase {
        class ADDON {
            enabled = 1;
            degreesPerSecond = 9;
            // Guidance type for munitions
            seekerType = "GPS_generic";
            attackProfile = "GBU";
        };     
    };

};

