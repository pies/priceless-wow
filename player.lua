--[[

	-- Fired when a player levels up.
	PLAYER_LEVEL_UP (Level, Hp, Mana, Talents, Str, Agi, Sta, Int, Spi)
		Level   - New player level. Note: UnitLevel("player") can return an incorrect value when called in this event handler or shortly after
		Hp      - Hit points gain
		Mana    - Mana points gain
		Talents - Talent points gain
		Str     - Strength gain
		Agi     - Agility gain
		Sta     - Stamina gain
		Int     - Intellect gain
		Spi     - Spirit gain
]]--

local function d(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg)
end

function dt (l, ...)
	if not ... or not (type(...) == 'table') then 
		d(l..' | (empty)')
	else
		for k,v in pairs(...) do
			d(l..' | '..k..': '..v)
		end
	end
end

Priceless.Player = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceHook-2.1", "AceEvent-2.0", "AceDebug-2.0")
local Player = Priceless.Player

function Player:Init()
	self.Name    = self:getName()
	self.Level   = self:getLevel()
	self.Class   = self:getClass()
	self.Race    = self:getRace()
	self.Faction = self:getFaction()
	self.Skills  = self:getSkills()
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("SKILL_LINES_CHANGED");
end

function Player:PLAYER_LEVEL_UP (level, hp, mana, talents, str, agi, sta, int, spi)
	self.Level = level
end

function Player:SKILL_LINES_CHANGED ()
	self.Skills  = self:getSkills()
end

function Player:getSkills()

	for ii = 1, GetNumSkillLines() do
		local _, isHeader, isExpanded = GetSkillLineInfo(ii)
		if isHeader and not isExpanded then ExpandSkillHeader(ii) end
	end

	local skills = {}
	for skillIndex = 1, GetNumSkillLines() do
		Name, isHeader, isExpanded, Rank = GetSkillLineInfo(skillIndex)
		if isHeader == nil then skills[Name] = Rank end
	end

	return skills
end

function Player:getFaction(unit)
	return UnitFactionGroup(unit or "player");
end

function Player:getRace(unit)
    local _,race = UnitRace(unit or "player")
    return race
end

function Player:getClass(unit)
    return UnitClass(unit or "player")
end

function Player:getName(unit)
    return UnitName(unit or "player")
end

function Player:getLevel(unit)
    return UnitLevel(unit or "player")
end

function Player:getLocation()
	SetMapToCurrentZone();
	local x, y    = GetPlayerMapPosition("player");
	local zone    = GetRealZoneText() or "";
	local subzone = GetSubZoneText();
	
	if not subzone or subzone == "" then
		subzone = zone;
	end

	return math.floor(x * 1000 + 0.5), math.floor(y * 1000 + 0.5), zone, subzone;
end
