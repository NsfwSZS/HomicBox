DRONES_REWRITE.Weapons["Refuel"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].InitializeNoHandler(self, "models/dronesrewrite/fueler/fueler.mdl", pos, ang)
		ent.ent = NULL
		ent.cnstr = NULL
		return ent	
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot then
			if not gun.ent:IsValid() then
				local tr = util.TraceHull({
					start = gun:GetPos(),
					endpos = gun:GetPos() + Vector(0, 0, -450),
					filter = self,
					mins = Vector(-20, -20, 0),
					maxs = Vector(20, 20, 0)
				})

				local ent = tr.Entity
				if ent:IsValid() and ent.IS_DRR and ent:GetFuel() < ent.MaxFuel then
					local rope = 0
					gun.cnstr, rope = constraint.Rope(
						self, 
						ent, 
						0, 
						0, 
						self:WorldToLocal(gun:GetPos()-Vector(0,0,7)), 
						Vector(0, 0, 0), 
						(gun:GetPos()-Vector(0,0,7) - ent:GetPos()):Length() + 150,
						6, 
						0, 
						6, 
						"cable/cable2", 
						false)
					
					gun.ent = ent

					local driver = self:GetDriver()
					if driver:IsValid() then
						driver:ChatPrint("[Drones] Refueling " .. ent:GetUnit())
					end

					self:SwitchLoopSound("Refueling", true, "ambient/water/leak_1.wav", 100, 1)
				end
			else
				gun:EmitSound("garrysmod/balloon_pop_cute.wav")
				self:SwitchLoopSound("Refueling", false)
				gun.cnstr:Remove()
				gun.ent = NULL
			end

			gun.NextShoot = CurTime() + 0.5
		end
	end,

	Think = function(self, gun)
		if gun.ent:IsValid() then
			if math.Round(self:GetFuel()) <= 0 
				or math.Round(gun.ent:GetFuel()) >= gun.ent.MaxFuel
				or gun.ent:GetPos():Distance(gun:GetPos()) > 150 then

				gun:EmitSound("garrysmod/balloon_pop_cute.wav")
				self:SwitchLoopSound("Refueling", false)
				constraint.RemoveConstraints(self, "Rope")
				gun.ent = NULL

				return
			end

			self:SetFuel(self:GetFuel() - 0.02)
			gun.ent:SetFuel(gun.ent:GetFuel() + 0.02)
		end
	end
}