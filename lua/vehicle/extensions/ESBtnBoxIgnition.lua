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
  print("Toggle ignition to accessories")
  if curIgnitionPos == ignitionAcc then
    electrics.values.ignitionLevel = ignitionOff
    curIgnitionPos = ignitionOff
    controller.mainController.setEngineIgnition(false)
  else
    electrics.values.ignitionLevel = ignitionAcc
    curIgnitionPos = ignitionAcc
    controller.mainController.setEngineIgnition(false)
  end

  local ignPos = electrics.values.ignitionLevel
  print("cur ignition lvl: " .. ignPos or nil)
end

local function toggleIgnitionOn()
  print("Toggle ignition to on")
  if curIgnitionPos == ignitionOn then
    electrics.values.ignitionLevel = ignitionOff
    curIgnitionPos = ignitionOff
    controller.mainController.setEngineIgnition(false)
  else
    electrics.values.ignitionLevel = ignitionOn
    curIgnitionPos = ignitionOn
    controller.mainController.setEngineIgnition(true)
  end

  local ignPos = electrics.values.ignitionLevel
  print("cur ignition lvl: " .. ignPos or nil)
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

M.toggleIgnitionAcc = toggleIgnitionAcc
M.toggleIgnitionOn = toggleIgnitionOn
M.turnStarter = turnStarter
M.releaseStarter = releaseStarter

return M