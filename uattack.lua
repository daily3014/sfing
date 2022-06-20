local Hooks = {}
local Code; do
	local Count = 0
	for _,inst in pairs(getnilinstances()) do
		if inst:IsA("StringValue") and inst.Value:len() == 13 then
			Code = inst
			break
		end
	end
end

if not Code then
	game.Players.LocalPlayer:Kick("[Error] Bypass may be patched? [1]")
	return
end

Hooks["FireServer"] = hookfunction(Instance.new("RemoteEvent").FireServer,function(self,...)
	local arguments = {...}

	if getcallingscript():IsA("ModuleScript") and getcallingscript().Parent == nil then
		if arguments[1] and arguments[1][1] and type(arguments[1][1]) == "table" then
			for i,v in pairs(arguments[1]) do
				if v[1] ~= Code.Value then
					if getgenv().LogAttempts then
						warn("[SFing AC Bypass] [ublubble] Anticheat attempted to kick for " .. tostring(v[1]))
					end
					arguments[1][i] = nil
				end
			end
		end
	end

	return Hooks["FireServer"](self,...)
end)

Hooks["namecall"] = hookmetamethod(game,"__namecall",newcclosure(function(...)
	local self,caller,method,args = ...,getcallingscript(),getnamecallmethod(),{...}; table.remove(args,1)

	if not checkcaller() and self and typeof(self) == "Instance" then
		if method == "Destroy" and (self.FindFirstChild(self,"Handle") or tostring(self) == "Handle") and caller and caller.ClassName == "ModuleScript" then
			if getgenv().LogAttempts then
				warn("[SFing AC Bypass] [ublubble] Anticheat attempted to destroy sword")
			end
			return
		end
	end

	return Hooks["namecall"](...)
end))

Hooks["newindex"] = hookmetamethod(game,"__newindex",newcclosure(function(self,prop,value)
	local caller = getcallingscript()

	if not checkcaller() and self and typeof(self) == "Instance" then
		if (tostring(self) == "Handle" or self:FindFirstChild("Handle")) and prop == "Parent" and value == nil then
			if getgenv().LogAttempts then
				warn("[SFing AC Bypass] [ublubble] Anticheat attempted to parent sword to nil")
			end
			return
		end
	end

	return Hooks["newindex"](self,prop,value)
end))

warn("[SFing AC Bypass] [ublubble] Applied some side bypasses")
