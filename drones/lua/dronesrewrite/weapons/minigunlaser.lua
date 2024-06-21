DRONES_REWRITE.Weapons["Laser Minigun"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/minigunlsr/minigunlsr.mdl", pos, ang, "models/dronesrewrite/attachment4/attachment4.mdl", pos)

		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, Vector(55, 0, 3))

		ent.Rotate = 0
		ent.Angle = 0

		ent.PrimaryAmmo = 1500
		ent.PrimaryAmmoMax = 1500
		ent.PrimaryAmmoType = { DRONES_REWRITE.AmmoTypes.Blaster }

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)

		if gun.StopRotating then
			gun.Rotate = math.Approach(gun.Rotate, 0, 0.025)
		end

		gun.Angle = gun.Angle + (gun.Rotate * 20)
		gun:ManipulateBoneAngles(gun:LookupBone("barrel"), Angle(0, gun.Angle, 0))
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot then
			if gun.Rotate >= 1 and gun:HasPrimaryAmmo() then
				local tr = self:GetCameraTraceLine()

				local src = gun:GetPos() + gun:GetForward() * 64 + gun:GetUp()

				local ammo = ents.Create("dronesrewrite_rd_laser_sm")
				ammo:SetPos(src)
				ammo:SetAngles(gun:GetAngles() + AngleRand() * 0.004)
				ammo:Spawn()
				ammo.Owner = self:GetDriver()
				
				constraint.NoCollide(ammo, self, 0, 0)

				ammo:EmitSound("drones/alien_fire.wav", 85, 100, 1, CHAN_WEAPON)

				local ef = EffectData()
				ef:SetOrigin(src - gun:GetForward() * 20)
				ef:SetNormal(gun:GetForward())
				util.Effect("dronesrewrite_muzzleflashblaster2", ef)

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

		self:SwitchLoopSound("MinigunSpin", false)
	end,

	Holster = function(self, gun)
		gun.StopRotating = true
		gun:EmitSound("vehicles/apc/apc_shutdown.wav")

		self:SwitchLoopSound("MinigunSpin", false)
	end,

	OnRemove = function(self, gun)
		self:SwitchLoopSound("MinigunSpin", false)
	end
}