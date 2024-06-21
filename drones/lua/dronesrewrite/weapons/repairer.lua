DRONES_REWRITE.Weapons["Repairer"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/laser/laser.mdl", pos, ang, "models/dronesrewrite/attachment4/attachment4.mdl", pos)
		ent:SetMaterial("models/dronesrewrite/guns/laserr_mat")
		
		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, Vector(40, 0, -1.75))

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

		util.ParticleTracerEx("laser_beam_b_drr", gun.Source:GetPos(), tr.HitPos, false, gun:EntIndex(), -1)
		ParticleEffect("laser_hit_b_drr", tr.HitPos, gun:GetLocalCamAng())

		local ent = tr.Entity
		
		if CurTime() > gun.NextShoot and ent:IsValid() then
			if ent.IS_DRR then
				if ent:GetHealth() < ent:GetDefaultHealth() then ent:SetHealthAmount(ent:GetHealth() + 3) end
			elseif ent:GetClass() == "dronesrewrite_console" then
				ent:Repair()
			else
				ent:TakeDamage(1)
			end

			gun.NextShoot = CurTime() + 0.3
		end

		self:SwitchLoopSound("Laser", true, "ambient/energy/force_field_loop1.wav", 150, 1)
	end
}