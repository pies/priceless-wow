Priceless.Util = {}

local Util = Priceless.Util

function Util:Print (msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg)
end


--[[ TABLE ]]--


function Util:isTable (var)
	return type(var) == 'table'
end

table.count = function(t)
  local _
  local out = 0
  for _ in pairs(t) do
    out = out + 1
  end
  return out
end

table.copy_into = function (dest, src)
	if not src or not type(v) == "table" then return dest end
	for k, v in pairs(src) do dest[k] = v end
	return dest
end


--[[ TEXT ]]--


function Util:TextWordWrap(text, limit, indent, indent1)
	indent = indent or ""
	indent1 = indent1 or indent
	limit = limit or 72
	local here = 1-#indent1
	return indent1..text:gsub("(%s+)()(%S+)()",
		function(sp, st, word, fi)
			if fi-here > limit then
				here = st - #indent
				return "\n"..indent..word
			end
		end)
end

function Util:TextUppercaseFirst(text)
	if not text then return text end
	return strupper(strsub(text, 0, 1))..strsub(text, 2)
end

function Util:TextClean(text)
	if strfind(strsub(text, 1, 10), "|c%x%x%x%x%x%x%x%x") and (strsub(text, -2) == "|r") then
		return strsub(text, 11, -3)
	else
		return text
	end
end

function Util:TextTrim(text)
    return (string.gsub(text, "^%s*(.-)%s*$", "%1"))
end 

-- Syntax candy
string.wordwrap = function(str, limit, indent, indent1) return Util:TextWordWrap(str, limit, indent, indent1) end
string.ucfirst = function(str) return Util:TextUppercaseFirst(str) end
string.clean = function(str) return Util:TextClean(str) end
string.trim = function(str) return Util:TextTrim(str) end


--[[ COLORS ]]--


Util.Color = {
	-- Difficulty
	Red     = "ff0000",
	Orange  = "ff7f00",
	Yellow  = "fff800",
	Green   = "00ff00",
	Gray    = "777777",
	-- Money
	Gold    = "ffd100", -- or ffd700
	Silver  = "e6e6e6", -- or c7c7cf
	Copper  = "c8602c", -- or eda55f
	-- Other
	Blue    = "5753ef",
	White   = "ffffff",
	Neutral = "cccccc",
	Label   = "88bbff", -- 0.5,0.7,1.0
}

function Util:Colorize(text, color, alpha)
	return "|c"..(alpha or "ff")..(color or 'ffffff')..(text or '').."|r"
end

function Util:RequiredColor(text, has, orange, yellow, green, gray)
	local has = has or 0
	local orange = orange or has
	local yellow = yellow or has
	local green = green or has
	local gray = gray or has

	if has < orange then return text:red() end
	if has < yellow then return text:orange() end
	if has < green  then return text:yellow() end
	if has < gray   then return text:green() end
	return text:white()
end

--Syntax candy

--[[ Colorize a string
Example:
local GreenText = "This text is green":color('00ff00')
local RedText = "This text is red and semi-transparent":color('ff0000', '7f')
]]--
string.color  = function(text, color, alpha) return Util:Colorize(text, color, alpha) end

--[[ Colors a string according to difficulty
Example:
local NodeRequires = { 150, 175, 200, 225 } -- Red, Yellow, Green, Gray
print( "Requires Mining (150)":requires(Player.Skills.Mining, NodeRequires) )
]]--
string.requires = function(text, has, needs)
	return Util:RequiredColor(text, has, needs[1] or 0, needs[2] or 0, needs[3] or 0, needs[4] or 0)
end

-- Difficulty colors
string.red    = function(text) return text:color(Util.Color.Red) end
string.orange = function(text) return text:color(Util.Color.Orange) end
string.yellow = function(text) return text:color(Util.Color.Yellow) end
string.green  = function(text) return text:color(Util.Color.Green) end
string.gray   = function(text) return text:color(Util.Color.Gray) end

-- Money colors
string.white  = function(text) return text:color(Util.Color.White) end
string.gold   = function(text) return text:color(Util.Color.Gold) end
string.silver = function(text) return text:color(Util.Color.Silver) end
string.copper = function(text) return text:color(Util.Color.Copper) end

