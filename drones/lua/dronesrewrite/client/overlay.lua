hook.Add("RenderScreenspaceEffects", "dronesrewrite_overlay", function()
	local ply = LocalPlayer()
	local drone = ply:GetNWEntity("DronesRewriteDrone")

	if drone:IsValid() and drone:DoCamEffects() then
		local overlayname = drone:GetOverlayName()
	
		if drone:GetNWBool("NightVision") and drone:HasFuel() then
			local eff_tab = {
				["$pp_colour_addr"] = 0,
				["$pp_colour_addg"] = 0.7,
				["$pp_colour_addb"] = 0,
				["$pp_colour_brightness"] = -0.4,
				["$pp_colour_contrast"] = 0.7,
				["$pp_colour_colour"] = 0.4,
				["$pp_colour_mulr"] = 0,
				["$pp_colour_mulg"] = 0,
				["$pp_colour_mulb"] = 0
			}

			DrawColorModify(eff_tab)

			DrawBloom(0, 1, 3, 4, 2, 0, 1, 1, 1)
			DrawSharpen(0.65, 4)
			--DrawSunbeams(1, 0.5, 122, 222, 522) 

			local dlight = DynamicLight(drone:EntIndex())
			if dlight then
				dlight.pos = drone:GetPos()
				dlight.r = 255
				dlight.g = 255
				dlight.b = 255
				dlight.brightness = 0
				dlight.Decay = 100
				dlight.Size = 2048
				dlight.DieTime = CurTime() + 0.1
			end
		end
	
		if DRONES_REWRITE.Overlay[overlayname] then DRONES_REWRITE.Overlay[overlayname](drone) end
		--DrawBloom(0.5, 0.5, 2, 2, 8, 0, 1, 1, 1)
	end
end)