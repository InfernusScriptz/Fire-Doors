local yes = "whitelisted"
local no = "blacklisted"
local List = {
	["GodWorldX"] = yes,
	["Playpozitiv_Youtube"] = yes,
	["melonboied"] = yes,
	["KenChic2143"] = yes,
	["arafree2"] = yes,
	["NaleyMne4ay"] = yes,
	["squid2022d"] = yes,
	["rechedmcvnGV"] = yes,
	["dzntzcuzcool"] = yes,
	["kardinhongfan12"] = yes,
	["roblox_games5005"] = yes,
	["Agent_Somik"] = yes,
	["Go_play2103"] = yes,
	["PLAYEReeio"] = yes,
	["sdsakhs"] = yes,
	["znjiuuiou"] = yes,
	["tottalynottanqrv"] = yes,
	["mhmdmuo"] = yes,
	["sokucuxxxx8"] = yes,
	["hecker7443"] = yes,
	["InfectionSmile_Fan1"]= yes,
}
local list = {}
for i,v in pairs(List) do
	list[string.lower(i)] = string.lower(v)
end
return list
