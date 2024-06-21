local modules = { }

local mdl = Model("models/dronesrewrite/upgrade_case/upgrade_case.mdl")

DRONES_REWRITE.AddModule = function(name, tab)
	modules[name] = table.Copy(tab)

	-- It's bad bad bad
	local ENT = { }
	
	ENT.Type = "anim"
	ENT.Base = "base_anim"
	ENT.PrintName = name
	ENT.Category = "Drones Rewrite Upgrades"
	ENT.Author = "Drones"
	ENT.Spawnable = true

	if CLIENT then
		function ENT:Draw()
			self:DrawModel()

			local pos = self:LocalToWorld(self:OBBCenter()) + vector_up * 12
			local ang = (pos - EyePos()):Angle()

			local a = 255 - math.Clamp(self:GetPos():Distance(EyePos()) * 0.6, 0, 255)
			
			cam.Start3D2D(pos, Angle(0, ang.y - 90, -ang.p + 90), 0.05)
				draw.SimpleText(self.PrintName, "DronesRewrite_customfont1big", 0, 0, Color(255, 255, 255, a + math.sin(CurTime() * 5) * a * 0.3), TEXT_ALIGN_CENTER)
			cam.End3D2D()
		end
	else
		function ENT:Initialize()
			self:SetModel(mdl)
			self:SetMoveType(MOVETYPE_VPHYSICS)
			self:SetSolid(SOLID_VPHYSICS)
			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetUseType(SIMPLE_USE)

			local phys = self:GetPhysicsObject()
			if IsValid(phys) then
			    phys:Wake()
			else
				self:Remove()
			end
		end

		function ENT:PhysicsCollide(data, phys)
			local ent = data.HitEntity

			if IsValid(ent) and ent.IS_DRR then
				if ent:AddModule(self.PrintName) then SafeRemoveEntity(self) end
			end
		end
	end

	local nicename = "dronesrewrite_upgrcase_" .. string.lower(string.Replace(name, " ", "_"))
	scripted_ents.Register(ENT, nicename)
end

DRONES_REWRITE.GetModule = function(name)
	return modules[name]
end

DRONES_REWRITE.GetModules = function()
	return modules
end

