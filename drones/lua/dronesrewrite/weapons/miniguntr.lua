DRONES_REWRITE.Weapons["3-barrel Minigun"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/miniguntr/miniguntr.mdl", pos, ang, "models/dronesrewrite/attachment4/attachment4.mdl", pos)

		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, Vector(55, 0, 3))

		ent.Rotate = 0
		ent.Angle = 0

		ent.PrimaryAmmo = 2500
		ent.PrimaryAmmoMax = 2500
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Pistol }

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)

		if gun.StopRotating then
			gun.Rotate = math.Approach(gun.Rotate, 0, 0.025)
		end

		gun.Angle = gun.Angle + (gun.Rotate * 20)
		gun:ManipulateBoneAngles(gun:LookupBone("barr"), Angle(0, gun.Angle, 0))
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot then
			if gun:HasPrimaryAmmo() then
				local tr = self:GetCameraTraceLine()

				local damage = 6 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()
				local force = 7 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()

				local bullet = {}
				bullet.Num = 1
				bullet.Src = gun.Source:GetPos()
				bullet.Dir = gun:GetLocalCamDir()
				bullet.Spread = Vector(0.01, 0.01, 0.01)
				bullet.Tracer = math.random(5, 12)
				bullet.Force = force
				bullet.Damage = damage
				bullet.Attacker = self:GetDriver()
				
				gun:EmitSound("weapons/ar2/fire1.wav", 80, math.random(100, 120), 1, CHAN_WEAPON)
				gun.Source:FireBullets(bullet)
				self:SwitchLoopSound("Minigun", true, "drones/minigunshoot.wav", 110, 1, 80)

				if not DRONES_REWRITE.ServerCVars.NoRecoil:GetBool() then
					local phys = self:GetPhysicsObject()
					phys:ApplyForceCenter((gun:GetPos() - tr.HitPos):GetNormal() * 200000 / self.Weight)
					phys:AddAngleVelocity(VectorRand() * 600 / self.Weight)
				end

				if not DRONES_REWRITE.ServerCVars.NoShells:GetBool() then
					local ef = EffectData()
					ef:SetOrigin(gun:LocalToWorld(Vector(0, 6, -7)))
					ef:SetAngles(gun:LocalToWorldAngles(Angle(0, -20, 0)))
					util.Effect("RifleShellEject", ef)
				end

				local ef = EffectData()
				ef:SetOrigin(gun.Source:GetPos())
				ef:SetNormal(gun:GetForward())
				util.Effect("dronesrewrite_muzzleflash", ef)

				gun:SetPrimaryAmmo(-1)
			else
				self:SwitchLoopSound("Minigun", false)
			end

			self:SetFuel(self:GetFuel() - 0.02)
			self:SwitchLoopSound("MinigunSpin", true, "vehicles/crane/crane_idle_loop3.wav", 100, 1, 90)

			gun.StopRotating = false
			gun.Rotate = 1
			gun.NextShoot = CurTime() + 0.015
		end
	end,

	OnAttackStopped = function(self, gun)
		gun.StopRotating = true
		gun:EmitSound("vehicles/apc/apc_shutdown.wav", 65, 80)

		self:SwitchLoopSound("Minigun", false)
		self:SwitchLoopSound("MinigunSpin", false)
	end,

	Holster = function(self, gun)
		gun.StopRotating = true
		gun:EmitSound("vehicles/apc/apc_shutdown.wav", 65, 80)

		self:SwitchLoopSound("Minigun", false)
		self:SwitchLoopSound("MinigunSpin", false)
	end,

	OnRemove = function(self, gun)
		self:SwitchLoopSound("Minigun", false)
		self:SwitchLoopSound("MinigunSpin", false)
	end
}