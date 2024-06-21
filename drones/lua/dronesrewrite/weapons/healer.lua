DRONES_REWRITE.Weapons["Healer"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/laser/laser.mdl", pos, ang, "models/dronesrewrite/attachment4/attachment4.mdl", pos)
		ent:SetMaterial("models/dronesrewrite/guns/laserh_mat")

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
		
		util.ParticleTracerEx("laser_beam_g_drr", gun.Source:GetPos(), tr.HitPos, false, gun:EntIndex(), -1)
		ParticleEffect("laser_hit_g_drr", tr.HitPos, gun:GetLocalCamAng())

		if CurTime() > gun.NextShoot then
			local ent = tr.Entity
			if ent:IsValid() and ent:IsPlayer() or ent:IsNPC() then
				ent:SetHealth(math.min(ent:GetMaxHealth(), ent:Health() + 1 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()))
			end

			gun.NextShoot = CurTime() + 0.05
		end
		
		self:SwitchLoopSound("Laser", true, "ambient/energy/force_field_loop1.wav", 150, 1)
	end
}