DRONES_REWRITE.AddModule("AI Random moving", {
	Slot = "AI",

	Initialize = function(drone)
		drone:SetDriver(NULL)
		drone.Camera:SetAngles(drone:GetAngles())

		drone.AI_installed = true

		drone.Buffer.RandomForward = 0
		drone.Buffer.RandomBack = 0
		drone.Buffer.RandomAngle = 0
		drone.Buffer.RandomUp = 0
		drone.Buffer.RandomDown = 0
		drone.Buffer.Stay = 0
		drone.Buffer.HoldAlt = 0
		drone.Buffer.HoldSprint = 0
	end,

	OnRemove = function(drone)
		if drone:CountModulesInSlot("AI") <= 0 then
			drone.AI_installed = false
		end
	end,

	Think = function(drone)
		if drone.Buffer.RandomAngle != 0 then
			local ang = drone:GetAngles()
			drone:ControlMotion("Left", "Right", math.NormalizeAngle(ang.y - drone.Buffer.RandomAngle), -15, 15)
		end

		if drone.Buffer.HoldAlt > 0 then
			drone.Buffer.HoldAlt = math.Approach(drone.Buffer.HoldAlt, 0, 1)
			drone:ClickKey("MoveSlowly")
		end

		if drone.Buffer.HoldSprint > 0 then
			drone.Buffer.HoldSprint = math.Approach(drone.Buffer.HoldSprint, 0, 1)
			drone:ClickKey("Sprint")
		end

		if drone.Buffer.RandomBack > 0 then
			drone.Buffer.RandomBack = math.Approach(drone.Buffer.RandomBack, 0, 1)
			drone:ClickKey("Back")
		end

		if drone.Buffer.RandomForward > 0 then
			drone.Buffer.RandomForward = math.Approach(drone.Buffer.RandomForward, 0, 1)
			drone:ClickKey("Forward")
		end

		if drone.Buffer.RandomUp > 0 then
			drone.Buffer.RandomUp = math.Approach(drone.Buffer.RandomUp, 0, 1)
			drone:ClickKey("Up")
		end

		if drone.Buffer.RandomDown > 0 then
			drone.Buffer.RandomDown = math.Approach(drone.Buffer.RandomDown, 0, 1)
			drone:ClickKey("Down")
		end

		if drone.Buffer.Stay > 0 then
			drone.Buffer.Stay = math.Approach(drone.Buffer.Stay, 0, 1)

			drone.Buffer.RandomForward = 0
			drone.Buffer.RandomBack = 0
			drone.Buffer.RandomUp = 0
			drone.Buffer.RandomDown = 0
		end

		if drone.AI_AllowForward and math.random(1, 80) == 1 then
			drone.Buffer.RandomBack = 0

			local start = drone:LocalToWorld(drone:OBBCenter())
			local tr = util.TraceLine({
				start = start,
				endpos = start + drone:GetForward() * math.random(1000, 4000),
				filter = drone
			})

			local dist = start:Distance(tr.HitPos)
			if dist <= 200 then
				local val = math.random(0, 1)
				if val == 0 then val = -1 end -- ??????

				drone.Buffer.RandomAngle = math.random(95, 130) * val
				drone.Buffer.HoldAlt = math.random(30, 60)
			end

			if dist > 100 then
				drone.Buffer.RandomForward = math.random(dist * 0.8, dist)
			end
		end

		if drone.AI_AllowBack and math.random(1, 320) == 1 then
			drone.Buffer.RandomForward = 0
			drone.Buffer.RandomBack = math.random(5, 20)
		end

		if drone.AI_AllowRotate and math.random(1, 120) == 1 then
			if drone.Buffer.RandomForward > 0 or drone.Buffer.RandomBack > 0 then
				drone.Buffer.RandomAngle = math.random(-90, 90)
			else
				drone.Buffer.RandomAngle = math.random(-180, 180)
			end
		end

		if drone.AI_AllowStay and math.random(1, 400) == 1 then 
			drone.Buffer.Stay = math.random(5, 30)
		end

		if drone.AI_AllowUp and math.random(1, 250) == 1 then 
			drone.Buffer.RandomDown = 0
			drone.Buffer.RandomUp = math.random(5, 30) 
		end

		if drone.AI_AllowDown and math.random(1, 250) == 1 then 
			drone.Buffer.RandomUp = 0
			drone.Buffer.RandomDown = math.random(5, 30) 
		end
	end
})

DRONES_REWRITE.AddModule("AI Moving core", {
	Slot = "AI",

	Initialize = function(drone)
		drone:SetDriver(NULL)
		drone.Camera:SetAngles(drone:GetAngles())

		drone.AI_installed = true
	end,

	OnRemove = function(drone)
		if drone:CountModulesInSlot("AI") <= 0 then
			drone.AI_installed = false
		end
	end,

	Think = function(drone) DRONES_REWRITE.AI.MovingCore(drone) end
})

DRONES_REWRITE.AddModule("AI Protect", {
	Slot = "AI",

	Initialize = function(drone)
		drone:SetDriver(NULL)
		drone.Camera:SetAngles(drone:GetAngles())

		drone.AI_installed = true

		drone:AddHook("TakeDamage", "ai_protect", function(dmg, attacker)
			drone.Buffer.Enemy = attacker
		end)
	end,

	OnRemove = function(drone)
		if drone:CountModulesInSlot("AI") <= 0 then
			drone.AI_installed = false
		end

		drone:RemoveHook("TakeDamage", "ai_protect")
	end,

	Think = function(drone)	
		if not drone:HasModule("AI Attack") then
			if not IsValid(drone.Buffer.Enemy) then drone.Buffer.Enemy = nil return end

			local val = 3000
			if IsValid(drone.Owner) then
				val = drone.Owner:GetInfoNum("dronesrewrite_ai_radius", 3000)
			end

			if drone.Buffer.Enemy:GetPos():Distance(drone:GetPos()) > val then
				drone.Buffer.Enemy = nil 
			end

			if drone.Buffer.Enemy and drone.Buffer.Enemy:IsPlayer() and not drone.Buffer.Enemy:Alive() then drone.Buffer.Enemy = nil end
			DRONES_REWRITE.AI.Attack(drone, drone.Buffer.Enemy)
		end
	end
})

