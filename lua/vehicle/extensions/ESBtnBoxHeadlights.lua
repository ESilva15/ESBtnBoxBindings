local M = {}

-- Additional logic needed for headlight toggle
-- BeamNG headlight status:
-- Off        0
-- Low Beams  1
-- High Beams 2
local headlightsOff = 0
local lowBeams = 1
local highBeams = 2
local brakeLightSwitch = false

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
  if currentHeadlightMode == highBeams then
    setHeadlightsTo(headlightsOff)
  else
    setHeadlightsTo(highBeams)
  end
end

local function toggleLowBeams()
  if currentHeadlightMode == lowBeams then
    setHeadlightsTo(headlightsOff)
  else
    setHeadlightsTo(lowBeams)
  end
end

local function toggleBrakeLights()
  brakeLightSwitch = not brakeLightSwitch
end

M.toggleHighBeams = toggleHighBeams
M.toggleLowBeams = toggleLowBeams
M.toggleBrakeLights = toggleBrakeLights

----------------------------------------------------------------------------------------------------
-- Lightbar handling
----------------------------------------------------------------------------------------------------
local lightbarOff = 0
local lightbarOn = 1
local lightbarWithSound = 2
local lightbarCurrentMode = 0


local function setLightbarMode(mode)
  electrics.set_lightbar_signal(mode)
  lightbarCurrentMode = mode
end

local function turnLightbarLight()
  if lightbarCurrentMode == lightbarOn then
    setLightbarMode(lightbarOff)
  else
    setLightbarMode(lightbarOn)
  end
end

local function turnLightbarSound()
  if lightbarCurrentMode == lightbarWithSound then
    setLightbarMode(lightbarOff)
  else
    setLightbarMode(lightbarWithSound)
  end
end

M.toggleLigthbarLight = turnLightbarLight
M.toggleLigthbarSound = turnLightbarSound

local myTimer = 0
local requestToReset = false
local function updateGFX(dt)
  if brakeLightSwitch then
    electrics.values.brake = 0
  end

  if not requestToReset then
    return
  end

  myTimer = myTimer + dt
  if myTimer > 1 then
    setLightbarMode(lightbarCurrentMode) 
    requestToReset = false
    myTimer = 0
  end
end

local function onReset()
  requestToReset = true
end
  

M.onReset = onReset
M.updateGFX = updateGFX

return M