DRONES_REWRITE.Weapons["Microwave"] = {
	Initialize = function(self)
		return DRONES_REWRITE.Weapons["Template"].InitializeNoDraw(self)
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot then
			self:GetPhysicsObject():AddAngleVelocity(VectorRand() * 180)

			for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
				if v == self then continue end

				if v.IS_DRONE then
					v:SetEnabled(false)

					local phys = v:GetPhysicsObject()

					phys:SetVelocity((v:GetPos() - self:GetPos()):GetNormal() * 450)
					phys:AddAngleVelocity(VectorRand() * 1200)
					
					v:TakeDamage(math.random(45,60) * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat(), self:GetDriver(), self)

					timer.Simple(10, function()
						if v:IsValid() then 
							v:SetEnabled(true)
						end
					end)
				end

				ParticleEffect("vapor_collapse_drr", v:GetPos(), Angle(0, 0, 0))
				v:TakeDamage(math.random(10,15) * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat(), self:GetDriver(), self)
			end

			ParticleEffect("vapor_collapse_drr", self:GetPos(), Angle(0, 0, 0))
			self:EmitSound("drones/nio_dissolve.wav", 100, 90)

			gun.NextShoot = CurTime() + 16
		end
	end
}