DRONES_REWRITE.AddModule("AI Attack", {
	Slot = "AI",

	Initialize = function(drone)
		drone:SetDriver(NULL)
		drone.Camera:SetAngles(drone:GetAngles())

		drone.AI_installed = true
	end,

	OnRemove = function(drone)
		if drone:CountModulesInSlot("AI") <= 0 then
			drone.AI_installed = false
		end
	end,

	Think = function(drone)
		local wep = drone:GetCurrentWeapon()

		if wep:IsValid() then
			for k, v in pairs(ents.GetAll()) do
				DRONES_REWRITE.AI.Attack(drone, v)
			end
		end
	end
})

DRONES_REWRITE.AddModule("AI Check territory", {
	Slot = "AI",

	Initialize = function(drone)
		drone:SetDriver(NULL)
		drone.Camera:SetAngles(drone:GetAngles())

		drone.Buffer.OldAngleDir = 1
		drone.Buffer.OldAngleDirP = 0.5
		drone.Buffer.RandomAngle = 0

		drone.AI_installed = true
	end,

	OnRemove = function(drone)
		if drone:CountModulesInSlot("AI") <= 0 then
			drone.AI_installed = false
		end
	end,

	Think = function(drone)
		local enemy = drone.Buffer.Enemy

		if not IsValid(enemy) then
			local ang = drone:WorldToLocalAngles(drone.CamAngles) + Angle(drone.Buffer.OldAngleDirP, drone.Buffer.OldAngleDir, 0)

			if not DRONES_REWRITE.ServerCVars.NoCameraRestrictions:GetBool() then
				if drone.AllowPitchRestrictions then
					if ang.p < drone.PitchMin then 
						ang.p = drone.PitchMin
						drone.Buffer.OldAngleDirP = -drone.Buffer.OldAngleDirP 
					end

					if ang.p > drone.PitchMax then 
						ang.p = drone.PitchMax
						drone.Buffer.OldAngleDirP = -drone.Buffer.OldAngleDirP 
					end
				end

				if drone.AllowYawRestrictions then
					if ang.y < drone.YawMin then 
						ang.y = drone.YawMin
						drone.Buffer.OldAngleDir = -drone.Buffer.OldAngleDir 
					end

					if ang.y > drone.YawMax then 
						ang.y = drone.YawMax
						drone.Buffer.OldAngleDir = -drone.Buffer.OldAngleDir 
					end
				end
			end

			drone.CamAngles = drone:LocalToWorldAngles(ang)

			if not drone:HasModule("AI Random moving") then
				if drone.Buffer.RandomAngle != 0 then
					local ang = drone:GetAngles()
					drone:ControlMotion("Left", "Right", math.NormalizeAngle(ang.y - drone.Buffer.RandomAngle), -15, 15)
				end

				if math.random(1, 200) == 1 then
					drone.Buffer.RandomAngle = math.random(-180, 180)
				end
			end
		end
	end
})

DRONES_REWRITE.AddModule("AI Follow enemy", {
	Slot = "AI",

	Initialize = function(drone)
		drone:SetDriver(NULL)
		drone.Camera:SetAngles(drone:GetAngles())

		drone.AI_installed = true
	end,

	OnRemove = function(drone)
		if drone:CountModulesInSlot("AI") <= 0 then
			drone.AI_installed = false
		end
	end,

	Think = function(drone)
		local enemy = drone.Buffer.Enemy

		if IsValid(enemy) then
			local drpos = drone:LocalToWorld(drone:OBBCenter())
			local tr = util.TraceLine({
				start = drpos,
				endpos = enemy:LocalToWorld(enemy:OBBCenter()),
				filter = drone
			})

			local opos = ((tr.Entity == enemy) and tr.HitPos or enemy:GetPos())
			local ang = drone:GetAngles()
			local dir = (opos - drpos):GetNormal()
			local checkang = math.NormalizeAngle(ang.y - dir:Angle().y)

			if not (checkang < -40 or checkang > 40) then -- Wtf?!?!
				local dist = opos:Distance(drpos)
				if dist > (drone.AI_DistanceEnemy or (160 + drone:OBBMaxs().x)) then
					drone:ClickKey("Forward")
				elseif dist < (drone.AI_DistanceEnemy or (100 + drone:OBBMaxs().x)) then
					drone:ClickKey("Back")
				end
			end

			drone.Buffer.RandomForward = 0
			drone.Buffer.RandomBack = 0
			drone.Buffer.RandomAngle = 0
			drone.Buffer.RandomUp = 0
			drone.Buffer.RandomDown = 0
			drone.Buffer.Stay = 0

			drone:ControlMotion("Left", "Right", checkang, -16, 16)

			-- Using false to shit shit shit
			if drone.AI_UseZ == false then return end

			local owner = drone.Owner
			local st = opos.z - drpos.z
			local val = (owner:IsValid() and owner:GetInfoNum("dronesrewrite_ai_flyzdistance", 100) or 100) + (drone.AI_AirZ or 70)

			if st > -val / 5 then
				drone:ClickKey("Up")
			elseif st < -val then
				drone:ClickKey("Down")
			end
		end
	end
})