-- Other colors
string.blue   = function(text) return text:color(Util.Color.Blue) end
string.neutral = function(text) return text:color(Util.Color.Neutral) end
string.label   = function(text) return text:color(Util.Color.Label) end



--[[ MATH ]]--


math.round = function (amount, to)
	to = to or 1
	return math.floor( (amount/to) + 0.5 ) * to
end


--[[ MONEY ]]--


local PRICE_SILVER = 100
local PRICE_GOLD   = 100 * PRICE_SILVER

function Util:AsGSC (price)
	price = price or 0
	local g = math.floor(price / PRICE_GOLD)
	local s = math.floor((price - (g * PRICE_GOLD)) / PRICE_SILVER)
	local c = math.floor(price - (g * PRICE_GOLD) - (s * PRICE_SILVER))
	return g, s, c
end

function Util:AsGold (price, rounded)
	price = price or 0
	if price == 0 then return ('0'):copper() end

	if rounded then
		if price > 100*PRICE_GOLD then
			price = math.round(price, PRICE_GOLD)
		elseif price > 100*PRICE_SILVER then
			price = math.round(price, PRICE_SILVER)
		end
	end

	local G, S, C = Util:AsGSC(price)
	local P = ''

	if G > 0 then P = (G..''):gold() .. '.' end
	if G > 0 and S < 10 then S = '0'..S end
	P = P .. (S..''):silver() .. '.'
	if C < 10 then C = '0'..C end
	P = P .. (C..''):copper()

	return P
end


--[[ TOOLTIP ]]--


function Util:GetTooltipContent(tooltip)
	local G = getfenv(0)
	local name = tooltip:GetName()
	local lc = tooltip:NumLines() or 0
	local tt = {}

	for i=1,lc do

		local L = G[name..'TextLeft'..i]
		if L then L = L:GetText() or '[nil]' else L = '' end
		local R = G[name..'TextRight'..i]
		if R then R = R:GetText() or '[nil]' else R = '' end
		local T = ''
		
		if L then 
			T = L 
		end
		
		if R then
			if T then T = T .. "\t" .. R else T = R end
		end

		tt[i] = T
	end

	return tt
end

function Util:AddToTooltip (left, right)
	if right then
		GameTooltip:AddDoubleLine(left, right,  0.5, 0.7, 1.0,  1.0, 1.0, 1.0)
	else
		GameTooltip:AddLine(left,  0.5, 0.7, 1.0 )
	end
end

function Util:ReplaceTooltipLine(L, R, Ln, Rn)
	if not Ln then Ln = '' end
	if not Rn then Rn = '' end

	L:SetText(Ln)
	if Ln == '' then L:Hide() else L:Show() end
	R:SetText(Rn)
	if Rn == '' then R:Hide() else R:Show() end
end

function Util:ReplaceTooltipLineNum (Tooltip, Num, Left, Right)
	local G = getfenv(0)
	local Name = (Tooltip or GameTooltip):GetName()
	if Left then
		local Line = G[Name..'TextLeft'..Num]
		Line:SetText(Left)
		Line:Show()
	end
	if Right then
		local Line = G[Name..'TextRight'..Num]
		Line:SetText(Right)
		Line:Show()
	end
end

function Util:CleanupTooltip(tooltip)
	local G = getfenv(0)
	local TT = tooltip
	local Tn = TT:GetName()
	local Tc = TT:NumLines()
	
	local nLine = 1
	for oLine=1,Tc do

		local oLn = Tn..'TextLeft'..oLine
		local oL = G[oLn]
		local oLt = oL and oL:GetText() or nil

		local oRn = Tn..'TextRight'..oLine
		local oR = G[oRn]
		local oRt = oR and oR:GetText() or nil
		
		if oLt or oRt then
			if oLine > nLine then
				local nL = G[Tn..'TextLeft'..nLine]
				nL:SetFont(oL:GetFont())
				nL:SetTextColor(oL:GetTextColor())
				nL:SetText(Util:WordWrap(oL:GetText(), 45))
				nL:Show()
				oL:Hide()

				local nR = G[Tn..'TextRight'..nLine]
				nR:SetFont(oR:GetFont())
				nR:SetTextColor(oR:GetTextColor())
				nR:SetText(oR:GetText())
				nR:Show()
				oR:Hide()
			end
			nLine = nLine + 1
		end
	end
