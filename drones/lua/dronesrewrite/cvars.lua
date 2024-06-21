DRONES_REWRITE.ServerCVars = { }
DRONES_REWRITE.ClientCVars = { }

-- Test. JUST. TEST.
DRONES_REWRITE.ServerCVars.Installed = CreateConVar("dronesrewrite_installed", 1, {
	FCVAR_ARCHIVE,
	FCVAR_NOTIFY,
	FCVAR_REPLICATED,
	FCVAR_SERVER_CAN_EXECUTE
}, "")

DRONES_REWRITE.ServerCVars.DebugMode = CreateConVar("dronesrewrite_debugmode", "0", { FCVAR_ARCHIVE, FCVAR_REPLICATED })
cvars.AddChangeCallback("dronesrewrite_debugmode", function(cvar, old, new)
	if tobool(new) then
		DRONES_REWRITE.LogDebug("ENTERING DEBUG MODE !!!")
	else
		DRONES_REWRITE.LogDebug("EXITING DEBUG MODE !!!")
	end
end)

DRONES_REWRITE.ServerCVars.FuelConsumptionCoef = CreateConVar("dronesrewrite_admin_fuelconscoef", "1", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.SpeedCoef = CreateConVar("dronesrewrite_admin_speedcoef", "1", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.RotSpeedCoef = CreateConVar("dronesrewrite_admin_rotspeedcoef", "1", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.HealthCoef = CreateConVar("dronesrewrite_admin_hpcoef", "1", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.SignalCoef = CreateConVar("dronesrewrite_admin_signalcoef", "1", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.DmgCoef = CreateConVar("dronesrewrite_admin_dmgcoef", "1", { FCVAR_ARCHIVE })

DRONES_REWRITE.ServerCVars.AllowAdmins = CreateConVar("dronesrewrite_admin_allowadmins", "1", { FCVAR_ARCHIVE })

DRONES_REWRITE.ServerCVars.NoDamage = CreateConVar("dronesrewrite_admin_nodamage", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NoFuel = CreateConVar("dronesrewrite_admin_nofuel", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NoLoopSound = CreateConVar("dronesrewrite_admin_noloop", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NoAmmo = CreateConVar("dronesrewrite_admin_noammo", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.SpawnAsDisabled = CreateConVar("dronesrewrite_admin_spawndisabled", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NPCIgnore = CreateConVar("dronesrewrite_admin_ignore", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.RemoveOnDestroyed = CreateConVar("dronesrewrite_admin_remove", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NoWaiting = CreateConVar("dronesrewrite_admin_nowaiting", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.AllowStealing = CreateConVar("dronesrewrite_admin_steal", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.AllowWater = CreateConVar("dronesrewrite_admin_allowwater", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NoHitPropellers = CreateConVar("dronesrewrite_admin_nohitpropellers", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NoNoise = CreateConVar("dronesrewrite_admin_nonoise", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NoFlyCor = CreateConVar("dronesrewrite_admin_noflycor", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NoWeps = CreateConVar("dronesrewrite_admin_noweps", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NoRecoil = CreateConVar("dronesrewrite_admin_norecoil", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NoSignalLimit = CreateConVar("dronesrewrite_admin_nosiglim", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NoShells = CreateConVar("dronesrewrite_admin_noshells", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.MS_DontSpawnStuff = CreateConVar("dronesrewrite_admin_nostuffms", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NoInterpolation = CreateConVar("dronesrewrite_admin_noint", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.AllowAdminModules = CreateConVar("dronesrewrite_admin_allowadminmodules", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.DontKickPly = CreateConVar("dronesrewrite_admin_nokick", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NoPhysDmg = CreateConVar("dronesrewrite_admin_nophysdmg", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.UpdateRate = CreateConVar("dronesrewrite_admin_updrate", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.UseUpdateRate = CreateConVar("dronesrewrite_admin_customrate", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.EmptyFuel = CreateConVar("dronesrewrite_admin_emptyfuel", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.NPCReverse = CreateConVar("dronesrewrite_admin_npcreverse", "0", { FCVAR_ARCHIVE })
DRONES_REWRITE.ServerCVars.AIDisable = CreateConVar("dronesrewrite_admin_aidisable", "0", { FCVAR_ARCHIVE })

DRONES_REWRITE.ServerCVars.NoCameraRestrictions = CreateConVar("dronesrewrite_admin_360rotate", "0", { FCVAR_ARCHIVE, FCVAR_REPLICATED })
DRONES_REWRITE.ServerCVars.CamAllowRestrictions = CreateConVar("dronesrewrite_admin_360cam", "0", { FCVAR_ARCHIVE, FCVAR_REPLICATED })
DRONES_REWRITE.ServerCVars.StaticCam = CreateConVar("dronesrewrite_admin_staticcam", "0", { FCVAR_ARCHIVE, FCVAR_REPLICATED })
DRONES_REWRITE.ServerCVars.NoSlots = CreateConVar("dronesrewrite_admin_noslots", "0", { FCVAR_ARCHIVE, FCVAR_REPLICATED })

if CLIENT then
	DRONES_REWRITE.ClientCVars.DrawHUD = CreateClientConVar("dronesrewrite_hud_drawhud", "1", true, false)
	DRONES_REWRITE.ClientCVars.DrawCrosshair = CreateClientConVar("dronesrewrite_hud_drawcrosshair", "1", true, false)
	DRONES_REWRITE.ClientCVars.DrawHealth = CreateClientConVar("dronesrewrite_hud_drawhealth", "1", true, false)
	DRONES_REWRITE.ClientCVars.DrawTargets = CreateClientConVar("dronesrewrite_hud_drawtargets", "1", true, false)
	DRONES_REWRITE.ClientCVars.DetectDamage = CreateClientConVar("dronesrewrite_hud_drawdamage", "1", true, false)
	DRONES_REWRITE.ClientCVars.DrawRadar = CreateClientConVar("dronesrewrite_hud_drawradar", "1", true, false)
	DRONES_REWRITE.ClientCVars.DrawFuel = CreateClientConVar("dronesrewrite_hud_drawfuel", "1", true, false)
	DRONES_REWRITE.ClientCVars.DrawCenter = CreateClientConVar("dronesrewrite_hud_drawcenter", "1", true, false)
	DRONES_REWRITE.ClientCVars.DrawWeps = CreateClientConVar("dronesrewrite_hud_drawweps", "1", true, false)
	DRONES_REWRITE.ClientCVars.OverlayDef = CreateClientConVar("dronesrewrite_overlay_usedefault", "1", true, false)
	DRONES_REWRITE.ClientCVars.HUD_useDef = CreateClientConVar("dronesrewrite_hud_usedefault", "1", true, false)

	DRONES_REWRITE.ClientCVars.HUD_customHud = CreateClientConVar("dronesrewrite_curhud", "Sci Fi", true, false)
	DRONES_REWRITE.ClientCVars.CustomOverlay = CreateClientConVar("dronesrewrite_curoverlay", "Default", true, false)

	DRONES_REWRITE.ClientCVars.DrawTpCrosshair = CreateClientConVar("dronesrewrite_cl_crosshairtp", "1", true, false)
	DRONES_REWRITE.ClientCVars.NoGlows = CreateClientConVar("dronesrewrite_cl_noglows", "0", true, false)
	DRONES_REWRITE.ClientCVars.NoScreen = CreateClientConVar("dronesrewrite_cl_noscreen", "0", true, false)
	DRONES_REWRITE.ClientCVars.NoConWin = CreateClientConVar("dronesrewrite_cl_noconwin", "0", true, false)
	DRONES_REWRITE.ClientCVars.DefaultTp = CreateClientConVar("dronesrewrite_cl_deftp", "0", true, false)
	DRONES_REWRITE.ClientCVars.NoConRender = CreateClientConVar("dronesrewrite_cl_noconrender", "0", true, false)
	DRONES_REWRITE.ClientCVars.CamDistanceCoefficient = CreateClientConVar("dronesrewrite_cl_cameradistance", "0", true, false)
	DRONES_REWRITE.ClientCVars.CamOrientation = CreateClientConVar("dronesrewrite_cl_camorientation", "Right", true, false)
	DRONES_REWRITE.ClientCVars.QuickSel = CreateClientConVar("dronesrewrite_cl_quickwepsel", "0", true, false)
	DRONES_REWRITE.ClientCVars.NoMuzzleFlash = CreateClientConVar("dronesrewrite_cl_dismuzzleflash", "0", true, false)
	DRONES_REWRITE.ClientCVars.DrawAttachments = CreateClientConVar("dronesrewrite_cl_drawattachments", "0", true, false)
	DRONES_REWRITE.ClientCVars.DisableHell = CreateClientConVar("dronesrewrite_cl_nohell", "0", true, false)

	DRONES_REWRITE.ClientCVars.WvCamOrientation = CreateClientConVar("dronesrewrite_cl_wvcamorientation", "Right", true, true)

	-- AI and serverside cvars
	DRONES_REWRITE.ClientCVars.AInpcs = CreateClientConVar("dronesrewrite_ai_noattacknpcs", "0", true, true)
	DRONES_REWRITE.ClientCVars.AIplys = CreateClientConVar("dronesrewrite_ai_noattackplayers", "0", true, true)
	DRONES_REWRITE.ClientCVars.AIdron = CreateClientConVar("dronesrewrite_ai_noattackdrones", "0", true, true)
	DRONES_REWRITE.ClientCVars.AIfrie = CreateClientConVar("dronesrewrite_ai_noattackfr", "0", true, true)
	DRONES_REWRITE.ClientCVars.AIowne = CreateClientConVar("dronesrewrite_ai_attackowner", "0", true, true)
	DRONES_REWRITE.ClientCVars.AIradi = CreateClientConVar("dronesrewrite_ai_radius", "3000", true, true)
	DRONES_REWRITE.ClientCVars.AIflyz = CreateClientConVar("dronesrewrite_ai_flyzdistance", "100", true, true)

	DRONES_REWRITE.ClientCVars.MouseLimit = CreateClientConVar("dronesrewrite_cl_mouselimit", "16", true, true)
	DRONES_REWRITE.ClientCVars.Hints = CreateClientConVar("dronesrewrite_cl_nomessage", "0", true, true)
	DRONES_REWRITE.ClientCVars.MouseRotation = CreateClientConVar("dronesrewrite_cl_mouserotation", "0", true, true)

	DRONES_REWRITE.ClientCVars.Keys = { }
	for name, v in pairs(DRONES_REWRITE.Keys) do
		DRONES_REWRITE.ClientCVars.Keys[name] = CreateClientConVar("dronesrewrite_key_" .. name, tostring(v), true, true)
	end

	concommand.Add("dronesrewrite_cl_resetcvars", function(ply)
		if SERVER then return end

		for k, v in pairs(DRONES_REWRITE.ClientCVars) do
			if istable(v) then
				for a, b in pairs(v) do
					RunConsoleCommand(b:GetName(), b:GetDefault())
				end
			else
				RunConsoleCommand(v:GetName(), v:GetDefault())
			end
		end
	end, nil, "Will reset your client settings") 

	concommand.Add("dronesrewrite_copy_clcvars", function(ply)
		if SERVER then return end

		local text = ""
		for k, v in pairs(DRONES_REWRITE.ClientCVars) do
			if istable(v) then
				for a, b in pairs(v) do
					text = text .. b:GetName() .. " " .. b:GetString() .. " \n"
				end
			else
				text = text .. v:GetName() .. " " .. v:GetString() .. " \n"
			end
		end
		SetClipboardText(text)
	end, nil, "Will copy cvars to clipboard") 

	concommand.Add("dronesrewrite_copy_svcvars", function(ply)
		if SERVER then return end

		local text = ""
		for k, v in pairs(DRONES_REWRITE.ServerCVars) do
			text = text .. v:GetName() .. " " .. v:GetString() .. " \n"
		end
		SetClipboardText(text)
	end, nil, "Will copy cvars to clipboard") 
end

concommand.Add("dronesrewrite_admin_resetcvars", function(ply)
	if CLIENT then return end
	if not ply:IsSuperAdmin() then print("Not a superadmin!") return end

	for k, v in pairs(DRONES_REWRITE.ServerCVars) do
		RunConsoleCommand(v:GetName(), v:GetDefault())
	end
end, nil, "Will reset your settings") 
