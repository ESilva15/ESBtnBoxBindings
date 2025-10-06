local M = {}

-- Additional logic needed for headlight toggle
-- BeamNG headlight status:
-- Off        0
-- Low Beams  1
-- High Beams 2
local headlightsOff = 0
local lowBeams = 1
local highBeams = 2

-- I will be forcing each state due to my controls not being sequential
-- I have a toggle switch (On - Off - On) and it will control both low and high beams, so
-- the top On will turn high beams on and the bottom On will turn low beams on. The middle position
-- will just be off.
-- Which makes this variable redundant, but if I do change my controls the logic will be useful
local currentHeadlightMode = 0

----------------------------------------------------------------------------------------------------
-- Utility
----------------------------------------------------------------------------------------------------
local function setHeadlightsTo(pos)
  electrics.setLightsState(pos)
  currentHeadlightMode = pos
end

----------------------------------------------------------------------------------------------------
-- HeadLight handling
----------------------------------------------------------------------------------------------------
local function toggleHighBeams()
  print("toggling high beams")
  if currentHeadlightMode == highBeams then
    setHeadlightsTo(headlightsOff)
  else
    setHeadlightsTo(highBeams)
  end
end

local function toggleLowBeams()
  print("toggling low beams")
  if currentHeadlightMode == lowBeams then
    setHeadlightsTo(headlightsOff)
  else
    setHeadlightsTo(lowBeams)
  end
end

----------------------------------------------------------------------------------------------------
-- Lightbar handling
----------------------------------------------------------------------------------------------------
local lightbarOff = 0
local lightbarOn = 1
local lightbarWithSound = 2
local lightbarCurrentMode = 0

local function turnLightbarLight()
  if lightbarCurrentMode == lightbarOn then
    electrics.set_lightbar_signal(lightbarOff)
    lightbarCurrentMode = lightbarOff
  else
    electrics.set_lightbar_signal(lightbarOn)
    lightbarCurrentMode = lightbarOn
  end
end

local function turnLightbarSound()
  if lightbarCurrentMode == lightbarWithSound then
    electrics.set_lightbar_signal(lightbarOff)
    lightbarCurrentMode = lightbarOff
  else
    electrics.set_lightbar_signal(lightbarWithSound)
    lightbarCurrentMode = lightbarWithSound
  end
end

M.toggleHighBeams = toggleHighBeams
M.toggleLowBeams = toggleLowBeams
M.toggleLigthbarLight = turnLightbarLight
M.toggleLigthbarSound = turnLightbarSound

return M