local spEcho = Spring.Echo (string)  
local spGetLocalTeamID = Spring.GetLocalTeamID ()    
local spGetTeamUnits = Spring.GetTeamUnits (teamID)
local spGetAllyTeamList = Spring.GetAllyTeamList ()
local spGetTeamList  = Spring.GetTeamList ()
local spGetUnitPosition = Spring.GetUnitPosition (unitID)
local spGetResources = Spring.GetTeamResources (teamID, "metal")
local spGetUnitDefID = Spring.GetUnitDefID (unitID)
local spGetUnitPosition = Spring.GetUnitPosition (unitID)
local spIsTransporting = Spring.GetUnitIsTransporting (unitID)
local spGetUnitTransporter = Spring.GetUnitTransporter (unitID)
local spCommand = Spring.GiveOrderToUnit (unitID, cmdID, {parametry}, {nic/"shift"/"ctrl"})
local spGetHeight = Spring.GetGroundHeight (x, z)






CMD.UNLOAD_UNIT = {x, y, z}
CMD.LOAD_UNITS = {unitID}
CMD.MOVE = {x, y, z}
CMD.RECLAIM = {x, y, z, range}
CMD.STOP = {}
CMD.TIMEWAIT = {time_ms}
CMD.SELFD = {}

