DRONES_REWRITE.Weapons["User"] = {
	Initialize = function(self)
		return DRONES_REWRITE.Weapons["Template"].InitializeNoDraw(self)
	end,

	Attack = function(self, gun)
		if self:WasKeyPressed("Fire1") and CurTime() > gun.NextShoot then
			local ent = self:GetCameraTraceLine(100).Entity

			if ent:IsValid() and not ent.IS_DRONE then
				ent:Use(self, self, 1, 1)
			end

			gun.NextShoot = CurTime() + 0.5
		end
	end
}