
SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "HK-UMP-45"
SWEP.Author 				= "Heckler & Koch"
SWEP.Instructions			= "The Heckler & Koch UMP is a submachine gun developed and manufactured by Heckler & Koch. Heckler & Koch developed the UMP as a lighter and cheaper successor to the MP5, though both remain in production."
SWEP.Category 				= "SIB SMG"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ".45 acp"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 35
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/ump45/fire01.wav"
SWEP.Primary.FarSound = "snd_jack_hmcd_smp_far.wav"
SWEP.Primary.Force = 22
SWEP.ReloadTime = 2.2
SWEP.ShootWait = 0.1
SWEP.ReloadSounds = {
    [0.1] = {"weapons/ump45/boltback.wav"},
    [0.3] = {"weapons/ump45/clipout.wav"},
    [1] = {"weapons/ump45/clipin.wav"},
    [1.5] = {"weapons/ump45/boltforward.wav"},
}
SWEP.TwoHands = true

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

------------------------------------------

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.HoldType = "smg"

------------------------------------------

SWEP.Slot					= 2
SWEP.SlotPos				= 0
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false

SWEP.ViewModel				= "models/district/w_smg_ump45.mdl"
SWEP.WorldModel				= "models/district/w_smg_ump45.mdl"

SWEP.addAng = Angle(-0.2,-0.3,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-8,0.75,4.9) -- Sight pos
SWEP.SightAng = Angle(-10,0,0) -- Sight ang

SWEP.Mobility = 1.3
