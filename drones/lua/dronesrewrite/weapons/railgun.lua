DRONES_REWRITE.Weapons["Railgun"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/railgun/railgun.mdl", pos, ang)

		ent.PrimaryAmmo = 200
		ent.PrimaryAmmoMax = 200
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.RailgunSticks }

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			local ammo = ents.Create("dronesrewrite_rail")
			ammo:SetPos(gun:GetPos() - gun:GetForward() * 64)
			ammo:SetOwner(self:GetDriver())
			ammo:SetAngles(gun:GetAngles())
			ammo:Spawn()
					
			constraint.NoCollide(ammo, self, 0, 0)

			local physamm = ammo:GetPhysicsObject()
			if IsValid(physamm) then physamm:EnableGravity(false) end 
					
			physamm:AddVelocity(gun:GetForward() * 5000)

			ammo:EmitSound("weapons/gauss/fire1.wav", 75, math.random(120, 200), 1, CHAN_WEAPON)

			gun:SetPrimaryAmmo(-1)
			gun.NextShoot = CurTime() + 0.13
		end
	end
}