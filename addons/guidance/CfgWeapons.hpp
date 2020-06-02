class CfgWeapons {
    class missiles_DAGR;

    class GVAR(dagr): missiles_DAGR {
        canLock = 0;
        magazines[] = {"6Rnd_ACE_Hydra70_DAGR","12Rnd_ACE_Hydra70_DAGR","24Rnd_ACE_Hydra70_DAGR"};
        lockingTargetSound[] = {"",0,1};
        lockedTargetSound[] = {"",0,1};
    };

    class CannonCore;
    // REPLAY BULLETS!
    class Gatling_30mm_Plane_CAS_01_F: CannonCore {
        magazines[] += {"ACE_1000Rnd_Gatling_30mm_Plane_DEBUG"};
   };

    class mortar_82mm: CannonCore {
        class Single1;
        magazines[] += {"8Rnd_82mm_Mo_DEBUG"};
    };
    
    class weapon_VLSBase;
    class weapon_VLS_01: weapon_VLSBase {
        magazines[] += {"magazine_Missiles_Cruise_DEBUG"};
    };
  
};
