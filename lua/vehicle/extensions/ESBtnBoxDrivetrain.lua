local M = {}

----------------------------------------------------------------------------------------------------
-- Range Box
----------------------------------------------------------------------------------------------------

local rangeMode4hi = "4hi"
local rangeMode4lo = "4lo"
local rangeMode2hi = "2hi"
local curRangeMode = rangeMode4hi

local function toggleHighFour()
  -- local transferCase = controller.getControllersByType('transfercaseControl')
  local transferCase = controller.getController('transfercaseControl')
  if transferCase then
    if curRangeMode == rangeMode4hi then
      print("Setting 2lo")
      transferCase.setDriveMode(rangeMode2hi)
      curRangeMode = rangeMode2hi
    else
      print("Setting 4hi")
      transferCase.setDriveMode(rangeMode4hi)
      curRangeMode = rangeMode4hi
    end
  end
end

local function toggleLowFour()
  -- local transferCase = controller.getControllersByType('transfercaseControl')
  local transferCase = controller.getController('transfercaseControl')
  if transferCase then
    if curRangeMode == rangeMode4lo then
      print("Setting 2lo")
      transferCase.setDriveMode(rangeMode2hi)
      curRangeMode = rangeMode2hi
    else
      print("Setting 4lo")
      transferCase.setDriveMode(rangeMode4lo)
      curRangeMode = rangeMode4lo
    end
  end
end

M.toggleHighFour = toggleHighFour
M.toggleLowFour = toggleLowFour

return M