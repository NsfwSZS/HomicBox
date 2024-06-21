DRONES_REWRITE.HUD["Drones 1"] = function(drone)
	local shouldDrawCrosshair = drone.HUD_shouldDrawCrosshair and DRONES_REWRITE.ClientCVars.DrawCrosshair:GetBool()
	local shouldDrawHealth = drone.HUD_shouldDrawHealth and DRONES_REWRITE.ClientCVars.DrawHealth:GetBool()
	local shouldDrawFuel = drone.HUD_shouldDrawFuel and DRONES_REWRITE.ClientCVars.DrawFuel:GetBool()
	local shouldDrawWeps = drone.HUD_shouldDrawWeps and DRONES_REWRITE.ClientCVars.DrawWeps:GetBool()
	local shouldDrawCenter = drone.HUD_shouldDrawCenter and DRONES_REWRITE.ClientCVars.DrawCenter:GetBool()

	local x, y = ScrW(), ScrH()
	local pos = (drone:GetForward() * 10 + drone:LocalToWorld(drone.FirstPersonCam_pos)):ToScreen()

	if shouldDrawCenter then
		surface.SetDrawColor(Color(255, 0, 0))

		surface.DrawLine(pos.x - 30, pos.y - 30, pos.x - 40, pos.y - 40)
		surface.DrawLine(pos.x - 30, pos.y + 30, pos.x - 40, pos.y + 40)
		surface.DrawLine(pos.x + 30, pos.y - 30, pos.x + 40, pos.y - 40)
		surface.DrawLine(pos.x + 30, pos.y + 30, pos.x + 40, pos.y + 40)

		for i = 1, x, 50 do surface.DrawLine(i, pos.y, i + 15, pos.y) end
		surface.DrawCircle(pos.x, pos.y, 50, Color(255, 0, 0))

		surface.DrawCircle(pos.x, pos.y, 200, Color(0, 255, 0))
		surface.DrawCircle(pos.x, pos.y, 210, Color(0, 255, 0))

		-- Misc
		draw.SimpleText(tostring(drone:GetPos()), "Trebuchet24", 50, y / 1.1, Color(255, 0, 0), TEXT_ALIGNT_LEFT)
		draw.SimpleText("SPEED " .. math.Round(drone:GetVelocity():Length()), "Trebuchet24", pos.x / 2, pos.y + 20, Color(255, 0, 0))
		draw.SimpleText(drone:GetUnit(), "Trebuchet24", pos.x / 2, pos.y + 40, Color(255, 0, 0))
	end

	if shouldDrawHealth then
		draw.SimpleText("ARMOR " .. drone:GetHealth(), "Trebuchet24", pos.x / 2, pos.y, Color(255, 0, 0))
	end

	if shouldDrawFuel then 
		draw.SimpleText("FUEL " .. drone:GetFuel(), "Trebuchet24", pos.x / 2, pos.y + 60, Color(255, 0, 0)) 
	end

	if shouldDrawWeps then
		draw.SimpleText("PRIMARY AMMO " .. drone:GetPrimaryAmmo() .. " / " .. drone:GetPrimaryMax(), "Trebuchet24", pos.x / 2, pos.y + 80, Color(255, 0, 0))
		draw.SimpleText("SECONDARY AMMO " .. drone:GetSecondaryAmmo() .. " / " .. drone:GetSecondaryMax(), "Trebuchet24", pos.x / 2, pos.y + 100, Color(255, 0, 0))
		draw.SimpleText("CURRENT WEAPON [" .. drone:GetNWString("CurrentWeapon"):upper() .. "]", "Trebuchet24", pos.x / 2, pos.y + 120, Color(255, 0, 0))
	end

	if shouldDrawCrosshair then
		--Crosshair

		x, y = x / 2, y / 2

		surface.SetDrawColor(Color(0, 255, 0))
		
		surface.DrawLine(x - 10, y - 10, x - 20, y - 20)
		surface.DrawLine(x - 10, y + 10, x - 20, y + 20)
		surface.DrawLine(x + 10, y - 10, x + 20, y - 20)
		surface.DrawLine(x + 10, y + 10, x + 20, y + 20)
	end
end