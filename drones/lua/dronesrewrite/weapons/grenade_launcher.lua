DRONES_REWRITE.Weapons["Grenade Launcher"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/autogrenadelauncher/autogrenadelauncher.mdl", pos, ang, "models/dronesrewrite/attachment4/attachment4.mdl", pos)

		ent.Grenade = {
			["Explosive"] = {
				Material = "models/dronesrewrite/grenade/grenade_x_mat",
				AmmoType = "item_drr_grenades",
				AmmoCount = 30,

				Explosion = function(driver, ammo)
					ammo:EmitSound("ambient/explosions/explode_1.wav", 80, 100)

					util.BlastDamage(ammo, IsValid(driver) and driver or ammo, ammo:GetPos(), 230, math.random(60, 100) * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat())
					
					--[[local ef = EffectData()
					ef:SetOrigin(ammo:GetPos())
					util.Effect("Explosion", ef)]]--
					
					ParticleEffect("splode_fire", ammo:GetPos(), Angle(0, 0, 0))
				end
			},
			
			["EMP"] = {
				Material = "models/dronesrewrite/grenade/grenade_e_mat",
				AmmoType = "item_drr_grenadeselec",
				AmmoCount = 30,

				Explosion = function(driver, ammo)
					ammo:EmitSound("drones/nio_dissolve.wav", 80, 100)

					for k, v in pairs(ents.FindInSphere(ammo:GetPos(), 200)) do
						if v.IS_DRR then v:TakeDamage(math.random(40, 90), driver, driver) end
					end
					
					util.BlastDamage(ammo, IsValid(driver) and driver or ammo, ammo:GetPos(), 200, math.random(5, 20) * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat())
					
					ParticleEffect("stinger_explode_drr", ammo:GetPos(), Angle(0, 0, 0))
				end
			},

			["Napalm"] = {
				Material = "models/dronesrewrite/grenade/grenade_f_mat",
				AmmoType = "item_drr_grenadesfire",
				AmmoCount = 30,

				Explosion = function(driver, ammo)
					local pos = ammo:GetPos()

					timer.Create("igniteshit" .. ammo:EntIndex(), 0.1, 8, function()
						for k, v in pairs(ents.FindInSphere(pos, 200)) do
							v:Ignite(3, 4)
						end
					end)

					ammo:EmitSound("ambient/fire/ignite.wav", 90, 100)

					util.BlastDamage(ammo, IsValid(driver) and driver or ammo, ammo:GetPos(), 150, math.random(60, 80))
					ParticleEffect("napalmgren_shockwave_drr", ammo:GetPos(), Angle(0, 0, 0))
				end
			}
		}

		ent.GetCurrentGrenade = function(ent)
			return ent.Grenade[ent.GrenadeType]
		end

		ent.HasPrimaryAmmo = function(ent)
			if DRONES_REWRITE.ServerCVars.NoAmmo:GetBool() then return true end
			return ent:GetCurrentGrenade().AmmoCount > 0
		end

		ent.HasSecondaryAmmo = function(ent)
			if DRONES_REWRITE.ServerCVars.NoAmmo:GetBool() then return true end
			return ent:GetCurrentGrenade().AmmoCount > 0
		end

		ent.SetPrimaryAmmo = function(ent, num, ammotype)
			if ent.PrimaryAsSecondary then
				ent:SetSecondaryAmmo(num, ammotype)

				return 
			end

			if not self.ShouldConsumeAmmo or DRONES_REWRITE.ServerCVars.NoAmmo:GetBool() then return end

			for k, v in pairs(ent.Grenade) do
				if ammotype == v.AmmoType then
					num = v.AmmoCount + num

					if num > v.AmmoCount and ent.Tab.OnPrimaryAdded then 
						ent.Tab.OnPrimaryAdded(self, ent, num - v.AmmoCount) 
					end

					self:SetNWInt("Ammo1", num)
					self:SetNWInt("MaxAmmo1", ent:GetPrimaryMax())

					v.AmmoCount = num
				end
			end
		end

		ent.SetSecondaryAmmo = function(ent, num, ammotype)
			if not self.ShouldConsumeAmmo or DRONES_REWRITE.ServerCVars.NoAmmo:GetBool() then return end

			for k, v in pairs(ent.Grenade) do
				if ammotype == v.AmmoType then
					num = v.AmmoCount + num

					if num > v.AmmoCount and ent.Tab.OnPrimaryAdded then 
						ent.Tab.OnPrimaryAdded(self, ent, num - v.AmmoCount) 
					end

					self:SetNWInt("Ammo2", num)
					self:SetNWInt("MaxAmmo2", ent:GetPrimaryMax())

					v.AmmoCount = num
				end
			end
		end

		ent.GrenadeType = table.GetFirstKey(ent.Grenade)
		self:SetNWString("gr_launch_type", ent.GrenadeType)

		ent.PrimaryAmmoMax = 30
		ent.PrimaryAmmoType = { 
			DRONES_REWRITE.AmmoTypes.FireGrenades,
			DRONES_REWRITE.AmmoTypes.ElectroGrenades,
			DRONES_REWRITE.AmmoTypes.Grenades
		}

		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot and gun:HasPrimaryAmmo() then
			local src = gun:GetPos() + gun:GetForward() * 60 - gun:GetUp() * 2

			local grn = gun:GetCurrentGrenade()
			local ammo = ents.Create("prop_physics")
			ammo.Grenade = grn
			ammo:SetModel("models/dronesrewrite/grenade_fired/grenade_fired.mdl")
			ammo:SetMaterial(grn.Material)
			ammo:SetPos(src)
			ammo:SetAngles(gun:GetAngles())
			ammo:Spawn()

			constraint.NoCollide(ammo, self, 0, 0)
				
			local physamm = ammo:GetPhysicsObject()	
			if physamm:IsValid() then
				physamm:SetMass(1)
				physamm:ApplyForceCenter(gun:GetForward() * 3200)
				physamm:AddAngleVelocity(VectorRand() * 50)
			end

			local ef = EffectData()
			ef:SetOrigin(src)
			ef:SetNormal(gun:GetForward())
			util.Effect("dronesrewrite_muzzleflashgrn", ef)

			timer.Simple(1.5, function()
				if IsValid(ammo) then
					ammo.Grenade.Explosion((IsValid(self) and IsValid(self:GetDriver())) and self:GetDriver() or ammo, ammo)
				end

				SafeRemoveEntity(ammo)
			end)

			gun:EmitSound("weapons/mortar/mortar_fire1.wav", 75, 110, 1, CHAN_WEAPON)

			gun:SetPrimaryAmmo(-1, grn.AmmoType)
			gun.NextShoot = CurTime() + 0.2
		end
	end,

	Attack2 = function(self, gun)
		if CurTime() > gun.NextShoot2 then
			local k, v = next(gun.Grenade, gun.GrenadeType)

			gun.GrenadeType = k or table.GetFirstKey(gun.Grenade)
			self:SetNWString("gr_launch_type", gun.GrenadeType)

			gun.NextShoot2 = CurTime() + 0.2
		end
	end,

	OnRemove = function(self, gun)
		self:RemoveHookClient("HUD", "gr_launcher_hud")
	end,

	Deploy = function(self, gun)
		self:AddHookClient("HUD", "gr_launcher_hud", [[
			local drone = LocalPlayer():GetNWEntity("DronesRewriteDrone")

			if drone:IsValid() then
				local x = 32
				local y = ScrH() / 2

				draw.SimpleText("Grenade type: " .. drone:GetNWString("gr_launch_type"), "DronesRewrite_font3", x, y, Color(0, 255, 255, 150))
			end
		]])
	end,

	Holster = function(self, gun)
		self:RemoveHookClient("HUD", "gr_launcher_hud")
	end
}