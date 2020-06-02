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

    class VehicleMagazine;
    class 1000Rnd_Gatling_30mm_Plane_CAS_01_F: VehicleMagazine {};
    class ACE_1000Rnd_Gatling_30mm_Plane_DEBUG: 1000Rnd_Gatling_30mm_Plane_CAS_01_F {
        ammo = "Gatling_30mm_DEBUG";
        displayName = "DEBUG";
        displayNameShort = "DEBUG";
    };

    class 8Rnd_82mm_Mo_shells;
    class 8Rnd_82mm_Mo_DEBUG: 8Rnd_82mm_Mo_shells {
        ammo = "Sh_82mm_DEBUG";
        displayName = "DEBUG";
        displayNameShort = "DEBUG";
    };
    
    class 1Rnd_HE_Grenade_shell;
    class 1Rnd_HE_Grenade_DEBUG: 1Rnd_HE_Grenade_shell{
        ammo = "G_40mm_DEBUG";
        displayName = "DEBUG";
        displayNameShort = "DEBUG";
        initSpeed = 160;
    };
    
    class magazine_Missiles_Cruise_01_x18;
    class magazine_Missiles_Cruise_DEBUG: magazine_Missiles_Cruise_01_x18 {
        ammo = "ammo_Missile_Cruise_DEBUG";
        displayName = "DEBUG";
        displayNameShort = "DEBUG";
    };
};