end

function Util:DebugTooltip(tooltip, msg)
	local G = getfenv(0)
	local TT = tooltip or GameTooltip
	local Tn = TT:GetName()
	local Tc = TT:NumLines()
	for I=1,Tc do
		local L = G[Tn..'TextLeft'..I]
		if L then L = L:GetText() or '[nil]' end
		local R = G[Tn..'TextRight'..I]
		if R then R = R:GetText() or '[nil]' end
	end
end


--[[ ITEM ]]--


function Util:GetItemInfo(id)
	local i = {}
	i.Name, i.Link, i.Rarity, i.Level, i.MinLevel, i.Category, i.SubCategory, i.Stack, i.EquipLocation, i.Texture = GetItemInfo(id)
	return i
end

function Util:IdFromLink(link)
	if (type(link) ~= 'string') then return end
	local id = link:match("|Hitem:(%-?%d+)")
	return tonumber(id)
end

-- Given a Blizzard item link, breaks it into it's itemID, randomProperty, enchantProperty, uniqueness, name and the four gemSlots.
function Util:BreakItemLink(link)
	if (type(link) ~= 'string') then return end
	local itemID, enchant, gemSlot1, gemSlot2, gemSlot3, gemBonus, randomProp, uniqID, name = link:match("|Hitem:(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+)|h%[(.-)%]|h")
	return tonumber(itemID) or 0, tonumber(randomProp) or 0, tonumber(enchant) or 0, tonumber(uniqID) or 0, tostring(name), tonumber(gemSlot1) or 0, tonumber(gemSlot2) or 0, tonumber(gemSlot3) or 0, tonumber(gemBonus) or 0
end




--------------------------------------
-- Insert value of any type into array
--------------------------------------
local function arrayInsert( ary, val, idx )
    -- Needed because table.insert has issues
    -- An "array" is a table indexed by sequential
    -- positive integers (no empty slots)
    local lastUsed = #ary + 1
    local nextAvail = lastUsed + 1

    -- Determine correct index value
    local index = tonumber(idx) -- Don't use idx after this line!
    if (index == nil) or (index > nextAvail) then
        index = nextAvail
    elseif (index < 1) then
        index = 1
    end

    -- Insert the value
    if ary[index] == nil then
        ary[index] = val
    else
        -- TBD: Should we try to allow for skipped indices?
        for j = nextAvail,index,-1 do
            ary[j] = ary[j-1]
        end
        ary[index] = val
    end
end

--------------------------------
-- Compare two items of any type
--------------------------------
local function compareAnyTypes( op1, op2 ) -- Return the comparison result
    -- Inspired by http://lua-users.org/wiki/SortedIteration
    local type1, type2 = type(op1),     type(op2)
    local num1,  num2  = tonumber(op1), tonumber(op2)
    
    if ( num1 ~= nil) and (num2 ~= nil) then  -- Number or numeric string
        return  num1 < num2                     -- Numeric compare
    elseif type1 ~= type2 then                -- Different types
        return type1 < type2                    -- String compare of type name
    -- From here on, types are known to match (need only single compare)
    elseif type1 == "string"  then            -- Non-numeric string
        return op1 < op2                        -- Default compare
    elseif type1 == "boolean" then
        return op1                              -- No compare needed!
         -- Handled above: number, string, boolean
    else -- What's left:   function, table, thread, userdata
        return tostring(op1) < tostring(op2)  -- String representation
    end
end

