DRONES_REWRITE.Weapons["Flamethrower"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].Initialize(self, "models/dronesrewrite/flamethrower/flamethrower.mdl", pos, ang, "models/dronesrewrite/attachment4/attachment4.mdl", pos)

		DRONES_REWRITE.Weapons["Template"].SpawnSource(ent, Vector(45, 0, 0))
		
		return ent
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,

	Attack = function(self, gun)
		local tr = self:GetCameraTraceLine(600)

		local ent = tr.Entity
		if ent:IsValid() then
			timer.Simple(math.Clamp(gun:GetPos():Distance(ent:GetPos()) / 600, 0.1, 1), function()
				if IsValid(self) and IsValid(ent) then
					local dmg = DamageInfo()
					dmg:SetAttacker(self:GetDriver():IsValid() and self:GetDriver() or self)
					dmg:SetInflictor(self)
					dmg:SetDamage(1.4 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat())
					dmg:SetDamageType(DMG_BURN)
					ent:TakeDamageInfo(dmg)

					ent:Ignite(3)
				end
			end)
		end

		if CurTime() > gun.NextShoot then
			--[[local ef = EffectData()
			ef:SetOrigin(tr.HitPos)
			ef:SetStart(gun.Source:GetPos())
			util.Effect("dronesrewrite_flame", ef)]]
			
			ParticleEffect("flamethrower_fire_drr", gun.Source:GetPos(), gun:GetLocalCamAng())

			self:SetFuel(self:GetFuel() - 0.04)

			gun:EmitSound("ambient/machines/thumper_dust.wav", 80, math.random(90, 110), 1, CHAN_WEAPON)
			gun.NextShoot = CurTime() + 0.04
		end
	end
}