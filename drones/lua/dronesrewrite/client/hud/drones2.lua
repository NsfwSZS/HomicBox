DRONES_REWRITE.HUD["Drones 2"] = function(drone)
	local shouldDrawCrosshair = drone.HUD_shouldDrawCrosshair and DRONES_REWRITE.ClientCVars.DrawCrosshair:GetBool()
	local shouldDrawHealth = drone.HUD_shouldDrawHealth and DRONES_REWRITE.ClientCVars.DrawHealth:GetBool()
	local shouldDrawTargets = drone.HUD_shouldDrawTargets and DRONES_REWRITE.ClientCVars.DrawTargets:GetBool()
	local shouldDrawFuel = drone.HUD_shouldDrawFuel and DRONES_REWRITE.ClientCVars.DrawFuel:GetBool()
	local shouldDrawWeps = drone.HUD_shouldDrawWeps and DRONES_REWRITE.ClientCVars.DrawWeps:GetBool()
	local shouldDetectDamage = drone.HUD_shouldDetectDamage and DRONES_REWRITE.ClientCVars.DetectDamage:GetBool()
	local shouldDrawCenter = drone.HUD_shouldDrawCenter and DRONES_REWRITE.ClientCVars.DrawCenter:GetBool()

	local x, y = ScrW(), ScrH()

	local textColor = drone.HUD_textColor
	local hudColor = drone.HUD_hudColor

	local pos = (drone:GetForward() * 10 + drone:LocalToWorld(drone.FirstPersonCam_pos)):ToScreen()
				
	if drone:HasFuel() then
		if shouldDrawTargets then
			local tr = drone:GetCameraTraceLine(nil, Vector(-32, -32, 0), Vector(32, 32, 0))

			for k, v in pairs(ents.FindInSphere(tr.HitPos, 640)) do
				if v == drone then continue end

				if not v:IsPlayer() and not v:IsNPC() and not v.IS_DRONE then continue end
				if v.IS_DRR and v:IsDroneDestroyed() then continue end

				-- Calculating target position
				local pos = v:LocalToWorld(v:OBBCenter())
				local bone = v:LookupBone("ValveBiped.Bip01_Head1")
				if bone then pos = v:GetBonePosition(bone) end

				local tr = util.TraceLine({
					start = drone:GetPos(),
					endpos = pos,
					filter = drone
				})

				if tr.Entity != v then continue end

				local size = (86 - math.Clamp(drone:GetPos():Distance(pos) * 0.03, 20, 86))
				pos = pos:ToScreen()

				local class = v:GetClass()
				local color = Color(0, 255, 0, 155)
				if IsEnemyEntityName(class) then color = Color(255, 0, 0, 155) end

				surface.SetMaterial(Material("stuff/dronestwo_target"))
				surface.SetDrawColor(color)
				surface.DrawTexturedRectRotated(pos.x, pos.y, size, size, CurTime() * 150)
				surface.DrawTexturedRectRotated(pos.x, pos.y, size, size, -CurTime() * 300)
			end
		end

		if shouldDrawFuel then
			surface.SetDrawColor(hudColor)
			surface.DrawOutlinedRect(pos.x - 260, pos.y - 80, 200, 15)
			surface.DrawRect(pos.x - 255, pos.y - 75, drone:GetFuel() / drone.MaxFuel * 190, 5)
			draw.SimpleText("Fuel " .. math.floor(drone:GetFuel() / drone.MaxFuel * 100) .. "%", "Trebuchet24", pos.x - 270, pos.y - 85, textColor, TEXT_ALIGN_RIGHT)

			draw.SimpleText("[" .. math.floor(drone:GetFuel()) .. " / " .. drone.MaxFuel .. "]", "Trebuchet18", pos.x - 270, pos.y - 56, textColor, TEXT_ALIGN_RIGHT)

			--Fuel lines
			surface.DrawLine(pos.x - 500, pos.y - 29, pos.x - 380, pos.y - 90)
			surface.DrawLine(pos.x - 380, pos.y - 90, pos.x - 50, pos.y - 95)
			surface.DrawLine(pos.x - 50, pos.y - 95, pos.x - 40, pos.y - 40)
		end

		if shouldDrawWeps then
			local ammo = drone:GetPrimaryAmmo() / drone:GetPrimaryMax() * 100

			surface.SetDrawColor(hudColor)
			surface.DrawOutlinedRect(pos.x - 260, pos.y + 55, 200, 15)
			surface.DrawRect(pos.x - 255, pos.y + 60, ammo * 1.9, 5)
			draw.SimpleText("Ammo " .. math.floor(ammo) .. "%", "Trebuchet24", pos.x - 270, pos.y + 50, textColor, TEXT_ALIGN_RIGHT)
			draw.SimpleText("[" .. drone:GetPrimaryAmmo() .. " / " .. drone:GetPrimaryMax() .. "]", "Trebuchet18", pos.x - 270, pos.y + 79, textColor, TEXT_ALIGN_RIGHT)

			local ammo = drone:GetSecondaryAmmo() / drone:GetSecondaryMax() * 100

			surface.DrawOutlinedRect(pos.x - 260, pos.y + 105, 200, 15)
			surface.DrawRect(pos.x - 255, pos.y + 110, ammo * 1.9, 5)
			draw.SimpleText("Secondary ammo " .. math.floor(ammo) .. "%", "Trebuchet24", pos.x - 270, pos.y + 100, textColor, TEXT_ALIGN_RIGHT)
			draw.SimpleText("[" .. drone:GetSecondaryAmmo() .. " / " .. drone:GetSecondaryMax() .. "]", "Trebuchet18", pos.x - 270, pos.y + 129, textColor, TEXT_ALIGN_RIGHT)
	
			draw.SimpleText("CURRENT WEAPON [" .. drone:GetNWString("CurrentWeapon") .. "]", "Trebuchet24", pos.x, pos.y + 220, textColor, TEXT_ALIGN_CENTER)
		end

		if shouldDrawHealth then
			surface.SetDrawColor(hudColor)
			surface.DrawOutlinedRect(pos.x - 405, pos.y - 10, 200, 15)
			surface.DrawRect(pos.x - 400, pos.y - 5, drone:GetHealth() / drone:GetDefaultHealth() * 190, 5)
			draw.SimpleText("HP [" .. math.floor(drone:GetHealth()) .. "]", "Trebuchet24", pos.x - 500, pos.y - 15, textColor)
		end

		if shouldDrawCenter then
			surface.SetDrawColor(hudColor)
			--Long lines
			surface.DrawLine(0, pos.y - 20, pos.x - 40, pos.y - 40)
			surface.DrawLine(0, pos.y + 20, pos.x - 40, pos.y + 40)
			surface.DrawLine(x, pos.y - 20, pos.x + 40, pos.y - 40)
			surface.DrawLine(x, pos.y + 20, pos.x + 40, pos.y + 40)

			--Center lines
			surface.DrawLine(pos.x - 5, pos.y + 5, pos.x - 40, pos.y + 40)
			surface.DrawLine(pos.x - 5, pos.y - 5, pos.x - 40, pos.y - 40)
			surface.DrawLine(pos.x + 5, pos.y + 5, pos.x + 40, pos.y + 40)
			surface.DrawLine(pos.x + 5, pos.y - 5, pos.x + 40, pos.y - 40)

			surface.SetMaterial(Material("stuff/dronestwo_crossring"))
			surface.SetDrawColor(hudColor)

			local size = 120
			surface.DrawTexturedRect(pos.x - (size/2), pos.y - (size/2), size, size)

			surface.SetMaterial(Material("stuff/littledrone"))
			surface.DrawTexturedRect(pos.x - 530, pos.y - 11, 22, 22)

			local current_pos = drone:GetPos()
			current_pos = tostring("X[" .. math.floor(current_pos.x) 
					.. "]  Y[" .. math.floor(current_pos.y) 
					.. "]  Z[" .. math.floor(current_pos.z) .. "]")

			draw.SimpleText(current_pos, "Trebuchet24", pos.x + 100, pos.y - 15, textColor, TEXT_ALIGN_LEFT)
			draw.SimpleText("SPEED [" .. math.floor(drone:GetVelocity():Length()) .. "]", "Trebuchet24", pos.x - 200, pos.y - 25, textColor)
			draw.SimpleText(drone:GetUnit(), "Trebuchet24", pos.x - 200, pos.y - 5, textColor)

			if drone:GetNWBool("NightVision") then
				draw.SimpleText("[Nightvision enabled]", "Trebuchet24", pos.x - 500, pos.y + 50, textColor, TEXT_ALIGN_CENTER)
			end
		end

		if shouldDetectDamage then
			if drone:GetHealth() < drone.CriticalHealthPoint then
				draw.SimpleText("[WARNING! LOW HP]", "Trebuchet24", pos.x, pos.y + 50, Color(255, 0, 0), TEXT_ALIGN_CENTER)
			end
		end

		--Crosshair
		if shouldDrawCrosshair then
			surface.SetMaterial(Material("stuff/dronestwo_crosshair"))
			surface.SetDrawColor(hudColor)

			x, y = x / 2, y / 2

			local size = 50
			surface.DrawTexturedRect(x - (size/2), y - (size/2), size, size)
		end
	end
end