local sensorInfo = {
	name = "loadPathInfo",
	desc = "Stores paths and strongholds into bb.paths and bb.strongholds",
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

return function()
  info = core.MissionInfo()
  bb.paths = {{},{},{}}
  bb.strongholds = {{},{},{}}
	--TODO assign from info
end