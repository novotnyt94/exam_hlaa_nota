local sensorInfo = {
	name = "columnCheck",
	desc = "check unit situation in given location",
	author = "novotnyt",
	date = "2018-06-22",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

local spGetMyAllyID = Spring.GetMyAllyTeamID
local spGetUnitsInCylinder = Spring.GetUnitsInCylinder
local spGetUnitAllyTeam = Spring.GetUnitAllyTeam
local spGetUnitPosition = Spring.GetUnitPosition

return function(unitIDs, radius)
  scores = {}
  for key, unitID in pairs(unitIDs) do
    x,y,z = spGetUnitPosition(unitID)
  	local closeUnits = spGetUnitsInCylinder(x, z, radius)
    if closeUnits == nil then
      scores[key] = 0 
      break
    end
    local total = 0
  	for i=1,#closeUnits do
  			if spGetUnitAllyTeam(closeUnits[i]) == spGetMyAllyID() then 
          total = total - 1
        else
          total = total + 1
        end
  		end
  	end
    scores[key] = total
  end
  return scores
end