DRONES_REWRITE.Weapons["Shield"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].InitializeNoHandler(self, "models/dronesrewrite/shieldgen/shieldgen.mdl", pos, ang)

		ent.ShieldActive = false
		ent.ShieldEnergy = 100
		ent.WaitEffect = 0

		ent.SetShield = function(ent, n)
			ent.ShieldActive = n

			if n then
				hook.Add("EntityTakeDamage", "dronesrewrite_shielddmgdec" .. ent:EntIndex(), function(ply, dmg)
					if ply:GetPos():Distance(ent:GetPos()) < 400 then
						local hp = dmg:GetDamage() * 0.8

						if ply.IS_DRR then
							ply:SetHealthAmount(ply:GetHealth() + hp)
						else
							ply:SetHealth(ply:Health() + hp)
						end
					end
				end)

				self:SwitchLoopSound("Shield", true, "ambient/energy/force_field_loop1.wav", 255)

				local e = ents.Create("prop_physics")
				e:SetPos(ent:GetPos())
				e:SetAngles(ent:GetAngles())
				e:SetModel("models/dronesrewrite/shield_draw/shield.mdl")
				e:SetMaterial("models/props_combine/stasisshield_sheet_dx7")
				e:Spawn()
				e:Activate()
				e:DrawShadow(false)
				e:SetParent(ent)
				e:SetNotSolid(true)
				e:PhysicsDestroy()

				ParticleEffectAttach("vapor_drr", 1, e, 1)

				ent.ShieldMdl = e

				self:AddHookClient("HUD", "ShieldDraw", [[
					local drone = LocalPlayer():GetNWEntity("DronesRewriteDrone")

					if drone:IsValid() then
						drone:DrawIndicator("Shield sphere", drone:GetNWInt("ShieldEnergy"))
					end
				]])
			else
				hook.Remove("EntityTakeDamage", "dronesrewrite_shielddmgdec" .. ent:EntIndex())
				self:SwitchLoopSound("Shield", false)
				SafeRemoveEntity(ent.ShieldMdl)
			end
		end

		ent.Healths = { }

		return ent
	end,

	Think = function(self, gun)
		if self:IsDroneDestroyed() then
			gun:SetShield(false)
			return
		end

		local num = math.floor(gun.ShieldEnergy)
		self:SetNWInt("ShieldEnergy", num)

		if gun.ShieldActive then
			gun.ShieldEnergy = math.Approach(gun.ShieldEnergy, 0, 0.02)

			local ef = EffectData()
			ef:SetStart(Vector(0, 0, 0))
			ef:SetOrigin(gun:GetPos() + VectorRand() * 400)
			ef:SetEntity(gun)
			ef:SetAngles(Angle(0, 255, 255)) -- Color
			util.Effect("dronesrewrite_beam", ef)

			if CurTime() > gun.WaitEffect then
				ParticleEffect("electrical_arc_01_parent", gun:GetPos(), Angle(0, 0, 0))
				gun.WaitEffect = CurTime() + math.Rand(0.1, 0.4)
			end

			if gun.ShieldEnergy <= 0 then
				gun:SetShield(false)
			end
		else
			gun.ShieldEnergy = math.Approach(gun.ShieldEnergy, 100, 0.02)
		end
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot then
			if not gun.ShieldActive and gun.ShieldEnergy >= 20 then
				gun:SetShield(true)
			else
				gun:SetShield(false)
			end

			gun:EmitSound("items/suitchargeok1.wav", 85, math.random(180, 200), 1, CHAN_WEAPON)

			gun.NextShoot = CurTime() + 0.5
		end
	end,

	OnRemove = function(self, gun)
		gun:SetShield(false)
		self:RemoveHookClient("HUD", "ShieldDraw")
	end
}