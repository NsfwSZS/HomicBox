DRONES_REWRITE.Weapons["Laser"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/laser/laser.mdl", pos, ang, "models/dronesrewrite/attachment4/attachment4.mdl", pos)
		ent:SetMaterial("models/dronesrewrite/guns/laserd_mat")
		
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
		local damage = 0.7 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()
		local tr = self:GetCameraTraceLine()

		util.ParticleTracerEx("laser_beam_r_drr", gun.Source:GetPos(), tr.HitPos, false, gun:EntIndex(), -1)
		ParticleEffect("laser_hit_r_drr", tr.HitPos, gun:GetLocalCamAng())

		local ent = tr.Entity
		if ent:IsValid() then
			ent:TakeDamage(damage, self:GetDriver(), self)
		end

		util.Decal("FadingScorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

		self:SwitchLoopSound("Laser", true, "ambient/energy/force_field_loop1.wav", 150, 1)
	end
}