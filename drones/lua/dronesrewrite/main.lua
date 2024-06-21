--[[
	Drones Rewrite
]]

DRONES_REWRITE = { }

DRONES_REWRITE.LogDebug = function(text)
	if DRONES_REWRITE.ServerCVars and DRONES_REWRITE.ServerCVars.DebugMode:GetBool() then
		MsgC(Color(255, 100, 100), "[DRR Debug] ", SERVER and Color(137, 222, 255) or Color(255, 222, 102), text, "\n")
	end
end

DRONES_REWRITE.Version = 4

DRONES_REWRITE.HUD = { }
DRONES_REWRITE.Overlay = { }
DRONES_REWRITE.Weapons = { }

DRONES_REWRITE.Keys = {
	["Forward"] = KEY_W,
	["Back"] = KEY_S,
	["Right"] = KEY_D,
	["Left"]  = KEY_A,
	["Down"]  = KEY_LCONTROL,
	["Up"] = KEY_SPACE,
	["Sprint"] = KEY_LSHIFT,
	["MoveSlowly"] = KEY_LALT,

	["Exit"] = KEY_E,
	["ThirdPerson"] = KEY_I,
	["Enable"] = KEY_G,
	["Fire1"] = MOUSE_LEFT,
	["Fire2"] = MOUSE_RIGHT,
	["SelfDestruct"] = KEY_J,
	["NightVision"] = KEY_R,
	["Flashlight"] = KEY_F,
	
	["SpecialKey"] = MOUSE_MIDDLE,
	["WeaponView"] = KEY_T,
	["Zoom"] = KEY_H,

	["StrafeRight"] = KEY_0, -- By default Strafes are not enabled
	["StrafeLeft"] = KEY_0
}

DRONES_REWRITE.SortedKeys = {
	"Forward",
	"Back",
	"Right",
	"Left",
	"Down",
	"Up",
	"Sprint",
	"MoveSlowly",

	"Exit",
	"ThirdPerson",
	"Enable",
	"Fire1",
	"Fire2",
	"SelfDestruct",
	"NightVision",
	"Flashlight",
	
	"SpecialKey",
	"WeaponView",
	"Zoom",

	"StrafeRight",
	"StrafeLeft"
}

DRONES_REWRITE.GetDrones = function()
	local tab = { }

	for k, v in pairs(ents.GetAll()) do
		if v.IS_DRONE then tab[#tab + 1] = v end
	end

	return tab
end

DRONES_REWRITE.GetDronesRewrite = function()
	local tab = { }

	for k, v in pairs(ents.GetAll()) do
		if v.IS_DRR then tab[#tab + 1] = v end
	end

	return tab
end

DRONES_REWRITE.FindDroneByUnit = function(unit)
	for k, v in pairs(DRONES_REWRITE.GetDronesRewrite()) do
		if string.find(string.lower(v:GetUnit()), string.lower(unit)) then return v end
	end

	return NULL
end

DRONES_REWRITE.IncludeFolder = function(path, recursive, str, fileFilter)
	str = str or "sh"
	fileFilter = fileFilter or { }

	local f, p = file.Find(path .. "/*", "LUA")

	for k, v in pairs(f) do
		if table.HasValue(fileFilter, v) then continue end

		local file = path .. "/" .. v

		if CLIENT and (str == "cl" or str == "sh") then
			include(file)
		end

		if SERVER then
			if str == "sv" or str == "sh" then
				include(file)
			end

			AddCSLuaFile(file)
		end
	end

	if recursive then
		for k, v in pairs(p) do
			DRONES_REWRITE.IncludeFolder(path .. "/" .. v, str)
		end
	end

	DRONES_REWRITE.LogDebug("Included " .. path)
end

DRONES_REWRITE.LoadFile = function(path)
	if SERVER then AddCSLuaFile(path) end
	include(path)

	DRONES_REWRITE.LogDebug("Included " .. path)
end

DRONES_REWRITE.LoadFile("dronesrewrite/receiver.lua")
DRONES_REWRITE.LoadFile("dronesrewrite/cvars.lua")
DRONES_REWRITE.IncludeFolder("dronesrewrite", false, "sh", { "main.lua", "receiver.lua", "cvars.lua" })
DRONES_REWRITE.IncludeFolder("dronesrewrite/client", true, "cl")
DRONES_REWRITE.IncludeFolder("dronesrewrite/weapons", true)

DRONES_REWRITE.DoPrecache = function()
	local a, models = file.Find("models/dronesrewrite/*", "GAME")

	local count = 0

	for _, mdlName in pairs(models) do
		local path = Format("models/dronesrewrite/%s/", mdlName)
		local mdlf, emp = file.Find(path .. "*", "GAME")
			
		for __, mdl in pairs(mdlf) do
			if string.find(mdl, ".mdl") then
				util.PrecacheModel(path .. mdl)
				count = count + 1
				break
			end
		end
	end

	print(Format("Precached %i Drones Rewrite models", count))
end

if SERVER then
	hook.Add("Initialize", "dronesrewrite_inithook", function()
		timer.Simple(0, function()
			http.Fetch("https://raw.githubusercontent.com/Ayditor/DronesRewrite/master/version.txt",
				function(body, len, headers, code)
					local version = tonumber(body)

					if version == DRONES_REWRITE.Version then
						MsgC(Color(0, 255, 0), "\nDrones Rewrite is up to date!\n")
					else
						local msg1 = "\nSeems like Drones Rewrite is outdated!"
						local msg2 = "\nNew version: " .. body
						local msg3 = "Your version: " .. DRONES_REWRITE.Version .. "!\n"
						MsgC(Color(255, 100, 80), msg1, msg2, msg3)

						print("Please download new version here: http://steamcommunity.com/sharedfiles/filedetails/?id=669642096")
					end
				end,

				function(error)
					print("Cannot check version of Drones Rewrite!")
				end
			)

			DRONES_REWRITE.DoPrecache()
		end)
	end)
end

DRONES_REWRITE.Loaded = true

if SERVER then MsgC(Color(0, 255, 0), "\nDrones Rewrite has been loaded! Addon version: " .. DRONES_REWRITE.Version .. "\n") end