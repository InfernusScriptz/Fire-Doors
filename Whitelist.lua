local yes = "whitelisted"
local no = "blacklisted"
local List = {
	["57a436ab07d5fa7cc1047b8ac141857919afa65845d9ba57dd59cb34ead961a67dbd5cfeef99fd4c9abe758c3b5fdbdb"] = yes,
	["3baca05b839243daf83ee91b374c10bc55d3f7554787b0bdb5cedf83fa5ca75c25882b42773eeca1bf9f512d9d2dc8b4"] = yes,
	["0ad7dd81b6625136c041f4f817f6425ac9ef0ef9405b95d298bf378bd7d548d4"] = yes,
	["2589dc95748ea676e5e8e757fe16d389bea5ba0a7f1f7c4dcbb76170372cdad74ff7ad9ace356341958e503ee8974776"] = yes,
	["4e9e1121d69fc2f5515a9cd5d7dd040a9028040122d594b9f0de920b0fc2084585d15ec893cd498641e0f0f260022fe4"] = yes,
	["a6164779d423cbf077f081a830b14dd8"] = yes,
	["b77a26674d8d6d09d203c4f0c7179a6982596bc7df6f2dc47f6c039ffd5af99837a858f758168f886b603feceec61db2"] = yes,
	["3f7271d5023ae7c5b53dbff7a6b35b286c19771d8364ee89adce8ba5ed117778"] = yes,
	["67bb93ced94c13f4ed2bb61abe81447a3c08e89ee1abaad2bc422db76b18a727"] = yes,
	["9809fbabd6fe2c9e26bb30fb3d09470f1d5264902fa42e95e6ea86cb24b67cb5"] = yes,
}
local vip = {
	["9809fbabd6fe2c9e26bb30fb3d09470f1d5264902fa42e95e6ea86cb24b67cb5"] = true,
}
local owner = string.lower("9809fbabd6fe2c9e26bb30fb3d09470f1d5264902fa42e95e6ea86cb24b67cb5")
local list = {}
local superlist = {}
for i,v in pairs(List) do
	list[string.lower(i)] = string.lower(v)
end
for i,v in pairs(vip) do
	superlist[string.lower(i)] = string.lower(v)
end
return list,superlist,owner
