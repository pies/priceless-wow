
Priceless.Item.Mat.Ore = {
	Copper        =  2770,
	Tin           =  2771,
	Silver        =  2775,
	Bloodstone    =  4278,
	Iron          =  2772,
	Indurium      =  5833,
	Gold          =  2776,
	Mithril       =  3858,
	DarkIron      = 11370,
	Truesilver    =  7911,
	Thorium       = 10620,
	FelIron       = 23424,
	Adamantite    = 23425,
	Khorium       = 23426,
	Eternium      = 23427,
	Nethercite    = 32464,
}

Priceless.Item.Mat.Bar = {
	Copper        =  2840,
	Tin           =  3576,
	Bronze        =  2841,
	Silver        =  2842,
	Iron          =  3575,
	Steel         =  3859,
	Gold          =  3577,
	Mithril       =  3860,
	Truesilver    =  6037,
	Thorium       = 12359,
	DarkIron      = 14891,
	FelIron       = 23445,
	Felsteel      = 23448,
	Adamantite    = 23446,
	HardenedAdam  = 23573,
	Khorium       = 23449,
	Eternium      = 23447,
}

Priceless.Item.Mat.Stone = {
	Rough       =  2835,
	Coarse      =  2836,
	Heavy       =  2838,
	Solid       =  7912,
	Dense       = 12365,
}

local Mat = Priceless.Item.Mat

local Bar    = Mat.Bar
local Ore    = Mat.Ore
local Stone  = Mat.Stone
local Mote   = Mat.Mote
local Gem    = Mat.Gem

local Vein   = Priceless.Object.Vein
local Other  = Priceless.Item.Other

local Util   = Priceless.Util
local Player = Priceless.Player

local Data = {}

Data.VeinNames = {
	['Adamantite Deposit']              = Vein.Adamantite,
	['Fel Iron Deposit']                = Vein.FelIron,
	['Gold Vein']                       = Vein.Gold,
	['Iron Deposit']                    = Vein.Iron,
	['Khorium Vein']                    = Vein.Khorium,
	['Mithril Deposit']                 = Vein.Mithril,
	['Rich Adamantite Deposit']         = Vein.RichAdamantite,
	['Rich Thorium Vein']               = Vein.RichThorium,
	['Silver Vein']                     = Vein.Silver,
	['Small Thorium Vein']              = Vein.Thorium,
	['Tin Vein']                        = Vein.Tin,
	['Truesilver Deposit']              = Vein.Truesilver,
	['Copper Vein']                     = Vein.Copper,
	['Nethercite Deposit']              = Vein.Nethercite,
	['Hakkari Thorium Vein']            = Vein.HakkariThorium,
	['Ooze Covered Gold Vein']          = Vein.OozeGold,
	['Ooze Covered Mithril Deposit']    = Vein.OozeMithril,
	['Ooze Covered Rich Thorium Vein']  = Vein.OozeRichThorium,
	['Ooze Covered Silver Vein']        = Vein.OozeSilver,
	['Ooze Covered Thorium Vein']       = Vein.OozeThorium,
	['Ooze Covered Truesilver Deposit'] = Vein.OozeTruesilver,
}

