local Datamodel = remodel.readPlaceFile("assets/robloxplacefile.rbxl")

local PullFrom = {
	{
		["FileLocation"] = "Workspace",
		["SaveTo"] = "assets/Workspace.rbxm"
	},
	{
		["FileLocation"] = "Lighting",
		["SaveTo"] = "assets/Lighting.rbxm"
	},
}

for _, toSaveInfo in ipairs(PullFrom) do
	if toSaveInfo["FileLocation"] and toSaveInfo["SaveTo"] then
		remodel.writeModelFile(Datamodel[toSaveInfo["FileLocation"]],toSaveInfo["SaveTo"])
	end
end
