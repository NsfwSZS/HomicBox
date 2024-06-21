DRONES_REWRITE.Weapons["Minedropper"] = {
	Initialize = function(self, pos, ang, src)
		local ent = DRONES_REWRITE.Weapons["Template"].InitializeNoHandler(self, "models/dronesrewrite/minedropper_wep/minedropper_wep.mdl", pos, ang)
		ent.Mines = { }

		ent.RespawnMine = function()
			if IsValid(ent.Mine) then return end
			if not ent:HasPrimaryAmmo() then
				ent.WaitForAmmo = true
				return
			end

			ent:EmitSound("items/ammo_pickup.wav", 70, 140)

			local ang = ent:GetAngles()

			local e = ents.Create("prop_physics")
			e:SetModel("models/dronesrewrite/landmine/landmine.mdl")
			e:SetPos(ent:GetPos() + ang:Right() * 15 - ang:Up() * 9.3)
			ang = self:GetAngles()
			ang:RotateAroundAxis(ang:Up(), 45)
			e:SetAngles(ang)
			e:Spawn()
			e:Activate()
			e:SetParent(ent)
			e:SetNotSolid(true)
			e:PhysicsDestroy()

			ent.Mine = e
		end

		ent:RespawnMine()

		ent.PrimaryAmmo = 10
		ent.PrimaryAmmoMax = 10
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Mines }

		return ent
	end,

	Attack = function(self, gun)
		if self:WasKeyPressed("Fire1") and CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			if not IsValid(gun.Mine) then return end

			gun:EmitSound("buttons/lightswitch2.wav", 70, 200, CHAN_WEAPON)

			local mine = ents.Create("dronesrewrite_mine")
			mine:SetPos(gun.Mine:GetPos())
			mine:SetAngles(gun.Mine:GetAngles())
			
			mine.DroneOwner = self
			mine.Owner = self:GetDriver()
			
			mine:Spawn()
			mine:GetPhysicsObject():SetVelocity(self:GetVelocity())
			
			table.insert(gun.Mines, mine)

			SafeRemoveEntity(gun.Mine)

			gun:SetPrimaryAmmo(-1)
			gun.NextShoot = CurTime() + 1
		end
	end,

	Attack2 = function(self, gun)
		for k, v in pairs(gun.Mines) do
			if IsValid(v) then
				v:Boom()
			end
		end
	end,

	Think = function(self, gun)
		if gun.WaitForAmmo and gun:HasPrimaryAmmo() then
			gun:RespawnMine()
			gun.WaitForAmmo = false
		end

		if not IsValid(gun.Mine) and CurTime() > gun.NextShoot then
			gun:RespawnMine()
		end
	end,
}