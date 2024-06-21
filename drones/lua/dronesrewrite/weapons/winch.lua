DRONES_REWRITE.Weapons["Winch"] = {
	Initialize = function(self, pos, ang)
		local ent = DRONES_REWRITE.Weapons["Template"].InitializeNoHandler(self, "models/dronesrewrite/winch/winch.mdl", pos, ang+Angle(0,0,180))

		ent.hookmdl = ents.Create("prop_physics")
		ent.hookmdl:SetModel("models/dronesrewrite/hook/hook.mdl")
		ent.hookmdl:SetPos(ent:GetPos()-Vector(0,0,9))
		ent.hookmdl:SetAngles(ent:GetAngles()+Angle(90,0,0))
		ent.hookmdl:Spawn()
		ent.hookmdl:GetPhysicsObject():EnableGravity(false)
		
		ent.hookweld = constraint.Weld(ent.hookmdl, self, 0, 0, 0, 0, true)
		
		ent.hookc = NULL
		ent.hookr = NULL
		
		ent.rplen = 64
		ent.wdir = 0 -- (-1) pull (0) stop (1) push
		ent.crl = 1
		ent.spdcnst = 10

		ent.storedent = NULL
		ent.propweld = NULL
		
		ent.dt = CurTime()

		
		ent.detachmdlh = function()
			ent.hookweld:Remove()
			ent.hookmdl:GetPhysicsObject():EnableGravity(true)

			ent.hookc, ent.hookr = constraint.Winch(
						self:GetOwner(),
						self,
						ent.hookmdl,
						0,
						0,
						self:WorldToLocal(ent:GetPos()-Vector(0,0,8)),
						Vector(0, 0, 0),
						1,
						KEY_NONE,
						KEY_NONE,
						1,
						1,
						"cable/rope"
						)

			ent.crl = 1
		end

		ent.attachmdlh = function()
			ent.hookmdl:SetPos(ent:GetPos()-Vector(0,0,9))
			ent.hookmdl:SetAngles(ent:GetAngles()+Angle(90,0,0))
			ent.hookmdl:GetPhysicsObject():EnableGravity(false)
			ent.hookc:Remove()
			ent.hookweld = constraint.Weld(ent.hookmdl, self, 0, 0, 0, 0, true)
		end
		
		ent.setRopeLength = function()
			ent.hookc:Fire("SetSpringLength",ent.crl,0)
			if IsValid(ent.hookr) then
				ent.hookr:Fire("SetLength",ent.crl,0)
			end
		end
		
		ent.rotateCyl = function()
			local oa = ent:GetManipulateBoneAngles(1)+Angle(0,0,2*ent.wdir) -- Z axis
			if oa.r < 0 then oa.r = 360 + oa.r elseif oa.r > 360 then oa.r = oa.r - 360 end
			
			ent:ManipulateBoneAngles(1, oa)
		end

		
		function ent:drr_playsound(name)
			ent:EmitSound(name)
		end
		
		function ent:collideCallback(coldata,cdr)
			local hitent = coldata.HitEntity
			local hitentc = hitent:GetClass()

			if IsValid(hitent) and ent.wdir ~= -1 and IsValid(ent.hookc) and !IsValid(ent.storedent) and hitentc ~= "player" and hitentc ~= "worldspawn" then
				ent.storedent = coldata.HitEntity
			end
		end
		
		ent.hookmdl:AddCallback("PhysicsCollide",ent.collideCallback)
		
		return ent
	end,

	Attack = function(self, gun)
		if CurTime() > gun.NextShoot then
			if gun.wdir == 0 and gun.crl == 1 then
				gun.detachmdlh()
				gun.wdir = 1
				
			elseif gun.wdir == -1 and gun.crl > 1 then
				gun.wdir = 1
				
			elseif gun.wdir > -1 and gun.crl > 1 then
				if IsValid(gun.storedent) then
					gun.propweld:Remove()
					gun.storedent = NULL
					gun:drr_playsound("physics/metal/weapon_impact_soft"..math.random(1,3)..".wav")
				end

				gun.wdir = -1
			end

			gun.NextShoot = CurTime() + 0.5
		end
	end,

	Think = function(self, gun)
		local dt = CurTime() - gun.dt 
		gun.dt = CurTime()

		if gun.wdir ~= 0 and IsValid(gun.hookc) then
			local nrl = gun.crl + (gun.wdir * gun.spdcnst * dt)

			if nrl > 1 and nrl <= gun.rplen then
				gun.crl = nrl
				
			elseif nrl <= 1 then
				gun.wdir = 0

				gun.crl = 1

				gun:attachmdlh()
				gun:drr_playsound("phx/epicmetal_soft"..math.random(1,7)..".wav")
			
			elseif nrl > gun.rplen then
				gun.wdir = 0

				gun.crl = gun.rplen
			end
			
			gun:setRopeLength()
			gun:rotateCyl()
		end
		
		if IsValid(gun.storedent) and !IsValid(gun.propweld) then
			gun.propweld = constraint.Weld(gun.hookmdl, gun.storedent, 0, 0, 0, 0, false)
			gun:drr_playsound("phx/epicmetal_soft"..math.random(1,7)..".wav")
		end
	end
}