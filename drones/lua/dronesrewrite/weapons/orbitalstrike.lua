DRONES_REWRITE.Weapons["Orbital Strike"] = {
	Initialize = function(self)
		--local ent = 

		return DRONES_REWRITE.Weapons["Template"].InitializeNoDraw(self)
	end,

	Attack = function(self, gun)
		if self:WasKeyPressed("Fire1") and CurTime() > gun.NextShoot then
			local tr = self:GetCameraTraceLine()
			local point = tr.HitPos
			local attacker = self:GetDriver()

			local time = 0.2

			sound.Play("drones/alarm.wav", point, 100, 100, 1) 

			timer.Simple(time, function()
				sound.Play("npc/strider/charging.wav", point, 120, 100, 1) 

				local ef = EffectData()
				ef:SetOrigin(tr.HitPos)
				util.Effect("dronesrewrite_obs_laser", ef)
			end)

			timer.Simple(time + 1.5, function()
				local ef = EffectData()
				ef:SetOrigin(point)
				util.Effect("dronesrewrite_explosionbig", ef)

				util.ScreenShake(point, 30, 2, 5, 20000) 

				sound.Play("npc/strider/fire.wav", point, 100, 100, 1) 
				sound.Play("ambient/explosions/explode_5.wav", point, 150, 100, 1)

				util.Decal("DrrBigExpo", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

				local attacker = IsValid(attacker) and attacker or self
				util.BlastDamage(attacker, attacker, point, 800, math.random(450,550) * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat())
			end)

			gun.NextShoot = CurTime() + 12
		end
	end
}