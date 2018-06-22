local sensorInfo = {
	name = "assignLines",
	desc = "Command infiltrators to follow lines",
	author = "novotnyt",
	date = "2018-06-20",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

local spCommand = Spring.GiveOrderToUnit

function getArgMin(counts)
  local argmin = 1
  local minval = counts[1]
  for i = 2, #counts do
  if counts[i] < minval then
    argmin = i
    minval = counts[i]
  end
  return argmin  
end

function givePathCommand(unitID, lineID)
  --TODO get path from missionInfo and follow it; end with CMD.SELFD if nothing was found
  --for
  --spCommand(unitID, CMD.MOVE, {...}, {"shift"})
  --end
  --spCommand(unitID, CMD.SELFD, {}, {"shift"})
end

return function()  
  local counts = {0,0,0}
	for key, value in pairs(bb.infiltrators) do 
		if value ~= 0 then
      counts[value] = counts[value] + 1
		end
	end
  for key, value in pairs(bb.infiltrators) do 
		if value == 0 then
      line = getArgMin(counts)
      counts[line] = counts[line] + 1
			bb.infiltrators[key] = line
      givePathCommand(key, line)      
			end
		end
	end
end