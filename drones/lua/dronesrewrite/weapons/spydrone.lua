DRONES_REWRITE.Weapons["Spy Drone Deployer"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].InitializeNoHandler(self, "models/props_lab/tpplug.mdl", pos, ang + Angle(90, 0, 0))

		ent.PrimaryAmmo = 3
		ent.PrimaryAmmoMax = 3
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.SpyDrones }

		ent.OldDriver = NULL

		return ent
	end,

	Think = function(self, gun)
		if (not IsValid(gun.OldDriver) or not IsValid(gun.Spy) or not gun.Spy:IsDroneWorkable()) and gun.SetupCam then
			SafeRemoveEntity(gun.Spy)

			self.Useable = true
			gun.SetupCam = false

			if gun.OldDriver then
				self:SetDriver(gun.OldDriver)
			end

			gun.OldDriver = NULL
		end
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() and not IsValid(gun.Spy) then
			gun.OldDriver = self:GetDriver()
			if not IsValid(gun.OldDriver) then return end

			local src = gun:GetPos() - gun:GetUp() * 8

			local ammo = ents.Create("dronesrewrite_spydrone")
			ammo:SetPos(src)
			ammo:SetAngles(gun:GetAngles())
			ammo:Spawn()

			ammo.Owner = gun.OldDriver

			self:SetDriver(NULL)
			self.Useable = false
			ammo:SetDriver(gun.OldDriver)

			ammo:AddHook("DroneDestroyed", "sd_eff", function()
				local ef = EffectData()
				ef:SetOrigin(ammo:GetPos())
				util.Effect("dronesrewrite_explosionsmall", ef)

				ammo:Remove() 
			end)

			ammo:AddHook("DriverExit", "sd_exit", function() ammo:Destroy() end)
			ammo:AddHook("SignalLost", "sd_lost", function() ammo:Destroy() end)
			
			constraint.NoCollide(ammo, self, 0, 0)

			gun.Spy = ammo
			gun.SetupCam = true

			gun:EmitSound("buttons/combine_button3.wav", 75, 100, 1, CHAN_WEAPON)

			gun:SetPrimaryAmmo(-1)
			gun.NextShoot = CurTime() + 3
		end
	end,

	OnRemove = function(self, gun)
		SafeRemoveEntity(gun.Spy)
	end
}