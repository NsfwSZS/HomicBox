DRONES_REWRITE.Weapons["Hell Skull"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].InitializeNoDraw(self)
		
		ent.PrimaryAmmo = 32
		ent.PrimaryAmmoMax = 32
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.HellSkulls }

		local function EndHell()
			if IsValid(self) and self.PoorHellVictims then
				for k, v in pairs(self.PoorHellVictims) do
					v:ConCommand("dronesrewrite_end_hell")
				end
			end
		end

		self:AddHook("DroneDestroyed", "hellEndD", EndHell)
		self:AddHook("Remove", "hellEndR", EndHell)

		return ent
	end,

	OnRemove = function(self)
		--self:RemoveHook("DroneDestroyed", "hellEndD")
		--self:RemoveHook("Remove", "hellEndR")
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			local src = gun:GetPos() - self:GetUp() * 18

			local ammo = ents.Create("dronesrewrite_hellskull")
			ammo.Owner = self:GetDriver()
			ammo.LightbringerDr = self

			ammo:SetPos(src)
			ammo:SetAngles(gun:GetAngles() + AngleRand() * 0.004)
			ammo:Spawn()
			
			constraint.NoCollide(ammo, self, 0, 0)

			ammo:EmitSound("drones/eblade_shock_01.wav", 85, 50, 1, CHAN_WEAPON)
	
			gun:SetPrimaryAmmo(-1)
			gun.NextShoot = CurTime() + 0.5
		end
	end
}