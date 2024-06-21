DRONES_REWRITE.Overlay["Default"] = function(drone)
	local eff_tab = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0.1,
		["$pp_colour_addb"] = 0.1,
		["$pp_colour_brightness"] = -0.1,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}

	DrawColorModify(eff_tab)
end