Data.Vein = {

	[Vein.Adamantite] = {
		Name  = 'Adamantite Deposit',
		Skill = { 325, 350, 375, 375 },
		Drops = {
			[100] = { Ore.Adamantite },
			[60]  = { Mote.Earth },
			[10]  = { Ore.Eternium },
			[1]   = 'Uncommon socket gem' --{ Gem.Azure, Gem.Blood, Gem.Deep, Gem.Flame, Gem.Golden, Gem.Shadow },
		}
	},
	[Vein.FelIron] = {
		Name  = 'Fel Iron Deposit',
		Skill = { 300, 325, 350, 375 },
		Drops = {
			[100] = { Ore.FelIron },
			[15]  = { Mote.Earth, Mote.Fire },
			[2]   = { Ore.Eternium },
			[0.6] = 'Uncommon socket gem' --{ Gem.Azure, Gem.Blood, Gem.Deep, Gem.Flame, Gem.Golden, Gem.Shadow },
		}
	},
	[Vein.Gold] = {
		Name  = 'Gold Vein',
		Skill = { 155, 175, 205, 255 },
		Drops = {
			[100] = { Ore.Gold },
			[1]   = { Gem.Citrine, Gem.Jade, Gem.Moonstone },
		}
	},
	[Vein.Iron] = {
		Name  = 'Iron Deposit',
		Skill = { 125, 150, 175, 225 },
		Drops = {
			[100]  = { Ore.Iron },
			[80]   = { Stone.Heavy},
			[1.25] = { Gem.Jade },
			[1]    = { Gem.Moonstone },
			[0.75] = { Gem.Citrine },
			[0.25] = { Gem.Aquamarine },
		},
	},
	[Vein.Khorium] = {
		Name  = 'Khorium Vein',
		Skill = { 375, 375, 375, 375 },
		Drops = {
			[100] = { Ore.Khorium },
			[40]  = { Mote.Earth },
			[10]  = { Ore.Eternium },
			[5]   = { Gem.Arcane },
			[1.5] = { Gem.Living },
			[1]   = 'Uncommon socket gem' --{ Gem.Azure, Gem.Blood, Gem.Deep, Gem.Flame, Gem.Golden, Gem.Shadow },
		}
	},
	[Vein.Mithril] = {
		Name  = 'Mithril Deposit',
		Skill = { 175, 200, 225, 275 },
		Drops = {
			[100]  = { Ore.Mithril, Stone.Solid },
			[0.75] = { Gem.Citrine, Gem.Aquamarine, Gem.StarRuby },
		}
	},
	[Vein.RichAdamantite] = {
		Name  = 'Rich Adamantite Deposit',
		Skill = { 350, 375, 375, 375 },
		Drops = {
			[100]  = { Ore.Adamantite },
			[60]   = { Mote.Earth },
			[10]   = { Ore.Eternium },
			[1]    = 'Uncommon socket gem' --{ Gem.Azure, Gem.Blood, Gem.Deep, Gem.Flame, Gem.Golden, Gem.Shadow },
		}
	},
	[Vein.RichThorium] = {
		Name  = 'Rich Thorium Vein',
		Skill = { 275, 300, 325, 375 },
		Drops = {
			[100]  = { Ore.Thorium },
			[80]   = { Stone.Dense },
			[2.75] = { Gem.Arcane },
			[0.75] = { Gem.Opal, Gem.StarRuby, Gem.Diamond, Gem.Sapphire, Gem.Emerald },
		}
	},
	[Vein.Silver] = {
		Name  = 'Silver Vein',
		Skill = { 75, 100, 125, 175 },
		Drops = {
			[100] = { Ore.Silver },
			[1.5] = { Gem.Agate },
			[1] = { Gem.Shadowgem, Gem.Moonstone },
		}
	},
	[Vein.Thorium] = {
		Name  = 'Small Thorium Vein',
		Skill = { 245, 270, 295, 345 },
		Drops = {
			[100] = { Ore.Thorium },
			[80] = { Stone.Dense },
			[2.75] = { Gem.Arcane },
			[0.75] = { Gem.Opal, Gem.StarRuby, Gem.Diamond, Gem.Sapphire, Gem.Emerald },
		}
	},
	[Vein.Tin] = {
		Name = 'Tin Vein',
		Skill = { 65, 90, 115, 165 },
		Drops = {
			[100]  = { Ore.Tin },
			[63]   = { Stone.Coarse },
			[1]    = { Gem.Agate, Gem.Shadowgem, Gem.Moonstone },
			[0.25] = { Gem.Jade },
		}
	},
	[Vein.Truesilver] = {
		Name  = 'Truesilver Deposit',
		Skill = { 230, 255, 280, 330 },
		Drops = {
			[100]   = { Ore.Truesilver },
			[1.25]  = { Gem.Aquamarine, Gem.Citrine, Gem.StarRuby },
		}
	},
	[Vein.Copper] = {
		Name  = 'Copper Vein',
		Skill = { 1, 25, 50, 100 },
		Drops = {
			[100] = { Ore.Copper },
			[70]  = { Stone.Rough },
			[1]   = { Gem.Shadowgem, Gem.Tigerseye, Gem.Malachite }
		}
	},
	[Vein.Nethercite] = {
		Name  = 'Nethercite Deposit',
		Skill = { 375, 375, 375, 375 },
		Drops = {
			[100] = { Ore.Nethercite },
			[15]  = { Mote.Earth, Mote.Fire },
			[2]   = { Ore.Eternium },
			[0.5] = 'Uncommon socket gem' -- { Gem.Golden, Gem.Blood, Gem.Flame, Gem.Azure, Gem.Deep, Gem.Shadow }
		}
	},

	[Vein.HakkariThorium] = {
		Name  = 'Hakkari Thorium Vein',
		Skill = { 275, 300, 325, 350 },
		Drops = {
			[100]  = { Ore.Thorium },
			[80]   = { Stone.Dense },
			[35]   = { Gem.Souldarite },
			[5] = { Gem.Arcane },
			[1] = { Gem.Diamond, Gem.StarRuby },
			[0.75] = { Gem.Emerald, Gem.Opal, Gem.Sapphire },
		}
	},

	[Vein.OozeGold] = {
		Name  = 'Ooze Covered Gold Vein',
		Skill = { 155, 175, 205, 255 }, -- ?
		Drops = {
			[100] = { Ore.Gold },
			[1.5] = { Gem.Citrine },
			[1] = { Gem.Moonstone },
			[0.5] = { Gem.Jade },
		}
	},
	[Vein.OozeMithril] = {
		Name  = 'Ooze Covered Mithril Deposit',
		Skill = { 175, 200, 225, 275 }, -- ?
		Drops = {
			[100] = { Ore.Mithril, Stone.Solid },
			[0.75] = { Gem.StarRuby  },
			[0.5] = { Gem.Citrine },
			[0.25] = { Gem.Aquamarine },
		}
	},
	[Vein.OozeRichThorium] = {
		Name  = 'Ooze Covered Rich Thorium Vein',
		Skill = { 275, 300, 325, 375 }, -- ?
		Drops = {
			[100]  = { Ore.Thorium },
			[80]   = { Stone.Dense },
			[2.75] = { Gem.Arcane },
			[0.75] = { Gem.Diamond, Gem.StarRuby, Gem.Emerald, Gem.Opal, Gem.Sapphire },
		}
	},
	[Vein.OozeSilver] = {
		Name  = 'Ooze Covered Silver Vein',
		Skill = { 75, 100, 125, 175 }, -- ?
		Drops = {
			[100]  = { Ore.Silver },
			[1.25] = { Gem.Moonstone },
			[0.75] = { Gem.Agate },
		}
	},
	[Vein.OozeThorium] = {
		Name  = 'Ooze Covered Thorium Vein',
		Skill = { 245, 270, 295, 345 }, -- ?
		Drops = {
			[100] = { Ore.Thorium },
			[80] = { Stone.Dense },
			[2.75] = { Gem.Arcane },
			[1] = { Gem.Diamond, Gem.Sapphire },
			[0.75] = { Gem.Opal, Gem.StarRuby, Gem.Emerald },
		}
	},
	[Vein.OozeTruesilver] = {
		Name  = 'Ooze Covered Truesilver Deposit',
		Skill = { 230, 255, 280, 330 },
		Drops = {
			[100]  = { Ore.Truesilver },
			[2] = { Gem.Aquamarine },
			[1.25] = { Gem.StarRuby },
			[1] = { Gem.Citrine },
		}
	},

	--"Dark Iron Deposit",
	--"Ancient Gem Vein",
}

