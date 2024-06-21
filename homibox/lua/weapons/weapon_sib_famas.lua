
SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "FAMAS"
SWEP.Author 				= "Fusil d'Assaut de la Manufacture d'Armes de Saint-Étienne"
SWEP.Instructions			= "The FAMAS is a bullpup assault rifle designed and manufactured in France by MAS in 1978, a year after the Austrian Steyr AUG."
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
SWEP.Primary.Sound = "weapons/famas/fire01.wav"
SWEP.Primary.FarSound = "weapons/famas/distant.wav"
SWEP.Primary.Force = 15
SWEP.ReloadTime = 2
SWEP.ShootWait = 0.1
SWEP.ReloadSounds = {
    [0.1] = {"weapons/famas/boltback.wav"},
    [0.2] = {"weapons/famas/clipout.wav"},
    [1.4] = {"weapons/famas/clipin.wav"},
    [1.7] = {"weapons/famas/cliphit.wav"},
    [2] = {"weapons/famas/boltforward.wav"},
}
SWEP.TwoHands = true
SWEP.Shell = "EjectBrass_556"
SWEP.ShellRotate = false

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

SWEP.ViewModel				= "models/district/w_rif_famas.mdl"
SWEP.WorldModel				= "models/district/w_rif_famas.mdl"

SWEP.addAng = Angle(0.12,0.3,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-7,1,7.7) -- Sight pos
SWEP.SightAng = Angle(-10,0,0) -- Sight ang

SWEP.Mobility = 1.6