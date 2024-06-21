DRONES_REWRITE.Weapons["Empty"] = {
	Initialize = function(self, pos, ang)
		return DRONES_REWRITE.Weapons["Template"].InitializeNoDraw(self)
	end
}