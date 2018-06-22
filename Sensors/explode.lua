local sensorInfo = {
	name = "explode",
	desc = "Destroy unit inside enemies",
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

local spCommand = Spring.GiveOrderToUnit

return function(unitIDs, scores, limit)
  for key, unitID in pairs(unitIDs) do
    if scores[key] >= limit then
      spCommand(unitID, CMD.SELFD, {}, {}) 
    end
  end
end