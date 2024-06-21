if SERVER then
	util.AddNetworkString("dronesrewrite_keyvalue")
	util.AddNetworkString("dronesrewrite_addweapon")

	-- New net system

	-- Main requests
	-- Keys
	net.Receive("dronesrewrite_keyvalue", function(len, ply)
		local key = net.ReadUInt(7)
		local pressed = net.ReadBit()

		local drone = ply:GetNWEntity("DronesRewriteDrone")

		if drone:IsValid() then 
			local bind = DRONES_REWRITE.KeyNames[key]

			if bind then 
				if not drone.Keys[bind] then drone.Keys[bind] = { } end
				drone.Keys[bind].Pressed = tobool(pressed)
			end

			for k, v in pairs(DRONES_REWRITE.Keys) do
				if ply:GetInfoNum("dronesrewrite_key_" .. k, 0) == key then
					if not drone.Keys[k] then drone.Keys[k] = { } end
					drone.Keys[k].Pressed = tobool(pressed)

					break
				end
			end
		end
	end)

	net.Receive("dronesrewrite_addweapon", function(len, ply)
		if not ply:IsAdmin() then return end

		local drone = net.ReadEntity()
		if not IsValid(drone) then return end

		local wepName = net.ReadString()
		local wep = net.ReadString()
		if not DRONES_REWRITE.Weapons[wep] then return end

		local ang = net.ReadAngle()
		local pos = net.ReadVector()
		local sync = net.ReadTable()

		local select = net.ReadBool()
		local prims = net.ReadBool()

		local att = net.ReadString()

		drone:FastAddWeapon(wepName, wep, pos, sync, ang, select, prims, att)
	end)


	-- Clientside
	util.AddNetworkString("dronesrewrite_helppls")
	util.AddNetworkString("dronesrewrite_helppls2")
	util.AddNetworkString("dronesrewrite_updcam")
	util.AddNetworkString("dronesrewrite_playsound")
	util.AddNetworkString("dronesrewrite_doprecache")
	util.AddNetworkString("dronesrewrite_closeconsole")
	util.AddNetworkString("dronesrewrite_opencontroller")
	util.AddNetworkString("dronesrewrite_clearconsole")
	util.AddNetworkString("dronesrewrite_openconsole")
	util.AddNetworkString("dronesrewrite_addline")
	util.AddNetworkString("dronesrewrite_removehook")
	util.AddNetworkString("dronesrewrite_addhook")
	util.AddNetworkString("dronesrewrite_openselectmenu")
	util.AddNetworkString("dronesrewrite_openbindsmenu")
	util.AddNetworkString("dronesrewrite_openweaponscustom")
	util.AddNetworkString("dronesrewrite_sniperrifle")
	util.AddNetworkString("dronesrewrite_sniperrifle_crosshair")

	-- Serverside
	util.AddNetworkString("dronesrewrite_addfriend")
	util.AddNetworkString("dronesrewrite_controldr")
	util.AddNetworkString("dronesrewrite_controllerlookup")
	util.AddNetworkString("dronesrewrite_conexit")
	util.AddNetworkString("dronesrewrite_concmd")
	util.AddNetworkString("dronesrewrite_makebind")
	util.AddNetworkString("dronesrewrite_requestweapons")
	util.AddNetworkString("dronesrewrite_addfriends")
	util.AddNetworkString("dronesrewrite_removeweapon")
	util.AddNetworkString("dronesrewrite_changewep")
	util.AddNetworkString("dronesrewrite_addmodule")
	util.AddNetworkString("dronesrewrite_clickkey")
end

