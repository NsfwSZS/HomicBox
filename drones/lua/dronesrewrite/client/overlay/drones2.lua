DRONES_REWRITE.Overlay["Drones 2"] = function(drone)
	local eff_tab = {
		["$pp_colour_addr"] = 0.2,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0.2,
		["$pp_colour_brightness"] = -0.2,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1.5,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 1
	}

	DrawColorModify(eff_tab)
	DrawMaterialOverlay("effects/combine_binocoverlay.vmt", 0)
end