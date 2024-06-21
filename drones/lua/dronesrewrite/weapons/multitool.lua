local modes = {
	[1] = "Keypad hacking mode",
	[2] = "Physgun mode"
}

local modesfunc = {
	[1] = function(self, gun, tr)
		local ent = tr.Entity

		if IsValid(ent) then
			if ent:GetClass() == "keypad" or ent:GetClass() == "keypad_wire" or ent:GetClass() == "gmod_wire_keypad" then
				if not ent.DrrHackProcess then ent.DrrHackProcess = 0 end
				ent.DrrHackProcess = ent.DrrHackProcess + 1

				ent:EmitSound("buttons/button1" .. math.random(7, 9) .. ".wav", 60)

				if ent.DrrHackProcess > 10 then
					ent.DrrHackProcess = nil
					
					if ent.Process then 
						ent:Process(true) 
					elseif ent.IsWire and Wire_TriggerOutput then
						ent:SetNetworkedString("keypad_display", "y")
						Wire_TriggerOutput(ent, "Valid", 1)
						ent:EmitSound("buttons/button9.wav")
					end
				end
			end
		end

		gun.NextShoot = CurTime() + 0.3
	end,

	[2] = function(self, gun, tr)
		local ent = tr.Entity

		if ent != gun.Physgun then
			gun.Physgun = ent
			gun.Dist = gun.Physgun:GetPos():Distance(gun:GetPos())
		elseif IsValid(gun.Physgun) and gun.Dist then
			local phys = gun.Physgun:GetPhysicsObject()

			if phys:IsValid() then
				local newtr = util.TraceLine({
					start = gun:GetPos(),
					endpos = gun:GetPos() + gun:GetForward() * gun.Dist,
					filter = gun.Physgun
				})
				
				local propPos = gun.Physgun:LocalToWorld(gun.Physgun:OBBCenter())
				
				phys:ApplyForceCenter((newtr.HitPos - propPos):GetNormal() * newtr.HitPos:Distance(propPos) * phys:GetMass() * 600)
				phys:ApplyForceCenter(-phys:GetVelocity() * phys:GetMass() * 0.9)
				phys:AddAngleVelocity(-phys:GetAngleVelocity() * 0.3)
			end
		end

		gun.NextShoot = CurTime()
	end
}

DRONES_REWRITE.Weapons["Multitool"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/multitool/multitool.mdl", pos, ang, "models/dronesrewrite/attachment2/attachment2.mdl", pos + Vector(0, 0, 4.8))

		ent.Mode = 1

		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, Vector(20, 0, 0))

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	OnAttackStopped = function(self, gun)
		self:SwitchLoopSound("Laser", false)
	end,

	Holster = function(self, gun)
		self:SwitchLoopSound("Laser", false)
	end,

	OnRemove = function(self, gun)
		self:SwitchLoopSound("Laser", false)
	end,

	Attack = function(self, gun)
		local tr = self:GetCameraTraceLine()

		util.ParticleTracerEx("laser_beam_drr", gun.Source:GetPos(), tr.HitPos, false, gun:EntIndex(), -1)
		ParticleEffect("laser_hit_drr", tr.HitPos, gun:GetLocalCamAng())

		if CurTime() > gun.NextShoot then
			if modesfunc[gun.Mode] then
				modesfunc[gun.Mode](self, gun, tr)
			end
		end

		self:SwitchLoopSound("Laser", true, "ambient/energy/force_field_loop1.wav", 150, 1)
	end,

	Attack2 = function(self, gun)
		if self:WasKeyPressed("Fire2") then
			gun.Mode = gun.Mode + 1
			if gun.Mode > 2 then gun.Mode = 1 end

			local driver = self:GetDriver()
			if IsValid(driver) then driver:ChatPrint("[Drones] " .. modes[gun.Mode]) end
		end
	end
}