
local PT = AceLibrary("PeriodicTable-3.0")
local Util = Priceless.Util
local _

local function parse_set_string (str)
  local out = {}
  local items = strsplit(str, ';')
  if type(items) == 'string' then return { items } end
  for _, item in pairs(items) do
    local tmp = strsplit(item, 'x')
    out[tmp[1]] = tmp[2]
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


local Code = {}

function Code:OnTooltipSetItem(tooltip, name, id, link)

	local sets = PT:ItemSearch(id)
	if not Util:isTable(sets) then return end

	--Util:Print('trades '..name..' - '..(id or ''))

	local prefix = "TradeskillResultMats.Reverse."

	local tmp = {}
	for _, s in pairs(sets) do
	  if string.find(s, prefix) then
		local data = PT:GetSetTable(s)
		local name = s:match('^'..prefix..'([A-Za-z]+)')
		if name then
			local items = parse_set_string(data[id])
			tmp[name] = (tmp[name] or 0) + count(items)
		end
	  end
	end

	if Util:isTable(tmp) and count(tmp) then
		local label = 'Used in:'
		for name, items in pairs(tmp) do
			local item = name..' ('..items..')'
			Util:AddToTooltip(label, item)
			label = ' '
		end
	end
end

Priceless:AddMod('Trades', Code)
