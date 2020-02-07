class CfgAmmo {
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

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "SALH";
            seekerTypes[] = {"GPS", "SALH"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "LIN";
            attackProfiles[] = {"LIN"};
        };
    };
    
    class Sh_82mm_AMOS;
    class Sh_82mm_DEBUG: Sh_82mm_AMOS {
        class ADDON {
            enabled = 1;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "SALH";
            seekerTypes[] = {"SALH"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "INDIRECT";
            attackProfiles[] = {"INDIRECT"};
        };
    };

    class G_40mm_HE;
    class G_40mm_DEBUG: G_40mm_HE {
        timeToLive = 30;
        class ADDON {
            enabled = 1;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "SALH";
            seekerTypes[] = {"SALH"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "INDIRECT";
            attackProfiles[] = {"INDIRECT"};
        };
    };

    class RocketBase;
    class R_MRAAWS_HEAT_F: RocketBase {};
    class R_MRAAWS_HEAT55_F: R_MRAAWS_HEAT_F {
        class ADDON {
            enabled = 1;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "PLOS";
            seekerTypes[] = {"PLOS"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "DIRECT";
            attackProfiles[] = {"DIRECT"};
        };
    };


    class ammo_Missile_Cruise_01;
    class ammo_Missile_Cruise_DEBUG: ammo_Missile_Cruise_01 {
        class ADDON {
            enabled = 1;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "GPS";
            seekerTypes[] = {"GPS"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "SSBM";
            attackProfiles[] = {"SSBM"};
        };
    };

    class MissileBase;
    class M_Titan_AT: MissileBase {};
    class M_Titan_AP: M_Titan_AT {
        class ADDON {
            enabled = 1;
            
            defaultSeekerType = "MCLOS";
            seekerTypes[] = {"MCLOS"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AGM";
            attackProfiles[] = {"AGM"};
        };
    };
    
    
    class M_Titan_AA: MissileBase {
        class ADDON {
            enabled = 1;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "IR";
            seekerTypes[] = {"IR"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AAM";
            attackProfiles[] = {"AAM"};
        };
    };

    class Missile_AGM_02_F : MissileBase {
        class ADDON {
            enabled = 1;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "EO";
            seekerTypes[] = {"EO"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 5000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AGM";
            attackProfiles[] = {"AGM"};
        };
    };
    
    class ammo_Missile_AntiRadiationBase: MissileBase {};
    class ammo_Missile_HARM: ammo_Missile_AntiRadiationBase {
        class ADDON {
            enabled = 1;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "PRH";
            seekerTypes[] = {"PRH"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 5000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AGM";
            attackProfiles[] = {"AGM"};
        };
    };

    class BombCore;
    class LaserBombCore: BombCore {};
    class ammo_Bomb_LaserGuidedBase: LaserBombCore {};
    class Bomb_04_F: ammo_Bomb_LaserGuidedBase {
        class ADDON {
            enabled = 1;
                
            // Guidance type for munitions
            defaultSeekerType = "SALH";
            seekerTypes[] = {"SALH"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 5000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "GBU";
            attackProfiles[] = {"GBU"};
        };
    };
    
    class ammo_Bomb_SmallDiameterBase: ammo_Bomb_LaserGuidedBase {};
    class ammo_Bomb_SDB: ammo_Bomb_SmallDiameterBase {
        class ADDON {
            enabled = 1;
                
            // Guidance type for munitions
            defaultSeekerType = "GPS";
            seekerTypes[] = {"GPS"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 5000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "GBU";
            attackProfiles[] = {"GBU"};
        };     
    };
};