Data.Bar = {
	[Bar.Copper]       = { name = 'Copper Bar', mats = { [Ore.Copper]     =  1 } },
	[Bar.Tin]          = { mats = { [Ore.Tin]        =  1 } },
	[Bar.Silver]       = { mats = { [Ore.Silver]     =  1 } },
	[Bar.Iron]         = { mats = { [Ore.Iron]       =  1 } },
	[Bar.Gold]         = { mats = { [Ore.Gold]       =  1 } },
	[Bar.Mithril]      = { mats = { [Ore.Mithril]    =  1 } },
	[Bar.Truesilver]   = { mats = { [Ore.Truesilver] =  1 } },
	[Bar.Thorium]      = { mats = { [Ore.Thorium]    =  1 } },
	[Bar.FelIron]      = { mats = { [Ore.FelIron]    =  2 } },
	[Bar.Adamantite]   = { mats = { [Ore.Adamantite] =  2 } },
	[Bar.Khorium]      = { mats = { [Ore.Khorium]    =  2 } },
	[Bar.Eternium]     = { mats = { [Ore.Eternium]   =  2 } },
	[Bar.Bronze]       = { compound = true, mats = { [Bar.Copper]     =  1, [Bar.Tin] = 1 } },
	[Bar.Steel]        = { compound = true, mats = { [Bar.Iron]       =  1, [Other.Coal] = 1 } },
	[Bar.Felsteel]     = { compound = true, mats = { [Bar.FelIron]    =  3, [Bar.Eternium] = 2 } },
	[Bar.HardenedAdam] = { compound = true, mats = { [Bar.Adamantite] = 10 } },
	[Bar.DarkIron]     = { special = true,  mats = { [Ore.DarkIron]   =  8 } },
}

