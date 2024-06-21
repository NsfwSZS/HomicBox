DRONES_REWRITE.AI.Friends = { }

DRONES_REWRITE.AI.ShowMenuPlayers = function()
	local win = DRONES_REWRITE.CreateWindow(400, 500)
	win.OnCloseButton = function()
		net.Start("dronesrewrite_addfriends")
			net.WriteTable(DRONES_REWRITE.AI.Friends)
		net.SendToServer()
	end
	
	local players = DRONES_REWRITE.CreateScrollPanel(0, 25, 400, 200, win)
	local friends = DRONES_REWRITE.CreateScrollPanel(0, 265, 400, 235, win)

	local i = 0

	local units = { }
	table.Add(units, player.GetAll())
	table.Add(units, DRONES_REWRITE.GetDrones())

	for k, v in pairs(units) do
		if not table.HasValue(DRONES_REWRITE.AI.Friends, v) then
			local id = v:IsPlayer() and v:Name() or v:GetUnit()
			local btn = DRONES_REWRITE.CreateButton("ADD " .. id, 0, 1 + i * 21, 400, 20, players, function()
				if not table.HasValue(DRONES_REWRITE.AI.Friends, v) then 
					table.insert(DRONES_REWRITE.AI.Friends, v) 

					win:Close()
					DRONES_REWRITE.AI.ShowMenuPlayers()
				end
			end)

			i = i + 1
		end
	end

	local lab = DRONES_REWRITE.CreateLabel("Friends | Close to apply", 15, 225, win)
	lab:SetFont("DronesRewrite_customfont1_1")
	lab:SizeToContents()

	for k, v in pairs(DRONES_REWRITE.AI.Friends) do
		if not IsValid(v) then continue end
		
		local id = v:IsPlayer() and v:Name() or v:GetUnit()
		local btn = DRONES_REWRITE.CreateButton("REMOVE " .. id, 0, k * 21 - 20, 400, 20, friends, function()
			table.RemoveByValue(DRONES_REWRITE.AI.Friends, v)

			win:Close()
			DRONES_REWRITE.AI.ShowMenuPlayers()
		end)
	end
end

local function setup(p)
	p:AddControl("CheckBox", { Label = "Do not attack NPCs", Command = "dronesrewrite_ai_noattacknpcs"})
	p:AddControl("CheckBox", { Label = "Do not attack any player", Command = "dronesrewrite_ai_noattackplayers"})
	p:AddControl("CheckBox", { Label = "Do not attack drones", Command = "dronesrewrite_ai_noattackdrones"})
	p:AddControl("CheckBox", { Label = "Do not attack friend's stuff", Command = "dronesrewrite_ai_noattackfr"})
	p:AddControl("CheckBox", { Label = "Attack owner", Command = "dronesrewrite_ai_attackowner"})

	p:AddControl("Label", { Text = "Notify: Default slider value is 3000" })
	local slider = vgui.Create("DNumSlider", p)
	slider:SetSize(150, 32)
	slider:SetText("Find radius")
	slider:SetMin(100)
	slider:SetMax(5000)
	slider:SetDecimals(0)
	slider:SetConVar("dronesrewrite_ai_radius")

	p:AddItem(slider)

	p:AddControl("Label", { Text = "Notify: Default slider value is 100" })
	local slider = vgui.Create("DNumSlider", p)
	slider:SetSize(150, 32)
	slider:SetText("Z Distance")
	slider:SetMin(100)
	slider:SetMax(5000)
	slider:SetDecimals(0)
	slider:SetConVar("dronesrewrite_ai_flyzdistance")

	p:AddItem(slider)

	local btn = DRONES_REWRITE.CreateButton("Show friends settings", 0, 0, 150, 30, p, function() DRONES_REWRITE.AI.ShowMenuPlayers() end)
	p:AddItem(btn)
end

hook.Add("PopulateToolMenu", "dronesrewrite_addmenuai", function() spawnmenu.AddToolMenuOption("Options", "Drones Settings", "dronesrewrite_ai", "AI", "", "", setup) end)