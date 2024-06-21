DRONES_REWRITE.ShowHelpWindow = function(open)
	local win = DRONES_REWRITE.CreateWindow(870, 500)
	win:SetSize(282, 500)
	win:SetupCloseButton()

	local anim = Derma_Anim("Sizing", win, function(pnl, anim, delta, data)
		pnl:SetSize(Lerp(delta, pnl:GetWide(), 870), 500)
		pnl:SetupCloseButton()
	end)

	local old = win.Think
	win.Think = function(self)
		old(self)
		if anim:Active() then anim:Run() end
	end

	local old = win.Paint
	win.Paint = function(win, w, h)
		old(win, w, h)

		local color = win.Animation and DRONES_REWRITE.Colors.Border or DRONES_REWRITE.Colors.Grey
		surface.SetDrawColor(color)
		surface.DrawLine(281, 25, 281, 500) -- Separate sections
	end

	local panel = DRONES_REWRITE.CreateScrollPanel(0, 25, 282, 474, win)
	local panellabs = DRONES_REWRITE.CreateScrollPanel(282, 25, 588, 475, win)

	panellabs.labs = { }
	panellabs.oldlabs = { }

	local anim2 = Derma_Anim("Alpha", panellabs, function(pnl, anim, delta, data)
		for k, v in pairs(pnl.oldlabs) do
			if IsValid(v) then
				v:SetAlpha(Lerp(delta, v:GetAlpha(), 0))
				if v:GetAlpha() <= 0 then v:Remove() end
			end
		end

		for k, v in pairs(pnl.labs) do
			if IsValid(v) then
				v:SetAlpha(Lerp(delta, v:GetAlpha(), 255))
			end
		end
	end)

	panellabs.Think = function(self)
		if anim2:Active() then anim2:Run() end
	end

	local count = 0
	local function CreateManual(label, open)
		local y = 1 + count * 31

		local btn = DRONES_REWRITE.CreateButton(label, 1, y, 280, 30, panel, function()
			if not win.Animation then
				anim:Start(1)
				win.Animation = true
			end

			for k, v in pairs(panellabs.labs) do
				table.insert(panellabs.oldlabs, v)
				panellabs.labs[k] = nil
			end

			open()

			anim2:Start(2)
			win:SetTitle(label)
		end)

		if open and open == label then
			btn.DoClick()
		end

		count = count + 1

		return btn
	end	

	for k, v in pairs(DRONES_REWRITE.Manuals) do
		CreateManual(v.label, function()
			for k, v in pairs(string.Explode("\n", v.text)) do
				local lab = DRONES_REWRITE.CreateLabel(v, 10, 10 + (k - 1) * 16, panellabs)
				lab:SetAlpha(0)
				table.insert(panellabs.labs, lab)
			end
		end)
	end

	-- TODO: uncomment later
	
	--[[local btn = CreateManual("Video", function()
		local HTML = vgui.Create("HTML", panellabs)
		HTML:SetHTML([[
			<iframe width="570" height="420" src="?autoplay=1" frameborder="0"></iframe>
		]] --[[)
		HTML:SetSize(600, 450)
		HTML:SetPos(0, 17)

		table.insert(panellabs.labs, HTML)
	end)

	btn:SetStaticColor(DRONES_REWRITE.Colors.DarkRed)
	btn:SetEnterColor(DRONES_REWRITE.Colors.LightRed)]]
end

local function setup(p)
	local icon = vgui.Create("DImageButton")
	icon:SetImage("stuff/drr")
	icon.DoClick = function()
		gui.OpenURL("http://steamcommunity.com/sharedfiles/filedetails/?id=669642096") 
	end
	p:AddItem(icon)

	local old = icon.PerformLayout
	icon.PerformLayout = function(self, w, h)
		old(self, w, h)
		self:SetSize(w, w)
	end

	local btn = DRONES_REWRITE.CreateButton("Show help window", 0, 0, 150, 30, p, function() DRONES_REWRITE.ShowHelpWindow() end)
	p:AddItem(btn)

	local btn = DRONES_REWRITE.CreateButton("Online help", 0, 0, 150, 30, p, function() 
		gui.OpenURL("http://steamcommunity.com/workshop/filedetails/discussion/669642096/364039531222857486/") 
	end)
	p:AddItem(btn)

	local btn = DRONES_REWRITE.CreateButton("Having issue? Let us know", 0, 0, 150, 30, p, function() 
		gui.OpenURL("http://steamcommunity.com/workshop/filedetails/discussion/669642096/364039531221413931/") 
	end)
	p:AddItem(btn)

	local btn = DRONES_REWRITE.CreateButton("Having idea? Let us know", 0, 0, 150, 30, p, function() 
		gui.OpenURL("http://steamcommunity.com/workshop/filedetails/discussion/669642096/364039531221418677/") 
	end)
	p:AddItem(btn)
end

hook.Add("PopulateToolMenu", "dronesrewrite_addmenuhelp", function() spawnmenu.AddToolMenuOption("Options", "Drones Settings", "dronesrewrite_help", "Help", "", "", setup) end)

concommand.Add("dronesrewrite_help", DRONES_REWRITE.ShowHelpWindow)