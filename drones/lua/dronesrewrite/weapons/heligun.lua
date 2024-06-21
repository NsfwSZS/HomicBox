DRONES_REWRITE.Weapons["Helicopter Gun"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].InitializeNoHandler(self, "models/gibs/gunship_gibs_nosegun.mdl", pos, ang)

		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, Vector(60, 0, -12))

		ent.PrimaryAmmo = 3000
		ent.PrimaryAmmoMax = 3000
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Pistol }

		ent.WaitForAttack = 0

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			if gun.WaitForAttack == 0 then
				self:EmitSound("npc/attack_helicopter/aheli_charge_up.wav", 90)
			end

			gun.WaitForAttack = gun.WaitForAttack + 1

			if gun.WaitForAttack > 60 then
				local damage = 14 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()
				local force = 10 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()

				self:SwitchLoopSound("GunHeli", true, "npc/attack_helicopter/aheli_weapon_fire_loop3.wav", 100, 1, 95)

				local bullet = {}
				bullet.Num = 1
				bullet.Src = gun.Source:GetPos()
				bullet.Dir = gun:GetLocalCamDir()
				bullet.Spread = Vector(0.07, 0.07, 0.07)
				bullet.Tracer = 1
				bullet.TracerName = "HelicopterTracer"
				bullet.Force = force
				bullet.Damage = damage
				bullet.Attacker = self:GetDriver()
				
				gun.Source:FireBullets(bullet)

				gun:SetPrimaryAmmo(-1)
			end

			gun.NextShoot = CurTime() + 0.02

			if gun.WaitForAttack > 220 then 
				gun.Tab.OnAttackStopped(self, gun) 
			end
		end
	end,

	OnAttackStopped = function(self, gun)
		self:SwitchLoopSound("GunHeli", false)
		gun.WaitForAttack = 0
		gun.NextShoot = CurTime() + 2
	end,

	Holster = function(self, gun)
		self:SwitchLoopSound("GunHeli", false)
	end,

	OnRemove = function(self, gun)
		self:SwitchLoopSound("GunHeli", false)
	end,
}