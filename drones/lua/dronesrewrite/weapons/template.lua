DRONES_REWRITE.Weapons["Template"] = {
	Initialize = function(self, model, pos, ang, attmdl, attpos)
		pos = pos or Vector(0, 0, 0)
		ang = ang or Angle(0, 0, 0)

		if attpos then
			attpos = attpos - ang:Up() * 9.1
		else
			attpos = pos - ang:Up() * 2
		end

		local e = ents.Create("base_anim")
		e:SetModel(model)
		e:SetPos(self:LocalToWorld(attpos))
		e:SetAngles(self:GetAngles() + ang)
		e:Spawn()
		e:SetAutomaticFrameAdvance(true)
		e:Activate()
		e:SetParent(self)
		e:SetNotSolid(true)
		e:PhysicsDestroy()

		e.ang = ang
		e.pos = pos

		e.NextShoot = 0
		e.NextShoot2 = 0
		e.InstantWait = 0

		e.PrimaryAmmoMax = 0
		e.PrimaryAmmo = 0
		e.PrimaryAmmoType = { }

		e.SecondaryAmmoMax = 0
		e.SecondaryAmmo = 0
		e.SecondaryAmmoType = { }

		e.GetPrimaryMax = function(e)
			if e.PrimaryAsSecondary then
				return e:GetSecondaryMax()
			end

			return e.PrimaryAmmoMax
		end

		e.GetSecondaryMax = function(e)
			return e.SecondaryAmmoMax
		end

		e.GetPrimaryAmmo = function(e) 
			if e.PrimaryAsSecondary then
				return e:GetSecondaryAmmo()
			end

			return e.PrimaryAmmo 
		end

		e.GetSecondaryAmmo = function(e)
			return e.SecondaryAmmo
		end

		e.HasPrimaryAmmo = function(e)
			if e.PrimaryAsSecondary then return e:HasSecondaryAmmo() end

			if DRONES_REWRITE.ServerCVars.NoAmmo:GetBool() then return true end
			if e.PrimaryAmmoMax == 0 then return true end

			return e.PrimaryAmmo > 0
		end

		e.HasSecondaryAmmo = function(e)
			if DRONES_REWRITE.ServerCVars.NoAmmo:GetBool() then return true end
			if e.SecondaryAmmoMax == 0 then return true end

			return e.SecondaryAmmo > 0
		end

		e.SetPrimaryAmmo = function(e, num, ammotype)
			if e.PrimaryAsSecondary then
				e:SetSecondaryAmmo(num, ammotype)

				return 
			end

			if not self.ShouldConsumeAmmo or DRONES_REWRITE.ServerCVars.NoAmmo:GetBool() then return end

			num = e.PrimaryAmmo + num

			self:SetNWInt("Ammo1", num)
			self:SetNWInt("MaxAmmo1", e:GetPrimaryMax())

			if num > e.PrimaryAmmo and e.Tab.OnPrimaryAdded then e.Tab.OnPrimaryAdded(self, e, num - e.PrimaryAmmo) end
			e.PrimaryAmmo = num
		end

		e.SetSecondaryAmmo = function(e, num, ammotype)
			if not self.ShouldConsumeAmmo or DRONES_REWRITE.ServerCVars.NoAmmo:GetBool() then return end

			num = e.SecondaryAmmo + num

			self:SetNWInt("Ammo2", num)
			self:SetNWInt("MaxAmmo2", e:GetSecondaryMax())

			if num > e.SecondaryAmmo and e.Tab.OnSecondaryAdded then e.Tab.OnSecondaryAdded(self, e, num - e.SecondaryAmmo) end
			e.SecondaryAmmo = num
		end

		e.GetLocalCamAng = function(e)
			local mask = MASK_SOLID_BRUSHONLY
			if self.AI_installed or self:GetDriver():IsValid() then mask = nil end

			return (self:GetCameraTraceLine(nil, nil, nil, mask).HitPos - e:GetPos()):Angle()
		end

		e.GetLocalCamDir = function(e)
			local mask = MASK_SOLID_BRUSHONLY
			if self.AI_installed or self:GetDriver():IsValid() then mask = nil end
			
			if IsValid(e.Source) then 
				return (self:GetCameraTraceLine(nil, nil, nil, mask).HitPos - e.Source:GetPos()):GetNormal()
			end

			return (self:GetCameraTraceLine(nil, nil, nil, mask).HitPos - e:GetPos()):GetNormal()
		end

		-- Setup handler

		attmdl = attmdl or "models/dronesrewrite/attachment/attachment.mdl"

		local h = ents.Create("base_anim")
		h:SetModel(attmdl)
		h:SetPos(self:LocalToWorld(pos))
		h:Spawn()
		h:Activate()
		h:SetParent(self)
		h:SetNotSolid(true)
		h:PhysicsDestroy()

		e.Handler = h

		DRONES_REWRITE.Weapons["Template"].Think(self, e)

		return e
	end,

	InitializeNoHandler = function(self, model, pos, ang, scale)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, model, pos, ang, scale)
		ent.Handler:Remove()

		return ent
	end,

	InitializeNoDraw = function(self)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/props_junk/PopCan01a.mdl")

		ent:SetNoDraw(true)
		ent:DrawShadow(false)
		ent.Handler:Remove()

		ent.NoDrawWeapon = true

		return ent
	end,

	SpawnSource = function(ent, pos)
		local e = ents.Create("base_anim")
		e:SetModel("models/props_junk/PopCan01a.mdl")
		e:SetPos(ent:LocalToWorld(pos))
		e:SetAngles(ent:GetAngles())
		e:Spawn()
		e:Activate()
		e:SetParent(ent)
		e:SetNotSolid(true)
		e:DrawShadow(false)
		e:PhysicsDestroy()

		e:SetColor(Color(0, 0, 0, 0))
		e:SetRenderMode(RENDERMODE_TRANSALPHA)

		if IsValid(ent.Source) then ent.Source2 = e return e end
		ent.Source = e

		return e
	end,

	Think = function(self, gun)
		if self:IsDroneWorkable() then
			local camang = gun:GetLocalCamAng()
			camang:Normalize()

			local wepang = self:GetAngles() + gun.ang
			local lpos, lang = WorldToLocal(Vector(0, 0, 0), camang, Vector(0, 0, 0), wepang)

			wepang:RotateAroundAxis(wepang:Up(), lang.y)

			if gun.Handler:IsValid() then
				if gun.RotSpeed then
					gun.Handler:SetAngles(LerpAngle(gun.RotSpeed, gun.Handler:GetAngles(), wepang))
				else
					gun.Handler:SetAngles(wepang)
				end
			end

			wepang:RotateAroundAxis(wepang:Right(), -lang.p)

			if gun.RotSpeed then
				gun:SetAngles(LerpAngle(gun.RotSpeed, gun:GetAngles(), wepang))
			else
				gun:SetAngles(wepang)
			end
		end
	end
}
