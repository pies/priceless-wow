local Util   = Priceless.Util
local Player = Priceless.Player
local Plant  = Priceless.Object.Plant

local Data = {}

Data.PlantNames = {
	['Silverleaf'] = Plant.Silverleaf,
	['Peacebloom'] = Plant.Peacebloom,
	['Bloodthistle'] = Plant.Bloodthistle,
	['Earthroot'] = Plant.Earthroot,
	['Mageroyal'] = Plant.Mageroyal,
	['Briarthorn'] = Plant.Briarthorn,
	['Stranglekelp'] = Plant.Stranglekelp,
	['Bruiseweed'] = Plant.Bruiseweed,
	['Wild Steelbloom'] = Plant.WildSteelbloom,
	['Grave Moss'] = Plant.GraveMoss,
	['Kingsblood'] = Plant.Kingsblood,
	['Liferoot'] = Plant.Liferoot,
	['Fadeleaf'] = Plant.Fadeleaf,
	['Goldthorn'] = Plant.Goldthorn,
	['Khadgar\'s Whisker'] = Plant.KhadgarsWhisker,
	['Wintersbite'] = Plant.Wintersbite,
	['Firebloom'] = Plant.Firebloom,
	['Purple Lotus'] = Plant.PurpleLotus,
	['Arthas\' Tears'] = Plant.ArthasTears,
	['Sungrass'] = Plant.Sungrass,
	['Blindweed'] = Plant.Blindweed,
	['Ghost Mushroom'] = Plant.GhostMushroom,
	['Gromsblood'] = Plant.Gromsblood,
	['Golden Sansam'] = Plant.GoldenSansam,
	['Dreamfoil'] = Plant.Dreamfoil,
	['Mountain Silversage'] = Plant.MountainSilversage,
	['Plaguebloom'] = Plant.Plaguebloom,
	['Icecap'] = Plant.Icecap,
	['Black Lotus'] = Plant.BlackLotus,
	['Felweed'] = Plant.Felweed,
	['Dreaming Glory'] = Plant.DreamingGlory,
	['Terocone'] = Plant.Terocone,
	['Ragveil'] = Plant.Ragveil,
	['Flame Cap'] = Plant.FlameCap,
	['Ancient Lichen'] = Plant.AncientLichen,
	['Netherbloom'] = Plant.Netherbloom,
	['Netherdust Bush'] = Plant.NetherdustBush,
	['Nightmare Vine'] = Plant.NightmareVine,
	['Mana Thistle'] = Plant.ManaThistle,
}

