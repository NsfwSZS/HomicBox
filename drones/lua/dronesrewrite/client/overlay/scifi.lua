DRONES_REWRITE.Overlay["Sci Fi"] = function(drone)
	local eff_tab = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0.1,
		["$pp_colour_addb"] = 0.1,
		["$pp_colour_brightness"] = -0.25,
		["$pp_colour_contrast"] = 1.2,
		["$pp_colour_colour"] = 0.25,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}

	DrawColorModify(eff_tab)
	DrawBloom(0.5, 1, 1, 1, 1, 1, 1, 1, 1)
	DrawSharpen(2, 0.5)
end