local yes = "whitelisted"
local no = "blacklisted"
local List = {
	["57a436ab07d5fa7cc1047b8ac141857919afa65845d9ba57dd59cb34ead961a67dbd5cfeef99fd4c9abe758c3b5fdbdb"] = yes,
}
local list = {}
for i,v in pairs(List) do
	list[string.lower(i)] = string.lower(v)
end
return list
