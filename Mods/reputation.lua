
local Util = Priceless.Util

local F_CENARION_EXP    = "Cenarion Exp."
local F_CONSORTIUM      = "Consortium"
local F_KURENAI         = "Kurenai"
local F_MAGHAR          = "Mag'har"
local F_SCRYERS         = "Scryers"
local F_ALDOR           = "Aldor"
local F_SPOREGGAR       = "Sporeggar"
local F_LOWER_CITY      = "Lower City"
local F_TIMBERMAW       = "Timbermaw Hold"
local F_ARGENT_DAWN     = "Argent Dawn"
local F_CENARION_CIRCLE = "Cenarion Circle"
local F_THORIUM_BRO     = "Thorium Bro."
local F_DARKMOON_FAIRE  = "Darkmoon Faire"

local F_TYPE_ALLY    = "Ally"
local F_TYPE_HORDE   = "Horde"
local F_TYPE_NEUTRAL = "Neutral"

local F_TYPE = {
	[F_SCRYERS]        = F_TYPE_NEUTRAL,
	[F_CENARION_EXP]   = F_TYPE_NEUTRAL,
	[F_SPOREGGAR]      = F_TYPE_NEUTRAL,
	[F_CONSORTIUM]     = F_TYPE_NEUTRAL,
	[F_MAGHAR]         = F_TYPE_HORDE,
	[F_KURENAI]        = F_TYPE_ALLY,
	[F_TIMBERMAW]      = F_TYPE_NEUTRAL
}

local R_NEUTRAL  = 'Neutral'
local R_FRIENDLY = 'Friendly'
local R_HONORED  = 'Honored'
local R_REVERED  = 'Revered'
local R_EXALTED  = 'Exalted'


local Item = Priceless.Item.Rep

local Data = {

	[Item.UnidPlantParts]  = { [F_CENARION_EXP] = { per =  25, stop = R_HONORED  } },
	[Item.CoilArmaments]   = { [F_CENARION_EXP] = { per =  75, stop = R_EXALTED  } },

	[Item.BogLordTendril]  = { [F_SPOREGGAR]    = { per = 125, stop = R_FRIENDLY } },
	[Item.Glowcap]         = { [F_SPOREGGAR]    = { per =  75, stop = R_FRIENDLY } },
	[Item.MatureSporeSac]  = { [F_SPOREGGAR]    = { per =  75, stop = R_FRIENDLY } },
	[Item.FertileSpores]   = { [F_SPOREGGAR]    = { per =  75, stop = R_EXALTED  } },
	[Item.Hibiscus]        = { [F_SPOREGGAR]    = { per = 150, stop = R_EXALTED  } },

	[Item.IvoryTusks]      = { [F_CONSORTIUM]   = { per =  83, stop = R_FRIENDLY } },
	[Item.Zaxxis]          = { [F_CONSORTIUM]   = { per =  25, stop = R_EXALTED  } },
	
	[Item.Warbeads]        = { 
		[F_CONSORTIUM] = { ['per'] = 25 }, 
		[F_MAGHAR]     = { ['per'] = 50 }, 
		[F_KURENAI]    = { ['per'] = 50 },
	},

	[Item.SpiritBeads]     = { [F_TIMBERMAW]    = { per = 15 } },

	[Item.BoneFragments]   = { [F_ARGENT_DAWN]  = { per = 0.3 } },
	[Item.CryptFiendParts] = { [F_ARGENT_DAWN]  = { per = 0.3 } },
	[Item.CoreOfElements]  = { [F_ARGENT_DAWN]  = { per = 0.3 } },
	[Item.SavageFrond]     = { [F_ARGENT_DAWN]  = { per = 0.3 } },
	[Item.DarkIronScraps]  = { [F_ARGENT_DAWN]  = { per = 0.3 } },

	[Item.EncTwilightText] = { [F_CENARION_CIRCLE] = { per = 25 } },
	
	[Item.DarkIronResidue] = { [F_THORIUM_BRO] = { per = 6, start = R_FRIENDLY, stop = R_HONORED } },

	[Item.SmallFurryPaw]   = { [F_DARKMOON_FAIRE] = { per = 0.2 } },
	[Item.TornBearPelt]    = { [F_DARKMOON_FAIRE] = { per = 0.8 } },
	[Item.SoftBushyTail]   = { [F_DARKMOON_FAIRE] = { per = 1.6 } },
	[Item.EvilBatEye]      = { [F_DARKMOON_FAIRE] = { per = 2   } },
	[Item.GlowScorpBlood]  = { [F_DARKMOON_FAIRE] = { per = 2   } },
	[Item.VibrantPlume]    = { [F_DARKMOON_FAIRE] = { per = 2.4 } },

	[Item.DreadVenomSac]   = { [F_ALDOR]   = { per =  31, stop = R_NEUTRAL } },
	[Item.MarkOfKiljaeden] = { [F_ALDOR]   = { per =  25, stop = R_HONORED } },
	[Item.MarkOfSargeras]  = { [F_ALDOR]   = { per =  25, stop = R_EXALTED } },
	[Item.FelArmament]     = { [F_ALDOR]   = { per = 350, stop = R_EXALTED } },

	[Item.DampsBasilEye]   = { [F_SCRYERS] = { per =  31, stop = R_NEUTRAL } },
	[Item.FirewingSignet]  = { [F_SCRYERS] = { per =  25, stop = R_HONORED } },
	[Item.SunfurySignet]   = { [F_SCRYERS] = { per =  25, stop = R_EXALTED } },
	[Item.ArcaneTome]      = { [F_SCRYERS] = { per = 350, stop = R_EXALTED } },

	[Item.ArakkoaFeather]  = { [F_LOWER_CITY] = { per = 8, stop = R_HONORED } },

}
	
local Code = {}

function Code:OnTooltipSetItem (tooltip, name, id, link)

	if type(Data[id]) ~= 'table' then return end
	--Util:Print('rep '..id)

	local info = Data[id]

	Util:AddToTooltip('Reputation turn-in:')

	for faction, details in pairs(info) do
		--Util:Print('faction '..faction)

		local per   = details.per
		local start = details.start
		local stop  = details.stop

		if per or start or stop then
			
			local note

			if start and stop then 
				note = ' (' .. start .. ' to '.. stop ..')'
			elseif start and not stop then 
				note = ' (from ' .. start .. ')'
			elseif stop and not start then
				note = ' (until ' .. stop .. ')'
			else
				note = ''
			end

			Util:AddToTooltip(' - '..faction .. note, per..' each')
		end
	end
end

Priceless:AddMod('Reputation', Code)
