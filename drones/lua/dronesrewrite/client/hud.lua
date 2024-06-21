hook.Add("HUDPaint", "dronesrewrite_hud", function()
	if not DRONES_REWRITE.ClientCVars.DrawHUD:GetBool() then return end

	local ply = LocalPlayer()
	local drone = ply:GetNWEntity("DronesRewriteDrone")

	if drone:IsValid() then
		if drone:DoCamEffects() and drone.HUD_shouldDrawHud then
			if DRONES_REWRITE.HUD[drone:GetHUDName()] then DRONES_REWRITE.HUD[drone:GetHUDName()](drone) end
		end

		if drone.HUD_shouldDrawCrosshair and DRONES_REWRITE.ClientCVars.DrawTpCrosshair:GetBool() and DRONES_REWRITE.ClientCVars.DrawCrosshair:GetBool() and drone:GetNWBool("ThirdPerson") then
			local pos = drone:GetCameraTraceLine().HitPos:ToScreen()
			local x, y = pos.x, pos.y

			surface.SetDrawColor(Color(255, 255, 255))
			surface.DrawLine(x - 5, y - 5, x - 10, y - 10)
			surface.DrawLine(x + 5, y - 5, x + 10, y - 10)
			surface.SetDrawColor(Color(0, 0, 0))
			surface.DrawLine(x - 5, y + 5, x - 10, y + 10)
			surface.DrawLine(x + 5, y + 5, x + 10, y + 10)

			surface.SetMaterial(Material("stuff/crosshair1"))
			surface.SetDrawColor(Color(255, 255, 255, 64))
			surface.DrawTexturedRect(x - 16, y - 16, 32, 32)
		end

		drone:CallHook("HUD")
	end
end)

local no_drawing = {
	CHudHealth = true,
	CHudBattery = true,
	CHudCrosshair = true,
	CHudAmmo = true,
	CHudSecondaryAmmo = true
}

hook.Add("HUDShouldDraw", "dronesrewrite_nohuddraw", function(name)
	local ply = LocalPlayer()
	local drone = ply:GetNWEntity("DronesRewriteDrone")

	if drone:IsValid() then
		if no_drawing[name] then return false end
	end
end)