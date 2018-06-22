local sensorInfo = {
	name = "findFronts",
	desc = "find places on map, where fighting is happenning",
	author = "Krabec,Petrroll,novotnyt",
	date = "2018-06-20",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0
local spGetUnitPosition = Spring.GetUnitPosition

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

local radius = 2000 --TODO constanta
local spGetMyAllyID = Spring.GetMyAllyTeamID
local spGetUnitsInCylinder = Spring.GetUnitsInCylinder
local spGetUnitAllyTeam = Spring.GetUnitAllyTeam

-- is location far enough from enemies
function isLocSafe(point)
	local closeUnits = spGetUnitsInCylinder(point.x, point.z, radius)
  if closeUnits == nil then return true end
	for i=1,#closeUnits do  --TODO osetrit jednotky ktere nevidim
		if spGetUnitAllyTeam(closeUnits[i]) ~= spGetMyAllyID() then return false end
	end
	return true
end

-- update lane map safety information 
function updateLaneSafety(i)
	local path = bb.map[i]
	local dangerStart = false
	for key,value in pairs(path) do

		if not dangerStart and not isLocSafe(value) then
			dangerStart = true
		end

		if dangerStart then
			path[key] = "danger"
		else
			path[key] = "safe"
		end
	end
	
end

-- init map with default values
function initMap(paths)
	bb.map = {}
	for i = 1,3 do
		-- init lane's map
		bb.map[i] = {}
		local index = 1
		for key,value in pairs(paths[i]) do
			bb.map[i][index] = "ERR"
			index = index + 1
		end
	end
end


return function()
	if bb.map == nil then initMap(bb.paths) end
	for i=1,3 do
		updateLaneSafety(i)
	end
end