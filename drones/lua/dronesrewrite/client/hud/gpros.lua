DRONES_REWRITE.HUD["GPROSupport"] = function(drone)
	local shouldDrawCrosshair = drone.HUD_shouldDrawCrosshair and DRONES_REWRITE.ClientCVars.DrawCrosshair:GetBool()
	local shouldDrawHealth = drone.HUD_shouldDrawHealth and DRONES_REWRITE.ClientCVars.DrawHealth:GetBool()
	local shouldDrawTargets = drone.HUD_shouldDrawTargets and DRONES_REWRITE.ClientCVars.DrawTargets:GetBool()
	local shouldDrawFuel = drone.HUD_shouldDrawFuel and DRONES_REWRITE.ClientCVars.DrawFuel:GetBool()
	local shouldDrawCenter = drone.HUD_shouldDrawCenter and DRONES_REWRITE.ClientCVars.DrawCenter:GetBool()
	local shouldDrawWeps = drone.HUD_shouldDrawWeps and DRONES_REWRITE.ClientCVars.DrawWeps:GetBool()

	local x, y = ScrW(), ScrH()

	local pos = (drone:GetForward() * 10 + drone:LocalToWorld(drone.FirstPersonCam_pos)):ToScreen()

	if shouldDrawCrosshair then
		surface.SetMaterial(Material("stuff/gprohud/cross_inner"))
		surface.SetDrawColor(Color(255, 255, 255))
		surface.DrawTexturedRect(x / 2 - 64, y / 2 - 64, 128, 128)
	end

	if shouldDrawTargets then
		for k, v in pairs(ents.FindInSphere(drone:GetCameraTraceLine(nil, Vector(-50, -50, 0), Vector(50, 50, 0)).HitPos, 400)) do
			if not v:IsPlayer() and not v:IsNPC() and not v.IS_DRONE then continue end
			if v.IS_DRONE and v:IsDroneDestroyed() then continue end
			if v == drone then continue end

			-- Calculating target position
			local pos = v:LocalToWorld(v:OBBCenter())
			local bone = v:LookupBone("ValveBiped.Bip01_Head1")
			if bone then pos = v:GetBonePosition(bone) end

			pos = pos:ToScreen()

			surface.SetMaterial(Material("stuff/gprohud/human_t"))
			surface.SetDrawColor(Color(255, 255, 255, 100))
			surface.DrawTexturedRect(pos.x - 32, pos.y - 32, 64, 64)
		end
	end

	if shouldDrawCenter then


		surface.SetMaterial(Material("stuff/gprohud/cross_frame"))
		surface.DrawTexturedRectRotated(pos.x, pos.y, 128, 128, 0)

		local newy = 30

		if shouldDrawHealth then
			surface.SetMaterial(Material("stuff/bar"))
			surface.SetDrawColor(Color(255, 100, 100, 200))
			
			surface.DrawOutlinedRect(pos.x - 378, pos.y - 15 + newy, 251, 30)
			for i = 1, (drone:GetHealth() / drone:GetDefaultHealth()) * 16 do
				surface.DrawTexturedRect(pos.x + i * 15 - 400, pos.y - 15 + newy, 40, 30)
			end

			draw.SimpleText("HEALTH", "DronesRewrite_font1", pos.x - 378, pos.y + 15 + newy, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT)
		end

		if shouldDrawFuel then
			surface.SetMaterial(Material("stuff/bar"))
			surface.SetDrawColor(Color(255, 200, 100, 200))
			
			surface.DrawOutlinedRect(pos.x + 127, pos.y - 15 + newy, 251, 30)
			for i = 1, (drone:GetFuel() / drone.MaxFuel) * 16 do
				surface.DrawTexturedRect(pos.x + i * 15 + 105, pos.y - 15 + newy, 40, 30)
			end

			draw.SimpleText("FUEL", "DronesRewrite_font1", pos.x + 375, pos.y + 15 + newy, Color(255, 255, 255, 200), TEXT_ALIGN_RIGHT)
		end

		if shouldDrawWeps then
			-- Primary
			surface.SetMaterial(Material("stuff/bar"))
			surface.SetDrawColor(Color(100, 255, 100, 200))
			
			surface.DrawOutlinedRect(pos.x - 378, pos.y - 15 - newy, 251, 30)
			for i = 1, (drone:GetPrimaryAmmo() / drone:GetPrimaryMax()) * 16 do
				surface.DrawTexturedRect(pos.x + i * 15 - 400, pos.y - 15 - newy, 40, 30)
			end

			draw.SimpleText("PRM AMMO", "DronesRewrite_font1", pos.x - 378, pos.y - 60 - newy, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT)


			-- Secondary
			surface.SetMaterial(Material("stuff/bar"))
			surface.SetDrawColor(Color(100, 255, 100, 200))
			
			surface.DrawOutlinedRect(pos.x + 127, pos.y - 15 - newy, 251, 30)
			for i = 1, (drone:GetSecondaryAmmo() / drone:GetSecondaryMax()) * 16 do
				surface.DrawTexturedRect(pos.x + i * 15 + 105, pos.y - 15 - newy, 40, 30)
			end

			draw.SimpleText("SCND AMMO", "DronesRewrite_font1", pos.x + 375, pos.y - 60 - newy, Color(255, 255, 255, 200), TEXT_ALIGN_RIGHT)

			local curWep = drone:GetNWString("CurrentWeapon")
			draw.SimpleText("WEAPON: " .. curWep, "DronesRewrite_font1", pos.x, pos.y + 100, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER)
		end
	end

	
end