Data.Ore = {
	[Ore.Copper]     = { name = 'Copper Ore',     source = Vein.Copper,     made_into = { Bar.Copper, Bar.Bronze } },
	[Ore.Tin]        = { name = 'Tin Ore',        source = Vein.Tin,        made_into = { Bar.Tin, Bar.Bronze } },
	[Ore.Silver]     = { name = 'Silver Ore',     source = Vein.Silver,     made_into = { Bar.Silver } },
	[Ore.Iron]       = { name = 'Iron Ore',       source = Vein.Iron,       made_into = { Bar.Iron, Bar.Steel } },
	[Ore.Gold]       = { name = 'Gold Ore',       source = Vein.Gold,       made_into = { Bar.Gold } },
	[Ore.Mithril]    = { name = 'Mithril Ore',    source = Vein.Mithril,    made_into = { Bar.Mithril } },
	[Ore.Truesilver] = { name = 'Truesilver Ore', source = Vein.Truesilver, made_into = { Bar.Truesilver } },
	[Ore.Thorium]    = { name = 'Thorium Ore',    source = Vein.Thorium,    made_into = { Bar.Thorium } },
	[Ore.FelIron]    = { name = 'Fel Iron Ore',   source = Vein.FelIron,    made_into = { Bar.FelIron, Bar.Felsteel } },
	[Ore.Adamantite] = { name = 'Adamantite Ore', source = Vein.Adamantite, made_into = { Bar.Adamantite, Bar.HardenedAdam } },
	[Ore.Khorium]    = { name = 'Khorium Ore',    source = Vein.Khorium,    made_into = { Bar.Khorium } },
	[Ore.DarkIron]   = { name = 'Dark Iron Ore',  source = Vein.DarkIron,   made_into = { Bar.DarkIron }, special = true },
	[Ore.Bloodstone] = { name = 'Bloodstone Ore', source = Vein.Bloodstone, special = true },
	[Ore.Indurium]   = { name = 'Indurium Ore',   source = Vein.Indurium,   special = true },

	[Ore.Eternium]   = { 
		name      = 'Eternium Ore',
		source    = { Vein.FelIron, Vein.Adamantite, Vein.RichAdamantite, Vein.Khorium, Vein.Nethercite }, 
		made_into = { Bar.Eternium, Bar.Felsteel } 
	},
}

Data.Stone = {
	[Stone.Rough]    = { name = 'Rough Stone',  source = { Vein.Copper } },
	[Stone.Coarse]   = { name = 'Coarse Stone', source = { Vein.Tin } },
	[Stone.Heavy]    = { name = 'Heavy Stone',  source = { Vein.Iron } },
	[Stone.Solid]    = { name = 'Solid Stone',  source = 'Any Mithril Deposit (100%)' },
	[Stone.Dense]    = { name = 'Dense Stone',  source = 'Any Thorium Vein (80%)' }
}

Data.Gem = {
	-- Simple
	[Gem.Citrine]    = { name = 'Citrine' },
	[Gem.Jade]       = { name = 'Jade' },
	[Gem.Moonstone]  = { name = 'Lesser Moonstone' },
	[Gem.Aquamarine] = { name = 'Aquamarine' },
	[Gem.Opal]       = { name = 'Large Opal' },
	[Gem.StarRuby]   = { name = 'Star Ruby' },
	[Gem.Diamond]    = { name = 'Azerothian Diamond' },
	[Gem.Sapphire]   = { name = 'Blue Sapphire' },
	[Gem.Emerald]    = { name = 'Huge Emerald' },
	[Gem.Agate]      = { name = 'Moss Agate' },
	[Gem.Shadowgem]  = { name = 'Shadowgem' },
	[Gem.Tigerseye]  = { name = 'Tigerseye' },
	[Gem.Malachite]  = { name = 'Malachite' },
	[Gem.Souldarite] = { name = 'Souldarite' },
	[Gem.Arcane]     = { name = 'Arcane Crystal' },
	-- uncommon socketable
	[Gem.Azure]      = { name = 'Azure Moonstone' },
	[Gem.Blood]      = { name = 'Blood Garnet' },
	[Gem.Deep]       = { name = 'Deep Peridot' },
	[Gem.Flame]      = { name = 'Flame Spessarite' },
	[Gem.Golden]     = { name = 'Golden Draenite' },
	[Gem.Shadow]     = { name = 'Shadow Draenite' },
	-- rare socketable
	[Gem.Living]     = { name = 'Living Ruby' },
}

