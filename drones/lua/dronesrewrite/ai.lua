DRONES_REWRITE.AI = { }

DRONES_REWRITE.AI.ShouldAttackReverse = function(drone, v)
	if not IsValid(drone.Owner) then return false end
	if not IsValid(v) then return false end

	if not v:IsNPC() and not v:IsPlayer() and not v.IS_DRONE then return false end
	if v:Health() <= 0 then return false end
	if v:GetClass() == "npc_bullseye" then return false end
	if drone:IsWeapon(v) then return false end

	local owner = drone.Owner

	local dist = v:GetPos():Distance(drone:GetPos())
	if dist > owner:GetInfoNum("dronesrewrite_ai_radius", 3000) then return false end

	if drone.Owner.dronesrewrite_friends and not table.HasValue(drone.Owner.dronesrewrite_friends, v:EntIndex()) then 
		return false 
	end

	if v:IsNPC() then 
		if tobool(owner:GetInfoNum("dronesrewrite_ai_noattacknpcs", 0)) then return false end
		if drone:IsEnemy(v:GetClass()) then return false end
	end

	if v:IsPlayer() then
		if tobool(owner:GetInfoNum("dronesrewrite_ai_noattackplayers", 0)) then return false end
	end

	if v.IS_DRONE then
		if tobool(owner:GetInfoNum("dronesrewrite_ai_noattackdrones", 0)) then return false end
		if v == drone then return false end

		if not v.IS_DRR then
			if v.Armor and v.Armor <= 0 then return false end
		else
			if v:IsDroneDestroyed() then return false end
		end
	end

	return true
end

DRONES_REWRITE.AI.ShouldAttack = function(drone, v)
	if not IsValid(drone.Owner) then return false end
	if not IsValid(v) then return false end

	if not v:IsNPC() and not v:IsPlayer() and not v.IS_DRONE then return false end
	if drone:IsWeapon(v) then return false end

	local owner = drone.Owner

	local dist = v:GetPos():Distance(drone:GetPos())
	if dist > owner:GetInfoNum("dronesrewrite_ai_radius", 3000) then return false end

	if drone.Owner.dronesrewrite_friends and table.HasValue(drone.Owner.dronesrewrite_friends, v:EntIndex()) then 
		return false 
	end

	if v:IsNPC() then 
		if v:Health() <= 0 then return false end
		if tobool(owner:GetInfoNum("dronesrewrite_ai_noattacknpcs", 0)) then return false end
		if not drone:IsEnemy(v:GetClass()) then return false end
	end

	if v:IsPlayer() then
		if v:Health() <= 0 then return false end
		if tobool(owner:GetInfoNum("dronesrewrite_ai_noattackplayers", 0)) then return false end
		if v == drone.Owner and not tobool(owner:GetInfoNum("dronesrewrite_ai_attackowner", 0)) then return false end
	end

	if v.IS_DRONE then
		if tobool(owner:GetInfoNum("dronesrewrite_ai_noattackdrones", 0)) then return false end
		if v == drone then return false end

		if v.IS_DRR then
			if v:IsDroneDestroyed() then return false end

			if tobool(owner:GetInfoNum("dronesrewrite_ai_noattackfr", 0)) and drone.Owner.dronesrewrite_friends then
				for k, p in pairs(player.GetAll()) do
					if table.HasValue(drone.Owner.dronesrewrite_friends, p:EntIndex()) then
						if p == v.Owner then return false end
					end
				end
			end
		else
			if v.Armor and v.Armor <= 0 then return false end
		end
	end

	return true
end

DRONES_REWRITE.AI.CheckSide = function(drone, side, distance)
	distance = distance or 180

	local start = drone:LocalToWorld(drone:OBBCenter())

	local tr = util.TraceLine({
		start = start,
		endpos = start + side * distance,
		filter = drone
	})

	return tr.Hit
end

