DRONES_REWRITE.Weapons["Artillery Cannon"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/artillery_cannon/artillery_cannon.mdl", pos, ang, "models/dronesrewrite/artillery_mount/artillery_mount.mdl", pos - Vector(0, 0, 30))

		ent.RotSpeed = 0.01
		ent.CamOffset = 1.2

		ent.PrimaryAmmo = 40
		ent.PrimaryAmmoMax = 40
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.CannonAmmo }

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			local src = gun:GetPos() + gun:GetForward() * 100 + gun:GetUp() * -4
			local src2 = gun:GetPos() + gun:GetForward() * -30 + gun:GetUp() * -4
			local src3 = gun:GetPos() + gun:GetForward() * 350 + gun:GetUp() * -4
			
			ParticleEffect("artillery_muzzle_main", src3, gun:GetAngles())

			local seq = gun:LookupSequence("fire")
			gun:ResetSequence(seq)
			gun:SetPlaybackRate( 1.0 )
			gun:SetSequence(seq)

			local ammo = ents.Create("dronesrewrite_projectile")
			ammo:SetPos(src)
			ammo:SetOwner(self:GetDriver())
			ammo:SetAngles(gun:GetAngles())
			ammo:Spawn()
			
			local shell = ents.Create("prop_physics")
			shell:SetModel("models/dronesrewrite/artillery_ammo_shell/artillery_ammo_shell.mdl")
			shell:SetPos(src2)
			shell:SetOwner(self:GetDriver())
			shell:SetAngles(gun:GetAngles())
			
			timer.Simple(0.3, function()
				shell:Spawn()
				
				local physshell = shell:GetPhysicsObject()
				
				if IsValid(physshell) then 
					physshell:AddVelocity(gun:GetUp() * -1000)
					physshell:AddAngleVelocity(Vector(0, 1500, 0))
				end 
				
				SafeRemoveEntityDelayed(shell, 15)
			end)	
			
			constraint.NoCollide(ammo, self, 0, 0)
			constraint.NoCollide(shell, self, 0, 0)

			local physamm = ammo:GetPhysicsObject()
			//if IsValid(physamm) then physamm:SetGravity(500) end 
			
			physamm:AddVelocity(gun:GetForward() * 50000)

			ammo:EmitSound("ambient/explosions/explode_4.wav", 100, 100, 1, CHAN_WEAPON)

			gun:SetPrimaryAmmo(-1)

			gun:EmitSound("weapons/shotgun/shotgun_cock.wav", 80, 70)
			
			timer.Simple(3, function()
				if IsValid(gun) then gun:EmitSound("vehicles/tank_readyfire1.wav", 80, 255) end
			end)
			gun.NextShoot = CurTime() + 3
		end
	end
}