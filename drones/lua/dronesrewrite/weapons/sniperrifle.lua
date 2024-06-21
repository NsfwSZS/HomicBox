DRONES_REWRITE.Weapons["Sniper Rifle"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/sniper_rifle/sniper_rifle.mdl", pos, ang)

		ent.SetZoom = function(ent, fov, fovn)
			local driver = self:GetDriver()

			if driver:IsValid() then
				if fov then
					self:SetCamera(ent, true, true, Vector(8, 0, -4))
					self:SetNWBool("ThirdPerson", false)
					driver:SetFOV(fovn, 0)

					net.Start("dronesrewrite_sniperrifle")
						net.WriteEntity(self)
						net.WriteBit(true)
					net.Send(driver)
				else
					self:SetCamera()
					ent.Mode = 0
					driver:SetFOV(90, 0)

					net.Start("dronesrewrite_sniperrifle")
						net.WriteEntity(self)
						net.WriteBit(false)
					net.Send(driver)
				end
			end
		end

		self:AddHook("DriverExit", "sniper_zoom", function()
			ent:SetZoom(false)
		end)

		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, Vector(40, 0, -4))

		ent.PrimaryAmmo = 50
		ent.PrimaryAmmoMax = 50
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Rifle }

		ent.Mode = 0

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if self:WasKeyPressed("Fire1") and CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			local damage = math.random(245, 270) * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()
			local force = 20 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()

			local bullet = {}
			bullet.Num = 1
			bullet.Src = gun.Source:GetPos()
			bullet.Dir = gun:GetLocalCamDir()
			bullet.Spread = Vector(0.001, 0.001, 0.001) * math.Clamp((self:GetVelocity():Length() * 0.1) - 1, 0, 60)
			bullet.Tracer = 1
			bullet.Force = force
			bullet.Damage = damage
			bullet.Attacker = self:GetDriver()
			
			gun.Source:FireBullets(bullet)
			gun:EmitSound("weapons/awp/awp1.wav", 80, 180, 1, CHAN_WEAPON)

			if not DRONES_REWRITE.ServerCVars.NoRecoil:GetBool() then
				local tr = self:GetCameraTraceLine()
				
				local phys = self:GetPhysicsObject()
				phys:ApplyForceCenter((gun:GetPos() - tr.HitPos):GetNormal() * 120000 / self.Weight)
				phys:AddAngleVelocity(VectorRand() * 2000 / self.Weight)
			end
			
			local ef = EffectData()
			ef:SetOrigin(gun.Source:GetPos())
			ef:SetNormal(gun:GetForward())
			util.Effect("dronesrewrite_muzzleflash", ef)

			if not DRONES_REWRITE.ServerCVars.NoShells:GetBool() then
				local ef = EffectData()
				ef:SetOrigin(gun:LocalToWorld(Vector(0, 6, -7)))
				ef:SetAngles(gun:LocalToWorldAngles(Angle(0, 90, 0)))
				util.Effect("RifleShellEject", ef)
			end

			gun:SetPrimaryAmmo(-1)
			gun.NextShoot = CurTime() + 1
		end
	end,

	Attack2 = function(self, gun)
		if CurTime() > gun.NextShoot2 then
			gun.Mode = gun.Mode + 1

			if gun.Mode == 1 then
				gun:SetZoom(true, 40)
			elseif gun.Mode == 2 then
				gun:SetZoom(true, 10)
			else
				gun:SetZoom(false)
			end

			gun.NextShoot2 = CurTime() + 0.2
		end
	end,

	Deploy = function(self, gun)
		net.Start("dronesrewrite_sniperrifle_crosshair")
			net.WriteEntity(self)
			net.WriteBit(false)
		net.Broadcast()
	end,

	Holster = function(self, gun)
		net.Start("dronesrewrite_sniperrifle_crosshair")
			net.WriteEntity(self)
			net.WriteBit(true)
		net.Broadcast()
		
		gun:SetZoom(false)
	end,

	OnRemove = function(self, gun)
		gun:SetZoom(false)
		self:RemoveHook("DriverExit", "sniper_zoom")
	end
}