DRONES_REWRITE.AI.Attack = function(drone, v)
	if not drone.AI_ReverseCheck and not DRONES_REWRITE.AI.ShouldAttack(drone, v) then return end
	if drone.AI_ReverseCheck and not DRONES_REWRITE.AI.ShouldAttackReverse(drone, v) then return end

	local dir = (v:LocalToWorld(v:OBBCenter()) - drone.Camera:GetPos()):GetNormal()

	local tr = util.TraceLine({
		start = drone.Camera:GetPos(),
		endpos = drone.Camera:GetPos() + dir * drone.Owner:GetInfoNum("dronesrewrite_ai_radius", 3000),
		filter = drone
	})

	local shoot = tr.Entity == v and drone.Camera:GetForward():GetNormal():Dot(dir) > 0.35

	if shoot then 
		drone.Buffer.Enemy = v

		local drpos = drone:GetPos()

		if not drone.AI_NoSkipZ then
			drpos.z = 0
			tr.HitPos.z = 0
		end

		local dist = tr.HitPos:Distance(drpos)
		if drone.AI_MaxDistance and dist > drone.AI_MaxDistance then return end
		if drone.AI_CustomEnemyChecker and not drone:AI_CustomEnemyChecker(v) then return end

		local ang = drone:WorldToLocalAngles(dir:Angle())

		if not DRONES_REWRITE.ServerCVars.NoCameraRestrictions:GetBool() then
			if drone.AllowPitchRestrictions then
				if ang.p < drone.PitchMin then ang.p = drone.PitchMin end
				if ang.p > drone.PitchMax then ang.p = drone.PitchMax end
			end

			if drone.AllowYawRestrictions then
				if ang.y < drone.YawMin then ang.y = drone.YawMin end
				if ang.y > drone.YawMax then ang.y = drone.YawMax end
			end
		end

		drone.CamAngles = drone:LocalToWorldAngles(ang)

		drone:ClickKey("Fire1")  

		if not timer.Exists("dronesrewrite_ai_setupcamangs" .. drone:EntIndex()) then
			timer.Create("dronesrewrite_ai_setupcamangs" .. drone:EntIndex(), 3, 1, function()
				if not IsValid(drone) then return end
				drone.Buffer.Enemy = nil
				drone.Camera:SetAngles(drone:GetAngles())
				drone.CamAngles = drone:GetAngles()
			end)
		end
	end
end

DRONES_REWRITE.AI.MovingCore = function(drone)
	local len = drone:GetPhysicsObject():GetVelocity():Length() * 0.01
	local num = 1.5 + len

	local dist = drone:OBBMaxs().x * num

	if not drone.Buffer.CheckEnabled then drone.Buffer.CheckEnabled = 0 end
	if not drone:IsDroneEnabled() and CurTime() > drone.Buffer.CheckEnabled then
		drone:SetEnabled(true)
		drone.Buffer.CheckEnabled = CurTime() + 2
	end

	if DRONES_REWRITE.AI.CheckSide(drone, -drone:GetForward(), dist) then
		drone:ClickKey("Forward")
		drone.Buffer.RandomBack = 0
	end

	if DRONES_REWRITE.AI.CheckSide(drone, drone:GetForward(), dist) then
		drone:ClickKey("Back")

		local val = math.random(0, 1)
		if val == 0 then val = -1 end -- ??????

		drone.Buffer.RandomAngle = math.random(95, 130) * val
		drone.Buffer.RandomForward = 0
	end

	if drone.Buffer.RandomForward and drone.Buffer.RandomForward > 0 and DRONES_REWRITE.AI.CheckSide(drone, drone:GetForward(), drone.Buffer.RandomForward) then
		drone.Buffer.RandomAngle = 90 * math.Clamp(math.random(-1, 1), -1, 1)
	end

	local dist = drone:OBBMaxs().z * 1.5

	if drone.AI_AllowUp and DRONES_REWRITE.AI.CheckSide(drone, -drone:GetUp(), dist) then
		drone:ClickKey("Up")
		drone.Buffer.RandomDown = 0
	end

	if drone.AI_AllowDown and DRONES_REWRITE.AI.CheckSide(drone, drone:GetUp(), dist) then
		drone:ClickKey("Down")
		drone.Buffer.RandomUp = 0
	end

	local dist = drone:OBBMaxs().y * num

	if DRONES_REWRITE.AI.CheckSide(drone, -drone:GetRight(), dist) then
		drone:ClickKey("StrafeRight")
	end

	if DRONES_REWRITE.AI.CheckSide(drone, drone:GetRight(), dist) then
		drone:ClickKey("StrafeLeft")
	end
end