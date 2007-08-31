
local Util   = Priceless.Util
local Player = Priceless.Player

local Code = {}

function Code:OnSkillChange(name, value)
	if name == 'Skinning' then
		-- Up to skinning 100, you can find out the highest level mob you can skin by: ((Skinning skill)/10)+10. 
		-- From skinning level 100 and up the formula is simply: (Skinning skill)/5.
		local up_to
		
		if value > 100 then
			up_to = math.floor(value/5)
		else
			up_to = math.floor(value/10) + 10
		end

		local text = 'You can skin creatures up to level '..up_to..'.'
		Util:Print(text:blue())
	end
end

Priceless:AddMod('Skinning', Code)
