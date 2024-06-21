include("shared.lua")

local matLamp = Material("sprites/light_glow02_add_noz")

function ENT:Draw()
	if not (not self.RenderInCam and LocalPlayer() == self:GetDriver() and not self:GetNWBool("ThirdPerson") and self:GetMainCamera() == self:GetCamera()) then 
		self:DrawModel() 
	end
	
	if self:GetNWBool("Flashlight") then
		if not self.PixVis then
			self.PixVis = util.GetPixelVisibleHandle()
		end

		local cam = self:GetMainCamera()

		if IsValid(cam) then
			local LightNrm = self:GetAngles():Forward()
			local ViewNormal = self:GetPos() - EyePos()
			local Distance = ViewNormal:Length()
			ViewNormal:Normalize()
			local ViewDot = ViewNormal:Dot( LightNrm * -1 )
			local LightPos = cam:GetPos() - self:GetForward() * 4

			if ViewDot >= 0 then
				local Visibile = util.PixelVisible(LightPos, 16, self.PixVis)	
				if not Visibile then return end
					
				local Size = math.Clamp(Distance * Visibile * ViewDot, 0, 128)
				Distance = math.Clamp(Distance, 32, 800)
				local Alpha = math.Clamp((1000 - Distance) * Visibile * ViewDot, 0, 255)

				render.SetMaterial(matLamp)
				--cam.IgnoreZ(true)
					render.DrawSprite(LightPos, Size, Size, Color(255, 255, 255, Alpha), Visibile * ViewDot)
					render.DrawSprite(LightPos, Size * 2, Size * 0.4, Color(255, 255, 255, Alpha), Visibile * ViewDot)
				--cam.IgnoreZ(false)
			end
		end
	end

	if DRONES_REWRITE.ClientCVars.DrawAttachments:GetBool() and self.Attachments then
		cam.IgnoreZ(true)
			for k, v in pairs(self.Attachments) do 
				local pos = self:LocalToWorld(v.Pos)

				local ang = (EyePos() - pos):Angle()
				ang:RotateAroundAxis(ang:Up(), 90)
				ang:RotateAroundAxis(ang:Forward(), 90)

				cam.Start3D2D(pos, ang, 0.1)
					local ppos
					if v.Pos then
						ppos = v.Pos.x .. " " .. v.Pos.y .. " " .. v.Pos.z
					end

					if not ppos then ppos = "No pos" end

					local pang
					if v.Angle then
						pang = v.Angle.p .. " " .. v.Angle.y .. " " .. v.Angle.r
					end

					if not pang then pang = "No angle" end
					
					draw.SimpleText(k, "DronesRewrite_font3", -86, -64, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
					draw.SimpleText("Position: " .. ppos, "DronesRewrite_font3", -86, -32, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
					draw.SimpleText("Angle: " .. pang, "DronesRewrite_font3", -86, 0, Color(255, 255, 255), TEXT_ALIGN_RIGHT)

					surface.SetDrawColor(Color(255, 255, 255))
					surface.SetMaterial(Material("stuff/whiteboxhud/target"))
					surface.DrawTexturedRect(-64, -64, 128, 128)
				cam.End3D2D()
			end
		cam.IgnoreZ(false)
	end
end

function ENT:DrawIndicator(index, val)
	if not self.HUD_indicators then self.HUD_indicators = { } end
	if not self.HUD_indicators[index] then self.HUD_indicators[index] = table.Count(self.HUD_indicators) end

	if val >= 100 then 
		self.HUD_indicators = nil
		return 
	end

	local x, y = ScrW() / 2 - 128, ScrH() - 86 - self.HUD_indicators[index] * 90
	local w, h = 256, 32

	draw.SimpleText(index .. ": " .. val .. "%", "DronesRewrite_font3", x + 128, y - 42, Color(0, 255, 255, 150), TEXT_ALIGN_CENTER)
						
	surface.SetDrawColor(Color(0, 150, 255, 200))
	surface.DrawOutlinedRect(x - 2, y - 2, w + 4, h + 4)
	surface.DrawRect(x, y, val * 2.56, h)
end

function ENT:GetOverlayName()
	local overlayname = self.OverlayName
	if not DRONES_REWRITE.ClientCVars.OverlayDef:GetBool() then
		overlayname = DRONES_REWRITE.ClientCVars.CustomOverlay:GetString()
	end

	return overlayname
end

function ENT:GetHUDName()
	local hudname = self.HUD_hudName
	if not DRONES_REWRITE.ClientCVars.HUD_useDef:GetBool() then 
		hudname = DRONES_REWRITE.ClientCVars.HUD_customHud:GetString()
	end

	return hudname
end

function ENT:CallBindMenu()
	net.Start("dronesrewrite_requestweapons")
		net.WriteEntity(self)
		net.WriteString("dronesrewrite_openbindsmenu")
		net.WriteBit(false)
	net.SendToServer()
end

function ENT:OpenBindsMenu(weps)
	if not weps then return end

	local win = DRONES_REWRITE.CreateWindow(200, 180)
	local p = DRONES_REWRITE.CreateScrollPanel(0, 26, 200, 154, win)

	local function foo(btn, v, isLeftKey)
		timer.Create("dronesrewritekey", 0.1, 1, function()
			if not btn then return end

			if isLeftKey == "unbind" then
				net.Start("dronesrewrite_makebind")
					net.WriteEntity(self)
					net.WriteBit(false)
					net.WriteString(v)
				net.SendToServer()

				return
			end

			btn:SetText("PRESS ANY BUTTON")
			btn:SetEnabled(false)

			hook.Add("DronesRewriteKey", "dronesrewrite_bindwep", function(key, pressed)
				local key = DRONES_REWRITE.KeyNames[key]

				net.Start("dronesrewrite_makebind")
					net.WriteEntity(self)
					net.WriteBit(isLeftKey)
					net.WriteString(v)
					net.WriteString(key)
				net.SendToServer()

				if IsValid(btn) then
					btn:SetEnabled(true)
					btn:SetText(v .. " - " .. key)
				end

				hook.Remove("DronesRewriteKey", "dronesrewrite_bindwep")
			end)
		end)
	end

	for k, v in pairs(weps) do
		local btn = DRONES_REWRITE.CreateButton(v, 0, (k - 1) * 21, 200, 20, p, function(btn)
			local menu = DermaMenu()

			menu:AddOption("Bind Attack1", function()
				foo(btn, v, true)
			end)

			menu:AddOption("Bind Attack2", function()
				foo(btn, v, false)
			end)

			menu:AddOption("Unbind", function()
				foo(btn, v, "unbind")
			end)

			menu:Open()
		end)
	end
end

function ENT:CallWeaponsMenu()
	if not LocalPlayer():IsAdmin() then LocalPlayer():ChatPrint("[Drones] You're not admin!") return end

	net.Start("dronesrewrite_requestweapons")
		net.WriteEntity(self)
		net.WriteString("dronesrewrite_openweaponscustom")
		net.WriteBit(true)
	net.SendToServer()
end

function ENT:OpenWeaponsMenu(weps)
	if not LocalPlayer():IsAdmin() then LocalPlayer():ChatPrint("[Drones] You're not admin!") return end
	--if not weps then return end

	local win = DRONES_REWRITE.CreateWindow(500, 460)

	local old = win.Paint
	win.Paint = function(win)
		old(win)
		draw.RoundedBox(0, 0, 25, 200, 445, DRONES_REWRITE.Colors.DarkGrey2)

		surface.SetDrawColor(DRONES_REWRITE.Colors.Border)

		surface.DrawLine(200, 25, 200, 460) -- Separate sections
		surface.DrawLine(0, 225, 200, 225) -- Separate menus
		surface.DrawLine(0, 259, 200, 259) -- Separate menus 2
	end

	local wepslist = DRONES_REWRITE.CreateScrollPanel(0, 25, 200, 200, win)

	DRONES_REWRITE.CreateLabel(self:GetUnit() .. "'s weapons:", 20, 235, win)
	local lab = DRONES_REWRITE.CreateLabel("No selected weapon!", 220, 35, win)

	local existweps = DRONES_REWRITE.CreateScrollPanel(0, 260, 200, 200, win)

	local addWep = ""
	local sync = { }

	local i = 0
	for k, v in pairs(DRONES_REWRITE.Weapons) do
		if k == "Template" then continue end -- Weapon that users shouldnt know about

		local btn = DRONES_REWRITE.CreateButton(k, 0, i * 31, 200, 30, wepslist, function() -- k is 1 first not 0 but we need 0
			addWep = k

			if lab then 
				lab:Remove() 
				lab = nil 
			end

			lab = DRONES_REWRITE.CreateLabel("Selected weapon: " .. k, 220, 35, win)
		end)

		i = i + 1
	end

	local btns = { }

	local function AddWeps()
		if not weps then weps = { } end
		if btns then
			for k, v in pairs(btns) do
				if IsValid(v) then v:Remove() end
			end

			table.Empty(btns)
		end

		local i = 0

		for k, v in pairs(weps) do
			local btn = DRONES_REWRITE.CreateButton(v, 0, i * 31, 200, 30, existweps, function() 
				if not sync[v] then sync[v] = { } end

				local menu = DermaMenu()
				menu:AddOption("Bind " .. addWep .. " weapon Attack1 to this " .. v .. " Attack1", function() sync[v].fire1 = "fire1" end)
				menu:AddOption("Bind " .. addWep .. " weapon Attack1 to this " .. v .. " Attack2", function() sync[v].fire2 = "fire1" end)
				menu:AddOption("Bind " .. addWep .. " weapon Attack2 to this " .. v .. " Attack1", function() sync[v].fire1 = "fire2" end)
				menu:AddOption("Bind " .. addWep .. " weapon Attack2 to this " .. v .. " Attack2", function() sync[v].fire2 = "fire2" end)

				menu:AddOption("Remove all chosen binds", function() sync[v] = nil end)

				menu:AddOption("Remove", function()
					net.Start("dronesrewrite_removeweapon")
						net.WriteEntity(self)
						net.WriteString(v)
					net.SendToServer()

					weps[k] = nil

					AddWeps()
				end)

				menu:Open()
			end)

			i = i + 1

			btns[i] = btn
		end
	end

	AddWeps()

	local sel = vgui.Create("DCheckBox", win)
	sel:SetPos(220, 110)
	sel:SetValue(1)
	DRONES_REWRITE.CreateLabel("Should be visible in weapon selection menu", 240, 110, win)

	local prims = vgui.Create("DCheckBox", win)
	prims:SetPos(220, 130)
	prims:SetValue(0)
	DRONES_REWRITE.CreateLabel("Primary ammo as secondary", 240, 130, win)

	DRONES_REWRITE.CreateLabel("Position", 220, 150, win)

	local pos = { "X", "Y", "Z" }
	local sliders = { }

	for k, v in pairs(pos) do
		local slider = vgui.Create("DNumSlider", win)
		slider:SetSize(220, 30)
		slider:SetPos(220, 150 + k * 20)
		slider:SetText(v)
		slider:SetMin(-5000)
		slider:SetMax(5000)
		slider:SetDecimals(0)
		slider:SetValue(0)
		slider.Label:SetFont("DronesRewrite_customfont1")

		sliders[k] = slider
	end

	DRONES_REWRITE.CreateLabel("Angle", 220, 240, win)

	local ang = { "P", "Y", "R" }
	local slidersa = { }

	for k, v in pairs(ang) do
		local slider = vgui.Create("DNumSlider", win)
		slider:SetSize(220, 30)
		slider:SetPos(220, 240 + k * 20)
		slider:SetText(v)
		slider:SetMin(-180)
		slider:SetMax(180)
		slider:SetDecimals(0)
		slider:SetValue(0)
		slider.Label:SetFont("DronesRewrite_customfont1")

		slidersa[k] = slider
	end

	local menu = vgui.Create("DComboBox", win)
	menu:SetSize(260, 25)
	menu:SetPos(220, 350)

	if self.Attachments then
		menu:SetText("Choose attachment")

		for k, v in pairs(self.Attachments) do
			menu:AddChoice(k)
		end
	else
		menu:SetText("No attachments found")
	end

	local del = true
	local text = vgui.Create("DTextEntry", win)
	text:SetSize(260, 25)
	text:SetPos(220, 380)
	text:SetText("Weapon name")
	text.OnGetFocus = function() 
		if del then text:SetText("") del = false end
	end

	local datt = vgui.Create("DCheckBox", win)
	datt:SetPos(220, 420)
	datt:SetValue(0)
	datt:SetConVar("dronesrewrite_cl_drawattachments")
	DRONES_REWRITE.CreateLabel("Draw attachments", 240, 420, win)

	local btn = DRONES_REWRITE.CreateButton("How to bind", 358, 415, 120, 25, win, function()
		DRONES_REWRITE.ShowHelpWindow("Binding weapons")
	end)

	local btn = DRONES_REWRITE.CreateButton("Add", 220, 60, 260, 40, win, function() -- k is 1 first not 0 but we need 0
		local ang = Angle(slidersa[1]:GetValue(), slidersa[2]:GetValue(), slidersa[3]:GetValue())
		local pos = Vector(sliders[1]:GetValue(), sliders[2]:GetValue(), sliders[3]:GetValue())
		local name = text:GetValue()

		net.Start("dronesrewrite_addweapon")
			net.WriteEntity(self)
			net.WriteString(name)
			net.WriteString(addWep)

			net.WriteAngle(ang)
			net.WriteVector(pos)
			net.WriteTable(sync)

			net.WriteBool(sel:GetChecked())
			net.WriteBool(prims:GetChecked())
			
			net.WriteString(menu:GetValue())
		net.SendToServer()

		table.insert(weps, name)
		AddWeps()
	end)
end

function ENT:IsFull(slot)
	local count = self.Slots[slot] or 9999
	return self:GetNWInt("SlotCount" .. slot) >= count
end

function ENT:OpenUpgradesMenu()
	--sync = sync or 1
	local selected = ""

	local win = DRONES_REWRITE.CreateWindow(365, 490)
	local oldpaint = win.Paint
	win.Paint = function(win)
		oldpaint(win)
		draw.RoundedBox(0, 0, 360, 365, 130, DRONES_REWRITE.Colors.DarkGrey2)
	end

	local old = win.Think
	win.Think = function(win) 
		old(win)
		if not self:IsValid() then win:Close() end 
	end

	local panel = DRONES_REWRITE.CreateScrollPanel(0, 25, 365, 335, win)

	local btns = { }
	local slots = { }

	local function UpdateBtns()
		for k, v in pairs(btns) do if IsValid(v) then v:Remove() end end
		btns = { }

		local i = 0

		local found = false
		for k, v in SortedPairsByMemberValue(self.Modules, "Slot", false) do
			if not v.System and not self:GetNWBool("hasModule" .. k) then continue end

			local slot = v.Slot or "System"
			local y = 1 + i * 31

			table.insert(btns, DRONES_REWRITE.CreateButton(k, 1, y, 170, 30, panel, function() end))
			table.insert(btns, DRONES_REWRITE.CreateButton(slot, 172, y, 125, 30, panel, function() end))

			local remove = vgui.Create("DButton", panel)
			remove:SetPos(315, y)
			remove:SetSize(30, 30)
			remove:SetText("")

			if slot != "System" then
				remove.DoClick = function()
					net.Start("dronesrewrite_addmodule")
						net.WriteEntity(self)
						net.WriteString(k)
						net.WriteBit(false)
					net.SendToServer()

					timer.Simple(0.15, function() UpdateBtns() end)
				end
			end
			remove.Paint = function(remove, w, h)
				local color = DRONES_REWRITE.Colors.Green
				if slot == "System" then color = DRONES_REWRITE.Colors.DarkGrey end

				surface.SetMaterial(Material("stuff/cross"))
				surface.SetDrawColor(color)
				surface.DrawTexturedRect(4, 4, w - 8, h - 8)
			end
			table.insert(btns, remove)

			i = i + 1
			found = true
		end

		if not found then
			win:SetTitle("No module installed!")
		end

		for k, v in pairs(slots) do if IsValid(v) then v:Remove() end end
		slots = { }

		DRONES_REWRITE.CreateLabel("Slots list and limits", 240, 366, win)

		for k, v in pairs(self.Slots) do
			if type(v) != "table" then -- Hotfix for BaseClass
				local lab = DRONES_REWRITE.CreateLabel(k .. " " .. self:GetNWInt("SlotCount" .. k) .. "/" .. v, 10, 350 + (table.Count(slots) + 1) * 16, win)
				lab:SetColor(DRONES_REWRITE.Colors.LightGrey)

				slots[k] = lab

				local oldshit
				slots[k].Think = function()
					if self:GetNWInt("SlotCount" .. k) != oldshit then
						slots[k]:SetText(k .. " " .. self:GetNWInt("SlotCount" .. k) .. "/" .. v)
						slots[k]:SizeToContents()

						oldshit = self:GetNWInt("SlotCount" .. k)
					end
				end
			end
		end
	end

	UpdateBtns()
end

ENT.selected = 1

function ENT:OpenSelectionMenu(weps)
	if not weps then surface.PlaySound("common/wpn_denyselect.wav") return end
	if self._SelectingWep == -1 then return end
	self._SelectingWep = -1

	surface.PlaySound("vehicles/atv_ammo_open.wav")

	local btns = { }

	local posx = 0
	local posy = 0

	local function close()
		if IsValid(self) then self._SelectingWep = 0 end
		for k, v in pairs(btns) do v:Remove() end

		hook.Remove("DronesRewriteKey", "dronesrewrite_selectwep_gui")
		hook.Remove("Think", "dronesrewrite_selectwep_gui_sel")
	end

	local function select()
		surface.PlaySound("common/wpn_moveselect.wav")
		timer.Create("dronesrewrite_selectwep_gui_close" .. self:EntIndex(), 1.5, 1, function() close() end)

		if self.selected < 1 then self.selected = #weps end
		if self.selected > #weps then self.selected = 1 end
	end

	select()

	for k, v in pairs(weps) do
		local btn = DRONES_REWRITE.CreateButton(string.upper(v), 15 + posx * 210, 30 + posy * 74, 200, 64, nil, function()
			if IsValid(self) then
				net.Start("dronesrewrite_changewep")
					net.WriteString(v)
				net.SendToServer()
			end

			self.selected = k

			close()
		end)

		btn:SetFont("DronesRewrite_font6")

		local paint = btn.Paint
		btn.Paint = function(btn)	
			paint(btn)

			if self.selected == k then
				draw.RoundedBox(0, 0, 0, btn:GetWide(), btn:GetTall(), DRONES_REWRITE.Colors.LightBlue)
			end
		end

		table.insert(btns, btn)

		posx = posx + 1

		if posx > 5 then 
			posx = 0
			posy = posy + 1
		end
	end

	local old = self.selected
	hook.Add("Think", "dronesrewrite_selectwep_gui_sel", function(ply, bind, p)
		if not IsValid(self) then hook.Remove("Think", "dronesrewrite_selectwep_gui_sel") return end
		if old != self.selected then select() old = self.selected end
	end)

	if DRONES_REWRITE.ClientCVars.QuickSel:GetBool() then
		for k, v in pairs(btns) do
			if self.selected == k then
				v.DoClick()
				break
			end
		end
	else
		hook.Add("DronesRewriteKey", "dronesrewrite_selectwep_gui", function(key, pressed)
			if not IsValid(self) then hook.Remove("DronesRewriteKey", "dronesrewrite_selectwep_gui") return end
			if not pressed then return end

			local key = DRONES_REWRITE.KeyNames[key]

			if key == "Mouse Left" then
				for k, v in pairs(btns) do
					if self.selected == k then
						v.DoClick()
						break
					end
				end
			end
		end)
	end
end