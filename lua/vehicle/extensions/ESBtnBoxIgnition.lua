local M = {}

----------------------------------------------------------------------------------------------------
-- UTILITY
----------------------------------------------------------------------------------------------------
local function setIgnitionLevel(level)
  electrics.values.ignitionLevel = level
  curIgnitionPos = level
end

-- BeamNG ignition states
-- Ignition OFF     0
-- Ignition Acc     1
-- Ignition ON      2
-- Ignition Running 3
local ignitionOff = 0
local ignitionAcc = 1
local ignitionOn = 2
local ignitionRunning = 3
local curIgnitionPos = 0
local requestToReset = false

local function setIgnitionOff()
  electrics.setIgnitionLevel(ignitionOff)
  curIgnitionPos = ignitionOff
  controller.mainController.setEngineIgnition(false)
end

local function setIgnitionAcc()
  electrics.setIgnitionLevel(ignitionAcc)
  curIgnitionPos = ignitionAcc
  controller.mainController.setEngineIgnition(false)
end

local function setIgnitionOn()
  electrics.setIgnitionLevel(ignitionOn)
  curIgnitionPos = ignitionOn
  controller.mainController.setEngineIgnition(true)
end

local function toggleIgnitionAcc()
  electrics.toggleIgnitionLevelOnUp()
  if curIgnitionPos == ignitionAcc then
    setIgnitionOff()
  else
    setIgnitionAcc()
  end
end

local function toggleIgnitionOn()
  if curIgnitionPos == ignitionOn then
    setIgnitionOff()
  else
    setIgnitionOn()
  end
end

----------------------------------------------------------------------------------------------------
-- STARTER
----------------------------------------------------------------------------------------------------

local starterHeld = false
local engineRunning = false

local function turnStarter()
  if curIgnitionPos < 2 then
    return
  end

  controller.mainController.setStarter(true)
end

local function releaseStarter()
  if curIgnitionPos < 2 then
    return
  end

  controller.mainController.setStarter(false)
end

M.toggleIgnitionAcc = toggleIgnitionAcc
M.toggleIgnitionOn = toggleIgnitionOn
M.turnStarter = turnStarter
M.releaseStarter = releaseStarter

local function restoreIgnition(level)
  print("Restoring ignition to " .. level)
  if level == ignitionAcc then
    print("Setting ignition to acc")
    setIgnitionAcc()
  elseif level == ignitionOn then
    print("Setting ignition to on")
    setIgnitionOn()
  end
end

local function onReset()
  -- TODO - find a way of checking if the vehicles eletrics are loaded or something
  requestToReset = true
end

local myTimer = 0
local function updateGFX(dt)
  if not requestToReset then
    return
  end

  myTimer = myTimer + dt
  if myTimer > 1 then
      restoreIgnition(curIgnitionPos)
      myTimer = 0
  end
end

M.onReset = onReset
M.updateGFX = updateGFX

return M