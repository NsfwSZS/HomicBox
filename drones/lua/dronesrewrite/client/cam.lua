local oldAngles

DRONES_REWRITE.UpdateCamera = function()
	hook.Add("CalcView", "dronesrewrite_view_camera", function(ply)
		local drone = ply:GetNWEntity("DronesRewriteDrone")

		if drone:IsValid() then
			if not oldAngles then 
				oldAngles = ply:EyeAngles() 
				ply:SetEyeAngles(DRONES_REWRITE.ServerCVars.StaticCam:GetBool() and drone:GetAngles() or Angle(0, 0, 0))
			end
			
			-- Calculating angles CLIENT-SIDE
			-- Without net
			local eang = ply:EyeAngles()

			if not DRONES_REWRITE.ServerCVars.NoCameraRestrictions:GetBool() then 
				if DRONES_REWRITE.ServerCVars.StaticCam:GetBool() then
					local ang = drone:GetAngles()
					ang.y = eang.y + math.AngleDifference(ang.y, eang.y)

					if drone.AllowPitchRestrictions then
						if eang.p < ang.p + drone.PitchMin then eang.p = ang.p + drone.PitchMin end
						if eang.p > ang.p + drone.PitchMax then eang.p = ang.p + drone.PitchMax end
					end

					if drone.AllowYawRestrictions then
						if eang.y < ang.y + drone.YawMin then eang.y = ang.y + drone.YawMin end
						if eang.y > ang.y + drone.YawMax then eang.y = ang.y + drone.YawMax end
					end
				else
					if drone.AllowPitchRestrictions then
						if eang.p < drone.PitchMin then eang.p = drone.PitchMin end
						if eang.p > drone.PitchMax then eang.p = drone.PitchMax end
					end

					if drone.AllowYawRestrictions then
						if eang.y < drone.YawMin then eang.y = drone.YawMin end
						if eang.y > drone.YawMax then eang.y = drone.YawMax end
					end
				end

				if not DRONES_REWRITE.ServerCVars.CamAllowRestrictions:GetBool() and drone:SupportAngles() and eang != ply:EyeAngles() then ply:SetEyeAngles(eang) end
			end

			local ang

			if drone.SimplestCamera or DRONES_REWRITE.ServerCVars.StaticCam:GetBool() then
				ang = eang
			else
				ang = drone:LocalToWorldAngles(eang)
			end
			
			drone.CamAngles = ang

			local view = { }

			if not drone:GetNWBool("ThirdPerson") then
				view.origin = drone:GetCamera():IsValid() and drone:GetCamera():LocalToWorld(drone:GetLocalCamPos()) or drone:GetPos()
				if drone:SupportAngles() then 
					if not DRONES_REWRITE.ServerCVars.CamAllowRestrictions:GetBool() then
						view.angles = (drone:GetCameraTraceLine(nil, nil, nil, MASK_SOLID_BRUSHONLY).HitPos - view.origin):Angle() + Angle(0, 0, ang.r) 
					else
						view.angles = drone:LocalToWorldAngles(ply:EyeAngles())
					end
				end 
			else
				local pang = ply:EyeAngles()
		
				local ang

				if drone.SimplestCamera or DRONES_REWRITE.ServerCVars.StaticCam:GetBool() then
					ang = pang
				else
					ang = drone:LocalToWorldAngles(pang)
				end

				local pos = drone:LocalToWorld(drone.ThirdPersonCam_pos)

				if not DRONES_REWRITE.ClientCVars.DefaultTp:GetBool() and not drone.SimplestCamera then
					local vec = Vector(pang.p, pang.y * -0.02, 5 + pang.p * 0.7)
					local camor = DRONES_REWRITE.ClientCVars.CamOrientation:GetString()

					if camor == "Right" then
						vec.y = drone:OBBMins().y * 1.3 + pang.y * -0.02
					elseif camor == "Left" then
						vec.y = -drone:OBBMins().y * 1.3 + pang.y * -0.02
					end

					pos = drone:LocalToWorld(drone.ThirdPersonCam_pos + vec)
				end

				local tr = util.TraceLine({
					start = drone:LocalToWorld(drone:OBBCenter()), --pos,-- drone:GetPos(),
					endpos = pos - ang:Forward() * (drone.ThirdPersonCam_distance + DRONES_REWRITE.ClientCVars.CamDistanceCoefficient:GetFloat() or 0),
					mask = MASK_SOLID_BRUSHONLY
				})

				view.origin = tr.HitPos + tr.HitNormal * 2
				view.angles = ang
			end

			return view 
		else
			if oldAngles then
				ply:SetEyeAngles(oldAngles)
				oldAngles = nil
			end
		end
	end)

	hook.Add("ShouldDrawLocalPlayer", "dronesrewrite_fixmodel", function(ply)
		local drone = ply:GetNWEntity("DronesRewriteDrone")
		if drone:IsValid() then return true end
	end)
end

-- Preventing other addons override your camera
DRONES_REWRITE.UpdateCamera()