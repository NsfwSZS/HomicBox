DRONES_REWRITE.Weapons["Pistol"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/pistol/pistol.mdl", pos, ang)

		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, Vector(8, 0, -4))

		ent.PrimaryAmmo = 120
		ent.PrimaryAmmoMax = 120
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Pistol }

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if self:WasKeyPressed("Fire1") then
			if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
				local tr = self:GetCameraTraceLine()

				local bullet = {}
				bullet.Num = 1
				bullet.Src = gun.Source:GetPos()
				bullet.Dir = gun:GetLocalCamDir()
				bullet.Spread = Vector(0.015, 0.015, 0.015)
				bullet.Tracer = 1
				bullet.Force = 5 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()
				bullet.Damage = math.random(5, 12) * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()
				bullet.Attacker = self:GetDriver()
				
				gun.Source:FireBullets(bullet)
				gun:EmitSound("weapons/pistol/pistol_fire2.wav", 70, 100, 1, CHAN_WEAPON)
				
				local ef = EffectData()
				ef:SetOrigin(gun.Source:GetPos())
				ef:SetNormal(gun:GetForward())
				util.Effect("dronesrewrite_muzzleflashsmall", ef)

				local ef = EffectData()
				ef:SetOrigin(gun:LocalToWorld(Vector(2, 1, -5)))
				ef:SetAngles(gun:LocalToWorldAngles(Angle(0, 90, 0)))
				util.Effect("ShellEject", ef)

				gun:SetPrimaryAmmo(-1)
				gun.NextShoot = CurTime() + 0.15
			end
		end
	end
}