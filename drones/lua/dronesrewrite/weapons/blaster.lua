DRONES_REWRITE.Weapons["Electric Blaster"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/blaster/blaster.mdl", pos, ang, "models/dronesrewrite/attachment4/attachment4.mdl", pos)

		ent.PrimaryAmmo = 800
		ent.PrimaryAmmoMax = 800
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Blaster }

		ent.WaitTime = 0

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)

		if gun.PlaySound and CurTime() > gun.NextShoot2 then
			gun:EmitSound("vehicles/tank_readyfire1.wav", 78, 255, 1, CHAN_WEAPON)
			gun.PlaySound = false
		end
	end,

	Attack = function(self, gun)
		if not self:IsKeyDown("Fire2") and  CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			local src = gun:GetPos() + gun:GetForward() * 64 + gun:GetUp()

			local ammo = ents.Create("dronesrewrite_bl_laser")
			ammo:SetPos(src)
			ammo:SetAngles(gun:GetAngles() + AngleRand() * 0.004)
			ammo:Spawn()
			ammo.Owner = self:GetDriver()
			
			constraint.NoCollide(ammo, self, 0, 0)

			ammo:EmitSound("drones/eblade_shock_01.wav", 85, 110, 1, CHAN_WEAPON)

			local ef = EffectData()
			ef:SetOrigin(src - gun:GetForward() * 20)
			ef:SetNormal(gun:GetForward())
			util.Effect("dronesrewrite_muzzleflashblaster", ef)
	
			gun:SetPrimaryAmmo(-1)
			gun.NextShoot = CurTime() + 0.1
		end
	end,

	Attack2 = function(self, gun)
		if not self:IsKeyDown("Fire1") and CurTime() > gun.NextShoot2 and gun:HasPrimaryAmmo() then
			local src = gun:GetPos() + gun:GetForward() * 64 - gun:GetUp() * 2.5

			local ammo = ents.Create("dronesrewrite_bl_laser")
			ammo:SetPos(src)
			ammo:SetAngles(gun:GetAngles() + AngleRand() * 0.02)
			ammo:Spawn()
			ammo.Owner = self:GetDriver()
			
			constraint.NoCollide(ammo, self, 0, 0)

			ammo:EmitSound("drones/eblade_shock_01.wav", 85, math.random(130, 160), 1, CHAN_WEAPON)

			local ef = EffectData()
			ef:SetOrigin(src - gun:GetForward() * 21)
			ef:SetNormal(gun:GetForward())
			util.Effect("dronesrewrite_muzzleflashblaster", ef)	

			gun:SetPrimaryAmmo(-1)
			gun.NextShoot2 = CurTime() + 0.02

			gun.WaitTime = math.Approach(gun.WaitTime, 1, 0.1)
			if gun.WaitTime >= 1 then 
				gun.PlaySound = true
				gun.NextShoot2 = CurTime() + 3.6
				gun.WaitTime = 0
			end
		end
	end
}