-------------------------------------------
-- Iterate over a table in sorted key order
-------------------------------------------
local function pairsByKeys (tbl, func)
    -- Inspired by http://www.lua.org/pil/19.3.html
    -- and http://lua-users.org/wiki/SortedIteration

    if func == nil then
        func = compareAnyTypes
    end

    -- Build a sorted array of the keys from the passed table
    -- Use an insertion sort, since table.sort fails on non-numeric keys
    local ary = {}
    local lastUsed = 0
    for key --[[, val--]] in pairs(tbl) do
        if (lastUsed == 0) then
            ary[1] = key
        else
            local done = false
            for j=1,lastUsed do  -- Do an insertion sort
                if (func(key, ary[j]) == true) then
                    arrayInsert( ary, key, j )
                    done = true
                    break
                end
            end
            if (done == false) then
                ary[lastUsed + 1] = key
            end
        end
        lastUsed = lastUsed + 1
    end

    -- Define (and return) the iterator function
    local i = 0                -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1
        if ary[i] == nil then
            return nil
        else
            return ary[i], tbl[ary[i]]
        end
    end
    return iter
end

---------------------------------------------
-- Return indentation string for passed level
---------------------------------------------
local function tabs(i)
    return string.rep(".",i).." "   -- Dots followed by a space
end

-----------------------------------------------------------
-- Return string representation of parameter's value & type
-----------------------------------------------------------
local function toStrType(t)
    local function fttu2hex(t) -- Grab hex value from tostring() output
        local str = tostring(t);
        if str == nil then
            return "tostring() failure! \n"
        else
            local str2 = string.match(str,"[ :][ (](%x+)")
            if str2 == nil then
                return "string.match() failure: "..str.."\n"
            else
                return "0x"..str2
            end
        end
    end
    -- Stringify a value of a given type using a table of functions keyed
    -- by the name of the type (Lua's version of C's switch() statement).
    local stringify = {
        -- Keys are all possible strings that type() may return,
        -- per http://www.lua.org/manual/5.1/manual.html#pdf-type.
        ["nil"]			= function(v) return "nil (nil)"			    end,
        ["string"]		= function(v) return '"'..v..'" (string)'	    end,
        ["number"]		= function(v) return v.." (number)"			    end,
        ["boolean"]		= function(v) return tostring(v).." (boolean)"  end,
        ["function"]	= function(v) return fttu2hex(v).." (function)" end,
        ["table"]		= function(v) return fttu2hex(v).." (table)"	end,
        ["thread"]		= function(v) return fttu2hex(v).." (thread)"	end,
        ["userdata"]	= function(v) return fttu2hex(v).." (userdata)" end
    }
    return stringify[type(t)](t)
end

-------------------------------------
-- Count elements in the passed table
-------------------------------------
local function lenTable(t)		-- What Lua builtin does this simple thing?
    local n=0                   -- '#' doesn't work with mixed key types
    if ("table" == type(t)) then
        for key in pairs(t) do  -- Just count 'em
            n = n + 1
        end
        return n
    else
        return nil
    end
end

--------------------------------
-- Pretty-print the passed table
--------------------------------
local function do_dumptable(t, indent, seen)
    -- "seen" is an initially empty table used to track all tables
    -- that have been dumped so far.  No table is dumped twice.
    -- This also keeps the code from following self-referential loops,
    -- the need for which was found when first dumping "_G".
    if ("table" == type(t)) then	-- Dump passed table
        seen[t] = 1
        if (indent == 0) then
            print ("The passed table has "..lenTable(t).." entries:")
            indent = 1
        end
        for f,v in pairsByKeys(t) do
            if ("table" == type(v)) and (seen[v] == nil) then    -- Recurse
                print( tabs(indent)..toStrType(f).." has "..lenTable(v).." entries: {")
                do_dumptable(v, indent+1, seen)
                print( tabs(indent).."}" )
            else
                print( tabs(indent)..toStrType(f).." = "..toStrType(v))
            end
        end
    else
        print (tabs(indent).."Not a table!")
    end
end

--------------------------------
-- Wrapper to handle persistence
--------------------------------
function dumptable(t)   -- Only global declaration in the package
    -- This wrapper exists only to set the environment for the first run:
    -- The second param is the indentation level.
    -- The third param is the list of tables dumped during this call.
    -- Getting this list allocated and freed was a pain, and this
    -- wrapper was the best solution I came up with...
    return do_dumptable(t, 0, {})
end



Util.Compare = compareAnyTypes
Util.PairsByKeys = pairsByKeys
Util.DumpTable = dumptable
