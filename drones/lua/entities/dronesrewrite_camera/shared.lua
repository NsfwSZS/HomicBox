ENT.Base = "dronesrewrite_base"
ENT.Type = "anim"
//ENT.PrintName = "CAM 'Camera'"
ENT.PrintName = 'Кватракоптер-шахид'
ENT.Spawnable = false
ENT.AdminSpawnable = true
ENT.Category = "!Дроны"

ENT.UNIT = "CAM"

ENT.Model = "models/dronesrewrite/cameradr/cameradr.mdl"

ENT.FirstPersonCam_pos = Vector(4.5, 0, -3.6)
ENT.ThirdPersonCam_distance = 30

ENT.DoExplosionEffect = "splode_drone_sparks"

ENT.AngOffset = 4
ENT.Alignment = 0.5

ENT.HealthAmount = 20
ENT.DefaultHealth = 20

ENT.Speed = 1500
ENT.SprintCoefficient = 1.7
ENT.RotateSpeed = 6

ENT.Fuel = 40
ENT.MaxFuel = 40

ENT.HUD_hudName = "Camera"
ENT.OverlayName = "Black and white"

ENT.UseNightVision = false
ENT.UseFlashlight = false

ENT.KeysFuncs = DRONES_REWRITE.DefaultKeys()

ENT.AllowYawRestrictions = true

ENT.YawMin = -55
ENT.YawMax = 55

ENT.PitchMin = -15

ENT.Slots = {
	["Camera"] = 1
}

ENT.Sounds = {
	PropellerSound = {
		Name = "drones/ardr.wav",
		Pitch = 100,
		Level = 65,
		PitchCoef = 0.02,
		Volume = 0.17
	},
	ExplosionSound = {
		Name = "ambient/energy/spark3.wav",
		Level = 100,
		Pitch = 150
	}
}

ENT.Propellers = {
	Damage = 1,
	Health = 10,
	HitRange = 7,
	Model = "models/dronesrewrite/flower_propeller/flower_propeller.mdl",

	HitPitch = 255,
	HitLevel = 60,
	RandomHitSounds = { "physics/metal/metal_box_impact_bullet2.wav", "physics/metal/metal_box_impact_bullet2.wav", "physics/metal/metal_box_impact_bullet2.wav" },
	RandomLoseSounds = { "physics/glass/glass_cup_break1.wav", "physics/glass/glass_cup_break2.wav" },

	LosePitch = 255,
	LoseLevel = 65,

	Info = {
		Vector(6.4, 9.15, 1.5),
		Vector(-6.4, -9.15, 1.5),
		Vector(-6.4, 9.15, 1.5),
		Vector(6.4, -9.15, 1.5)
	}
}

ENT.Weapons = { ["Camera"] = { Name = "Camera" } }

ENT.Modules = DRONES_REWRITE.GetBaseModules()
DRONES_REWRITE.CopyModule(ENT.Modules, "Nightvision")
DRONES_REWRITE.CopyModule(ENT.Modules, "Flashlight")

language.Add("dronesrewrite_camera", "cvadrocopter")
