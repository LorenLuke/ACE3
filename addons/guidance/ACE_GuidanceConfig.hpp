class GVAR(SensorTypes) {
    class generic {
        functionName = "";
        priority = 0;
        preguidanceEnabled = 1;
        range = -1;
        angle = -1;
        datalinked = 0;
    };
    class EO_contrast: generic { //contrast seeker, e.g. javelin
        functionName = QFUNC(sensorType_EO_contrast);
        priority = 1000;
        range = 2500;
        angle = 65;
    };
    class EO_image: generic { //image comparison, e.g. maverick
        functionName = QFUNC(sensorType_EO_image);
        priority = 1000;
        range = 5000;
        angle = 65;
    };    
    class TV: generic {
        functionName = QFUNC(sensorType_TV);
        priority = 100000;
        datalinked = 1;
        };
    class IR: generic {
        functionName = QFUNC(sensorType_IR);
        priority = 10000;
        range = 3500; //range to detect something with 1.0 IR coefficient
        angle = 25;
    };
    class GPS: generic {
        functionName = QFUNC(sensorType_GPS);
        priority = 1;
    };
    class INS: generic {
        functionName = QFUNC(sensorType_INS);
        priority = 1;
    };
    class SALH: generic {
        functionName = QFUNC(sensorType_SALH);
        priority = 10000;
        range = 3500;
        angle = 60;
    };
    class SARH: generic {
        functionName = QFUNC(sensorType_SARH);
        priority = 10000;
        range = 1; //powoer-distance (plus distance of reflection) equivalent of radar to detect, after 1/r^4 bleedoff
        angle = 30;
    };
    class ARH: generic {
        functionName = QFUNC(sensorType_ARH);
        priority = 100000;
        range = 1250; //range to just barely detect a target with 1.0 stealth coefficient
        angle = 30;
    };
    class PRH: generic {
        functionName = QFUNC(sensorType_PRH);
        priority = 10000;
        range = 0.01; //emitted energy density must be equal to power level (with 1 being base unit of detecting 1.0 stealth at range); 
        angle = 30;
    };
    class SACLOS: generic {
        functionName = QFUNC(sensorType_SACLOS);
        priority = 100000;
        preguidanceEnabled = 0;
        range = 5000;
        angle = 15;
    };
    class MCLOS: generic {
        functionName = QFUNC(sensorType_MCLOS);
        priority = 100000;
        preguidanceEnabled = 0;
        range = 5000;
    };
    class PLOS: generic {
        functionName = QFUNC(sensorType_PLOS);
        priority = 100000;
    };
};

class GVAR(SeekerTypes) {
    class generic {
        functionName = QFUNC(seekerType_UNGUIDED);
        // [sensor name, range, angle, terminal sensor, active on rail, data linked]; -1 for ignore/use default;
        sensors[] = {};
        terminalRange = -1; //range /FROM LAUNCH POINT/ to where terminal seekers kick in
        terminalAngle = -1; //when vector to target and missile vector are this far apart anguglarly, kick in terminal seekers;
    };
    
    class EO_contrast_generic: generic {
        sensors[] = {{"EO_contrast", -1, -1, 0, 1, 0}};
        functionName = QFUNC(seekerType_EO_generic);
    };
    class EO_image_generic: generic {
        sensors[] = {{"EO_image", -1, -1, 0, 1, 0}};
        functionName = QFUNC(seekerType_EO_generic);
    };
    class TV_generic: generic {
        sensors[] = {{"TV", -1, -1, 0, 1, 1}};
        functionName = QFUNC(seekerType_TV_generic);
    };
    class IR_generic: generic {
        sensors[] = {{"IR", -1, -1, 0, 1, 0}};
        functionName = QFUNC(seekerType_IR_generic);
    };
    class GPS_generic: generic {
        sensors[] = {{"GPS", -1, -1, 0, 1, 0}};
        functionName = QFUNC(seekerType_GPS_generic);
    };
    class INS_generic: generic {
        sensors[] = {{"INS", -1, -1, 0, 1, 0}};
        functionName = QFUNC(seekerType_INS_generic);
    };
    class SALH_generic: generic {
        sensors[] = {{"SALH", -1, -1, 0, 1, 0}};
        functionName = QFUNC(seekerType_SALH_generic);
    };
    class SARH_generic: generic {
        sensors[] = {{"SARH", -1, -1, 0, 1, 0}};
        functionName = QFUNC(seekerType_SARH_generic);
    };
    class ARH_generic: generic {
        sensors[] = {{"ARH", -1, -1, 0, 1, 0}};
        functionName = QFUNC(seekerType_ARH_generic);
    };
    class PRH_generic: generic {
        sensors[] = {{"PRH", -1, -1, 0, 1, 0}};
        functionName = QFUNC(seekerType_PRH_generic);
    };
    class SACLOS_generic: generic {
        sensors[] = {{"SACLOS", -1, -1, 0, 0, 0}};
        functionName = QFUNC(seekerType_SACLOS_generic);
    };
    class MCLOS_generic: generic {
        sensors[] = {{"MCLOS", -1, -1, 0, 0, 0}};
        functionName = QFUNC(seekerType_MCLOS_generic);
    };
    class PLOS_generic: generic {
        sensors[] = {{"PLOS", -1, -1, 0, 0. 0}};
        functionName = QFUNC(seekerType_PLOS_generic);
    };
    
    
    class Sidewinder: generic {
        sensors[] = {{"INS", -1, -1, 0, 1, 0}, {"IR", -1, -1, 1, 1, 0}};
        terminalRange = 300;
        terminalAngle = 0.05;
        functionName = QFUNC(seekerType_AIM9);
    };
    class SidewinderX: Sidewinder {
        sensors[] = {{"INS", -1, -1, 0, 1, 0}, {"IR", -1, 180, 1, 1, 0}};
        functionName = QFUNC(seekerType_AIM9X);
        terminalRange = 2000;
        terminalAngle = 0.002;
    };
    class AAMRAAM: generic {
        
    };
    
    class Stinger: generic {
        sensors[] = {{"IR", -1, -1, 0, 1, 0}};
    };
    class Maverick: generic {
        sensors[] = {{"EO", 5000, -1, 0, 1, 0}};
    };
    class LaserMaverick: generic {
        sensors[] = {{"SALH", 5000, -1, 0, 1, 0}};
    };
};

class GVAR(AttackProfiles) {
    //DEBUG
    class LIN {

        functionName = QFUNC(attackProfile_LIN);
    };
    
    class ASM {

        functionName = QFUNC(attackProfile_ASM);
    };

    class SSBM {

        functionName = QFUNC(attackProfile_SSBM);
    };
    
    class AIM {

        functionName = QFUNC(attackProfile_AIM);
    };
    
     class GBU {

        functionName = QFUNC(attackProfile_GBU);
    };
    
    class INDIRECT {

        functionName = QFUNC(attackProfile_INDIRECT);
    };
    
    class DIRECT {

        functionName = QFUNC(attackProfile_DIRECT);
    };
};
