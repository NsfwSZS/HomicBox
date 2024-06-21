local oldWep
local wepChanged
local oldHealth = 0

DRONES_REWRITE.HUD["Sci Fi 2"] = function(drone)
	local shouldDrawCrosshair = drone.HUD_shouldDrawCrosshair and DRONES_REWRITE.ClientCVars.DrawCrosshair:GetBool()
	local shouldDrawHealth = drone.HUD_shouldDrawHealth and DRONES_REWRITE.ClientCVars.DrawHealth:GetBool()
	local shouldDrawTargets = drone.HUD_shouldDrawTargets and DRONES_REWRITE.ClientCVars.DrawTargets:GetBool()
	local shouldDrawFuel = drone.HUD_shouldDrawFuel and DRONES_REWRITE.ClientCVars.DrawFuel:GetBool()
	local shouldDetectDamage = drone.HUD_shouldDetectDamage and DRONES_REWRITE.ClientCVars.DetectDamage:GetBool()
	local shouldDrawCenter = drone.HUD_shouldDrawCenter and DRONES_REWRITE.ClientCVars.DrawCenter:GetBool()
	local shouldDrawWeps = drone.HUD_shouldDrawWeps and DRONES_REWRITE.ClientCVars.DrawWeps:GetBool()

	local x, y = ScrW(), ScrH()
	local pos = (drone:GetForward() * 10 + drone:LocalToWorld(drone.FirstPersonCam_pos)):ToScreen()

	--surface.SetDrawColor(Color(0, 255, 255))
	--surface.DrawOutlinedRect(50, 50, x - 100, y - 100)

	surface.SetDrawColor(Color(0, 255, 255, 50))

	for i = -2, 2 do
		surface.DrawLine(330, pos.y + i * 2, pos.x - 420, pos.y + i * 2)
		surface.DrawLine(pos.x + 420, pos.y + i * 2, ScrW() - 50, pos.y + i * 2)
	end

	if shouldDrawCrosshair then
		surface.SetMaterial(Material("effects/select_ring"))
		surface.SetDrawColor(Color(0, 255, 255, 100))
		surface.DrawTexturedRect(x / 2 - 20, y / 2 - 20, 40, 40)
		surface.DrawTexturedRect(x / 2 - 2, y / 2 - 2, 4, 4)
	end

	if drone:GetHealth() <= drone:GetDefaultHealth() / 5 then
		surface.SetMaterial(Material("stuff/console/broken4"))
		surface.SetDrawColor(Color(255, 255, 255, math.Clamp(255 - (drone:GetHealth() / drone:GetDefaultHealth()) * 255, 0, 50)))
		surface.DrawTexturedRect(0, 0, x, y)
	end

	if shouldDrawCenter then 
		surface.SetMaterial(Material("stuff/target"))
		surface.SetDrawColor(Color(0, 255, 255, 100))
		surface.DrawTexturedRect(pos.x - 40, pos.y - 40, 80, 80)

		surface.DrawCircle(pos.x, pos.y, 200, Color(0, 255, 255, 50))
		surface.DrawCircle(pos.x, pos.y, 400, Color(0, 255, 255, 150))
		surface.DrawCircle(pos.x, pos.y, 410, Color(0, 255, 255, 150))
		surface.DrawCircle(pos.x, pos.y, 420, Color(0, 255, 255, 250))

		local pos = (drone:LocalToWorld(drone.FirstPersonCam_pos) - drone:GetUp() * 10):ToScreen()
		surface.DrawCircle(pos.x, pos.y, 20, Color(0, 255, 255, 70))
		surface.DrawCircle(pos.x, pos.y, 22, Color(0, 255, 255, 50))
		surface.DrawCircle(pos.x, pos.y, 200, Color(0, 255, 255, 50))
		surface.DrawCircle(pos.x, pos.y, 400, Color(0, 255, 255, 150))
		surface.DrawCircle(pos.x, pos.y, 410, Color(0, 255, 255, 150))
		surface.DrawCircle(pos.x, pos.y, 420, Color(0, 255, 255, 250))
	end

	if shouldDrawHealth then
		local hp = (drone:GetHealth() / drone:GetDefaultHealth()) * 200
		surface.SetDrawColor(Color(255, 255, 255, 20))
		surface.DrawRect(100, ScrH() - 104, 200, 20)
		surface.SetDrawColor(Color(0, 255, 255, 100))
		surface.DrawRect(100, ScrH() - 104, hp, 20)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawOutlinedRect(100, ScrH() - 104, 200, 20)

		draw.SimpleText("HP", "DronesRewrite_font2", 310, ScrH() - 100, Color(255, 255, 255, 100))
	end

	if shouldDrawFuel then
		local fuel = (drone:GetFuel() / drone.MaxFuel) * 200
		surface.SetDrawColor(Color(255, 255, 255, 20))
		surface.DrawRect(100, ScrH() - 64, 200, 20)
		surface.SetDrawColor(Color(255, 125, 0, 100))
		surface.DrawRect(100, ScrH() - 64, fuel, 20)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawOutlinedRect(100, ScrH() - 64, 200, 20)

		draw.SimpleText("Fuel", "DronesRewrite_font2", 310, ScrH() - 60, Color(255, 255, 255, 100))
	end

	if shouldDrawTargets then
		local tr = drone:GetCameraTraceLine(nil, Vector(-32, -32, 0), Vector(32, 32, 0))

		for k, v in pairs(ents.FindInSphere(tr.HitPos, 500)) do
			if v:IsPlayer() or v:IsNPC() or v.IS_DRONE then
				local pos = v:GetPos()
				local bone = v:LookupBone("ValveBiped.Bip01_Head1")
				if bone then pos = v:GetBonePosition(bone) end

				local size = (64 - math.Clamp(drone:GetPos():Distance(pos) * 0.04, 20, 64))
				pos = pos:ToScreen()

				surface.SetMaterial(Material("stuff/center"))
				surface.SetDrawColor(Color(0, 155, 255, math.abs(math.sin(CurTime() * 2)) * 200))
				surface.DrawTexturedRectRotated(pos.x, pos.y, size, size, CurTime() * math.sin(CurTime() * 2) * 2)

				--surface.DrawLine(pos.x + 20, pos.y - size * 0.3, pos.x + 120, pos.y - size * 0.3)
				draw.SimpleText(v:GetClass(), "DronesRewrite_font4", pos.x + 25, pos.y - 10, Color(0, 0, 255, 130))
			end
		end
	end

	if shouldDrawWeps then
		local curWep = drone:GetNWString("CurrentWeapon")

		if oldWep != curWep then
			wepChanged = true

			timer.Create("dronesrewrite_changedwep", 3, 1, function() wepChanged = false end)
		end

		if wepChanged then
			draw.SimpleText("CURRENT WEAPON [" .. curWep .. "]", "DronesRewrite_font1", ScrW() / 2, ScrH() - 128, Color(255, 255, 255, 150), TEXT_ALIGN_CENTER)
		end

		oldWep = curWep

		local ammo = (drone:GetPrimaryAmmo() / drone:GetPrimaryMax()) * 200
		surface.SetDrawColor(Color(255, 255, 255, 20))
		surface.DrawRect(100, ScrH() - 204, 200, 20)
		surface.SetDrawColor(Color(255, 255, 0, 100))
		surface.DrawRect(100, ScrH() - 204, ammo, 20)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawOutlinedRect(100, ScrH() - 204, 200, 20)
		draw.SimpleText("Primary ammo", "DronesRewrite_font2", 310, ScrH() - 200, Color(255, 255, 255, 100))

		local ammo = (drone:GetSecondaryAmmo() / drone:GetSecondaryMax()) * 200
		surface.SetDrawColor(Color(255, 255, 255, 20))
		surface.DrawRect(100, ScrH() - 244, 200, 20)
		surface.SetDrawColor(Color(255, 255, 0, 100))
		surface.DrawRect(100, ScrH() - 244, ammo, 20)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawOutlinedRect(100, ScrH() - 244, 200, 20)
		draw.SimpleText("Secondary ammo", "DronesRewrite_font2", 310, ScrH() - 240, Color(255, 255, 255, 100))
	end

	if shouldDetectDamage then
		if oldHealth > drone:GetHealth() then
			droneDamaged = true
			timer.Create("dronesrewrite_changedamaged", 2, 1, function() droneDamaged = false end)
		end

		if droneDamaged then
			draw.SimpleText("DAMAGED", "DronesRewrite_font1", x / 2, y / 2 + 200, Color(255, 0, 0, 120), TEXT_ALIGN_CENTER)
		end

		oldHealth = drone:GetHealth()
	end
end