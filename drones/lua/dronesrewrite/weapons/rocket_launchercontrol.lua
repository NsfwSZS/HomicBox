DRONES_REWRITE.Weapons["Homing Missile Launcher"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/hrocketlnc/hrocketlnc.mdl", pos, ang, "models/dronesrewrite/attachment4/attachment4.mdl", pos)

		ent.RespawnRocket = function()
			if IsValid(ent.Rocket) then return end

			if not ent:HasPrimaryAmmo() then
				ent.WaitForAmmo = true
				return
			end

			local e = ents.Create("prop_physics")
			e:SetModel("models/dronesrewrite/hrocket_cl/hrocket_cl.mdl")
			e:SetPos(ent:GetPos() - ent:GetUp() + ent:GetForward() * 5)
			e:SetAngles(ent:GetAngles())
			e:Spawn()
			e:Activate()
			e:SetParent(ent)
			e:SetNotSolid(true)
			e:PhysicsDestroy()

			ent.Rocket = e
		end

		ent:RespawnRocket()

		ent.PrimaryAmmo = 6
		ent.PrimaryAmmoMax = 12
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.GuidedMis }

		return ent
	end,

	Think = function(self, gun)
		if IsValid(gun.Missile) and gun.Missile.Enabled then
			if not gun.Missile.Force then gun.Missile.Force = 5 end
			gun.Missile.Force = Lerp(0.005, gun.Missile.Force, 35)

			if gun.Missile.Follow then
				local enemy = gun.Missile.Enemy

				if IsValid(enemy) then
					if enemy == gun.Missile then gun.Missile.Enemy = NULL return end

					local tang = (enemy:LocalToWorld(enemy:OBBCenter()) - gun.Missile:GetPos()):GetNormal():Angle()
					local sang = gun.Missile:GetAngles()

					local p = math.NormalizeAngle(tang.p - sang.p)
					local y = math.NormalizeAngle(tang.y - sang.y)
					local r = -math.NormalizeAngle(sang.r)

					local phys = gun.Missile:GetPhysicsObject()
					phys:AddAngleVelocity(Vector(r, p, y) * gun.Missile.Force)
					phys:AddAngleVelocity(-phys:GetAngleVelocity() * 0.3)

					if gun.Missile:GetPos():Distance(enemy:GetPos()) <= 64 then 
						gun.Missile:Boom()
					end
				end
			else
				local driver = self:GetDriver()

				if driver:IsValid() then
					local tang = self:GetAngles() + driver:EyeAngles()
					local sang = gun.Missile:GetAngles()

					local p = math.NormalizeAngle(tang.p - sang.p)
					local y = math.NormalizeAngle(tang.y - sang.y)
					local r = -math.NormalizeAngle(sang.r)

					local phys = gun.Missile:GetPhysicsObject()
					phys:AddAngleVelocity(Vector(r, p, y) * 5)
					phys:AddAngleVelocity(-phys:GetAngleVelocity() * 0.6)

					for k, v in pairs(self.ValidWeapons) do
						if v.NextShoot < CurTime() + 0.5 then
							v.NextShoot = CurTime() + 0.5
						end
					end

					if self:WasKeyPressed("Fire1") and CurTime() > gun.NextShoot2 then
						gun.Missile:Boom()
					end
				end
			end
		elseif gun.SetupCam then
			self:SetCamera()
			gun.SetupCam = false
		end

		if gun.WaitForAmmo and gun:HasPrimaryAmmo() then
			gun:RespawnRocket()
			gun.WaitForAmmo = false
		end

		if not IsValid(gun.Rocket) and CurTime() > gun.NextShoot then
			gun:RespawnRocket()
		end

		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			if not IsValid(gun.Rocket) then return end
			if IsValid(gun.Missile) then gun.Missile.Follow = true end

			local ammo = ents.Create("dronesrewrite_rocketbig")
			ammo.Enemy = self:GetNWEntity("rocketlauncher_target")
			ammo.Owner = self:GetDriver():IsValid() and self:GetDriver() or self
			ammo:SetPos(gun.Rocket:GetPos())
			ammo:SetAngles(gun:GetAngles())
			ammo:Spawn()
			ammo:EmitSound("weapons/rpg/rocketfire1.wav", 75, 100, 1, CHAN_WEAPON)
			ammo.Follow = true
			constraint.NoCollide(ammo, self, 0, 0)

			local physamm = ammo:GetPhysicsObject()
			if IsValid(physamm) then physamm:ApplyForceCenter(ammo:GetForward() * 12000) end 
			gun.Missile = ammo

			SafeRemoveEntity(gun.Rocket)

			gun:SetPrimaryAmmo(-1)
			gun.NextShoot2 = CurTime() + 0.3
			gun.NextShoot = CurTime() + 3.5
		end
	end,

	Attack2 = function(self, gun)
		if CurTime() > gun.NextShoot2 then
			if IsValid(gun.Missile) then
				gun.Missile.Follow = not gun.Missile.Follow

				if gun.Missile.Follow then
					gun.Missile.Enemy = NULL

					local phys = gun.Missile:GetPhysicsObject()
					phys:AddAngleVelocity(-phys:GetAngleVelocity())

					self:SetCamera()
					gun.SetupCam = false
				else
					self:SetCamera(gun.Missile, true, false)
					gun.SetupCam = true
				end
			else
				self:SetNWEntity("rocketlauncher_target", self:GetCameraTraceLine(nil, Vector(-64, -64, -64), Vector(64, 64, 64)).Entity)
			end

			gun.NextShoot2 = CurTime() + 0.3
		end
	end,

	OnRemove = function(self, gun)
		self:RemoveHookClient("HUD", "rocketdraw")
	end,

	Deploy = function(self, gun)
		self:AddHookClient("HUD", "rocketdraw", [[
			local drone = LocalPlayer():GetNWEntity("DronesRewriteDrone")

			if drone:IsValid() then
				local ent = drone:GetNWEntity("rocketlauncher_target")
				
				if IsValid(ent) then
					local pos = ent:GetPos():ToScreen()

					surface.SetDrawColor(Color(255, 0, 0, 150))
					surface.SetMaterial(Material("stuff/whiteboxhud/crosshair"))
					surface.DrawTexturedRectRotated(pos.x, pos.y, 32, 32, CurTime() * 1000)
				end
			end
		]])
	end,

	Holster = function(self, gun)
		self:RemoveHookClient("HUD", "rocketdraw")
	end
}
