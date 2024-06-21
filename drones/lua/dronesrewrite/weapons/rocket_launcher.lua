DRONES_REWRITE.Weapons["Rocket Launcher"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/rocket_launcher/rocket_launcher.mdl", pos, ang, "models/dronesrewrite/attachment4/attachment4.mdl", pos)

		ent.PrimaryAmmo = 40
		ent.PrimaryAmmoMax = 40
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Rockets }

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			local src = gun:GetPos() + gun:GetForward() + gun:GetUp() * 2

			local ammo = ents.Create("dronesrewrite_rocket")
			ammo:SetPos(src)
			ammo:SetOwner(self:GetDriver())
			ammo:SetAngles(gun:GetAngles())
			ammo:Spawn()
			
			constraint.NoCollide(ammo, self, 0, 0)

			local physamm = ammo:GetPhysicsObject()
			if IsValid(physamm) then physamm:EnableGravity(false) end 
			
			physamm:AddVelocity(gun:GetForward() * 5000)

			ammo:EmitSound("weapons/rpg/rocketfire1.wav", 79, 100, 1, CHAN_WEAPON)

			gun:SetPrimaryAmmo(-1)

			timer.Simple(0.3, function()
				if IsValid(gun) then gun:EmitSound("vehicles/tank_readyfire1.wav", 80, 255) end
			end)
			gun.NextShoot = CurTime() + 1.2
		end
	end
}