Data.Mote = {
	[Mote.Air]    = { name = 'Mote of Air' },
	[Mote.Earth]  = { name = 'Mote of Earth' },
	[Mote.Fire]   = { name = 'Mote of Fire' },
	[Mote.Life]   = { name = 'Mote of Life' },
	[Mote.Mana]   = { name = 'Mote of Mana' },
	[Mote.Shadow] = { name = 'Mote of Shadow' },
	[Mote.Water]  = { name = 'Mote of Water' },
}

local Code = {}

function Code:Ore (id)
	local isTable = function(var) return type(var) == 'table' end

	local H = Player.Skills.Mining or 0 -- Has
	local Ore = Data.Ore[id]
	local S = Ore.source -- Source
	if not isTable(S) and not S then return end
	if not isTable(S) then S = {S} end

	local L = 'Mined from:'
	for _, vein_id in pairs(S) do
		local V = Data.Vein[vein_id]

		local D
		for prob, drops in pairs(V.Drops) do
			if Util:isTable(drops) then
				for _, drop in pairs(drops) do
					if drop == id then D = prob end
				end
			end
		end

		local N = V.Name .. ' - ' .. D .. '%'

		if H > 0 then
			Util:AddToTooltip(L, N:requires(H, V.Skill))
		else
			Util:AddToTooltip(L, N)
		end

		L = ' '
	end
end

function Code:Bar (id)
	local data = Data.Bar[id]
	if not data then return end

	local left = 'Smelted from:'
	for id, amt in pairs(data.mats) do
		local info = Util:GetItemInfo(id)
		if not info or not info.Name then return end
		Util:AddToTooltip(left, amt..' x '..info.Name)
		left = ' '
	end
end

function Code:Stone (id)
	local data = Data.Stone[id]
	local S = data.source

	local L = 'Mined from:'
	if type(S) == 'table' then
		for _, sid in pairs(S) do
			
			local V = Data.Vein[sid]
			if not Util:isTable(V) then Priceless:Print('No vein with id: '..sid) end
			if not Util:isTable(V.Drops) then Priceless:Print('No drop table for vein with id: '..sid) end

			for chance, ores in pairs(V.Drops) do
				if Util:isTable(ores) then
					for _, ore in pairs(ores) do
						if ore == id then
							Util:AddToTooltip(L, tostring(V.Name)..' ('..tostring(chance)..'%)')
						end
					end
				end
			end

			L = ' '
		end
	else
		Util:AddToTooltip(L, S)
	end
end

function Code:Vein (id)
	local Obj = Data.Vein[id]
	if not Obj then return end

	local req_str = 'Mining ('..Obj.Skill[1]..')'
	local req_text = Util:RequiredColor(req_str, Player.Skills.Mining or 0, Obj.Skill[1], Obj.Skill[2], Obj.Skill[3], Obj.Skill[4])
	local Left = 'Requires '..req_text..', contains:'
	local Right = ''

	--Util:AddToTooltip(Left, Right)
	Util:ReplaceTooltipLineNum(GameTooltip, 2, Left, Right)

	local Reverse = function(a,b) return not Util.Compare(a,b) end

	for Dpct, Dlist in Util.PairsByKeys(Obj.Drops, Reverse) do
		local names = {}
		if type(Dlist) == 'string' then
			names = Dlist
		else
			for _, Did in pairs(Dlist) do
				local tmp = Data.Ore[Did] or Data.Stone[Did] or Data.Gem[Did] or Data.Mote[Did]
				local name = tmp and tmp.name
				if name then table.insert(names, name) end
			end
			names = table.concat(names, ', ')
		end
		
		Util:AddToTooltip(names:white(), Dpct..'%')
	end
end

function Code:OnTooltipSetItem(tooltip, name, id, link)
	local isTable = Priceless.Util.isTable
	if Util:isTable(Data.Bar[id])   then Code:Bar(id) end
	if Util:isTable(Data.Ore[id])   then Code:Ore(id) end
	if Util:isTable(Data.Stone[id]) then Code:Stone(id) end
end

function Code:OnTooltipSetObject(tooltip, name)
	local vein_id = Data.VeinNames[name]
	if vein_id then Code:Vein(vein_id) end
end


function Code:OnSkillChange(name, value)
	if name ~= 'Mining' then return end

	for _, D in pairs(Data.Vein) do
		local S = D.Skill
		if S[1] == value then
			local text = 'You can now mine '..D.Name..'.'
			Util:Print(text:blue())
		end
	end
end

Priceless:AddMod('Mining', Code)
