DRONES_REWRITE.Weapons["Bomb"] = {
	Initialize = function(self)
		self:AddHook("DroneDestroyed", "bomb_destr", function()
			ParticleEffect("splode_big_main", self:GetPos(), Angle(0, 0, 0))

			util.BlastDamage(self, IsValid(self:GetDriver()) and self:GetDriver() or self, self:GetPos(), 300, 200 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat())
			self:Remove()
		end)

		return DRONES_REWRITE.Weapons["Template"].InitializeNoDraw(self)
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,
	
	Attack = function(self, gun)
		self:Destroy()
	end
}

DRONES_REWRITE.Weapons["Plasma Bomb"] = {
	Initialize = function(self)
		self:AddHook("DroneDestroyed", "bomb_destrpl", function()
			ParticleEffect("stinger_explode_drr", self:GetPos(), Angle(0, 0, 0))
			
			util.BlastDamage(self, IsValid(self:GetDriver()) and self:GetDriver() or self, self:GetPos(), 350, 300 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat())
			self:Remove()
		end)

		return DRONES_REWRITE.Weapons["Template"].InitializeNoDraw(self)
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,
	
	Attack = function(self, gun)
		self:Destroy()
	end,

	OnRemove = function(self, gun)
		self:RemoveHook("DroneDestroyed", "bomb_destr")
	end
}

DRONES_REWRITE.Weapons["Nuclear Bomb"] = {
	Initialize = function(self)
		return DRONES_REWRITE.Weapons["Template"].InitializeNoDraw(self)
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,
	
	Attack = function(self, gun)
		local pos = self:GetPos()

		local ef = EffectData()
		ef:SetOrigin(pos)
		util.Effect("dronesrewrite_nuke", ef)

		local driver = self:GetDriver()

		timer.Create("dronesrewrite_donuke" .. self:EntIndex(), 0.5, 15, function()
			for k, v in pairs(ents.FindInSphere(pos, 200000)) do
				local phys = v:GetPhysicsObject()

				constraint.RemoveAll(v)
				v:TakeDamage(v:Health(), driver, driver)

				if v.IS_DRR then v:Destroy() end

				if IsValid(phys) then
					local dist = pos:Distance(v:GetPos())
					phys:SetVelocity((v:GetPos() - pos):GetNormal() * phys:GetMass() * 5 + vector_up * phys:GetMass() * 2)
					phys:AddAngleVelocity(VectorRand() * phys:GetMass())

					phys:Wake()
					phys:EnableMotion(true)
				end
			end
		end)

		-- Radiation 
		timer.Simple(8, function()
			timer.Create("dronesrewrite_nuke_radiation", 4, 8, function()
				sound.Play("ambient/energy/whiteflash.wav", pos, 120, 44)

				for k, v in pairs(ents.FindInSphere(pos, 5000)) do
					if v:IsPlayer() or v:IsNPC() then v:TakeDamage(5, driver, driver) end
				end
			end)
		end)

		self:Remove()
	end
}