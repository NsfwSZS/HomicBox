DRONES_REWRITE.Weapons["Double Gun"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/doublegun/doublegun.mdl", pos, ang, "models/dronesrewrite/attachment4/attachment4.mdl", pos)

		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, Vector(40, 0, 3))

		ent.PrimaryAmmo = 2000
		ent.PrimaryAmmoMax = 2000
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Pistol }

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			local damage = 8 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()
			local force = 25 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()

			local tr = self:GetCameraTraceLine()

			local bullet = {}
			bullet.Num = 1
			bullet.Src = gun.Source:GetPos()
			bullet.Dir = gun:GetLocalCamDir()
			bullet.Spread = Vector(0.02, 0.02, 0.02)
			bullet.Tracer = 1
			bullet.Force = force
			bullet.Damage = damage
			bullet.Attacker = self:GetDriver()
			
			gun.Source:FireBullets(bullet)
			gun:EmitSound("weapons/shotgun/shotgun_fire" .. math.random(6, 7) .. ".wav", 85, math.random(150, 180), 1, CHAN_WEAPON)

			local bullet = {}
			bullet.Num = 1
			bullet.Src = gun.Source:LocalToWorld(Vector(0, 0, -3))
			bullet.Dir = gun:GetLocalCamDir()
			bullet.Spread = Vector(0.02, 0.02, 0.02)
			bullet.Tracer = 1
			bullet.Force = force
			bullet.Damage = damage
			bullet.Attacker = self:GetDriver()
			
			gun.Source:FireBullets(bullet)
			gun:EmitSound("weapons/shotgun/shotgun_fire" .. math.random(6, 7) .. ".wav", 85, math.random(150, 180), 1, CHAN_WEAPON)

			if not DRONES_REWRITE.ServerCVars.NoRecoil:GetBool() then
				local phys = self:GetPhysicsObject()
				phys:ApplyForceCenter((gun:GetPos() - tr.HitPos):GetNormal() * 200)
				phys:AddAngleVelocity(VectorRand() * 1.2)
			end

			if not DRONES_REWRITE.ServerCVars.NoShells:GetBool() then
				local ef = EffectData()
				ef:SetOrigin(gun:LocalToWorld(Vector(9, 1, 0)))
				ef:SetAngles(gun:LocalToWorldAngles(Angle(0, 90, 0)))
				util.Effect("ShellEject", ef)

				local ef = EffectData()
				ef:SetOrigin(gun:LocalToWorld(Vector(9, 1, 3)))
				ef:SetAngles(gun:LocalToWorldAngles(Angle(0, 90, 0)))
				util.Effect("ShellEject", ef)
			end
			
			local ef = EffectData()
			ef:SetOrigin(gun.Source:GetPos())
			ef:SetNormal(gun:GetForward())
			util.Effect("dronesrewrite_muzzleflash", ef)

			gun:SetPrimaryAmmo(-1)
			gun.NextShoot = CurTime() + 0.07
		end
	end
}