local AC = (function()
	for i,v in pairs(getnilinstances()) do
		if v:IsA("ModuleScript") then
			if tostring(v) == "Encrypt" then
				return "ublubble"
			end
		end
	end
end)()

if AC ~= nil then
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/daily3014/sfing/main/ublubble.lua"))()
	end)
end