DRONES_REWRITE.Weapons["Turret's Gun"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].InitializeNoDraw(self)
		
		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, pos)

		ent.PrimaryAmmo = 500
		ent.PrimaryAmmoMax = 500
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Pistol }

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			local damage = 11 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()
			local force = 4 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()

			local bullet = {}
			bullet.Num = 1
			bullet.Src = gun.Source:GetPos()
			bullet.Dir = gun:GetLocalCamDir()
			bullet.Spread = Vector(0.03, 0.03, 0.03)
			bullet.Tracer = 1
			bullet.TracerName = "AR2Tracer"
			bullet.Force = force
			bullet.Damage = damage
			bullet.Attacker = self:GetDriver()
			
			gun.Source:FireBullets(bullet)
			gun:EmitSound("npc/turret_floor/shoot" .. math.random(1, 3) .. ".wav", 82, 100, 1, CHAN_WEAPON)

			self:SetSequence(self:LookupSequence("Fire"))

			gun:SetPrimaryAmmo(-1)
			gun.NextShoot = CurTime() + 0.07
		end
	end
}