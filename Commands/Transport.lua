function getInfo()
	return {
		onNoUnits = SUCCESS,
		parameterDefs = {
			{ 
				name = "transporterID",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",

			},
      { 
				name = "targetID",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",

			},
			{ 
				name = "pos",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},		
      { 
				name = "finalPos",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			}		
		}

	}
end

running = {}

-- speedups
local spEcho = Spring.Echo
local spIsTransporting = Spring.GetUnitIsTransporting
local spCommand = Spring.GiveOrderToUnit
local spGetUnitPosition = Spring.GetUnitPosition
local spGetHeight = Spring.GetGroundHeight
local spGetUnitDefID = Spring.GetUnitDefID
local spGetUnitCommands = Spring.GetUnitCommands

-- @description Unit with TransporterID will transport TargetID to position Pos and then it can move to FinalPos 

function Run(self, units, parameter) 
  local transporterID = parameter.transporterID
	local targetID = parameter.targetID
  local pos = parameter.pos
  local finalPos = parameter.finalPos
  --transporter and target check
  if transporterID == nil or 
     targetID == nil or 
     pos == nil or
     not UnitDefs[spGetUnitDefID(transporterID)].isTransport or 
     UnitDefs[spGetUnitDefID(targetID)].cantBeTransported then
    return SUCCESS
  end
  
  if running[transporterID] ~= nil then
    if spGetUnitCommands(transporterID, 0) <= 1 then
      running[transporterID] = nil
      bb.transports[transporterID] = "free"
      return SUCCESS
    else
      return RUNNING
    end
  end
  running[transporterID] = true
  transported = spIsTransporting(transporterID)  
  spCommand(transporterID, CMD.STOP, {}, {})  
  --if the transporter is transporting something different, drop it
  if transported ~= nil and transported[1] ~= targetID then
    spCommand(transporterID, CMD.TIMEWAIT, {500}, {"shift"})
    x, y, z = spGetUnitPosition(transporterID)
    spCommand(transporterID, CMD.UNLOAD_UNIT, {x, spGetHeight(x, z), z}, {"shift"})
  end
  
  --if the transporter is not transporting target, pick it
  if transported == nil or transported[1] ~= targetID then
    spCommand(transporterID, CMD.LOAD_UNITS, {targetID}, {"shift"})
  end

  --transport unit to wanted position 
  spCommand(transporterID, CMD.MOVE, {pos.x, spGetHeight(pos.x, pos.z), pos.z}, {"shift"})
  spCommand(transporterID, CMD.TIMEWAIT, {500}, {"shift"})
  spCommand(transporterID, CMD.UNLOAD_UNIT, {pos.x, spGetHeight(pos.x, pos.z), pos.z}, {"shift"})
  
  --if required, move transporter somewhere else
  if finalPos ~= nil then
    spCommand(transporterID, CMD.MOVE, {finalPos.x, spGetHeight(finalPos.x, finalPos.z), finalPos.z}, {"shift"})
  end
  return RUNNING
end