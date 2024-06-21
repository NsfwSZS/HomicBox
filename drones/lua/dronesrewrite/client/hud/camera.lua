DRONES_REWRITE.HUD["Camera"] = function(drone)
	local shouldDrawCenter = drone.HUD_shouldDrawCenter and DRONES_REWRITE.ClientCVars.DrawCenter:GetBool()
	local shouldDrawFuel = drone.HUD_shouldDrawFuel and DRONES_REWRITE.ClientCVars.DrawFuel:GetBool()

	local x, y = ScrW(), ScrH()
	local pos = (drone:GetForward() * 10 + drone:LocalToWorld(drone.FirstPersonCam_pos)):ToScreen()

		
		


	
       

	local text = "Фонарик: " .. (drone:GetNWBool("camera_flashen", true) and "Включен" or "Выключен")
	draw.SimpleText(text, "HomigradFontBig", 20, 100, Color(255, 255, 255), TEXT_ALIGN_LEFT) 
	local dx = drone:GetPos()
	local l1 = LocalPlayer():GetPos()
	local dista = math.floor(math.DistanceSqr(dx[1], dx[2], l1[1], l1[2])/100000 )
	draw.SimpleText("ПКМ: Взорвать", "HomigradFontBig", 20, 150, Color(255, 55, 55), TEXT_ALIGN_LEFT)
	if dista < 2 then
		dist = 1
	else
		dist = math.floor(math.DistanceSqr(dx[1], dx[2], l1[1], l1[2])/100000 )
	end

	if dista > 799 then
		col = Color(255, 55, 55)
	else
		col = Color(255, 255, 255)
	end
	
	draw.SimpleText(string.format("Заряд: %s ⁂", drone:GetFuel()), "HomigradFontBig", 20, 75, Color(255, 255, 255), TEXT_ALIGN_LEFT)
	draw.SimpleText(string.format("Дистанция от вас: %s метров", dist ), "HomigradFontBig", 20, 200, col, TEXT_ALIGN_LEFT) 
	draw.SimpleText("Разрешение: " .. ScrW() .. "x" .. ScrH(), "HomigradFontBig", 20, 125, Color(255, 255, 255), TEXT_ALIGN_LEFT)

	x, y = x / 2, y / 2
	surface.DrawRect(x - 100, y - 70, 52, 2)
	surface.DrawRect(x - 100, y - 70, 2, 50)

	surface.DrawRect(x + 50, y - 70, 50, 2)
	surface.DrawRect(x + 100, y - 70, 2, 50)

	surface.DrawRect(x - 100, y + 70, 50, 2)
	surface.DrawRect(x - 100, y + 20, 2, 50)

	surface.DrawRect(x + 50, y + 70, 52, 2)
	surface.DrawRect(x + 100, y + 20, 2, 50)

	if shouldDrawCenter then
		surface.SetMaterial(Material("stuff/cross"))
		local owner = LocalPlayer()

	 local tr = {}
        tr.start = drone:GetPos()
        local dir = Vector(1,0,0)
        dir:Rotate(drone:EyeAngles())
        tr.endpos = tr.start + dir * 750000
        tr.filter = drone

        local traceResult = util.TraceLine(tr)
        local ent = traceResult.Entity
        --owner:ChatPrint(ent:GetMaterialType())
        if ent:IsPlayer() then
			draw.SimpleText(ent:Name(), "HomigradFontBig", pos.x, pos.y+25, Color(255, 55, 255), 1,1)
        end


		surface.DrawTexturedRect(pos.x, pos.y, 15, 15)
	end
end