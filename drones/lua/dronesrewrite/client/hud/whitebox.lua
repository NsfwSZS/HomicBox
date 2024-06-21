local oldWep
local wepChanged
local oldHealth = 0
local area = 70

local doSound = true

local warn, warn2

local warning = nil
local function Warning(text, delay)
	if SERVER then return end

	warning = nil -- ??
	warning = { text = text, delay = delay }

	timer.Create("dronesrewrite_whitebox_warning", delay, 1, function()
		warning = nil
	end)

	surface.PlaySound("drones/whiteboxhud/warning.wav")
end

DRONES_REWRITE.HUD["White Box"] = function(drone)
	local shouldDrawCrosshair = drone.HUD_shouldDrawCrosshair and DRONES_REWRITE.ClientCVars.DrawCrosshair:GetBool()
	local shouldDrawHealth = drone.HUD_shouldDrawHealth and DRONES_REWRITE.ClientCVars.DrawHealth:GetBool()
	local shouldDrawTargets = drone.HUD_shouldDrawTargets and DRONES_REWRITE.ClientCVars.DrawTargets:GetBool()
	local shouldDrawFuel = drone.HUD_shouldDrawFuel and DRONES_REWRITE.ClientCVars.DrawFuel:GetBool()
	local shouldDetectDamage = drone.HUD_shouldDetectDamage and DRONES_REWRITE.ClientCVars.DetectDamage:GetBool()
	local shouldDrawCenter = drone.HUD_shouldDrawCenter and DRONES_REWRITE.ClientCVars.DrawCenter:GetBool()
	local shouldDrawWeps = drone.HUD_shouldDrawWeps and DRONES_REWRITE.ClientCVars.DrawWeps:GetBool()

	local alpha = 100 + math.abs(math.tan(CurTime() * 2) * 100)
	local w, h = ScrW(), ScrH()
	local pos = (drone:GetForward() * 10 + drone:LocalToWorld(drone.FirstPersonCam_pos)):ToScreen()

	surface.SetDrawColor(Color(255, 255, 255, 1))
	surface.SetMaterial(Material("stuff/whiteboxhud/lines"))
	surface.DrawTexturedRect(0, 0, w, h)

	if shouldDrawCenter then
		surface.SetDrawColor(Color(0, 0, 0, 200))
		surface.SetMaterial(Material("stuff/whiteboxhud/center"))
		surface.DrawTexturedRectRotated(pos.x, pos.y, 256, 256, drone:GetAngles().r)

		surface.SetMaterial(Material("stuff/whiteboxhud/center_lines"))
		surface.DrawTexturedRect(pos.x - 128, pos.y - 128, 256, 256)

		surface.SetMaterial(Material("stuff/whiteboxhud/circlerot"))

		local x = CurTime() * 0.6
		local delta = (math.sin(x) ^ 3 - math.cos(x) ^ 2) * 360
		surface.SetDrawColor(Color(255, 255, 255, alpha))
		surface.DrawTexturedRectRotated(pos.x, pos.y, 256, 256, delta)
	end

	if shouldDrawCrosshair then
		surface.SetDrawColor(Color(255, 200, 0, 100))

		surface.DrawLine(w / 2, 0, w / 2, h / 2 - 64)
		surface.DrawLine(w / 2, h / 2 + 64, w / 2, h)
		surface.DrawLine(256, h / 2, w / 2 - 64, h / 2)
		surface.DrawLine(w / 2 + 64, h / 2, ScrW() - 256, h / 2)

		surface.SetMaterial(Material("stuff/whiteboxhud/crosshair"))
		surface.DrawTexturedRect(w / 2 - 64, h / 2 - 64, 128, 128)

		surface.SetMaterial(Material("stuff/whiteboxhud/sidecirc"))

		local neww = h * 1.5
		surface.DrawTexturedRect((w - neww) / 2, (h - neww) / 2, neww, neww)

		local color = Color(200, 250, 250, alpha)
		draw.SimpleText("Scanning...", "DronesRewrite_font5", ScrW() - 160, 32, color, TEXT_ALIGNT_LEFT)
		draw.SimpleText("UNIT " .. drone:GetUnit(), "DronesRewrite_font5", ScrW() - 160, 52, color, TEXT_ALIGNT_LEFT)

		draw.SimpleText("Powered by DRR", "DronesRewrite_font5", 32, 32, color, TEXT_ALIGNT_LEFT)
		draw.SimpleText("Weapon: " .. drone:GetNWString("CurrentWeapon"), "DronesRewrite_font5", 32, 52, color, TEXT_ALIGNT_LEFT)

		local text = "[" .. math.floor(drone:GetPos():Distance(drone:GetCameraTraceLine().HitPos)) ..  "]"
		draw.SimpleText(text, "DronesRewrite_font5", 32, 72, Color(200, 250, 250, alpha), TEXT_ALIGNT_LEFT)
	end

	if shouldDrawTargets then
		local tr = drone:GetCameraTraceLine(nil, Vector(-32, -32, 0), Vector(32, 32, 0))

		for k, v in pairs(ents.FindInSphere(tr.HitPos, 640)) do
			if v:IsPlayer() or v:IsNPC() or v.IS_DRONE then
				local pos = v:LocalToWorld(v:OBBCenter())
				local bone = v:LookupBone("ValveBiped.Bip01_Head1")
				if bone then pos = v:GetBonePosition(bone) end

				local tr = util.TraceLine({
					start = drone:GetPos(),
					endpos = pos,
					filter = drone
				})

				if tr.Entity != v then continue end

				local size = (64 - math.Clamp(drone:GetPos():Distance(pos) * 0.025, 16, 50))
				pos = pos:ToScreen()

				local class = v:GetClass()
				local alpha = math.abs(math.sin(CurTime() * 3)) * 200
				local color = Color(0, 255, 0, alpha)
				if IsEnemyEntityName(class) then color = Color(255, 0, 0, alpha) end

				surface.SetMaterial(Material("stuff/whiteboxhud/target"))
				surface.SetDrawColor(color)
				surface.DrawTexturedRect(pos.x - size / 2, pos.y - size / 2, size, size)

				draw.SimpleText(class:upper(), "DronesRewrite_font2", pos.x - size + 16, pos.y, color, TEXT_ALIGN_RIGHT)
			end
		end
	end

	if shouldDrawHealth then
		local h = h / 2

		local hp = (drone:GetHealth() / drone:GetDefaultHealth()) * 255
		surface.SetDrawColor(Color(255 - hp, hp, 0, alpha))
		surface.SetMaterial(Material("stuff/whiteboxhud/armor"))

		local x = w / 2 - 256
		local y = h - 64

		surface.DrawTexturedRect(x, y, 64, 64)

		draw.SimpleText(drone:GetHealth(), "DronesRewrite_font3", x - 8, y + 16, Color(255 - hp, hp, 0), TEXT_ALIGN_RIGHT)
	
		if drone:GetHealth() <= drone:GetDefaultHealth() / 4 then
			--[[if doSound then
				timer.Create("drr_playsnd_wb" .. drone:EntIndex(), 0.7, 1, function()
					surface.PlaySound("drones/alarm.wav")
					doSound = true
				end)

				doSound = false
			end]]

			surface.SetMaterial(Material("stuff/console/broken4"))
			surface.SetDrawColor(Color(255, 255, 255, 8 + math.Clamp(math.tan(CurTime()), 0, 8)))
			surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

			if not warn then
				Warning("LOW HEALTH !!!", 5)
				surface.PlaySound("drones/whiteboxhud/alarm.wav")
				warn = true
			end
		else
			if warn then
				warn = false
			end
		end
	end

	if shouldDrawFuel then
		local h = h / 2

		local fuel = (drone:GetFuel() / drone.MaxFuel) * 255
		surface.SetDrawColor(Color(255 - fuel, fuel, 0, alpha))
		surface.SetMaterial(Material("stuff/whiteboxhud/can"))

		local x = w / 2 - 256
		local y = h + 16

		surface.DrawTexturedRect(x, y, 64, 64)

		draw.SimpleText(drone:GetFuel(), "DronesRewrite_font3", x - 8, y + 16, Color(255 - fuel, fuel, 0), TEXT_ALIGN_RIGHT)

		if drone:GetFuel() <= drone.MaxFuel / 4 then
			if not warn2 then
				Warning("LOW FUEL !!!", 5)
				warn2 = true
			end
		else
			if warn2 then
				warn2 = false
			end
		end
	end

	if shouldDrawWeps then
		local h = h / 2

		local ammo = (drone:GetPrimaryAmmo() / drone:GetPrimaryMax()) * 255
		local color = Color(255 - ammo, ammo, 0, alpha)

		surface.SetDrawColor(color)
		surface.SetMaterial(Material("stuff/whiteboxhud/ammo"))

		local x = w / 2 + 192
		local y = h - 64

		surface.DrawTexturedRect(x, y, 64, 64)
		draw.SimpleText("1", "DronesRewrite_font3", x + 64, y + 32, color)
		draw.SimpleText(drone:GetPrimaryAmmo(), "DronesRewrite_font3", x + 86, y + 16, color)

		local ammo = (drone:GetSecondaryAmmo() / drone:GetSecondaryMax()) * 255
		local color = Color(255 - ammo, ammo, 0, alpha)

		local y = h + 16

		surface.SetDrawColor(color)
		surface.SetMaterial(Material("stuff/whiteboxhud/ammo"))
		surface.DrawTexturedRect(x, y, 64, 64)

		draw.SimpleText(drone:GetSecondaryAmmo(), "DronesRewrite_font3", x + 86, y + 16, color)
		draw.SimpleText("2", "DronesRewrite_font3", x + 64, y + 32, color)
	end

	if warning then
		local x, y = w/2, h/2
		local a = 120 + math.sin(CurTime() * 6) * 80

		draw.SimpleText("WARNING", "DronesRewrite_customfont1big", x, y + 40, Color(255, 0, 0, a), TEXT_ALIGN_CENTER)
		draw.SimpleText(warning.text, "DronesRewrite_customfont1big2", x, y + 120, Color(255, 0, 0, a), TEXT_ALIGN_CENTER)
	end
end
