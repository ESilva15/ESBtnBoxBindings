local M = {}

----------------------------------------------------------------------------------------------------
-- Range Box
----------------------------------------------------------------------------------------------------

local rangeMode4hi = "4hi"
local rangeMode4lo = "4lo"
local rangeMode2hi = "2hi"
local curRangeMode = rangeMode2hi

-- changeMode changes the instance of transfercaseControl `tfc` to the mode `mode`
local function changeTransfercaseMode(tfc, mode)
  if curRangeMode == mode then
    mode = rangeMode2hi
  end

  tfc.setDriveMode(mode)
  curRangeMode = mode
end

local function toggleHighFour()
  -- local transferCase = controller.getControllersByType('transfercaseControl')
  local transferCase = controller.getController('transfercaseControl')
  if transferCase == nil then
    return
  end

  changeTransfercaseMode(transferCase, rangeMode4hi)
end

local function toggleLowFour()
  -- local transferCase = controller.getControllersByType('transfercaseControl')
  local transferCase = controller.getController('transfercaseControl')

  if transferCase == nil then
    return
  end

  changeTransfercaseMode(transferCase, rangeMode4lo)
end

M.toggleHighFour = toggleHighFour
M.toggleLowFour = toggleLowFour

----------------------------------------------------------------------------------------------------
-- Locking Diffs
----------------------------------------------------------------------------------------------------

local lockedMode = "locked"
local openMode = "open"
local frontDiff = {
  name = "differential_F",
  locked = false,
}
local rearDiff = {
  name = "differential_R",
  locked = false,
}

local function diffNotFoundMsg(diffName)
  guihooks.trigger('toastrMsg', {
      type = "error",
      title = "404 Diff",
      msg = "No diff named " .. diffName,
      config = {timeOut = 5000}
  })
end

local function getDiff(diffObj)
  local diff = powertrain.getDevice(diffObj.name)
  if diff == nil or next(diff) == nil then
    diffNotFoundMsg(diffObj.name)
    return {}
  end

  return diff
end

local function openDiff(diffObj)
  print("Opening diff")
  local diff = getDiff(diffObj)
  if next(diff) == nil then
    return {}
  end

  powertrain.setDeviceMode(diff.name, openMode)
  diffObj.locked = false
end

local function lockDiff(diffObj)
  print("Locking diff")
  local diff = getDiff(diffObj)
  if next(diff) == nil then
    return
  end
  powertrain.setDeviceMode(diff.name, lockedMode)
  diffObj.locked = true
end


local function toggleDiff(diffObj)
  if diffObj.locked then
    openDiff(diffObj)
  else
    lockDiff(diffObj)
  end
end

local function toggleFrontDiffLock() 
  toggleDiff(frontDiff)
end

local function toggleRearDiffLock() 
  toggleDiff(rearDiff)
end

local function toggleBothDiffLock()
  toggleFrontDiffLock()
  toggleRearDiffLock()
end

M.toggleFrontDiffLock = toggleFrontDiffLock
M.toggleRearDiffLock = toggleRearDiffLock
M.toggleBothDiffLock = toggleBothDiffLock

local function onReset()
  -- We need to set the things to the state they were in
  for _, diffObj in ipairs({frontDiff, rearDiff}) do
    if diffObj.locked then
      lockDiff(diffObj)
    else
      openDiff(diffObj)
    end
  end
end

M.onReset = onReset

return M