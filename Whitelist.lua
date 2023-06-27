local yes = "whitelisted"
local no = "blacklisted"
local List = {
	["57a436ab07d5fa7cc1047b8ac141857919afa65845d9ba57dd59cb34ead961a67dbd5cfeef99fd4c9abe758c3b5fdbdb"] = yes,
	["3baca05b839243daf83ee91b374c10bc55d3f7554787b0bdb5cedf83fa5ca75c25882b42773eeca1bf9f512d9d2dc8b4"] = yes,
	["0ad7dd81b6625136c041f4f817f6425ac9ef0ef9405b95d298bf378bd7d548d4"] = yes,
	["2589dc95748ea676e5e8e757fe16d389bea5ba0a7f1f7c4dcbb76170372cdad74ff7ad9ace356341958e503ee8974776"] = yes,
	["4e9e1121d69fc2f5515a9cd5d7dd040a9028040122d594b9f0de920b0fc2084585d15ec893cd498641e0f0f260022fe4"] = yes,
}
local list = {}
for i,v in pairs(List) do
	list[string.lower(i)] = string.lower(v)
end
return list
