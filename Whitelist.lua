local yes = "whitelisted"
local no = "blacklisted"
local List = {
	["GodWorldX"] = yes,
	["Playpozitiv_Youtube"] = yes,
	["melonboied"] = yes,
	["KenChic2143"] = yes,
	["arafree2"] = yes,
}
local list = {}
for i,v in pairs(List) do
	list[string.lower(i)] = string.lower(v)
end
return list
