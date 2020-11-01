local f 		= CreateFrame("Frame")
local played 	= false
local lastrun 	= 0
local start 	= 0
local throttle 	= 20 -- update time in seconds
local firstrun 	= true

local function FindUnitAura(unit, filter)
    for i = 1, 40 do
        local name, _, _, _, _, _, _, _, _, spellId = UnitAura(unit, i, filter)
        if not name then return end
		--print (i,name)
        if spellId == 23920 then
			return name, spellId
		end
    end
end

f:SetScript("OnEvent", function(self, event, ...)
	if not IsInInstance() then return
	else
		local buffname, buffId = FindUnitAura("player", "HELPFUL")
		if buffId == 23920 then
			start = GetTime()
			if (start - lastrun) > throttle or (firstrun) == true then
				firstrun = false
				SendChatMessage("Reflecting!", "SAY", nil, nil)
				lastrun = GetTime()
			end
		end
	end
end)

f:RegisterUnitEvent("UNIT_AURA", "player")

--97463,  --Rallying Cry