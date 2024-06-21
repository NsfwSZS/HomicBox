DRONES_REWRITE.Weapons["Spider Bite"] = {
	Initialize = function(self, pos)
		local ent = DRONES_REWRITE.Weapons["Template"].InitializeNoDraw(self)
		ent.BitePos = pos -- Not useable stuff
		return ent
	end,

	Attack = function(self, gun)
		if self:WasKeyPressed("Fire1") and CurTime() > gun.NextShoot then
			local ent = self:GetCameraTraceLine(32).Entity

			if ent:IsValid() then
				local driver = self:GetDriver()
				ent:TakeDamage(1 * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat(), driver, driver)

				if not ent.DRR_Poisoned then
					local next = 0
					local freq = 5
					local times = 0

					if ent:IsPlayer() then
						net.Start("dronesrewrite_playsound")
							net.WriteString("vo/npc/male01/moan01.wav")
						net.Send(ent)
					end

					hook.Add("Think", "dronesrewrite_bite_poison" .. ent:EntIndex(), function()
						if CurTime() > next then
							if not IsValid(ent) or ((ent:IsNPC() and ent:Health() <= 0) or (ent:IsPlayer() and not ent:Alive())) then
								if IsValid(ent) then ent.DRR_Poisoned = false end

								hook.Remove("Think", "dronesrewrite_bite_poison" .. ent:EntIndex())
								return
							end

							if ent:IsPlayer() then
								net.Start("dronesrewrite_playsound")
									net.WriteString("vo/npc/male01/ow0" .. math.random(1, 2) .. ".wav")
								net.Send(ent)
							end

							ent:TakeDamage((6 - freq) * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat(), driver, driver)

							next = CurTime() + freq
							freq = math.Approach(freq, 1, 1)
							times = times + 1

							if times >= 17 then
								if ent:IsPlayer() then
									net.Start("dronesrewrite_playsound")
										net.WriteString("vo/npc/male01/moan04.wav")
									net.Send(ent)
								end

								ent.DRR_Poisoned = false
								hook.Remove("Think", "dronesrewrite_bite_poison" .. ent:EntIndex())
							end
						end
					end)

					ent.DRR_Poisoned = true
				end

				gun:EmitSound("npc/barnacle/barnacle_tongue_pull2.wav", 75, 100, 1, CHAN_WEAPON)
			end

			gun:EmitSound("npc/barnacle/neck_snap1.wav", 60, math.random(80, 110), 1, CHAN_WEAPON)
			gun.NextShoot = CurTime() + 0.2
		end
	end
}