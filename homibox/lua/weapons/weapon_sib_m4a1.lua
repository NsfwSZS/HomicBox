SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "M4A1"
SWEP.Author 				= "ArmaLite"
SWEP.Instructions			= "An AR-15–style rifle is any lightweight semi-automatic rifle based on or similar to the Colt AR-15 design. The Colt model removed the selective fire feature of its predecessor, the original ArmaLite AR-15, itself a scaled-down derivative of the AR-10 design by Eugene Stoner."
SWEP.Category 				= "SIB Rifles"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 35
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/m4a1s/us_fire01.wav"
SWEP.Primary.FarSound = "weapons/m4a1s/us_distant01.wav"
SWEP.Primary.Force = 15
SWEP.ReloadTime = 2.5
SWEP.ShootWait = 0.1
SWEP.ReloadSounds = {
    [0.1] = {"weapons/m4a4/clipout.wav"},
    [1.3] = {"weapons/m4a4/clipin.wav"},
    [2] = {"weapons/m4a4/cliphit.wav"},
}
SWEP.TwoHands = true
SWEP.Shell = "EjectBrass_556"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

------------------------------------------

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.HoldType = "ar2"

------------------------------------------

SWEP.Slot					= 2
SWEP.SlotPos				= 0
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false

SWEP.ViewModel				= "models/district/w_rif_m4a1.mdl"
SWEP.WorldModel				= "models/district/w_rif_m4a1.mdl"

SWEP.addAng = Angle(0.12,-0.08,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-5,0.98,5.9) -- Sight pos
SWEP.SightAng = Angle(-10,0,0) -- Sight ang

SWEP.Mobility = 1.3
