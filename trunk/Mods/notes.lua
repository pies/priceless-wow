
local Rep = Priceless.Item.Rep
local Junk = Priceless.Item.Junk
local Other = Priceless.Item.Other
local Lockbox = Priceless.Item.Lockbox

local Notes = {
	
	[Rep.ApexisShard] = 
		"Currency for Ogri'la items (10-160 per item).\nUse 35 at a Forge Camp to summon an elite demon\nwhich drops an Apexis Crystal.",
	
	[Rep.Glowcap] = 
		"Currency for Sporeggar items (1-45 per item).",
	
	[Rep.Warbeads] =
		"Ground from Nagrand ogres\nfor Consortium reputation.",
	
	[Rep.OshugunCrystal]  = 
		"20 Samples = 1 Halaa Research Token",

	[Junk.UndHippFeather] = 
		"Vendor junk item (despite quality).",
	
	[Other.LightFeather] =
		"Used for mage and priest spells.",

	[Other.GorillaFang] =
		"Quest [45] Stranglethorn Fever requires 10 of those. Otherwise useless.",

	[Other.DeeprockSalt] =
		"Best farmed from Rock Elementals (level 37-44, droprate 21%) in Badlands.",

	[Other.BlackVitriol] =
		"Used for a single Alchemy receipe, used only once by each alchemist. Otherwise useless.",

	[Lockbox.OrnateBronze] = "Requires Lockpicking (1)",
	[Lockbox.HeavyBronze]  = "Requires Lockpicking (25)",
	[Lockbox.Iron]         = "Requires Lockpicking (70)",
	[Lockbox.StrongIron]   = "Requires Lockpicking (125)",
	[Lockbox.Steel]        = "Requires Lockpicking (175)",
	[Lockbox.ReinfSteel]   = "Requires Lockpicking (225)",
	[Lockbox.Mithril]      = "Requires Lockpicking (225)",
	[Lockbox.Thorium]      = "Requires Lockpicking (225)",
	[Lockbox.Eternium]     = "Requires Lockpicking (225)",
	[Lockbox.Khorium]      = "Requires Lockpicking (325)",
}

local Code = {}

function Code:OnTooltipSetItem(tooltip, name, id, link)
	local Note = Notes[id]
	if Note then Priceless.Util:AddToTooltip('Note: '..Note:white()) end
end

Priceless:AddMod('Notes', Code)
