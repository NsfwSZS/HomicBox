local camOrientation = {
	"Right",
	"Left",
	"Center"
}

local camOrientation2 = {
	"Right",
	"Left",
	"Center",
	"Down"
}

local function setup(p)
	p:AddControl("CheckBox", { Label = "Disable glow effects", Command = "dronesrewrite_cl_noglows"})
	p:AddControl("CheckBox", { Label = "Disable console window", Command = "dronesrewrite_cl_noconwin"})
	p:AddControl("CheckBox", { Label = "Disable console renderer", Command = "dronesrewrite_cl_noconrender"})
	p:AddControl("CheckBox", { Label = "Disable hints", Command = "dronesrewrite_cl_nomessage"})
	p:AddControl("CheckBox", { Label = "Disable drones' view renderer in console", Command = "dronesrewrite_cl_noscreen"})
	p:AddControl("CheckBox", { Label = "Casual thirdperson", Command = "dronesrewrite_cl_deftp"})
	p:AddControl("CheckBox", { Label = "Draw thirdperson crosshair", Command = "dronesrewrite_cl_crosshairtp"})
	p:AddControl("CheckBox", { Label = "Mouse rotation (i recommend not to use this)", Command = "dronesrewrite_cl_mouserotation"})
	p:AddControl("CheckBox", { Label = "Quick weapon selection", Command = "dronesrewrite_cl_quickwepsel"})
	p:AddControl("CheckBox", { Label = "Disable muzzleflash effect", Command = "dronesrewrite_cl_dismuzzleflash"})
	p:AddControl("CheckBox", { Label = "Enable attachments' drawing", Command = "dronesrewrite_cl_drawattachments"})

	p:AddControl("Label", { Text = "Notify: Default slider value is 1" })
	local slider = vgui.Create("DNumSlider", p)
	slider:SetSize(150, 32)
	slider:SetText("Camera distance increment")
	slider:SetMin(-100)
	slider:SetMax(200)
	slider:SetDecimals(0)
	slider:SetConVar("dronesrewrite_cl_cameradistance")

	p:AddItem(slider)

	p:AddControl("Label", { Text = "Notify: Default slider value is 16" })
	local slider = vgui.Create("DNumSlider", p)
	slider:SetSize(150, 32)
	slider:SetText("Mouse rotation limit")
	slider:SetMin(0)
	slider:SetMax(180)
	slider:SetDecimals(0)
	slider:SetConVar("dronesrewrite_cl_mouselimit")

	p:AddItem(slider)

	-- Thirdperson
	local orientation = vgui.Create("DComboBox", p)
	orientation:SetText("Third person cam orientation " .. DRONES_REWRITE.ClientCVars.CamOrientation:GetString())
	
	for k, v in pairs(camOrientation) do
		orientation:AddChoice(v)
	end
	
	orientation.OnSelect = function(p, index, val)
		val = tostring(val)
		orientation:SetText("Third person cam orientation " .. val)
		RunConsoleCommand("dronesrewrite_cl_camorientation", val)
	end

	p:AddItem(orientation)

 	-- Weapon view
 	local orientation = vgui.Create("DComboBox", p)
	orientation:SetText("Weapon view cam orientation " .. DRONES_REWRITE.ClientCVars.WvCamOrientation:GetString())
	
	for k, v in pairs(camOrientation2) do
		orientation:AddChoice(v)
	end
	
	orientation.OnSelect = function(p, index, val)
		val = tostring(val)
		orientation:SetText("Weapon view cam orientation " .. val)
		RunConsoleCommand("dronesrewrite_cl_wvcamorientation", val)
	end
	
	p:AddItem(orientation)

	p:AddControl("CheckBox", { Label = "Draw drones HUD", Command = "dronesrewrite_hud_drawhud"})
	p:AddControl("CheckBox", { Label = "Draw Crosshair", Command = "dronesrewrite_hud_drawcrosshair"})
	p:AddControl("CheckBox", { Label = "Draw Health", Command = "dronesrewrite_hud_drawhealth"})
	p:AddControl("CheckBox", { Label = "Draw Fuel", Command = "dronesrewrite_hud_drawfuel"})
	p:AddControl("CheckBox", { Label = "Draw Targets", Command = "dronesrewrite_hud_drawtargets"})
	p:AddControl("CheckBox", { Label = "Draw Damage", Command = "dronesrewrite_hud_drawdamage"})

	-- Removed
	--p:AddControl("CheckBox", { Label = "Draw Radar", Command = "dronesrewrite_hud_drawradar"})
	
	p:AddControl("CheckBox", { Label = "Draw Center", Command = "dronesrewrite_hud_drawcenter"})
	p:AddControl("CheckBox", { Label = "Draw Weapons", Command = "dronesrewrite_hud_drawweps"})

	p:AddControl("Label", { Text = " "})

	p:AddControl("CheckBox", { Label = "Use Default HUD", Command = "dronesrewrite_hud_usedefault"})
	local d = vgui.Create("DListView")
	d:SetSize(150, 200)
	d:AddColumn("HUD")
	for k, v in pairs(DRONES_REWRITE.HUD) do d:AddLine(k) end
	d.OnClickLine = function(parent, line, isselected) RunConsoleCommand("dronesrewrite_curhud", line:GetValue(1)) end
	p:AddItem(d)

	p:AddControl("CheckBox", { Label = "Use Default Overlay", Command = "dronesrewrite_overlay_usedefault"})
	d = vgui.Create("DListView")
	d:SetSize(150, 200)
	d:AddColumn("Overlay")
	for k, v in pairs(DRONES_REWRITE.Overlay) do d:AddLine(k) end
	d.OnClickLine = function(parent, line, isselected) RunConsoleCommand("dronesrewrite_curoverlay", line:GetValue(1)) end
	p:AddItem(d)
end

hook.Add("PopulateToolMenu", "dronesrewrite_addmenuclient", function() spawnmenu.AddToolMenuOption("Options", "Drones Settings", "dronesrewrite_client", "Client", "", "", setup) end)