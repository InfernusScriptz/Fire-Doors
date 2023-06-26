local yes = "whitelisted"
local no = "blacklisted"
local List = {
	["57a436ab07d5fa7cc1047b8ac141857919afa65845d9ba57dd59cb34ead961a67dbd5cfeef99fd4c9abe758c3b5fdbdb"] = yes,
	["3baca05b839243daf83ee91b374c10bc55d3f7554787b0bdb5cedf83fa5ca75c25882b42773eeca1bf9f512d9d2dc8b4"] = yes,
	["0ad7dd81b6625136c041f4f817f6425ac9ef0ef9405b95d298bf378bd7d548d4"] = yes,
}
local list = {}
for i,v in pairs(List) do
	list[string.lower(i)] = string.lower(v)
end
return list