DRONES_REWRITE.AddModule("AI Follow owner", {
	Slot = "AI",

	Initialize = function(drone)
		drone:SetDriver(NULL)
		drone.Camera:SetAngles(drone:GetAngles())

		drone.AI_installed = true
	end,

	OnRemove = function(drone)
		if drone:CountModulesInSlot("AI") <= 0 then
			drone.AI_installed = false
		end
	end,

	Think = function(drone)
		local owner = drone.Owner

		local drpos = drone:GetPos()
		local opos = owner:GetPos()
		local dist = opos:Distance(drpos)

		if owner:IsValid() and owner:Alive() and dist < 4000 then
			local ang = drone:GetAngles()
			local dir = (opos - drpos):GetNormal()

			local checkang = math.NormalizeAngle(ang.y - dir:Angle().y)

			if dist > 1600 then
				drone:ClickKey("Sprint")
			end

			if dist < 300 then
				drone:ClickKey("MoveSlowly")
			end

			if not (checkang < -40 or checkang > 40) then -- Wtf?!?!
				if dist > (150 + drone:OBBMaxs().x) then
					drone:ClickKey("Forward")
				elseif dist < (40 + drone:OBBMaxs().x) then
					drone:ClickKey("Back")
				end
			end

			drone:ControlMotion("Left", "Right", checkang, -16, 16)
				
			-- Using false to shit shit shit
			if drone.AI_UseZ == false then return end

			local st = opos.z - drpos.z
			local val = owner:GetInfoNum("dronesrewrite_ai_flyzdistance", 100) + (drone.AI_AirZ or 10)

			if st > -val / 5 then
				drone:ClickKey("Up")
			elseif st < -val then
				drone:ClickKey("Down")
			end
		end
	end
})

DRONES_REWRITE.AddModule("AI Camera point", {
	Slot = "AI",

	Initialize = function(drone)
		drone:SetDriver(NULL)
		drone.Camera:SetAngles(drone:GetAngles())

		drone.AI_installed = true
	end,

	OnRemove = function(drone)
		if drone:CountModulesInSlot("AI") <= 0 then
			drone.AI_installed = false
		end
	end,

	Think = function(drone)
		if IsValid(drone.Owner) then
			drone.CamAngles = (drone.Owner:GetEyeTrace().HitPos - drone:GetCamera():GetPos()):GetNormal():Angle()
		end
	end
})

DRONES_REWRITE.AddModule("AI Static camera", {
	Slot = "AI",

	Initialize = function(drone)
		drone:SetDriver(NULL)
		drone.Camera:SetAngles(drone:GetAngles())

		drone.AI_installed = true
	end,

	OnRemove = function(drone)
		if drone:CountModulesInSlot("AI") <= 0 then
			drone.AI_installed = false
		end
	end,

	Think = function(drone)
		drone.CamAngles = drone:GetAngles()
	end
})

DRONES_REWRITE.AddModule("Remove modules", {
	Default = true,
	SkipSlot = true,
	System = true,

	Initialize = function(drone)
		drone:RemoveAllModules()
	end,

	OnRemove = function(drone) end,
	Think = function(drone) end
})

