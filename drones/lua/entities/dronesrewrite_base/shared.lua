ENT.DrrBaseType = "base"

ENT.RenderInCam = true
ENT.WaitNPCS = 0
ENT.NextAction = 0
ENT.EnginePower = 0
ENT.FlyConstant = 2.2524 -- 2.26 2.34 2.25 2.2524
ENT.BlockKeys = false
ENT.MoveCoefficient = 1

ENT.DRONES_REWRITE_DELTA = 0
ENT.DRRFriendsControlling = nil

ENT.CamAngles = Angle(0, 0, 0)

ENT.HackValue = 1

ENT.Useable = true
ENT.IS_DRONE = true
ENT.IS_DRR = true
ENT.AllowControl = false
ENT.BlockRemoteController = false
ENT.ShowOnRadar = true

ENT.UNIT = "BASE"

ENT.AI_AllowDown = true
ENT.AI_AllowUp = true
ENT.AI_AllowForward = true
ENT.AI_AllowBack = true
ENT.AI_AllowRotate = true
ENT.AI_AllowStay = true

ENT.DisableInWater = true
ENT.DRRDefMaxDistance = 10000

ENT.Slots = {
	["Body"] = 2,
	["Engine"] = 1,
	["Camera"] = 1,
	["AI"] = 5,
	["Fuel"] = 1
}

ENT.Modules = nil
ENT.Buffer = { }

ENT.Base = "base_anim"
ENT.Type = "anim"
ENT.PrintName = "Base Drone"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Category = ""

ENT.Weight = 100
ENT.Model = "models/props_phx/construct/metal_plate1.mdl"

ENT.HealthAmount = 100
ENT.DefaultHealth = 100
ENT.CriticalHealthPoint = 30
ENT.DamageThreshold = 0 --[[ AKA "Penetration threshold" ]]--

ENT.DoExplosionEffect = true
ENT.ExplosionForce = 37
ENT.ExplosionAngForce = 3

-- Physics and movement params --
ENT.Speed = 2300 -- No comments
ENT.UpSpeed = 6900
ENT.SprintCoefficient = 2
ENT.RotateSpeed = 13

ENT.AngOffset = 10 -- How much force do when we're rotating (A & D)
ENT.PitchOffset = 1  -- How much force do when we're moving (W & S)
ENT.Alignment = 1 -- How much force do to align drone
ENT.AlignmentPitch = 0 -- Same but pitch
ENT.AlignmentRoll = 0 -- Same but roll

ENT.Damping = 1 -- Velocity damping
ENT.AngDamping = 1 -- Angle velocity damping
-- Full
ENT.AngPitchDamping = 0
ENT.AngYawDamping = 0
ENT.AngRollDamping = 0

-- Hint:
-- math.Clamp(phys:GetVelocity():Length() * self.VelCoefficientOffset, 1, self.VelCoefficientMax) * self.AngOffsetVel
ENT.VelCoefficientOffset = 0.0025 -- Velocity:Length() coefficient
ENT.VelCoefficientMax = 3 -- Max force of velocity angle offset
ENT.AngOffsetVel = 1 -- Coefficient of velocity angle offset

ENT.NoiseCoefficient = 0.3 -- Noise
ENT.NoiseCoefficientPos = 0 -- Same but vector
ENT.NoiseCoefficientAng = 0 -- Same but angle
----------------------------------

ENT.CameraModel = "models/dronesrewrite/camera/camera.mdl"
ENT.SimplestCamera = false
ENT.FirstPersonCam_pos = Vector(0, 0, -5)
ENT.ThirdPersonCam_pos = Vector(0, 0, 0)
ENT.ThirdPersonCam_distance = 100
ENT.EnabledThirdPerson = true
ENT.RenderCam = true
ENT.CamZoom = 30

ENT.OverlayName = "Default"
ENT.HUD_hudName = "Sci Fi"
ENT.HUD_textColor = Color(200, 255, 255)
ENT.HUD_hudColor = Color(200, 255, 255)
ENT.HUD_shouldDrawCrosshair = true
ENT.HUD_shouldDrawHud = true
ENT.HUD_shouldDrawHealth = true
ENT.HUD_shouldDrawTargets = true
ENT.HUD_shouldDrawOverlay = true
ENT.HUD_shouldDetectDamage = true
ENT.HUD_shouldDrawRadar = true
ENT.HUD_shouldDrawFuel = true
ENT.HUD_shouldDrawCenter = true
ENT.HUD_shouldDrawWeps = true

ENT.Enabled = true
ENT.UseNightVision = true
ENT.UseFlashlight = true

ENT.Fuel = 100
ENT.MaxFuel = 100
ENT.FuelReduction = 0.1
ENT.ShouldConsumeFuel = true

ENT.MaxPrimaryAmmo = 0
ENT.MaxSecondaryAmmo = 0

ENT.ShouldConsumeAmmo = true
ENT.Immortal = false

ENT.NoPropellers = false

