local yes = "whitelisted"
local no = "blacklisted"
local List = {
	
}
local list = {}
for i,v in pairs(List) do
	list[string.lower(i)] = string.lower(v)
end
return list
