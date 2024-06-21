DRONES_REWRITE.Overlay["Red"] = function(drone)
	local eff_tab = {
		["$pp_colour_addr"] = 0.5,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = -0.5,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 0.7,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}

	DrawSharpen(0.65, 4)
	--DrawMotionBlur(0.3, 1, 0.01)

	DrawColorModify(eff_tab)
end