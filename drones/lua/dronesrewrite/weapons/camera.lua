
local function Bomb(ent)
        local SelfPos,PowerMult,Model = ent:LocalToWorld(ent:OBBCenter()),6,ent:GetModel()

        
            ParticleEffect("pcf_jack_groundsplode_large",SelfPos,vector_up:Angle())
            util.ScreenShake(SelfPos,99999,99999,1,3000)
            sound.Play("BaseExplosionEffect.Sound", SelfPos,120,math.random(90,110))

            for i = 1,4 do
                sound.Play("explosions/doi_ty_01_close.wav",SelfPos,140,math.random(80,110))
            end

            if util.GetSurfaceIndex(ent:GetBoneSurfaceProp(0)) == 3 or util.GetSurfaceIndex(ent:GetBoneSurfaceProp(0)) == 66 then
                JMod.FragSplosion(ent, SelfPos + Vector(0, 0, 20), 1024, 50, 3500, ent.owner or game.GetWorld())
            end

            timer.Simple(.1,function()
                for i = 1, 5 do
                    local Tr = util.QuickTrace(SelfPos, VectorRand() * 20)

                    if Tr.Hit then
                        util.Decal("Scorch", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
                    end
                end
            end)

            JMod.WreckBuildings(ent, SelfPos, PowerMult)
            JMod.BlastDoors(ent, SelfPos, PowerMult)

            -- if BigFireModels[Model] then
            --     for i = 1, 25 do
            --         local FireVec = ( VectorRand() * .3 + Vector(0, 0, .3)):GetNormalized()
            --         FireVec.z = FireVec.z / 2
            --         local Flame = ents.Create("ent_jack_gmod_eznapalm")
            --         Flame:SetPos(SelfPos + Vector(0, 0, 50))
            --         Flame:SetAngles(FireVec:Angle())
            --         Flame:SetOwner(game.GetWorld())
            --         JMod.SetOwner(Flame, game.GetWorld())
            --         Flame.SpeedMul = 0.25
            --         Flame.Creator = game.GetWorld()
            --         Flame.HighVisuals = true
            --         Flame:Spawn()
            --         Flame:Activate()
            --     end
            -- elseif FireModels[Model] then
            --     for i = 1, 7 do
            --         local FireVec = ( VectorRand() * .3 + Vector(0, 0, .3)):GetNormalized()
            --         FireVec.z = FireVec.z / 2
            --         local Flame = ents.Create("ent_jack_gmod_eznapalm")
            --         Flame:SetPos(SelfPos + Vector(0, 0, 50))
            --         Flame:SetAngles(FireVec:Angle())
            --         Flame:SetOwner(game.GetWorld())
            --         JMod.SetOwner(Flame, game.GetWorld())
            --         Flame.SpeedMul = 0.25
            --         Flame.Creator = game.GetWorld()
            --         Flame.HighVisuals = true
            --         Flame:Spawn()
            --         Flame:Activate()
            --     end
            -- end

            if IsValid(ent) then
                ent:RemoveCallOnRemove("homigrad-bomb")
                --if RagdollOwner(ent) then RagdollOwner(ent):KillSilent() end
                timer.Simple(.6, function()
                	-- ent:Remove()
            	end)                
            end
            timer.Simple(0,function()
                local ZaWarudo = game.GetWorld()
                local Infl, Att = (IsValid(ent) and ent) or ZaWarudo, (IsValid(ent) and IsValid(ent.owner) and ent.owner) or (IsValid(ent) and ent) or ZaWarudo
                util.BlastDamage(Infl,Att,SelfPos,60 * PowerMult,120 * PowerMult)

                --util.BlastDamage(Infl,Att,SelfPos,20 * PowerMult,1000 * PowerMult)
            end)
        if IsValid(ent.parentBomb) then ent.parentBomb:Remove() end
    end




DRONES_REWRITE.Weapons["Camera"] = {
	Initialize = function(self)
		return DRONES_REWRITE.Weapons["Template"].InitializeNoDraw(self)
	end,

	Think = function(self, gun)
		DRONES_REWRITE.Weapons["Template"].Think(self, gun)
	end,
	
	Attack = function(self, gun)
		if self:WasKeyPressed("Fire1") then
			if self:GetDriver():IsValid() then
				local tr = util.TraceLine({
					start = gun:GetPos(),
					endpos = gun:GetPos() + gun:GetForward() * 256,
					filter = self
				})

				if self:GetNWBool("camera_flashen", true) then
					local ef = EffectData()
					ef:SetOrigin(tr.HitPos)
					util.Effect("camera_flash", ef, true)
				end

				gun:EmitSound("drones/camerawep.wav", 80, 100, 1, CHAN_WEAPON)
				self:GetDriver():ConCommand("jpeg")
			end
		end
	end,

	Attack2 = function(self, gun)
		if self:WasKeyPressed("Fire2") then
			self:SetNWBool("camera_flashen", not self:GetNWBool("camera_flashen", true))

			Bomb(self)
		end
	end
}