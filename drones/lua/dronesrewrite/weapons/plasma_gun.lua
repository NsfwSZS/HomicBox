DRONES_REWRITE.Weapons["Plasma Rifle"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/plasmagun/plasmagun.mdl", pos, ang)

		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, Vector(17.5, 2, -3.5))

		ent.PrimaryAmmo = 800
		ent.PrimaryAmmoMax = 1200
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Plasma }

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			local damage = math.random(8,12) * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()
			local force = 5 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()

			local tr = self:GetCameraTraceLine()

			local bullet = {}
			bullet.Num = 1
			bullet.Src = gun.Source:GetPos()
			bullet.Dir = gun:GetLocalCamDir()
			bullet.Spread = Vector(0.04, 0.03, 0.03)
			bullet.Tracer = 1
			bullet.TracerName = "nrg_tracer_drr"
			bullet.Force = force
			bullet.Damage = damage
			bullet.Attacker = self:GetDriver()
			bullet.Callback = function(ply, tr)
				ParticleEffect("blade_glow_drr", tr.HitPos, Angle(0, 0, 0))

				sound.Play("drones/eblade_shock_01.wav", tr.HitPos, 60, 160)

				if math.random(1, 20) == 1 then
					ParticleEffect("electrical_arc_01_system", tr.HitPos, Angle(0, 0, 0))
				end

				util.Decal("FadingScorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
			end

			gun:FireBullets(bullet)
			gun:EmitSound("drones/nio_dissolve.wav", 85, math.random(150, 180), 1, CHAN_WEAPON)

			local ef = EffectData()
			ef:SetOrigin(gun.Source:LocalToWorld(Vector(0, -2, 0)))
			ef:SetNormal(gun:GetForward())
			util.Effect("dronesrewrite_muzzleflashplasma", ef)

			if not DRONES_REWRITE.ServerCVars.NoRecoil:GetBool() then
				local phys = self:GetPhysicsObject()
				phys:ApplyForceCenter((gun:GetPos() - tr.HitPos):GetNormal() * 50000 / self.Weight)
				phys:AddAngleVelocity(VectorRand() * 200 / self.Weight)
			end
	
			gun:SetPrimaryAmmo(-1)
			gun.NextShoot = CurTime() + 0.1
		end
	end
}