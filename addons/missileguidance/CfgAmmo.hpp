class CfgAmmo {
	
	//BOMBS AND LGBS
	class Bomb_04_F;
	class ACE_BombCore: Bomb_04_F {
        // Begin ACE guidance Configs
		class ace_missileguidance {
			enabled = 0;
			
			minDeflection = 0.001;      // Minimum flap deflection for guidance
			maxDeflection = 0.001;       // Maximum flap deflection for guidance
			incDeflection = 0.0002;      // The increment in which deflection adjusts (per second).
			dlyDeflection = 0;           // Delay in reacting to signal input (simulates angular inertia) in seconds.

			canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
			defaultSeekerType = "UNGUIDED";
			seekerTypes[] = { "UNGUIDED" };

			defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = { "LOAL" };
			
            seekerAngle = 30;           // Angle in front of the missile which can be searched
			seekerMaxAngle = 0;         // Maximum angle in which the seeker can turn
			
            seekerMinRange = 1;
            seekerMaxRange = 5000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "BOMB";
            attackProfiles[] = { "BOMB" };
			
			glideRatio = 3; //Paveway II = 5. Source: https://books.google.com/books?id=exm7JCR6DNsC&pg=PT203&lpg=PT203#v=onepage&q&f=false
			//Viper Strike = 10; Source: https://en.wikipedia.org/wiki/GBU-44/B_Viper_Strike#Specifications
			
		};
	};

	class ACE_MK82: ACE_BombCore {
        // Begin ACE guidance Configs
		class ace_missileguidance: ace_missileguidance {
			enabled = 0;

            // Attack profile type selection
            defaultAttackProfile = "BOMB";
            attackProfiles[] = { "BOMB" };
			
			//Like to have this variable than not.
			glideRatio = 3; //Paveway II = 5. Source: https://books.google.com/books?id=exm7JCR6DNsC&pg=PT203&lpg=PT203#v=onepage&q&f=false
			//Viper Strike = 10; Source: https://en.wikipedia.org/wiki/GBU-44/B_Viper_Strike#Specifications
			
		};
	};

	class ACE_GBU12: ACE_MK82 {
		displayName = "GBU-12 Paveway II";
		displayNameShort = "GBU-12";
		model = "\A3\Weapons_F\Ammo\Bomb_01_fly_F";
		// Begin ACE guidance Configs
		class ace_missileguidance: ace_missileguidance {
			enabled = 1;
			
			incDeflection = 0.001;      // The increment in which deflection adjusts (per second)..
			dlyDeflection = 0.15;           // Delay in reacting to signal input (simulates angular inertia) in seconds.
			canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
			defaultSeekerType = "SALH";
			seekerTypes[] = { "SALH" };

			defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = { "LOAL" };
			
            seekerAngle = 30;           // Angle in front of the missile which can be searched
			
            seekerMinRange = 1;
            seekerMaxRange = 5000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "BOMB";
            attackProfiles[] = { "BOMB" };
			
			glideRatio = 5; 
			
		};
	};

	class ACE_GBU38: ACE_MK82 {
		displayName = "GBU-38 JDAM";
		displayNameShort = "GBU-38";

		// Begin ACE guidance Configs
		class ace_missileguidance: ace_missileguidance {
			enabled = 1;
			
			canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
			defaultSeekerType = "GPS";
			seekerTypes[] = { "GPS" };

			defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = { "LOAL" };

            // Attack profile type selection
            defaultAttackProfile = "BOMB";
            attackProfiles[] = { "BOMB" };
			
			glideRatio = 4; 
			
		};
	};

	class ACE_MK83: ACE_MK82 {
		displayName = "Mk83 Bomb";
		displayNameShort = "Mk83";
		Hit = 6500;
		indirectHit = 1400;
		indirectHitRange = 22;
        // Begin ACE guidance Configs
		class ace_missileguidance: ace_missileguidance {
			glideRatio = 2.5; 
		};
	};

	class ACE_GBU16: ACE_MK82 {
		displayName = "GBU-16 Paveway II";
		displayNameShort = "GBU-16";
	// Begin ACE guidance Configs
		class ace_missileguidance: ace_missileguidance {
			enabled = 1;
			
			incDeflection = 0.001;      // The increment in which deflection adjusts (per second)..
			dlyDeflection = 0.15;           // Delay in reacting to signal input (simulates angular inertia) in seconds.
			canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
			defaultSeekerType = "SALH";
			seekerTypes[] = { "SALH" };

			defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = { "LOAL" };
			
            seekerAngle = 30;           // Angle in front of the missile which can be searched
			
            seekerMinRange = 1;
            seekerMaxRange = 5000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "BOMB";
            attackProfiles[] = { "BOMB" };
			
			glideRatio = 4.5; 
			
		};
	};

	class ACE_GBU32: ACE_MK82 {
		displayName = "GBU-32 JDAM";
		displayNameShort = "GBU-32";

		// Begin ACE guidance Configs
		class ace_missileguidance: ace_missileguidance {
			enabled = 1;
			
			canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
			defaultSeekerType = "GPS";
			seekerTypes[] = { "GPS" };

            // Attack profile type selection
            defaultAttackProfile = "BOMB";
            attackProfiles[] = { "BOMB" };
			
			glideRatio = 3.75;  
			
		};
	};

	class ACE_MK84: ACE_MK82 {
		displayName = "Mk84 Bomb";
		displayNameShort = "Mk84";

		Hit = 7500;
		indirectHit = 1950;
		indirectHitRange = 30;
        // Begin ACE guidance Configs
		class ace_missileguidance: ace_missileguidance {
			glideRatio = 2.5; 
		};
	};

	class ACE_GBU10: ACE_MK84 {
		displayName = "GBU-10 Paveway II";
		displayNameShort = "GBU-10";

		// Begin ACE guidance Configs
		class ace_missileguidance: ace_missileguidance {
			enabled = 1;

			incDeflection = 0.001;      // The increment in which deflection adjusts (per second)..
			dlyDeflection = 0.15;           // Delay in reacting to signal input (simulates angular inertia) in seconds.			
            // Guidance type for munitions
			defaultSeekerType = "SALH";
			seekerTypes[] = { "SALH" };

			defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = { "LOAL" };
			
            seekerAngle = 30;           // Angle in front of the missile which can be searched
			
            seekerMinRange = 1;
            seekerMaxRange = 5000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "BOMB";
            attackProfiles[] = { "BOMB" };
			
			//Like to have this variable than not.
			glideRatio = 4.25; //Paveway II. Source: https://books.google.com/books?id=exm7JCR6DNsC&pg=PT203&lpg=PT203#v=onepage&q&f=false
			//Viper Strike = 10; Source: https://en.wikipedia.org/wiki/GBU-44/B_Viper_Strike#Specifications
			
		};
	};

	class ACE_GBU31: ACE_MK84 {
		displayName = "GBU-31 JDAM";
		displayNameShort = "GBU-31";

        // Begin ACE guidance Configs
		class ace_missileguidance: ace_missileguidance {
			enabled = 1;
			
			canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
			defaultSeekerType = "GPS";
			seekerTypes[] = { "GPS" };

            // Attack profile type selection
            defaultAttackProfile = "BOMB";
            attackProfiles[] = { "BOMB" };
			
			glideRatio = 3.5;  
			
		};
	};


	//Missile guidance
    class MissileCore;
	class MissileBase: MissileCore {
        // Begin ACE guidance Configs
		class ace_missileguidance {
			enabled = 0;
			
			minDeflection = 0.0005;      // Minimum flap deflection for guidance
			maxDeflection = 0.0025;       // Maximum flap deflection for guidance
			incDeflection = 0.0005;      // The increment in which deflection adjusts (per second)..
			dlyDeflection = 0;           // Delay in reacting to signal input (simulates angular inertia) in seconds.
			
			canVanillaLock = 1;
			
            // Guidance type for munitions
			defaultSeekerType = "UNGUIDED";
			seekerTypes[] = { "UNGUIDED" };

			defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = { "LOAL" };
			
            seekerAngle = 90;           // Angle in front of the missile which can be searched
			seekerMaxAngle = 0;         // Maximum angle in which the seeker can turn
			seekerMaxTraverse = 0;       // Maximum rate of traverse that the seeker can turn deg/s
			
            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "LIN";
            attackProfiles[] = { "LIN" };
			
		};
	};

	//SACLOS
	class M_Scalpel_AT: MissileBase {
		class ace_missileguidance: ace_missileguidance {
			enabled = 1;
			
			canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
			defaultSeekerType = "SACLOS";
			seekerTypes[] = { "SACLOS" };

			defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = { "LOAL" };
			
            seekerAngle = 5;           // Angle in front of the missile which can be searched
			
            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "LIN";
            attackProfiles[] = { "LIN" };
			
		};
	};
	
	//AA missiles
	class M_Air_AA: MissileBase {
        // Begin ACE guidance Configs
		class ace_missileguidance: ace_missileguidance {
			enabled = 1;
			
			canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
			defaultSeekerType = "AAIR";
			seekerTypes[] = { "AAIR" };

			defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = { "LOAL" };
			
            seekerAngle = 5;           // Angle in front of the missile which can be searched
			seekerMaxAngle = 10;         // Maximum angle in which the seeker can turn
			seekerMaxTraverse = 0;       // Maximum rate of traverse that the seeker can turn deg/s
			
            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AAIR";
            attackProfiles[] = { "AAIR" };
			
		};
	};

	class Missile_AA_04_F: MissileBase {
        // Begin ACE guidance Configs
		class ace_missileguidance: ace_missileguidance {
			enabled = 1;
			
			canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
			defaultSeekerType = "AAIR";
			seekerTypes[] = { "AAIR" };

			defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = { "LOAL" };
			
            seekerAngle = 5;           // Angle in front of the missile which can be searched
			seekerMaxAngle = 10;         // Maximum angle in which the seeker can turn
			seekerMaxTraverse = 0;       // Maximum rate of traverse that the seeker can turn deg/s
			
            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AIR";
            attackProfiles[] = { "AIR" };
			
		};
	};


	class M_Titan_AA: MissileBase {
        // Begin ACE guidance Configs
        class ace_missileguidance: ace_missileguidance {
            enabled = 1;

            canVanillaLock = 0;

            // Guidance type for munitions
            defaultSeekerType = "AAIR";
            seekerTypes[] = { "AAIR" };

            defaultSeekerLockMode = "LOBL";
            seekerLockModes[] = { "LOBL" };

            seekerAngle = 5;           // Angle in front of the missile which can be searched
			seekerMaxAngle = 10;         // Maximum angle in which the seeker can turn
			seekerMaxTraverse = 1;       // Maximum rate of traverse that the seeker can turn deg/s

            seekerMinRange = 0;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            //seekLastTargetPos = 1;      // seek last target position [if seeker loses LOS of target, continue to last known pos]

            // Attack profile type selection
            defaultAttackProfile = "AAIR";
            attackProfiles[] = { "AAIR" };
        };
	};


	//laser guided
    class M_PG_AT: MissileBase {};
	
    class ACE_Hydra70_DAGR: M_PG_AT {
        displayName = CSTRING(Hydra70_DAGR);
        displayNameShort = CSTRING(Hydra70_DAGR_Short);

        description = CSTRING(Hydra70_DAGR_Desc);
        descriptionShort = CSTRING(Hydra70_DAGR_Desc);
		
        irLock = 0;
        laserLock = 0;
        manualControl = 0;
        maxSpeed = 300;
	
        EGVAR(rearm,caliber) = 70;
	
        class ace_missileguidance: ace_missileguidance {
			enabled = 1;
			
            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "SALH";
            seekerTypes[] = { "SALH", "Optic", "GPS", "SACLOS", "MCLOS" };

            defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = { "LOAL", "LOBL" };

            seekerAngle = 90;           // Angle in front of the missile which can be searched

            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "DAGR";
            attackProfiles[] = { "DAGR", "DIR", "MID", "HI" };
        };
    };


    // Titan
    class M_Titan_AT: MissileBase {
        // Begin ACE guidance Configs
        class ace_missileguidance: ace_missileguidance {
            enabled = 1;
	
            minDeflection = 0.00005;      // Minimum flap deflection for guidance
            maxDeflection = 0.025;       // Maximum flap deflection for guidance
            incDeflection = 0.00005;      // The increment in which deflection adjusts (per second)..
			dlyDeflection = 0.01;           // Delay in reacting to signal input (simulates angular inertia) in seconds.
			
            canVanillaLock = 0;

            // Guidance type for munitions
            defaultSeekerType = "SACLOS";
            seekerTypes[] = { "SACLOS" };

            defaultSeekerLockMode = "LOBL";
            seekerLockModes[] = { "LOBL" };

            seekerAngle = 10;           // Angle in front of the missile which can be searched

            seekerMinRange = 0;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            seekLastTargetPos = 1;      // seek last target position [if seeker loses LOS of target, continue to last known pos]

            // Attack profile type selection
            defaultAttackProfile = "LIN";
            attackProfiles[] = { "LIN"};
        };

	};

    class ACE_Javelin_FGM148: M_Titan_AT {
        irLock = 1;
        laserLock = 0;
        airLock = 0;

        // Turn off arma crosshair-guidance
        manualControl = 0;

        hit = 1400;         // default: 800
        indirectHit = 20;
        indirectHitRange = 2;
        // ACE uses these values
        //trackOversteer = 1;
        //trackLead = 0;
	
        initTime = 2;
	
        // Begin ACE guidance Configs
        class ace_missileguidance {
            enabled = 1;
	
            minDeflection = 0.00005;      // Minimum flap deflection for guidance
            maxDeflection = 0.025;       // Maximum flap deflection for guidance
            incDeflection = 0.00005;      // The increment in which deflection adjusts (per second)..
			dlyDeflection = 0;           // Delay in reacting to signal input (simulates angular inertia) in seconds.
			
            canVanillaLock = 0;

            // Guidance type for munitions
            defaultSeekerType = "Optic";
            seekerTypes[] = { "Optic" };

            defaultSeekerLockMode = "LOBL";
            seekerLockModes[] = { "LOBL" };

            seekerAngle = 180;           // Angle in front of the missile which can be searched

            seekerMinRange = 0;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            seekLastTargetPos = 1;      // seek last target position [if seeker loses LOS of target, continue to last known pos]

            // Attack profile type selection
            defaultAttackProfile = "JAV_TOP";
            attackProfiles[] = { "JAV_TOP", "JAV_DIR" };
        };
    };
    class ACE_Javelin_FGM148_static: ACE_Javelin_FGM148 {
        //Take config changes from (M_Titan_AT_static: M_Titan_AT)
        initTime = 0.25;  //"How long (in seconds) the projectile waits before starting it's engine.", - but doesn't seem to do anything
        effectsMissileInit = "RocketBackEffectsStaticRPG";

        //Explicity add guidance config
        class ace_missileguidance: ace_missileguidance {};
	};

};
