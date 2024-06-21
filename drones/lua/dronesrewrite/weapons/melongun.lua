DRONES_REWRITE.Weapons["Melon Thrower"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].InitializeNoHandler(self, "models/weapons/w_rocket_launcher.mdl", pos, ang)

		ent.PrimaryAmmo = 100500
		ent.PrimaryAmmoMax = 100500
		ent.PrimaryAmmoType = {  }

		ent.WaitTime = 0

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			local ent = ents.Create("prop_physics")
			ent:SetModel("models/props_junk/watermelon01.mdl")
			ent:SetPos(gun:GetPos() + gun:GetForward() * 50)
			ent:Spawn()
			ent:EmitSound("weapons/ar2/ar2_altfire.wav")

			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then phys:EnableGravity(false) phys:SetMass(50000) phys:SetVelocity(gun:GetForward() * 99999999) end
	
			gun.NextShoot = CurTime() + 0.1
		end
	end
}