DRONES_REWRITE.AddModule("Repair propellers", {
	Default = true,
	SkipSlot = true,
	System = true,

	Initialize = function(drone)
		drone:AddPropellers()
		drone:RemoveModule("Repair propellers")
	end,

	OnRemove = function(drone)
	end,

	Think = function(drone)
	end
})

DRONES_REWRITE.AddModule("Health booster", {
	Default = true,
	Slot = "Body",

	Initialize = function(drone)
		drone.Buffer.HealthModuleCache = drone:GetHealth() * 0.3

		drone:SetDefaultHealth(drone:GetDefaultHealth() + drone.Buffer.HealthModuleCache)
		drone:SetHealthAmount(drone:GetHealth() + drone.Buffer.HealthModuleCache)
	end,

	OnRemove = function(drone)
		drone:SetDefaultHealth(drone:GetDefaultHealth() - drone.Buffer.HealthModuleCache)
		drone:SetHealthAmount(math.min(drone:GetDefaultHealth(), drone:GetHealth()))

		drone.Buffer.HealthModuleCache = 0
	end,

	Think = function(drone) end
})

DRONES_REWRITE.AddModule("Hack protection", {
	Default = true,
	Slot = "Body",

	Initialize = function(drone)
		drone.HackValue = drone.HackValue + 1
		drone:EmitSound("buttons/combine_button_locked.wav", 70, 220)
	end,

	OnRemove = function(drone)
		drone.HackValue = drone.HackValue - 1
	end,

	Think = function(drone) end
})

DRONES_REWRITE.AddModule("Invisible for radar", {
	Default = true,
	Slot = "Body",

	Initialize = function(drone)
		drone:SetNWBool("NoDRRRadar", true)
	end,

	OnRemove = function(drone)
		drone:SetNWBool("NoDRRRadar", false)
	end,

	Think = function(drone) end
})

DRONES_REWRITE.AddModule("Healer", {
	Default = true,
	Slot = "Body",

	Initialize = function(drone)
		local e = ents.Create("dronesrewrite_ai_healer")
		e.Drone = drone
		e:Spawn()
		e:Activate()

		drone.Buffer.Healer = e
	end,

	OnRemove = function(drone)
		SafeRemoveEntity(drone.Buffer.Healer)
	end,

	Think = function(drone) end
})

DRONES_REWRITE.AddModule("Increase speed", {
	Default = true,
	Slot = "Engine",

	Initialize = function(drone)
		drone.Buffer.SpeedModuleCache = drone.Speed * 0.5
		drone.Speed = drone.Speed + drone.Buffer.SpeedModuleCache
	end,

	OnRemove = function(drone)
		drone.Speed = drone.Speed - drone.Buffer.SpeedModuleCache
		drone.Buffer.SpeedModuleCache = 0
	end,

	Think = function(drone) end
})

DRONES_REWRITE.AddModule("Increase up speed", {
	Default = true,
	Slot = "Engine",

	Initialize = function(drone)
		drone.Buffer.UpSpeedModuleCache = drone.UpSpeed * 0.5
		drone.UpSpeed = drone.UpSpeed + drone.Buffer.UpSpeedModuleCache
	end,

	OnRemove = function(drone)
		drone.UpSpeed = drone.UpSpeed - drone.Buffer.UpSpeedModuleCache
		drone.Buffer.UpSpeedModuleCache = 0
	end,

	Think = function(drone) end
})

DRONES_REWRITE.AddModule("Decrease fuel consumption", {
	Default = true,
	Slot = "Fuel",

	Initialize = function(drone)
		drone.Buffer.FuelReductionCache = drone.FuelReduction * 0.5
		drone.FuelReduction = drone.FuelReduction - drone.Buffer.FuelReductionCache
	end,

	OnRemove = function(drone)
		drone.FuelReduction = drone.FuelReduction + drone.Buffer.FuelReductionCache
		drone.Buffer.FuelReductionCache = 0
	end,

	Think = function(drone) end
})

DRONES_REWRITE.AddModule("Increase fuel capacity", {
	Default = true,
	Slot = "Fuel",

	Initialize = function(drone)
		drone.Buffer.MaxFuelCache = drone.MaxFuel * 0.5
		drone.MaxFuel = drone.MaxFuel + drone.Buffer.MaxFuelCache
	end,

	OnRemove = function(drone)
		drone.MaxFuel = drone.MaxFuel - drone.Buffer.MaxFuelCache
		drone.Buffer.MaxFuelCache = 0
	end,

	Think = function(drone) end
})

