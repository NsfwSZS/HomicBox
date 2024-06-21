DRONES_REWRITE.Weapons["Invisible"] = {
	Initialize = function(self)
		local ent = DRONES_REWRITE.Weapons["Template"].InitializeNoDraw(self) 

		ent.IsInvisible = false
		ent.InvisibleEnergy = 100

		ent.SetInvisible = function(ent, n)
			self.PlayLoop = not n
			self.ShouldNpcsIgnore = n

			self:SetNoDraw(n)
			if not self.NoPropellers then
				for k, v in pairs(self.ValidPropellers) do
					v:SetNoDraw(n)
				end
			end

			for k, v in pairs(self.ValidWeapons) do
				if v.NoDrawWeapon then continue end

				if IsValid(v.Handler) then v.Handler:SetNoDraw(n) end
				v:SetNoDraw(n)
			end

			if n then
				self:AddHookClient("HUD", "InvisibleDraw", [[
					local drone = LocalPlayer():GetNWEntity("DronesRewriteDrone")
					if drone:IsValid() then	drone:DrawIndicator("Invisible", drone:GetNWInt("InvisibleEnergy")) end
				]])
			end

			ent.IsInvisible = n

			ParticleEffect("elecray_hit_drr", self:GetPos(), Angle(0, 0, 0))
			ent:EmitSound("ambient/energy/weld2.wav", 44, 255, 0.5)
		end

		return ent
	end,

	Think = function(self, gun)
		local num = math.floor(gun.InvisibleEnergy)
		self:SetNWInt("InvisibleEnergy", num)

		if gun.IsInvisible then
			gun.InvisibleEnergy = math.Approach(gun.InvisibleEnergy, 0, 0.05)

			if gun.InvisibleEnergy <= 0 then
				gun:SetInvisible(false)
			end
		else
			gun.InvisibleEnergy = math.Approach(gun.InvisibleEnergy, 100, 0.1)
		end
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot then
			if not gun.IsInvisible and gun.InvisibleEnergy >= 50 then
				gun:SetInvisible(true)
			else
				gun:SetInvisible(false)
			end

			gun.NextShoot = CurTime() + 0.5
		end
	end,

	OnRemove = function(self, gun)
		self:RemoveHookClient("HUD", "InvisibleDraw")
	end
}