//Documentation for UAV system;
/*
ACE settings-
Enable <BOOL>- Enable ACE UAV module;
Restrict UAV network to side <BOOL>- restricts UAV network only to the UAV's side, even if an enemy has the appropriate side's terminal;
Restrict UAV connection to side <BOOL>- restricts UAV connection only to the UAV's side, even if an enemy has the appropriate side's terminal, an enemy can still view UAVs on the map;
Restrict UAV control to side <BOOL>- restricts UAV control only to the UAV's side, even if an enemy has the appropriate side's terminal, an enemy unit can still view the feed;
Restrict UAV control to operators <BOOL>- restricts UAV control to drone operators only, others can still view.



global Variables-
GVAR(
UAVNetworks <ARRAY>- List of all UAV networks;
UAVNetworks_WEST <ARRAY>-
UAVNetworks_EAST <ARRAY>-
UAVNetworks_GUER <ARRAY>-
UAVNetworks_CIV <ARRAY>-

UAV Variables-
GVAR(
connectedUnits- list of units connected to UAV in any way;
viewingUnits- list of two element arrays for units currently viewing camera feeds from the UAV, form as array- [_unit, "driver/gunner", PiP boolean (false for fullscreen)];
controllingUnits- list of units currently controlling the UAV, form as array- [_unit, "driver/gunner"];
networks- list of networks the UAV can be accessed from;
)

Unit Variables- 
GVAR(
connectedUAV- singular UAV the unit is connected to;
viewingUAV- array of the UAV the unit is viewing, if viewing, [uav, "driver/gunner", PiP boolean (false for fullscreen)]; if not viewing, viewingUAV = [];
controllingUAV- array of the UAV the unit is controlling, if controlling, [uav, "driver/gunner"]; if not controlling, controllingUAV = [];

networks- array of networks the unit can access inherently, form of ["networkName", control boolean (false if can only view on network)], works without terminal;
dependedNetworks- array of networks the unit can access with an item (most likely a terminal, can be any item), form of ["networkName", "item type", control boolean (false if can only view on network)], requires specified terminal;
