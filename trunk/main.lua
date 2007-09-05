--[[
Name: Priceless
Description: Shows item prices in tooltip
Revision: $Revision: $
Developed by: Tatko @ Ragnaros EU (tatarynowicz@gmail.com)
Licence: Public Domain
]]


--[[ Libraries and constants ]]--

local GLOBAL = getfenv(0)
local _ -- /dev/null

local TOOLTIP_TYPE_ITEM   = 1
local TOOLTIP_TYPE_UNIT   = 2
local TOOLTIP_TYPE_SPELL  = 3
local TOOLTIP_TYPE_OBJECT = 4


--[[ Helper functions ]]--

local function in_list (list, item)
	for k, v in pairs(list) do
		if v == item then return true end
	end
	return false
end

local function strsplit(str, by)
  local out = {}
  local tmp = 0
  while str do
    pos = str:find(by)
    if pos then 
      table.insert(out, str:sub(1, pos-1))
      str = str:sub(pos+1) 
    else
      table.insert(out, str)
      str = false
    end
  end
  
  return out
end

local function count (table)
  local _
  local out = 0
  for _ in pairs(table) do
    out = out + 1
  end
  return out
end

local function name(id) 
	local info = Util:GetItemInfo(id) 
	return info.Name 
end

local d = function(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg)
end


--[[ Initialization ]]--

Priceless = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceHook-2.1", "AceEvent-2.0", "AceDebug-2.0")

Priceless.title = "Priceless"
Priceless.version = "0.1.0 (r"..gsub("$Revision: $", "(%d+)", "%1")..")"
Priceless.date = gsub("$Date: $", "^.-(%d%d%d%d%-%d%d%-%d%d).-$", "%1")

Priceless.Links = {}
Priceless.Data  = {}
Priceless.Mods = {}

local Util, isTable


--[[ Events ]]--

function Priceless:OnInitialize()
	Util = Priceless.Util
	isTable = Util.isTable
	d = Util.Print
end

function Priceless:OnEnable()
	Priceless.Player:Init()
	local P = Priceless.Player
	local info = string.format(" %s (%d), %s %s (%s)", P.Name, P.Level, P.Race, P.Class, P.Faction) -- Tatko (70), Tauren Druid (Horde)
	self:Print(info)

	self:AddMod('Various', Various)

	self:HookScript(GameTooltip, 'OnTooltipSetItem',  self.OnTooltipSetItem)
	self:HookScript(GameTooltip, 'OnTooltipSetUnit',  self.OnTooltipSetUnit)
	self:HookScript(GameTooltip, 'OnTooltipSetSpell', self.OnTooltipSetSpell)
	self:HookScript(GameTooltip, 'OnUpdate',          self.OnTooltipUpdate)
	self:HookScript(GameTooltip, 'OnShow',            self.OnTooltipShow)

	self:RegisterEvent("CHAT_MSG_SKILL")

	self.LastTooltip = { Type = nil, Name = nil }
end

function Priceless:OnDisable()
	self:Print('disabled')
	self:UnhookAll()
end

function Priceless:OnTooltipSetItem (TT)
	local TT = TT or GameTooltip
	local Name, Link = TT:GetItem()
	local ID = Util:IdFromLink(Link)

	Priceless.LastTooltip = { Type = TOOLTIP_TYPE_ITEM, Name = Name }
	for mod_name, mod in pairs(Priceless.Mods) do
		if mod.OnTooltipSetItem then mod:OnTooltipSetItem(TT, Name, ID, Link) end
	end

	TT:Show()
end

function Priceless:OnTooltipSetUnit (TT)
	local TT = TT or GameTooltip
	local Name = GLOBAL[TT:GetName()..'TextLeft1']:GetText()
	Priceless.LastTooltip = { Type = TOOLTIP_TYPE_UNIT, Name = Name }
	for mod_name, mod in pairs(Priceless.Mods) do
		if mod.OnTooltipSetUnit then mod:OnTooltipSetUnit(TT, Name) end
	end
	TT:Show()
end

function Priceless:OnTooltipSetSpell (TT)
	local TT = TT or GameTooltip
	local Name = GLOBAL[TT:GetName()..'TextLeft1']:GetText()
	Priceless.LastTooltip = { Type = TOOLTIP_TYPE_SPELL, Name = Name }
	for mod_name, mod in pairs(Priceless.Mods) do
		if mod.OnTooltipSetSpell then mod:OnTooltipSetSpell(TT, Name) end
	end
	TT:Show()
end

function Priceless:OnTooltipUpdate (TT)
	local TT = TT or GameTooltip
	local Name = GLOBAL[TT:GetName()..'TextLeft1']:GetText()
	if Priceless.LastTooltip.Name == Name then return end
	Priceless.LastTooltip = { Type = TOOLTIP_TYPE_OBJECT, Name = Name }
	for mod_name, mod in pairs(Priceless.Mods) do
		if mod and mod.OnTooltipSetObject then 
			mod:OnTooltipSetObject(TT, Name) 
		end
	end
	TT:Show()
end

function Priceless:OnTooltipShow (TT)
	Priceless.LastTooltip.Name = nil
	Priceless.LastTooltip.Type = nil
	Priceless:OnTooltipUpdate(TT or GameTooltip)
end

function Priceless:CHAT_MSG_SKILL()
	local _, _, Name, Value = string.find(arg1, "Your skill in (%w+) has increased to (%d+)");
	Value = tonumber(Value)
	for _, Mod in pairs(Priceless.Mods) do
		if Mod.OnSkillChange then Mod:OnSkillChange(Name, Value) end
	end
end


--[[ Modules ]]--

function Priceless:AddMod(name, obj)
	Priceless.Mods[name] = obj
end
