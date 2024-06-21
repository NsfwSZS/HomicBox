DRONES_REWRITE.Weapons["Assault Rifle"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/gun/gun.mdl", pos, ang)
		
		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, Vector(36, 0, -4))

		ent.PrimaryAmmo = 1000
		ent.PrimaryAmmoMax = 1000
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Pistol }

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			local damage = 10 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()
			local force = 10 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()

			local bullet = {}
			bullet.Num = 1
			bullet.Src = gun.Source:GetPos()
			bullet.Dir = gun:GetLocalCamDir()
			bullet.Spread = Vector(0.03, 0.02, 0.02)
			bullet.Tracer = 1
			bullet.Force = force
			bullet.Damage = damage
			bullet.Attacker = self:GetDriver()
			
			gun.Source:FireBullets(bullet)
			gun:EmitSound("weapons/shotgun/shotgun_fire" .. math.random(6, 7) .. ".wav", 85, math.random(180, 200), 1, CHAN_WEAPON)

			if not DRONES_REWRITE.ServerCVars.NoRecoil:GetBool() then
				local phys = self:GetPhysicsObject()
				phys:ApplyForceCenter((gun:GetPos() - self:GetCameraTraceLine().HitPos):GetNormal() * 50000 / self.Weight)
				phys:AddAngleVelocity(VectorRand() * 200 / self.Weight)
			end
			
			local ef = EffectData()
			ef:SetOrigin(gun.Source:GetPos())
			ef:SetNormal(gun:GetForward())
			util.Effect("dronesrewrite_muzzleflash", ef)

			if not DRONES_REWRITE.ServerCVars.NoShells:GetBool() then
				local ef = EffectData()
				ef:SetOrigin(gun:LocalToWorld(Vector(0, 6, -7)))
				ef:SetAngles(gun:LocalToWorldAngles(Angle(0, 90, 0)))
				util.Effect("ShellEject", ef)
			end

			gun:SetPrimaryAmmo(-1)
			gun.NextShoot = CurTime() + 0.05
		end
	end
}