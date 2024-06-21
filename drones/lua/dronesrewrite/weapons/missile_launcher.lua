DRONES_REWRITE.Weapons["Missile Battery"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/rocket_battery/rocket_battery.mdl", pos, ang, "models/dronesrewrite/attachment3/attachment3.mdl", pos + ang:Up() * 7 + ang:Forward() * 2)
		ent.Rockets = { }

		local count = 1

		ent.AddRockets = function(ent)
			local count = 1

			for a = 0, 6 do
				for b = 0, 3 do
					SafeRemoveEntity(ent.Rockets[count])

					local h = ents.Create("prop_physics")
					h:SetModel("models/dronesrewrite/bigrocket_cl/bigrocket_cl.mdl")
					h:SetPos(ent:LocalToWorld(Vector(0, a * 4.7, b * 4.7)) + ent:GetUp() * 9.7 + ent:GetRight() * 14 + ent:GetForward() * 33)
					h:SetAngles(ent:GetAngles())
					h:Spawn()
					h:Activate()
					h:SetParent(ent)
					h:SetNotSolid(true)
					h:PhysicsDestroy()

					ent.Rockets[count] = h

					count = count + 1
				end
			end
		end

		ent:AddRockets()

		ent.PrimaryAmmo = 100
		ent.PrimaryAmmoMax = 100
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Missiles }

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	OnPrimaryAdded = function(self, gun, num)
		gun:AddRockets()
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			local rocket = table.Random(gun.Rockets)
			if not IsValid(rocket) then return end

			local ammo = ents.Create("dronesrewrite_missile")
			ammo:SetPos(rocket:GetPos())
			ammo:SetOwner(self:GetDriver())
			ammo:SetAngles(rocket:GetAngles())
			ammo:Spawn()
					
			constraint.NoCollide(ammo, self, 0, 0)

			local physamm = ammo:GetPhysicsObject()
			if IsValid(physamm) then physamm:EnableGravity(false) end 
					
			physamm:AddVelocity(gun:GetForward() * 5000)

			local pos = gun:WorldToLocal(rocket:GetPos())
			local id = table.KeyFromValue(gun.Rockets, rocket)

			rocket:EmitSound("drones/missilelaunch.wav", 86, math.random(95, 115), 1, CHAN_WEAPON)
			gun:SetPrimaryAmmo(-1)

			local ef = EffectData()
			ef:SetOrigin(rocket:GetPos())
			ef:SetNormal(gun:GetForward())
			util.Effect("dronesrewrite_missilelaunch", ef)
			
			if not DRONES_REWRITE.ServerCVars.NoAmmo:GetBool() then
				rocket:Remove()
				gun.Rockets[id] = nil

				-- 28 is a number of rockets in the launcher
				if gun:GetPrimaryAmmo() >= 28 then
					timer.Simple(15, function()
						if not self:IsValid() then return end
						if not gun:IsValid() then return end
						if not gun:HasPrimaryAmmo() then return end
						if IsValid(gun.Rockets[id]) then return end

						local h = ents.Create("prop_physics")
						h:SetModel("models/dronesrewrite/bigrocket_cl/bigrocket_cl.mdl")
						h:SetPos(gun:LocalToWorld(pos))
						h:SetAngles(gun:GetAngles())
						h:Spawn()
						h:Activate()
						h:SetParent(gun)
						h:SetNotSolid(true)
						h:PhysicsDestroy()

						gun.Rockets[id] = h
						gun:EmitSound("items/ammocrate_close.wav")
					end)
				end
			end

			gun.NextShoot = CurTime() + 0.35
		end
	end
}