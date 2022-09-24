function splitstring(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local function GetInstanceFromDatamodel(Datamodel, StringPath)
	local CurrentObjectReference = Datamodel

	for _, ObjectName in pairs(splitstring(StringPath, ".")) do
		if CurrentObjectReference:FindFirstChild(ObjectName) ~= nil then
			CurrentObjectReference = CurrentObjectReference[ObjectName]
		else
			error(ObjectName .. " was not found.")
			return nil
		end
	end

	return CurrentObjectReference
end

local function SaveAssetToFilesystem(Asset, Path)
	for _, Instance in pairs(Asset:GetChildren()) do
		if Instance.ClassName ~= "Folder" then
			print(Path)
			remodel.writeModelFile(Instance, Path .. "/" .. Instance.Name .. ".rbxmx")
		else
			remodel.createDirAll(Path .. "/" .. Instance.Name)
			SaveAssetToFilesystem(Instance, Path .. "/" .. Instance.Name)
		end
	end
end

local Datamodel = remodel.readPlaceFile("assets/robloxgamefile.rbxl")
-- print(Datamodel.Parent)
-- local Pullfrom = GetInstanceFromDatamodel(Datamodel, "Workspace.Parts")
-- local Saveto = "Assets/Workspace"

-- SaveAssetToFilesystem(Pullfrom, Saveto)

local SERVICES = { "Workspace", "Lighting" }
for _, serviceName in ipairs(SERVICES) do
	local service = Datamodel[serviceName]

	remodel.writeModelFile(service, "assets/" .. serviceName .. ".rbxm")
end
