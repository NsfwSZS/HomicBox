DRONES_REWRITE.Overlay["Orange Scanner"] = function(drone)
	local eff_tab = {
		["$pp_colour_addr"] = 1,
		["$pp_colour_addg"] = 0.5,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = -0.7,
		["$pp_colour_contrast"] = 1.3,
		["$pp_colour_colour"] = 0.4,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}

	DrawSharpen(0.8, 2)
	--DrawMotionBlur(0.3, 1, 0.01)

	DrawSobel(10)
	DrawColorModify(eff_tab)
	DrawToyTown(3, 400)
end