Data.Plant = {

	[Plant.Silverleaf] = {
		Name = 'Silverleaf',
		Skill = { 1, 25, 50, 100 },
		},
	[Plant.Peacebloom] = {
		Name = 'Peacebloom',
		Skill = { 1, 25, 50, 100 },
		},
	[Plant.Bloodthistle] = {
		Name = 'Bloodthistle',
		Skill = { 1, 25, 50, 100 }, -- all?
		},
	[Plant.Earthroot] = {
		Name = 'Earthroot',
		Skill = { 15, 40, 70, 115 }, -- 70?
		},
	[Plant.Mageroyal] = {
		Name = 'Mageroyal',
		Skill = { 50, 75, 100, 150 }, -- 75?
		},
	[Plant.Briarthorn] = {
		Name = 'Briarthorn',
		Skill = { 70, 95, 120, 170 }, --95?
		},
	[Plant.Stranglekelp] = {
		Name = 'Stranglekelp',
		Skill = { 85, 115, 135, 185 },
		},
	[Plant.Bruiseweed] = {
		Name = 'Bruiseweed',
		Skill = { 100, 130, 150, 200 },
		},
	[Plant.WildSteelbloom] = {
		Name = 'Wild Steelbloom',
		Skill = { 115, 145, 165, 215 },
		},
	[Plant.GraveMoss] = {
		Name = 'Grave Moss',
		Skill = { 120, 150, 170, 220 },
		},
	[Plant.Kingsblood] = {
		Name = 'Kingsblood',
		Skill = { 125, 155, 175, 225 },
		},
	[Plant.Liferoot] = {
		Name = 'Liferoot',
		Skill = { 150, 175, 200, 250 },
		},
	[Plant.Fadeleaf] = {
		Name = 'Fadeleaf',
		Skill = { 160, 190, 210, 260 },
		},
	[Plant.Goldthorn] = {
		Name = 'Goldthorn',
		Skill = { 170, 205, 220, 270 }, -- 205? 270?
		},
	[Plant.KhadgarsWhisker] = {
		Name = 'Khadgar\'s Whisker',
		Skill = { 185, 210, 235, 285 },
		},
	[Plant.Wintersbite] = {
		Name = 'Wintersbite',
		Skill = { 195, 225, 245, 295 },
		},
	[Plant.Firebloom] = {
		Name = 'Firebloom',
		Skill = { 205, 235, 255, 305 }, -- 305?
		},
	[Plant.PurpleLotus] = {
		Name = 'PurpleLotus',
		Skill = { 210, 240, 260, 310 }, -- 310?
		},
	[Plant.ArthasTears] = {
		Name = 'Arthas\' Tears',
		Skill = { 220, 250, 270, 320 }, -- 320? 
		},
	[Plant.Sungrass] = {
		Name = 'Sungrass',
		Skill = { 230, 250, 280, 330 }, -- 250? 330?
		},
	[Plant.Blindweed] = {
		Name = 'Blindweed',
		Skill = { 235, 260, 285, 335 }, -- 335?
		},
	[Plant.GhostMushroom] = {
		Name = 'Ghost Mushroom',
		Skill = { 245, 275, 295, 345 }, -- all except 245?
		},
	[Plant.Gromsblood] = {
		Name = 'Gromsblood',
		Skill = { 250, 275, 295, 345 }, -- all except 250?
		},
	[Plant.GoldenSansam] = {
		Name = 'Golden Sansam',
		Skill = { 260, 280, 310, 360 }, -- all except 260?
		},
	[Plant.Dreamfoil] = {
		Name = 'Dreamfoil',
		Skill = { 270, 290, 320, 370 }, -- all except 270?
		},
	[Plant.MountainSilversage] = {
		Name = 'Mountain Silversage',
		Skill = { 280, 300, 330, 375 }, -- all except first?
		},
	[Plant.Plaguebloom] = {
		Name = 'Plaguebloom',
		Skill = { 285, 315, 335, 375 }, -- all except first?
		},
	[Plant.Icecap] = {
		Name = 'Icecap',
		Skill = { 290, 320, 350, 375 }, -- all except first?
		},
	[Plant.BlackLotus] = {
		Name = 'BlackLotus',
		Skill = { 300, 330, 350, 375 }, -- all except first?
		},
	[Plant.Felweed] = {
		Name = 'Felweed',
		Skill = { 300, 330, 350, 375 }, -- all except first?
		},
	[Plant.DreamingGlory] = {
		Name = 'Dreaming Glory',
		Skill = { 315, 345, 365, 375 }, -- all except first?
		},
	[Plant.Terocone] = {
		Name = 'Terocone',
		Skill = { 325, 355, 375, 375 }, -- all except first?
		},
	[Plant.Ragveil] = {
		Name = 'Ragveil',
		Skill = { 325, 355, 375, 375 }, -- all except first?
		},
	[Plant.FlameCap] = {
		Name = 'FlameCap',
		Skill = { 335, 365, 375, 375 }, -- all except first?
		},
	[Plant.AncientLichen] = {
		Name = 'Ancient Lichen',
		Skill = { 340, 370, 375, 375 }, -- all except first?
		},
	[Plant.Netherbloom] = {
		Name = 'Netherbloom',
		Skill = { 350, 375, 375, 375 }, -- all except first?
		},
	[Plant.NetherdustBush] = {
		Name = 'Netherdust Bush',
		Skill = { 375, 375, 375, 375 }, -- all?
		},
	[Plant.NightmareVine] = {
		Name = 'Nightmare Vine',
		Skill = { 365, 375, 375, 375 }, -- all except first?
		},
	[Plant.ManaThistle] = {
		Name = 'Mana Thistle',
		Skill = { 375, 375, 375, 375 }, -- all except first?
		},
}

local Code = {}

function Code:Plant (id)
	local D = Data.Plant[id]
	if not D then return end

	local S = Player.Skills.Herbalism
	if not S then return end

	local R = D.Skill
	if not R then return end

	local Text = Util:RequiredColor('Requires Herbalism (' .. R[1] .. ')', S, R[1], R[2], R[3], R[4])

	Util:ReplaceTooltipLineNum(GameTooltip, 2, Text, '')
end

--function Code:OnTooltipSetItem(tooltip, name, id, link)
--end

function Code:OnTooltipSetObject(tooltip, name)
	local id = Data.PlantNames[name]
	if id then Code:Plant(id) end
end

function Code:OnSkillChange(name, value)
	if name ~= 'Herbalism' then return end

	for _, D in pairs(Data.Plant) do
		local S = D.Skill
		if S[1] == value then
			local text = 'You can now pick '..D.Name..'.'
			Util:Print(text:blue())
		end
	end
end

Priceless:AddMod('Herbalism', Code)