if SERVER then
	net.Receive("dronesrewrite_addfriend", function(len, ply)
		local drone = net.ReadEntity()
		local guy = net.ReadEntity()

		if not IsValid(drone) then return end
		if not drone:CanBeControlledBy_skipai(ply) then ply:ChatPrint("[Drones] You're not owner of this drone!") return end

		if not drone.DRRFriendsControlling then drone.DRRFriendsControlling = { } end

		if not IsValid(guy) then ply:ChatPrint("[Drones] Invalid player!") return end

		if table.HasValue(drone.DRRFriendsControlling, guy:SteamID()) then
			table.RemoveByValue(drone.DRRFriendsControlling, guy:SteamID())
			ply:ChatPrint(guy:Name() .. " has been removed from friends!")

			local friends = { }
			for k, v in pairs(drone.DRRFriendsControlling) do
				local ply = player.GetBySteamID(v)
				if ply:IsValid() then table.insert(friends, ply:Name()) end
			end

			if next(friends) == nil then return end

			ply:ChatPrint("Current friends: " .. table.concat(friends, ", "))
		else
			table.insert(drone.DRRFriendsControlling, guy:SteamID())
			ply:ChatPrint(guy:Name() .. " has been added to friends!")
		end
	end)

	net.Receive("dronesrewrite_controldr", function(len, ply)
		local con = net.ReadEntity()
		local drone = con.Drone
		if IsValid(drone) then drone:SetDriver(ply, con.DistanceMaxDRR, con) end
	end)

	net.Receive("dronesrewrite_controllerlookup", function(len, ply)
		local con = net.ReadEntity()
		local unit = net.ReadString()

		if not IsValid(con) then return end

		local drone = DRONES_REWRITE.FindDroneByUnit(unit)
		if IsValid(drone) and not drone:CanBeControlledBy(ply) then return end

		con:SetDrone(drone)
	end)

	net.Receive("dronesrewrite_conexit", function(len, ply)
		local con = net.ReadEntity()

		if not IsValid(con) then return end

		if con:GetClass() != "dronesrewrite_console" then return end
		if ply != con.User then return end
		
		con:Exit()
	end)

	net.Receive("dronesrewrite_concmd", function(len, ply)
		local console = net.ReadEntity()
		local cmd = net.ReadString()
		local unk = net.ReadString()

		if not IsValid(console) then return end

		local _args = string.Explode(" ", unk)
		if console:GetClass() != "dronesrewrite_console" then return end
		if not IsValid(console.User) then return end
		if ply != console.User then return end

		if console.CatchCommand and not console.CatchCommand(console, _args, string.lower(cmd)) then
			return
		end

		if console.Commands[string.lower(cmd)] then 
			console.Commands[string.lower(cmd)](console, _args)
		else
			console:AddLine("Unknown command: " .. cmd)
		end
	end)

	net.Receive("dronesrewrite_makebind", function(len, ply)
		local drone = net.ReadEntity()
		local isLeftBtn = tobool(net.ReadBit())
		local wepName = net.ReadString()
		local key = net.ReadString()

		if not IsValid(drone) then return end
		if not drone:CanBeControlledBy(ply) then return end

		local wep = drone.ValidWeapons[wepName]

		if wep.Key then drone:FastRemoveBind(wep.Key, wepName .. "_binds") end
		if wep.Key2 then drone:FastRemoveBind(wep.Key2, wepName .. "_binds") end

		if not key then return end

		if IsValid(wep) then
			if isLeftBtn then 
				wep.Key = key 

				drone:AddKeyBind(key, wepName .. "_binds", function()
					drone:Attack1(wepName)
				end)

				drone:AddUnpressKeyBind(key, wepName .. "_binds", function()
					drone:OnAttackStopped(wepName)
				end)
			else
				wep.Key2 = key

				drone:AddKeyBind(key, wepName .. "_binds", function()
					drone:Attack2(wepName)
				end)

				drone:AddUnpressKeyBind(key, wepName .. "_binds", function()
					drone:OnAttackStopped2(wepName)
				end)
			end
		end
	end)

	net.Receive("dronesrewrite_requestweapons", function(len, ply)
		local drone = net.ReadEntity()
		local sendto = net.ReadString()
		local sel = tobool(net.ReadBit())

		local weps = { }
		for k, v in pairs(drone.ValidWeapons) do 
			if v.NoSelecting and not sel then continue end
			table.insert(weps, k)
		end

		net.Start(sendto)
			net.WriteEntity(drone)
			net.WriteTable(weps)
		net.Send(ply)
	end)

	net.Receive("dronesrewrite_addfriends", function(len, ply)
		ply.dronesrewrite_friends = net.ReadTable()
	end)

	net.Receive("dronesrewrite_removeweapon", function(len, ply)
		local drone = net.ReadEntity()
		local wep = net.ReadString()

		if not IsValid(ply) then return end
		if not ply:IsAdmin() then return end

		drone:RemoveWeapon(wep)
	end)

	net.Receive("dronesrewrite_changewep", function(len, ply)
		local wep = net.ReadString()
		local drone = ply:GetNWEntity("DronesRewriteDrone")
		if drone:IsValid() then drone:SelectNextWeapon(wep) end
	end)

	net.Receive("dronesrewrite_addmodule", function(len, ply)
		local drone = net.ReadEntity()
		local module = net.ReadString()
		local add = tobool(net.ReadBit())

		if not IsValid(drone) then return end
		if not drone:CanBeControlledBy_skipai(ply) then 
			net.Start("dronesrewrite_playsound")
				net.WriteString("buttons/button10.wav")
			net.Send(ply)
			
			return 
		end

		net.Start("dronesrewrite_playsound")
			net.WriteString("buttons/button24.wav")
		net.Send(ply)
		
		local mod = drone.Modules[module]
		if not mod then return end

		if add then
			if mod.System then drone:AddModule(module) end -- now you can't add new modules via gui
		else
			if drone:RemoveModule(module) then
				local nicename = "dronesrewrite_upgrcase_" .. string.lower(string.Replace(module, " ", "_"))

				local case = ents.Create(nicename)
				if not case then return end

				local tr = util.TraceLine({
					start = ply:GetShootPos(),
					endpos = ply:GetShootPos() + ply:GetAimVector() * 200,
					filter = ply
				})

				local ang = (case:GetPos() - ply:GetPos()):Angle()
				ang.p = 0
				ang.r = 0

				case:SetPos(tr.HitPos - tr.HitNormal * 32)
				case:SetAngles(ang)
				case:Spawn()

				ply:AddCleanup("entity", case)
				undo.Create(module)
					undo.AddEntity(case)
					undo.SetPlayer(ply)
				undo.Finish("Upgrade case " .. module)
				cleanup.Add(ply, "entity", case)
			end
		end
	end)

	net.Receive("dronesrewrite_clickkey", function(len, ply)
		local drone = net.ReadEntity()
		local key = net.ReadString()

		if not IsValid(drone) then return end
		if not drone:CanBeControlledBy_skipai(ply) then return end

		drone:ClickKey(key)
	end)

	net.Receive("dronesrewrite_presskey", function(len, ply)
		local drone = net.ReadEntity()
		local key = net.ReadInt(8)
		
		if not IsValid(drone) then return end
		if not drone:CanBeControlledBy_skipai(ply) then return end

		local bind = DRONES_REWRITE.KeyNames[key]

		for k, v in pairs(DRONES_REWRITE.Keys) do
			if ply:GetInfoNum("dronesrewrite_key_" .. k, 0) == key then
				bind = k
				break
			end
		end

		if not bind then return end

		drone:PressKey(bind)
	end)
