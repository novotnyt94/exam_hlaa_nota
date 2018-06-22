local sensorInfo = {
	name = "getAllinfiltrators",
	desc = "Returns all owned infiltrators on the map",
	author = "Krabec,novotnyt",
	date = "2018-06-20",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- @description return table of all transportable allied units
return function()
	local teamID = Spring.GetMyTeamID()
	local allies = Spring.GetTeamUnits(teamID)
	local infiltrators = {}
	if bb.infiltrators == nil then
		bb.infiltrators = {}
	end
	for key,value in pairs(bb.infiltrators) do
		if not Spring.ValidUnitID(key) then bb.infiltrators[key] = nil end
	end
	
	local index = 1
	for _,value in pairs(allies) do
		local defID = Spring.GetUnitDefID(value)
		if UnitDefs[defID].humanName == "Infiltrator" then
			infiltrators[#infiltrators+1] = value
			if bb.infiltrators[value] == nil then
				bb.infiltrators[value] = 0
			end
		end
	end
	return infiltrators
end