DRONES_REWRITE.AddModule("Decrease engine noise", {
	Default = true,
	Slot = "Engine",

	Initialize = function(drone)
	end,

	OnRemove = function(drone)
		if drone.LoopSounds and drone.LoopSounds["Rotor"] then
			local snd = drone.Sounds.PropellerSound

			local oldvolume = 1
			local oldlevel = 75
			if snd then 
				oldvolume = snd.Volume or 1
				oldlevel = snd.Level or 75
			end

			drone.LoopSounds["Rotor"]:ChangeVolume(oldvolume)

			drone.LoopSounds["Rotor"]:Stop()
			drone.LoopSounds["Rotor"]:SetSoundLevel(oldlevel)
			drone.LoopSounds["Rotor"]:Play()
		end
	end,
    
	Think = function(drone) 
		if drone.LoopSounds and drone.LoopSounds["Rotor"] then
			local snd = drone.Sounds.PropellerSound

			local oldvolume = 1
			local oldlevel = 75
			if snd then 
				oldvolume = snd.Volume or 1
				oldlevel = snd.Level or 75
			end

			local newvolume = oldvolume * 0.6
			local newlevel = math.floor(oldlevel * 0.8)

			if drone.LoopSounds["Rotor"]:GetVolume() != newvolume then
				drone.LoopSounds["Rotor"]:ChangeVolume(newvolume)
			end

			if drone.LoopSounds["Rotor"]:GetSoundLevel() != newlevel then
				-- SetSoundLevel doesn't work when sound is playing
				drone.LoopSounds["Rotor"]:Stop()
				drone.LoopSounds["Rotor"]:SetSoundLevel(newlevel)
				drone.LoopSounds["Rotor"]:Play()
			end
		end
	end
})

DRONES_REWRITE.AddModule("Zoom increaser", {
	Default = true,
	Slot = "Camera",

	Initialize = function(drone)
		drone.Buffer.CamZoomCache = drone.CamZoom * 0.5
		drone.CamZoom = drone.CamZoom - drone.Buffer.CamZoomCache
	end,

	OnRemove = function(drone)
		drone.CamZoom = drone.CamZoom + drone.Buffer.CamZoomCache
		drone.Buffer.CamZoomCache = 0
	end,

	Think = function(drone) end
})

