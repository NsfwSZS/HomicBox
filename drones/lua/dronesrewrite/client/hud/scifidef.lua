local scaleShit = 0
local oldHealth = 0
local droneDamaged
local targetFound
local oldWep
local wepChanged

DRONES_REWRITE.HUD["Sci Fi"] = function(drone)
	local shouldDrawCrosshair = drone.HUD_shouldDrawCrosshair and DRONES_REWRITE.ClientCVars.DrawCrosshair:GetBool()
	local shouldDrawHealth = drone.HUD_shouldDrawHealth and DRONES_REWRITE.ClientCVars.DrawHealth:GetBool()
	local shouldDrawRadar = drone.HUD_shouldDrawRadar and DRONES_REWRITE.ClientCVars.DrawRadar:GetBool()
	local shouldDrawTargets = drone.HUD_shouldDrawTargets and DRONES_REWRITE.ClientCVars.DrawTargets:GetBool()
	local shouldDrawFuel = drone.HUD_shouldDrawFuel and DRONES_REWRITE.ClientCVars.DrawFuel:GetBool()
	local shouldDetectDamage = drone.HUD_shouldDetectDamage and DRONES_REWRITE.ClientCVars.DetectDamage:GetBool()
	local shouldDrawCenter = drone.HUD_shouldDrawCenter and DRONES_REWRITE.ClientCVars.DrawCenter:GetBool()
	local shouldDrawWeps = drone.HUD_shouldDrawWeps and DRONES_REWRITE.ClientCVars.DrawWeps:GetBool()

	local x, y = ScrW(), ScrH()
	local pos = (drone:GetForward() * 10 + drone:LocalToWorld(drone.FirstPersonCam_pos)):ToScreen()
	

	if shouldDrawCrosshair then
		surface.SetMaterial(Material("stuff/crosshair1"))
		surface.SetDrawColor(Color(drone.HUD_hudColor.r, drone.HUD_hudColor.g, drone.HUD_hudColor.b, 100))
		surface.DrawTexturedRect(x / 2 - 64, y / 2 - 64, 128, 128)
	end

	if drone:GetHealth() <= drone:GetDefaultHealth() / 5 then
		surface.SetMaterial(Material("stuff/console/broken4"))
		surface.SetDrawColor(Color(255, 255, 255, math.Clamp(255 - (drone:GetHealth() / drone:GetDefaultHealth()) * 255, 0, 50)))
		surface.DrawTexturedRect(0, 0, x, y)
	end

	if shouldDrawCenter then
		--Arrow
		surface.SetMaterial(Material("stuff/arrow"))
		surface.SetDrawColor(drone.HUD_hudColor)

		local clampy = math.Clamp(pos.y, y / 2 - 100, y / 2 + 100)
		if pos.x > ScrW() then
			surface.DrawTexturedRect(ScrW() - 100, clampy, 100, 100)
			--draw.SimpleText("CENTER", "DronesRewrite_font1", ScrW() - 100, clampy + 50, drone.HUD_textColor, TEXT_ALIGN_RIGHT)
		elseif pos.x < 0 then
			surface.DrawTexturedRectRotated(50, clampy + 50, 100, 100, 180)
			--draw.SimpleText("CENTER", "DronesRewrite_font1", 90, clampy + 50, drone.HUD_textColor, TEXT_ALIGN_LEFT)
		end

		surface.SetMaterial(Material("stuff/center"))
		surface.SetDrawColor(Color(drone.HUD_hudColor.r, drone.HUD_hudColor.g, drone.HUD_hudColor.b, 50))
		surface.DrawTexturedRect(pos.x - 100, pos.y - 100, 200, 200)

		surface.SetMaterial(Material("stuff/target"))
		surface.SetDrawColor(Color(0, 255, 255, 16))

		local x = CurTime() * 0.4
		local delta = (math.sin(x) ^ 2 - math.cos(x) ^ 2) * 360
		surface.DrawTexturedRectRotated(pos.x, pos.y, 500, 500, delta)

		draw.SimpleText("SPEED [" .. math.floor(drone:GetVelocity():Length()) .. "]", "DronesRewrite_font2", pos.x + 70, pos.y - 90, drone.HUD_textColor)
		draw.SimpleText("FUEL [" .. drone:GetFuel() .. " / " .. drone.MaxFuel .."]", "DronesRewrite_font2", pos.x + 80, pos.y - 75, drone.HUD_textColor)
		draw.SimpleText("PRIMARY AMMO [" .. drone:GetPrimaryAmmo() .. " / " .. drone:GetPrimaryMax() .."]", "DronesRewrite_font2", pos.x + 90, pos.y - 60, drone.HUD_textColor)
		draw.SimpleText("SECONDARY AMMO [" .. drone:GetSecondaryAmmo() .. " / " .. drone:GetSecondaryMax() .."]", "DronesRewrite_font2", pos.x + 100, pos.y - 45, drone.HUD_textColor)
		draw.SimpleText("HEALTH [" .. drone:GetHealth() .. " / " .. drone:GetDefaultHealth() .."]", "DronesRewrite_font2", pos.x + 100, pos.y - 30, drone.HUD_textColor)

		local nightvision_flashlight_pos = 105
		if drone:GetNWBool("NightVision") then
			draw.SimpleText("NightVision enabled", "DronesRewrite_font2", pos.x, pos.y + nightvision_flashlight_pos, drone.HUD_textColor, TEXT_ALIGN_CENTER)
			nightvision_flashlight_pos = 120
		end

		if drone:GetNWBool("Flashlight") then
			draw.SimpleText("Flashlight enabled", "DronesRewrite_font2", pos.x, pos.y + nightvision_flashlight_pos, drone.HUD_textColor, TEXT_ALIGN_CENTER)
			nightvision_flashlight_pos = 120
		end
	end

	if shouldDrawHealth then
		surface.SetMaterial(Material("stuff/bar"))
		surface.SetDrawColor(drone.HUD_hudColor)
		
		for i = 1, (drone:GetHealth() / drone:GetDefaultHealth()) * 33 do
			surface.DrawTexturedRect(95 + i * 15, y - 100, 40, 30)
		end

		draw.SimpleText("HEALTH", "DronesRewrite_font1", 130, y - 70, drone.HUD_textColor, TEXT_ALIGN_LEFT)
	end

	if shouldDrawFuel then
		surface.SetMaterial(Material("stuff/bar"))
		surface.SetDrawColor(drone.HUD_hudColor)

		for i = 1, (drone:GetFuel() / drone.MaxFuel) * 33 do
			surface.DrawTexturedRect(95 + i * 15, y - 140, 40, 30)
		end

		draw.SimpleText("FUEL", "DronesRewrite_font1", 130, y - 185, drone.HUD_textColor, TEXT_ALIGN_LEFT)
	end

	if shouldDrawFuel or shouldDrawHealth then
		surface.SetMaterial(Material("stuff/barroad"))
		surface.SetDrawColor(drone.HUD_hudColor)
		surface.DrawTexturedRect(90, y - 405, 600, 600)

		surface.SetMaterial(Material("stuff/corner"))
		surface.SetDrawColor(drone.HUD_hudColor)
		surface.DrawTexturedRect(0, y - 200, 200, 200)
	end

	--[[if shouldDrawRadar then
		surface.SetMaterial(Material("stuff/circle"))
		surface.SetDrawColor(Color(0, 255, 0, 100))
		surface.DrawTexturedRect(20, 20, 200, 200)

		for k, v in pairs(ents.FindInSphere(drone:GetPos(), 4000)) do
			if v:IsPlayer() or v:IsNPC() or v.IS_DRONE then
				local vpos = (v:GetPos() - drone:GetPos()) / 90
				local ang = drone:GetAngles().y

				surface.DrawTexturedRect(115 + vpos.x, 115 + vpos.y, 10, 10)
			end
		end
	end]]

	if shouldDrawTargets then
		local tr = drone:GetCameraTraceLine(nil, Vector(-32, -32, 0), Vector(32, 32, 0))

		for k, v in pairs(ents.FindInSphere(tr.HitPos, 640)) do
			if v:IsPlayer() or v:IsNPC() or v.IS_DRONE then
				local pos = v:LocalToWorld(Vector(0, 0, 20))
				local bone = v:LookupBone("ValveBiped.Bip01_Head1")
				if bone then pos = v:GetBonePosition(bone) end

				local tr = util.TraceLine({
					start = drone:GetPos(),
					endpos = pos,
					filter = drone
				})

				if tr.Entity != v then continue end

				local size = (64 - math.Clamp(drone:GetPos():Distance(pos) * 0.04, 20, 64))
				pos = pos:ToScreen()

				local class = v:GetClass()
				local color = Color(64, 255, 64, 155)
				if IsEnemyEntityName(class) then color = Color(255, 64, 64, 155) end

				surface.SetMaterial(Material("stuff/center"))
				surface.SetDrawColor(color)
				surface.DrawTexturedRectRotated(pos.x, pos.y, size, size, CurTime() * 1000)
			end
		end

		local ent = tr.Entity

		targetFound = false
		if ent:IsValid() and (ent:IsPlayer() or ent:IsNPC() or ent.IS_DRONE) then
			local pos = ent:GetPos()
			local bone = ent:LookupBone("ValveBiped.Bip01_Head1")
			if bone then pos = ent:GetBonePosition(bone) end

			pos = pos:ToScreen()

			local name = ent:GetClass()
			if ent:IsPlayer() then name = ent:Name() end

			local id = ent:EntIndex()
			if ent.IS_DRR then id = ent:GetUnit() end

			local speed = math.floor(ent:GetVelocity():Length())

			scaleShit = math.Approach(scaleShit, 100, 150)

			surface.SetMaterial(Material("stuff/target"))
			surface.SetDrawColor(Color(255, 255, 255, 160 / scaleShit * 50))
			surface.DrawTexturedRectRotated(pos.x, pos.y, scaleShit, scaleShit, CurTime() * -600)

			draw.SimpleText("TARGET", "DronesRewrite_font2", pos.x + 25, pos.y - 15, Color(255, 0, 0))
			draw.SimpleText("CODE [" .. name .. "]", "DronesRewrite_font2", pos.x + 25, pos.y - 5, drone.HUD_textColor)
			draw.SimpleText("ID [" .. id .. "]", "DronesRewrite_font2", pos.x + 25, pos.y + 5, drone.HUD_textColor)
			draw.SimpleText("SPEED [" .. speed .. "]", "DronesRewrite_font2", pos.x + 25, pos.y + 15, drone.HUD_textColor)

			targetFound = true
		end

		if not targetFound then
			scaleShit = 4000
		end
	end

	if shouldDrawWeps then
		local curWep = drone:GetNWString("CurrentWeapon")

		if oldWep != curWep then
			wepChanged = true

			timer.Create("dronesrewrite_changedwep", 2, 1, function() wepChanged = false end)
		end

		if wepChanged then
			draw.SimpleText("Weapon: " .. curWep, "DronesRewrite_font3", x / 2, y / 2 + 100, drone.HUD_textColor, TEXT_ALIGN_CENTER)
		end

		oldWep = curWep
	end

	if shouldDetectDamage then
		if drone:GetHealth() > 0 and oldHealth > drone:GetHealth() then
			droneDamaged = true
			timer.Create("dronesrewrite_changedamaged", 2, 1, function() droneDamaged = false end)
		end

		if droneDamaged then
			draw.SimpleText("WARNING! GETTING DAMAGE!", "DronesRewrite_font1", x / 2, y - 220, Color(255, 0, 0, 120), TEXT_ALIGN_CENTER)
		end

		oldHealth = drone:GetHealth()
	end

	if drone:IsDroneDestroyed() then
		draw.SimpleText("SYSTEM DAMAGED", "DronesRewrite_font1", x / 2, y / 2 + 50, Color(255, 0, 0, 150), TEXT_ALIGN_CENTER)
	end
end