local Util   = Priceless.Util
local Player = Priceless.Player

local Data = {}
local Code = {}


local d = function(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg)
end

local TT_LIGHTGRAY = { r = 0.75, g = 0.75, b = 0.75 }
local TT_LIGHTBLUE = { r = 37/255, g = 192/255, b = 235/255 }

function Code:GetUnitReactionColor (token)
	local IsPlayer = UnitIsPlayer(token) or UnitPlayerControlled(token)
	local CanAttackMe = UnitCanAttack(token, "player")
	local CanBeAttacked = UnitCanAttack("player", token)
	local CanPVP = (UnitIsPVP(token) and not UnitIsPVPSanctuary(token) and not UnitIsPVPSanctuary("player"))
	local IsInCombat = (UnitIsTapped(token) and not UnitIsTappedByPlayer(token))

	if IsPlayer then
		if CanAttackMe then
			if CanBeAttacked then
				return UnitReactionColor[2];
			else
				return UnitReactionColor[3];
			end
		elseif CanBeAttacked then
			return UnitReactionColor[4];
		elseif CanPVP then
			return UnitReactionColor[6];
		else
			return TT_LIGHTBLUE;
		end
	elseif IsInCombat then
		return TT_LIGHTGRAY;
	else
		local id = UnitReaction(token,"player") or 5
		return UnitReactionColor[id];
	end
end

function Code:OnTooltipSetUnit (Tooltip, Name)
	local G = getfenv(0)
	local token = "mouseover"

	local ReactionColor = Code:GetUnitReactionColor(token)
	local TooltipName = Tooltip:GetName()
	local TooltipLeft1 = G[TooltipName .. 'TextLeft1']

	TooltipLeft1:SetTextColor(ReactionColor.r, ReactionColor.g, ReactionColor.b)
end

Priceless:AddMod('Units', Code)
