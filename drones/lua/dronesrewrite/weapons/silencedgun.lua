DRONES_REWRITE.Weapons["Silent Rifle"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/silenced/silenced.mdl", pos, ang)

		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, Vector(46, 0, -4))

		ent.PrimaryAmmo = 200
		ent.PrimaryAmmoMax = 200
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Pistol }

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if self:WasKeyPressed("Fire1") then
			if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
				local damage = math.random(13,18) * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()
				local force = 5 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()

				local tr = self:GetCameraTraceLine()

				local bullet = {}
				bullet.Num = 1
				bullet.Src = gun.Source:GetPos()
				bullet.Dir = gun:GetLocalCamDir()
				bullet.Spread = Vector(0.004, 0.004, 0.004)
				bullet.Tracer = 1
				bullet.Force = force
				bullet.Damage = damage
				bullet.Attacker = self:GetDriver()
				
				gun.Source:FireBullets(bullet)
				gun:EmitSound("weapons/usp/usp1.wav", 62, 100, 1, CHAN_WEAPON)
				
				local ef = EffectData()
				ef:SetOrigin(gun.Source:GetPos())
				ef:SetNormal(gun:GetForward())
				util.Effect("dronesrewrite_muzzleflashsmall", ef)

				gun:SetPrimaryAmmo(-1)
				gun.NextShoot = CurTime() + 0.2
			end
		end
	end
}