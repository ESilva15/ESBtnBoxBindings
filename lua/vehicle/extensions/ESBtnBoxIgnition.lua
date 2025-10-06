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

local function toggleIgnitionAcc()
  electrics.toggleIgnitionLevelOnUp()
  print("Toggle ignition to accessories")
  if curIgnitionPos == ignitionAcc then
    electrics.setIgnitionLevel(ignitionOff)
    curIgnitionPos = ignitionOff
    controller.mainController.setEngineIgnition(false)
  else
    electrics.setIgnitionLevel(ignitionAcc)
    curIgnitionPos = ignitionAcc
    controller.mainController.setEngineIgnition(false)
  end
end

local function toggleIgnitionOn()
  print("Toggle ignition to on")
  if curIgnitionPos == ignitionOn then
    electrics.setIgnitionLevel(ignitionOff)
    curIgnitionPos = ignitionOff
    controller.mainController.setEngineIgnition(false)
  else
    electrics.setIgnitionLevel(ignitionOn)
    curIgnitionPos = ignitionOn
    controller.mainController.setEngineIgnition(true)
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
  print("releasing starter")
  if curIgnitionPos < 2 then
    return
  end

  controller.mainController.setStarter(false)
end

-- local function update(dt)
--   if starterHeld then
--     -- Engine cranked long enough?
--     if electrics.values.rpm > 400 then
--       -- Engine started
--       controller.mainController.setStarter(false)
--       setIgnitionLevel(ignitionRunning)
--       engineRunning = true
--       starterHeld = false
--       print("Engine started successfully")
--     end
--   end

--   -- If engine was running and ignition is turned off → shut down
--   if engineRunning and curIgnitionPos < ignitionOn then
--     controller.mainController.setEngineIgnition(false)
--     engineRunning = false
--     print("Engine stopped due to ignition OFF/ACC")
--   end
-- end

M.toggleIgnitionAcc = toggleIgnitionAcc
M.toggleIgnitionOn = toggleIgnitionOn
M.turnStarter = turnStarter
M.releaseStarter = releaseStarter
-- M.update = update

return M