else
	net.Receive("dronesrewrite_helppls", function()
		if DRONES_REWRITE.DidMessage then return end

		notification.AddLegacy("You can disable Drones hints in Q > Options > Drones Settings > Client > No hints", NOTIFY_HINT, 10)
		surface.PlaySound("ambient/water/drip3.wav")

		timer.Simple(2, function()
			notification.AddLegacy("Need help or have question? Go to Q > Options > Drones Settings > Help > Show help window", NOTIFY_HINT, 13)
			surface.PlaySound("ambient/water/drip3.wav")
		end)

		timer.Simple(5, function()
			notification.AddLegacy("Please read F.A.Q. from help window if you don't understand something. Just do it!", NOTIFY_HINT, 11)
			surface.PlaySound("ambient/water/drip2.wav")
		end)

		--[[timer.Simple(10, function()
			notification.AddLegacy("It's possible to edit drones. Press and hold C and right click on drone", NOTIFY_HINT, 7)
			surface.PlaySound("ambient/water/drip2.wav")
		end)]]

		DRONES_REWRITE.DidMessage = true
	end)

	net.Receive("dronesrewrite_helppls2", function()
		if DRONES_REWRITE.DidMessage2 then return end

		notification.AddLegacy("Controls: Q > Options > Drones Settings > Keys", NOTIFY_GENERIC, 7)
		surface.PlaySound("ambient/water/drip3.wav")

		DRONES_REWRITE.DidMessage2 = true
	end)

	net.Receive("dronesrewrite_updcam", function()
		DRONES_REWRITE.UpdateCamera()
	end)

	net.Receive("dronesrewrite_playsound", function()
		local name = net.ReadString()
		surface.PlaySound(name)
	end)

	net.Receive("dronesrewrite_doprecache", function()
		DRONES_REWRITE.DoPrecache()
	end)

	net.Receive("dronesrewrite_closeconsole", function()
		local con = net.ReadEntity()

		if not IsValid(con) then return end
		con:CloseWindow()
	end)

	net.Receive("dronesrewrite_opencontroller", function()
		local con = net.ReadEntity()

		if not IsValid(con) then return end
		con:OpenMenu()
	end)

	net.Receive("dronesrewrite_clearconsole", function()
		local con = net.ReadEntity()

		if not IsValid(con) then return end
		con.Cache = { }
	end)

	net.Receive("dronesrewrite_openconsole", function()
		local con = net.ReadEntity()

		if not IsValid(con) then return end
		con:OpenConsole()
	end)

	net.Receive("dronesrewrite_addline", function()
		local con = net.ReadEntity()
		local line = net.ReadString()
		local color = net.ReadColor()

		if not IsValid(con) then return end
		if not con.AddLine then return end

		con:AddLine(line, color)
	end)

	net.Receive("dronesrewrite_removehook", function()
		local drone = net.ReadEntity()
		local class = net.ReadString()
		local name = net.ReadString()

		if not IsValid(drone) then return end
		drone:RemoveHook(class, name)
	end)

	net.Receive("dronesrewrite_addhook", function()
		local drone = net.ReadEntity()
		local class = net.ReadString()
		local name = net.ReadString()
		local func = net.ReadString()

		if not IsValid(drone) then return end
		if not drone.AddHook then return end

		drone:AddHook(class, name, func)
	end)

	net.Receive("dronesrewrite_openselectmenu", function()
		local drone = net.ReadEntity()
		local weps = net.ReadTable()

		if not IsValid(drone) then return end
		drone:OpenSelectionMenu(weps)
	end)

	net.Receive("dronesrewrite_openbindsmenu", function()
		local drone = net.ReadEntity()
		local weps = net.ReadTable()

		if not IsValid(drone) then return end
		drone:OpenBindsMenu(weps)
	end)

	net.Receive("dronesrewrite_openweaponscustom", function()
		local drone = net.ReadEntity()
		local weps = net.ReadTable()

		if not IsValid(drone) then return end
		drone:OpenWeaponsMenu(weps)
	end)

	net.Receive("dronesrewrite_sniperrifle", function()
		local drone = net.ReadEntity()
		local show = tobool(net.ReadBit())

		if show then
			if IsValid(drone) then drone.HUD_shouldDrawHud = false end

			hook.Add("AdjustMouseSensitivity", "dronesrewrite_sniper_mouse", function(old)
				return 0.16
			end)

			hook.Add("HUDPaint", "dronesrewrite_sniper_rifle", function()
				local x, y = ScrW() / 2, ScrH() / 2

				surface.SetMaterial(Material("particles/dronesrewrite_sniper"))
				surface.SetDrawColor(Color(0, 0, 0, 255))

				local size = ScrH() * 2
				surface.DrawLine(0, y, ScrW(), y)
				surface.DrawLine(x, 0, x, ScrH())
				surface.DrawTexturedRect(x - (size/2), y - (size/2), size, size)

				surface.SetDrawColor(Color(0, 0, 0, 64))
				surface.SetMaterial(Material("stuff/whiteboxhud/center"))
				surface.DrawTexturedRectRotated(x, y, size * 0.8, size * 0.8, CurTime() * 32)

				local text = "[" .. math.floor(drone:GetPos():Distance(drone:GetCameraTraceLine().HitPos)) ..  "]"
				draw.SimpleText(text, "DronesRewrite_font5", x - 128, y - 32, Color(0, 0, 0, 255), TEXT_ALIGNT_LEFT)

				local text = "[" .. drone:GetPrimaryAmmo() ..  "]"
				draw.SimpleText(text, "DronesRewrite_font5", x + 64, y - 32, Color(0, 0, 0, 255), TEXT_ALIGNT_RIGHT)
			end)
		else
			if IsValid(drone) then drone.HUD_shouldDrawHud = true end

			hook.Remove("AdjustMouseSensitivity", "dronesrewrite_sniper_mouse")
			hook.Remove("HUDPaint", "dronesrewrite_sniper_rifle")
		end
	end)

	net.Receive("dronesrewrite_sniperrifle_crosshair", function()
		local drone = net.ReadEntity()
		local show = tobool(net.ReadBit())

		if show then
			if IsValid(drone) then drone.HUD_shouldDrawCrosshair = true end
		else
			if IsValid(drone) then drone.HUD_shouldDrawCrosshair = false end
		end
	end)
end