-- NOTE: These parts must be tables --
ENT.Propellers = nil
ENT.Sounds = nil
ENT.Weapons = nil
ENT.KeysFuncs = nil
ENT.Legs = nil
ENT.Attachments = nil
--------------------------------

ENT.PlayLoop = true

ENT.AllowPitchRestrictions = true
ENT.PitchMin = 0
ENT.PitchMax = 90

ENT.AllowYawRestrictions = false
ENT.YawMin = 0
ENT.YawMax = 0

ENT.CurrentWeapon = nil

-- Walker base params --
ENT.Dists = nil
ENT.Slip = 6
ENT.AngSlip = 0.05
ENT.isDroneOnGround = false
ENT.Hover = 15
ENT.WaitForSound = 0.13
------------------------

function ENT:IsDroneOnGround() return self.isDroneOnGround end

function ENT:AddHook(hook, name, func)
	if not self.hooks then self.hooks = { } end

	if not self.hooks[hook] then self.hooks[hook] = { } end
	self.hooks[hook][name] = func
end

function ENT:RemoveHook(hook, name)
	if not self.hooks then self.hooks = { } end

	if self.hooks[hook] and self.hooks[hook][name] then 
		self.hooks[hook][name] = nil 
	end
end

function ENT:CallHook(name, ...)
	if not self.hooks then self.hooks = { } end
	if not self.hooks[name] then return end

	for k, v in pairs(self.hooks[name]) do
		if CLIENT then 
			RunString(v) -- Worst shit ever
		else
			v(...)
		end
	end
end

function ENT:AddHookClient(hook, name, func)
	if CLIENT then return end

	net.Start("dronesrewrite_addhook")
		net.WriteEntity(self)
		net.WriteString(hook)
		net.WriteString(name)
		net.WriteString(func)
	net.Broadcast()
end

function ENT:RemoveHookClient(hook, name, func)
	if CLIENT then return end

	net.Start("dronesrewrite_removehook")
		net.WriteEntity(self)
		net.WriteString(hook)
		net.WriteString(name)
	net.Broadcast()
end

function ENT:GetUnit() return self.UNIT .. self:EntIndex() end

function ENT:GetNumPropellers()
	return self.Propellers and #self.Propellers.Info or 0
end

function ENT:CalculateFlyConstant() 
	if self.DrrBaseType == "base" then
		return self.FlyConstant * (4 / self:GetNumPropellers()) 
	else
		return 1
	end
end

function ENT:IsDroneDestroyed() return self:GetHealth() <= 0 end
function ENT:IsDroneImmortal() return self.Immortal or DRONES_REWRITE.ServerCVars.NoDamage:GetBool() end
function ENT:IsDroneEnabled() return SERVER and self.Enabled or self:GetNWBool("Enabled") end
function ENT:IsDroneWorkable() return self:HasFuel() and not self:IsDroneDestroyed() and self:IsDroneEnabled() end

function ENT:GetHealth() return CLIENT and self:GetNWInt("Health") or self.HealthAmount end
function ENT:GetDefaultHealth() return self:GetNWInt("DefHealth") end

function ENT:GetFuel() return CLIENT and self:GetNWInt("Fuel") or self.Fuel  end
function ENT:HasFuel() return self.Fuel > 0 or not self.ShouldConsumeFuel or DRONES_REWRITE.ServerCVars.NoFuel:GetBool() end

function ENT:GetPrimaryAmmo()
	return self:GetNWInt("Ammo1")
end

function ENT:GetPrimaryMax()
	return self:GetNWInt("MaxAmmo1")
end

function ENT:GetSecondaryAmmo() 
	return self:GetNWInt("Ammo2")
end

function ENT:GetSecondaryMax()
	return self:GetNWInt("MaxAmmo2")
end

function ENT:GetDriver() return self:GetNWEntity("DronesRewriteDriver") end
function ENT:GetCamera() return self:GetNWEntity("Camera") end
function ENT:GetMainCamera() return self:GetNWEntity("MainCamera") end

function ENT:DoCamEffects() return self:GetNWBool("CameraHUD") and not self:GetNWBool("ThirdPerson") end
function ENT:SupportAngles() return self:GetNWBool("SupportAngles") and not self:GetNWBool("ThirdPerson") end

function ENT:GetLocalCamPos() return self:GetNWVector("CameraPositions") end

function ENT:GetCameraTraceLine(distance, mins, maxs, mask)
	local cam = self:GetCamera()
	if not IsValid(cam) then cam = self end
	
	local campos = cam:GetPos()

	distance = distance or 100000
	mins = mins or Vector(0, 0, 0)
	maxs = maxs or Vector(0, 0, 0)

	local filter = { }
	table.insert(filter, cam)
	table.insert(filter, self)

	local tr = util.TraceHull({
		start = campos,
		endpos = campos + self.CamAngles:Forward() * distance,
		filter = filter,
		mins = mins,
		maxs = maxs,
		mask = mask
	})

	return tr
end