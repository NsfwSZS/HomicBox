local keys = { }
for i = 0, 113 do
	keys[i] = false
end

hook.Add("Think", "dronesrewrite_cl_keys", function()
	for i = 0, 113 do
		local oldpressed = keys[i]
		keys[i] = i >= 107 and input.IsMouseDown(i) or input.IsKeyDown(i)

		if oldpressed != keys[i] then
			hook.Run("DronesRewriteKey", i, keys[i])
		end
	end
end)

hook.Add("DronesRewriteKey", "dronesrewrite_controlkeys", function(key, pressed)
	local send = pressed
	if vgui.CursorVisible() and pressed then send = false end

	local ply = LocalPlayer()
	local drone = ply:GetNWEntity("DronesRewriteDrone")

	if drone:IsValid() then
		net.Start("dronesrewrite_keyvalue")
			net.WriteUInt(key, 7)
			net.WriteBit(send)
		net.SendToServer()

		DRONES_REWRITE.LogDebug(string.format("Pressing key %i %s", key, tostring(send)))
	end
end)

local function setup(p)
	--[[p.btns = { }

	for k, bind in pairs(DRONES_REWRITE.SortedKeys) do
		local text = bind .. " : " .. string.upper(input.GetKeyName(DRONES_REWRITE.ClientCVars.Keys[bind]:GetString()))

		p.btns[bind] = DRONES_REWRITE.CreateButton(text, 0, 0, 150, 30, p, function()
			timer.Create("dronesrewritekey", 0.1, 1, function()
				p.btns[bind]:SetText("PRESS ANY BUTTON")

				hook.Add("DronesRewriteKey", "dronesrewrite_controlkeysset", function(key, pressed)
					RunConsoleCommand("dronesrewrite_key_" .. bind, key)
					p.btns[bind]:SetText(bind .. " : " .. string.upper(input.GetKeyName(key)))

					hook.Remove("DronesRewriteKey", "dronesrewrite_controlkeysset")
				end)
			end)
		end)

		p:AddItem(p.btns[bind])
	end]]

	local d = vgui.Create("DListView")
	d:SetSize(150, 400)
	d:AddColumn("Bind")
	d:AddColumn("Key")

	for k, v in pairs(DRONES_REWRITE.SortedKeys) do
		d:AddLine(v, string.upper(input.GetKeyName(DRONES_REWRITE.ClientCVars.Keys[v]:GetString())))
	end

	d.OnClickLine = function(parent, line, isselected)
		local bind = line:GetValue(1)

		timer.Create("dronesrewritekey", 0.1, 1, function()
			line:SetValue(2, "PRESS ANY BUTTON")

			hook.Add("DronesRewriteKey", "dronesrewrite_controlkeysset", function(key, pressed)
				RunConsoleCommand("dronesrewrite_key_" .. bind, key)

				line:SetValue(2, string.upper(input.GetKeyName(key)))

				hook.Remove("DronesRewriteKey", "dronesrewrite_controlkeysset")
			end)
		end)
	end

	p:AddItem(d)

	local btn = DRONES_REWRITE.CreateButton("Set to default", 0, 0, 150, 30, p, function()
		d:Clear()

		for bind, key in pairs(DRONES_REWRITE.Keys) do
			RunConsoleCommand("dronesrewrite_key_" .. bind, key)
			d:AddLine(bind, string.upper(input.GetKeyName(key)))
		end
	end)

	p:AddItem(btn)
end

hook.Add("PopulateToolMenu", "dronesrewrite_addmenukeys", function() spawnmenu.AddToolMenuOption("Options", "Drones Settings", "dronesrewrite_keys", "Controls / Keys", "", "", setup) end)