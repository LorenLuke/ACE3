class CfgMagazines {
    class 12Rnd_PG_missiles;

    class 6Rnd_ACE_Hydra70_DAGR : 12Rnd_PG_missiles {
        ammo = "ACE_Hydra70_DAGR";
        count = 12;
        displayName = "6 Round DAGR";
        displayNameShort = "6 Round DAGR";
        descriptionShort = "6 Round DAGR";
        weight = 36;

    };
    class 12Rnd_ACE_Hydra70_DAGR : 6Rnd_ACE_Hydra70_DAGR {
        count = 12;
        displayName = "16 Round DAGR";
        displayNameShort = "16 Round DAGR";
        descriptionShort = "16 Round DAGR";
        weight = 72;
    };
    class 24Rnd_ACE_Hydra70_DAGR : 6Rnd_ACE_Hydra70_DAGR {
        count = 24;
        displayName = "24 Round DAGR";
        displayNameShort = "24 Round DAGR";
        descriptionShort = "24 Round DAGR";
        weight = 72;
    };


    class 2Rnd_Mk82;
    
    class 2Rnd_ACE_Mk82: 2Rnd_Mk82 { // Old style vehicle magazine
        count = 2;
        ammo = "ACE_Mk82";
        displayName = "Mk82 [ACE]";
        displayNameShort = "Mk82 [ACE]";
        descriptionShort = "Mk82 [ACE]";
    };

    // 1.70 pylon magazines:	
	class PylonRack_2Rnd_ACE_Mk82: 2Rnd_ACE_Mk82 {
		displayName = "2x Mk82 [ACE]";
		count = 2;
		mass = 450;
		pylonWeapon = "ACE_Mk82BombLauncher";
//        hardpoints[] = {"UNI_SCALPEL", "B_GBU12_DUAL_RAIL", "I_GBU12_DUAL_RAIL"};
        hardpoints[] = {"UNI_SCALPEL"};
	};

	class PylonRack_2Rnd_ACE_GBU12: PylonRack_2Rnd_ACE_Mk82 {
		displayName = "2x GBU-12 [ACE]";
        displayNameShort = "GBU-12";
        descriptionShort = "GBU-12";
        ammo = "ACE_GBU12";
		count = 2;
		mass = 450;
		pylonWeapon = "ACE_GBU12BombLauncher";
	};

	class PylonRack_2Rnd_ACE_GBU35: PylonRack_2Rnd_ACE_Mk82 {
        ammo = "ACE_GBU35";
		displayName = "1x GBU-35 [ACE]";
        displayNameShort = "GBU-35";
        descriptionShort = "GBU-35";

		pylonWeapon = "ACE_GBU35BombLauncher";
	};
	
		class PylonMissile_1Rnd_ACE_Mk82: PylonRack_2Rnd_ACE_Mk82 {
		displayName = "1x Mk82 [ACE]";
        displayNameShort = "Mk82";
        descriptionShort = "Mk82";

		count = 1;
		mass = 225;
		pylonWeapon = "ACE_Mk82BombLauncher";
        hardpoints[] = {"UNI_SCALPEL", "B_BOMB_PYLON", "B_GBU12", "I_GBU12", "B_GBU12_DUAL_RAIL", "I_GBU12_DUAL_RAIL"};
	};

	class PylonMissile_1Rnd_ACE_GBU12: PylonMissile_1Rnd_ACE_Mk82 {
		displayName = "1x GBU-12 [ACE]";
        displayNameShort = "GBU-12";
        descriptionShort = "GBU-12";

        ammo = "ACE_GBU12";
		count = 1;
		mass = 225;
		pylonWeapon = "ACE_GBU12BombLauncher";
	};

	class PylonMissile_1Rnd_ACE_GBU38: PylonMissile_1Rnd_ACE_Mk82 {
		displayName = "1x GBU-38 [ACE]";
        displayNameShort = "GBU-38";
        descriptionShort = "GBU-38";

        ammo = "ACE_GBU38";
		count = 1;
		mass = 225;
		pylonWeapon = "ACE_GBU38BombLauncher";
	};

	class PylonRack_2Rnd_ACE_Mk83: PylonRack_2Rnd_ACE_Mk82 {
		displayName = "2x Mk83 [ACE]";
        displayNameShort = "Mk83";
        descriptionShort = "Mk83";

		ammo = "ACE_Mk83";
		count = 2;
		mass = 900;
		pylonWeapon = "ACE_Mk83BombLauncher";
        hardpoints[] = {"UNI_SCALPEL", "B_GBU12_DUAL_RAIL", "I_GBU12_DUAL_RAIL"};
	};

	class PylonRack_2Rnd_ACE_GBU16: PylonRack_2Rnd_ACE_Mk83 {
		displayName = "2x GBU-16 [ACE]";
        displayNameShort = "GBU-16 [ACE]";
        descriptionShort = "GBU-16 [ACE]";

        ammo = "ACE_GBU16";
		count = 2;
		mass = 900;
		pylonWeapon = "ACE_GBU16BombLauncher";
        hardpoints[] = {"UNI_SCALPEL"};
	};

	class PylonRack_2Rnd_ACE_GBU32: PylonRack_2Rnd_ACE_Mk83 {
		displayName = "2x GBU-32 [ACE]";
        displayNameShort = "GBU-32";
        descriptionShort = "GBU-32";

        ammo = "ACE_GBU32";
		count = 2;
		mass = 900;
		pylonWeapon = "ACE_GBU32BombLauncher";
	};

	class PylonMissile_1Rnd_ACE_Mk83: PylonRack_2Rnd_ACE_Mk83 {
		displayName = "1x Mk83 [ACE]";
        displayNameShort = "Mk83";
        descriptionShort = "Mk83";
		count = 1;
		mass = 450;
		pylonWeapon = "ACE_Mk83BombLauncher";
        hardpoints[] = {"UNI_SCALPEL", "B_BOMB_PYLON", "B_GBU12", "I_GBU12", "B_GBU12_DUAL_RAIL", "I_GBU12_DUAL_RAIL"};
	};

	class PylonMissile_1Rnd_ACE_GBU16: PylonMissile_1Rnd_ACE_Mk83 {
		displayName = "1x GBU-16 [ACE]";
        displayNameShort = "GBU-16";
        descriptionShort = "GBU-16";

        ammo = "ACE_GBU16";
		count = 1;
		mass = 450;
		pylonWeapon = "ACE_GBU16BombLauncher";
	};

	class PylonMissile_1Rnd_ACE_GBU32: PylonMissile_1Rnd_ACE_Mk83 {
		displayName = "1x GBU-32 [ACE]";
        displayNameShort = "GBU-32";
        descriptionShort = "GBU-32";

        ammo = "ACE_GBU32";
		count = 1;
		mass = 450;
		pylonWeapon = "ACE_GBU32BombLauncher";
	};

	class PylonMissile_1Rnd_ACE_Mk84: PylonMissile_1Rnd_ACE_Mk83 {
		displayName = "1x Mk84 [ACE]";
        displayNameShort = "Mk84";
        descriptionShort = "Mk84";

		mass = 900;
		pylonWeapon = "ACE_Mk83BombLauncher";
        hardpoints[] = {"UNI_SCALPEL", "B_BOMB_PYLON", "B_GBU12_DUAL_RAIL", "I_GBU12_DUAL_RAIL"};
	};

	class PylonMissile_1Rnd_ACE_GBU10: PylonMissile_1Rnd_ACE_Mk84 {
		displayName = "1x GBU-10 [ACE]";
        displayNameShort = "GBU-10";
        descriptionShort = "GBU-10";

        ammo = "ACE_GBU10";
		count = 1;
		mass = 900;
		pylonWeapon = "ACE_GBU10BombLauncher";
	};

	class PylonMissile_1Rnd_ACE_GBU31: PylonMissile_1Rnd_ACE_Mk84 {
		displayName = "1x GBU-31 [ACE]";
        displayNameShort = "GBU-31";
        descriptionShort = "GBU-31";

        ammo = "ACE_GBU31";
		count = 1;
		mass = 900;
		pylonWeapon = "ACE_GBU31BombLauncher";
	};

};
