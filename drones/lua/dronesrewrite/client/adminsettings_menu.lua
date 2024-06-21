local function setup(p)
	p:AddControl("CheckBox", { Label = "Debug mode", Command = "dronesrewrite_debugmode"})
	p:AddControl("Label", { Text = " "})

	p:AddControl("CheckBox", { Label = "Enable god mode for drones", Command = "dronesrewrite_admin_nodamage"})
	p:AddControl("CheckBox", { Label = "Disable fuel consumption", Command = "dronesrewrite_admin_nofuel"})
	p:AddControl("CheckBox", { Label = "Disable propellers' sound", Command = "dronesrewrite_admin_noloop"})
	p:AddControl("CheckBox", { Label = "Disable limit for upgrades slots", Command = "dronesrewrite_admin_noslots"})
	p:AddControl("CheckBox", { Label = "Infinite ammo", Command = "dronesrewrite_admin_noammo"})
	p:AddControl("CheckBox", { Label = "Do not disable drone in the water", Command = "dronesrewrite_admin_allowwater"})
	p:AddControl("CheckBox", { Label = "Disable camera rotation restrictions", Command = "dronesrewrite_admin_360rotate"})
	p:AddControl("CheckBox", { Label = "Disable shoot delay", Command = "dronesrewrite_admin_nowaiting"})
	p:AddControl("CheckBox", { Label = "Disable swing", Command = "dronesrewrite_admin_nonoise"})
	p:AddControl("CheckBox", { Label = "Disable fly correction (handles drone when pitch is high)", Command = "dronesrewrite_admin_noflycor"})
	p:AddControl("CheckBox", { Label = "Disable weapons", Command = "dronesrewrite_admin_noweps"})
	p:AddControl("CheckBox", { Label = "Disable guns' recoil", Command = "dronesrewrite_admin_norecoil"})
	p:AddControl("CheckBox", { Label = "Disable signal limit", Command = "dronesrewrite_admin_nosiglim"})
	p:AddControl("CheckBox", { Label = "Disable shells", Command = "dronesrewrite_admin_noshells" })
	p:AddControl("CheckBox", { Label = "Disable weapons rotation smoothing (interpolation)", Command = "dronesrewrite_admin_noint" })
	p:AddControl("CheckBox", { Label = "Disable physical damage (when drone bumps into walls)", Command = "dronesrewrite_admin_nophysdmg" })
	p:AddControl("Label", { Text = " "})

	p:AddControl("CheckBox", { Label = "Mothership: do not spawn stuff", Command = "dronesrewrite_admin_nostuffms" })
	p:AddControl("CheckBox", { Label = "NPCs: ignore drones", Command = "dronesrewrite_admin_ignore"})
	p:AddControl("CheckBox", { Label = "NPCs: combines fight on drones side", Command = "dronesrewrite_admin_npcreverse"})
	p:AddControl("CheckBox", { Label = "Remove drone on destroy", Command = "dronesrewrite_admin_remove"})
	p:AddControl("CheckBox", { Label = "Do not hit propellers", Command = "dronesrewrite_admin_nohitpropellers"})
	p:AddControl("CheckBox", { Label = "Do not kick player (If damaged)", Command = "dronesrewrite_admin_nokick" })
	p:AddControl("CheckBox", { Label = "Allow players steal drones", Command = "dronesrewrite_admin_steal"})
	p:AddControl("CheckBox", { Label = "Allow admins steal drones", Command = "dronesrewrite_admin_allowadmins"})
	--p:AddControl("CheckBox", { Label = "Allow using admin modules", Command = "dronesrewrite_admin_allowadminmodules"})
	p:AddControl("CheckBox", { Label = "Allow camera 360 rotation (only camera)", Command = "dronesrewrite_admin_360cam"})
	p:AddControl("CheckBox", { Label = "Lock camera rotation", Command = "dronesrewrite_admin_staticcam"})
	p:AddControl("CheckBox", { Label = "Spawn drones without fuel", Command = "dronesrewrite_admin_emptyfuel"})

	local key = string.upper(input.GetKeyName(DRONES_REWRITE.ClientCVars.Keys["Enable"]:GetString()))
	p:AddControl("CheckBox", { 
		Label = "Spawn as disabled (to enable press [" .. key .. "] while in drone)",
		Command = "dronesrewrite_admin_spawndisabled"
	})

	p:AddControl("Label", { Text = "Notify: Default sliders values are 1" })
	local slider = vgui.Create("DNumSlider", p)
	slider:SetSize(150, 32)
	slider:SetText("Damage coefficient")
	slider:SetMin(0.1)
	slider:SetMax(10)
	slider:SetDecimals(1)
	slider:SetConVar("dronesrewrite_admin_dmgcoef")

	p:AddItem(slider)

	local slider = vgui.Create("DNumSlider", p)
	slider:SetSize(150, 32)
	slider:SetText("Fuel consumption coefficient")
	slider:SetMin(0)
	slider:SetMax(10)
	slider:SetDecimals(1)
	slider:SetConVar("dronesrewrite_admin_fuelconscoef")

	p:AddItem(slider)

	local slider = vgui.Create("DNumSlider", p)
	slider:SetSize(150, 32)
	slider:SetText("Speed coefficient")
	slider:SetMin(0.1)
	slider:SetMax(10)
	slider:SetDecimals(1)
	slider:SetConVar("dronesrewrite_admin_speedcoef")

	p:AddItem(slider)

	local slider = vgui.Create("DNumSlider", p)
	slider:SetSize(150, 32)
	slider:SetText("Rotation speed coefficient")
	slider:SetMin(0.1)
	slider:SetMax(10)
	slider:SetDecimals(1)
	slider:SetConVar("dronesrewrite_admin_rotspeedcoef")

	p:AddItem(slider)

	local slider = vgui.Create("DNumSlider", p)
	slider:SetSize(150, 32)
	slider:SetText("Health coefficient")
	slider:SetMin(0.1)
	slider:SetMax(10)
	slider:SetDecimals(1)
	slider:SetConVar("dronesrewrite_admin_hpcoef")

	p:AddItem(slider)

	local slider = vgui.Create("DNumSlider", p)
	slider:SetSize(150, 32)
	slider:SetText("Signal coefficient")
	slider:SetMin(0.1)
	slider:SetMax(10)
	slider:SetDecimals(1)
	slider:SetConVar("dronesrewrite_admin_signalcoef")

	p:AddItem(slider)

	--[[p:AddControl("Label", { Text = "Tip: Update rate is delay between any action you do in drone and performing it on server. Higher values will increase performance and decrease comfort in control. Use this if you have low FPS while using drones. I recommend you skip this" })
	p:AddControl("CheckBox", { Label = "Use custom update rate", Command = "dronesrewrite_admin_customrate"})
	p:AddControl("Label", { Text = "Notify: Default slider value is 0" })
	local slider = vgui.Create("DNumSlider", p)
	slider:SetSize(150, 32)
	slider:SetText("Update rate")
	slider:SetMin(0)
	slider:SetMax(1)
	slider:SetDecimals(2)
	slider:SetConVar("dronesrewrite_admin_updrate")

	p:AddItem(slider)]]
end

hook.Add("PopulateToolMenu", "dronesrewrite_addmenuadmin", function() spawnmenu.AddToolMenuOption("Options", "Drones Settings", "dronesrewrite_admin", "Server", "", "", setup) end)