DRONES_REWRITE.AddModule("Shield", {
	Default = true,
	Slot = "Body",

	Initialize = function(drone)
		drone.Buffer.ShieldHealth = drone:GetDefaultHealth() / 2
		drone.Buffer.ShieldMax = drone.Buffer.ShieldHealth

		drone:SetNWInt("shield_health", math.floor(drone.Buffer.ShieldHealth))
		drone:SetNWInt("shield_def", math.floor(drone.Buffer.ShieldMax))

		drone:AddHookClient("HUD", "DrawShield", [[
			local drone = LocalPlayer():GetNWEntity("DronesRewriteDrone")

			if drone:IsValid() then
				drone:DrawIndicator("Shield", math.floor((drone:GetNWInt("shield_health") / drone:GetNWInt("shield_def")) * 100))
			end
		]])

		drone:AddHook("TakeDamage", "shield_dmg", function(dmg)
			SafeRemoveEntity(drone.Buffer.Shield)

			local dmgAmount = dmg:GetDamage()
			local pos = dmg:GetDamagePosition()

			drone.Buffer.ShieldHealth = drone.Buffer.ShieldHealth - dmgAmount / 10

			local e = ents.Create("base_anim")
			e:SetModel(drone.Model)
			e:SetModelScale(1.02, 0)
			e:SetMaterial("models/props_combine/stasisshield_sheet")
			e:SetPos(drone:GetPos())
			e:SetAngles(drone:GetAngles())
			e:Spawn()
			e:SetParent(drone)
			e:SetNotSolid(true)
			e:PhysicsDestroy()
				
			drone.Buffer.Shield = e

			drone:SetHealthAmount(drone:GetHealth() + dmgAmount / 1.3)
			drone:EmitSound("ambient/energy/weld2.wav", 100, 255, 1)

			ParticleEffect("blade_glow_drr", pos, Angle(0, 0, 0))

			timer.Destroy("dronesrewrite_regen" .. drone:EntIndex())

			timer.Create("dronesrewrite_remshield" .. drone:EntIndex(), 6, 1, function() 
				if drone and drone:IsValid() then 
					SafeRemoveEntity(drone.Buffer.Shield) 

					timer.Create("dronesrewrite_regen" .. drone:EntIndex(), 0.1, 0, function()
						if not drone:IsValid() then timer.Destroy("dronesrewrite_regen" .. drone:EntIndex()) return end
						if drone.Buffer.ShieldHealth >= drone.Buffer.ShieldMax then return end

						drone.Buffer.ShieldHealth = drone.Buffer.ShieldHealth + 1
					end)
				end
			end)

			if drone.Buffer.ShieldHealth <= 0 then 
				drone:EmitSound("drones/nio_dissolve.wav", 100, 160)
				drone:RemoveModule("Shield") 

				ParticleEffect("electrical_arc_01_system", pos, Angle(0, 0, 0))
			end
		end)
	end,

	OnRemove = function(drone)
		drone:RemoveHook("TakeDamage", "shield_dmg")
		drone:RemoveHookClient("HUD", "DrawShield")

		timer.Destroy("dronesrewrite_regen" .. drone:EntIndex())

		SafeRemoveEntity(drone.Buffer.Shield)
	end,

	Think = function(drone) 
		if drone.Buffer.ShieldHealth then drone:SetNWInt("shield_health", math.floor(drone.Buffer.ShieldHealth)) end
	end
})

DRONES_REWRITE.AddModule("Signal booster", {
	Default = true,
	Slot = "Body",

	Initialize = function(drone)
		drone.DRRDefMaxDistance = drone.DRRDefMaxDistance + 12000
	end,

	OnRemove = function(drone)
		drone.DRRDefMaxDistance = drone.DRRDefMaxDistance - 12000
	end,

	Think = function(drone) 
	end
})

DRONES_REWRITE.AddModule("Nightvision", {
	Slot = "Camera",

	Initialize = function(drone)
		drone.UseNightVision = true
	end,

	OnRemove = function(drone)
		drone.UseNightVision = false
		drone:SetNWBool("NightVision", false)
	end,

	Think = function(drone) end
})

DRONES_REWRITE.AddModule("Flashlight", {
	Slot = "Camera",

	Initialize = function(drone)
		drone.UseFlashlight = true
	end,

	OnRemove = function(drone)
		drone.UseFlashlight = false
		drone:SetNWBool("Flashlight", false)
	end,

	Think = function(drone) end
})

DRONES_REWRITE._GetBaseModules = function()
	local Modules = { }

	for k, v in pairs(DRONES_REWRITE.GetModules()) do
		if v.Default then Modules[k] = table.Copy(v) end
	end

	return Modules
end

DRONES_REWRITE.GetAIModules = function()
	local Modules = { }

	for k, v in pairs(DRONES_REWRITE.GetModules()) do
		if v.Slot == "AI" then Modules[k] = table.Copy(v) end
	end

	return Modules
end




-- These functions are for drones
local function add(src, tar)
	for k, v in pairs(tar) do
		src[k] = table.Copy(v)
	end

	return src
end

DRONES_REWRITE.GetBaseModules = function()
	local Modules = { }

	Modules = add(Modules, DRONES_REWRITE._GetBaseModules())
	
	if GetConVarNumber("dronesrewrite_admin_aidisable") == 0 then
		Modules = add(Modules, DRONES_REWRITE.GetAIModules())
	end

	return Modules
end

DRONES_REWRITE.GetSystemModules = function()
	local Modules = { }

	Modules = add(Modules, DRONES_REWRITE.GetAIModules())

	for k, v in pairs(DRONES_REWRITE.GetModules()) do
		if v.System then Modules[k] = table.Copy(v) end
	end

	return Modules
end

DRONES_REWRITE.CopyModule = function(tab, name)
	tab[name] = table.Copy(DRONES_REWRITE.GetModule(name))
end

