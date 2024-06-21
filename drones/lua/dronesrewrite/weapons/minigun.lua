DRONES_REWRITE.Weapons["Heavy Minigun"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/minigun/minigun.mdl", pos, ang, "models/dronesrewrite/attachment4/attachment4.mdl", pos)

		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, Vector(55, 0, 3))

		ent.Rotate = 0
		ent.Angle = 0

		ent.PrimaryAmmo = 3000
		ent.PrimaryAmmoMax = 3000
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
			if gun.Rotate >= 1 and gun:HasPrimaryAmmo() then
				local tr = self:GetCameraTraceLine()

				local damage = 8 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()
				local force = 10 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat()

				local bullet = {}
				bullet.Num = 1
				bullet.Src = gun.Source:GetPos()
				bullet.Dir = gun:GetLocalCamDir()
				bullet.Spread = Vector(0.02, 0.01, 0.01)
				bullet.Tracer = math.random(2, 15)
				bullet.Force = force
				bullet.Damage = damage
				bullet.Attacker = self:GetDriver()
				
				gun.Source:FireBullets(bullet)
				gun:EmitSound("weapons/ar2/fire1.wav", 85, math.random(80, 100), 1, CHAN_WEAPON)

				self:SwitchLoopSound("Minigun", true, "drones/minigunshoot.wav", 100, 10)

				if not DRONES_REWRITE.ServerCVars.NoRecoil:GetBool() then
					local phys = self:GetPhysicsObject()
				phys:ApplyForceCenter((gun:GetPos() - tr.HitPos):GetNormal() * 400000 / self.Weight)
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

			self:SetFuel(self:GetFuel() - 0.01)
			self:SwitchLoopSound("MinigunSpin", true, "vehicles/crane/crane_idle_loop3.wav", 100, 1, 90)

			gun.StopRotating = false
			gun.Rotate = math.Approach(gun.Rotate, 1, 0.025)
			gun.NextShoot = CurTime() + 0.02
		end
	end,

	OnAttackStopped = function(self, gun)
		gun.StopRotating = true
		gun:EmitSound("vehicles/apc/apc_shutdown.wav")

		self:SwitchLoopSound("Minigun", false)
		self:SwitchLoopSound("MinigunSpin", false)
	end,

	Holster = function(self, gun)
		gun.StopRotating = true
		gun:EmitSound("vehicles/apc/apc_shutdown.wav")

		self:SwitchLoopSound("Minigun", false)
		self:SwitchLoopSound("MinigunSpin", false)
	end,

	OnRemove = function(self, gun)
		self:SwitchLoopSound("Minigun", false)
		self:SwitchLoopSound("MinigunSpin", false)
	end
}