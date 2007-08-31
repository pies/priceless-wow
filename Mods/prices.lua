
local Util = Priceless.Util

local Prices = {}

function Prices:FromAuctioneer(link)
	if not Auctioneer then return end

	local Ka = Auctioneer.Util.GetAuctionKey();
	local Ki = Auctioneer.ItemDB.CreateItemKeyFromLink(link);

	local A, Ac = Auctioneer.Statistic.GetItemHistoricalMedianBuyout(Ki, Ka);

	if not A or A == 0 then return end

	local L, Lc = Auctioneer.Statistic.GetItemSnapshotMedianBuyout(Ki, Ka);
	local V     = Auctioneer.API.GetVendorSellPrice(Ki);
	local P     = math.floor((A*Ac + L*Lc) / (Ac + Lc))

	return P, A, Ac, L, Lc, V
end

function Prices:FromColaLight(link)
	if not ColaLight then return end
	return ColaLight:GetItemValue(link)
end

function Prices:OnTooltipSetItem(tooltip, name, id, link)
	local P = Prices:FromAuctioneer(link)
	if P and P > 0 then Util:AddToTooltip('AH Price:', Util:AsGold (P, true)) end

	local V = Prices:FromColaLight(link)
	if V and V > 0 then Util:AddToTooltip('Vendor Price:', Util:AsGold (V, true)) end
end

Priceless:AddMod('Prices', Prices)
