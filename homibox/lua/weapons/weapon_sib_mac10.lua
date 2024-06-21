
SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "MAC-10"
SWEP.Author 				= "Military Armament Corporation"
SWEP.Instructions			= "The Military Armament Corporation Model 10 and more commonly known as the MAC-10, is a compact, blowback operated machine pistol/submachine gun that was developed by Gordon B. Ingram in 1964. It is chambered in either .45 ACP or 9mm."
SWEP.Category 				= "SIB SMG"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9х19 mm Parabellum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 15
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/mac10/fire01.wav"
SWEP.Primary.FarSound = "snd_jack_hmcd_sht_far.wav"
SWEP.Primary.Force = 30
SWEP.ReloadTime = 2.2
SWEP.ShootWait = 0.05
SWEP.ReloadSounds = {
    [0.1] = {"weapons/mac10/clipout.wav"},
    [0.8] = {"weapons/mac10/clipin.wav"},
    [1.2] = {"weapons/mac10/boltforward.wav"},
    [1.4] = {"weapons/mac10/boltback.wav"},
}
SWEP.TwoHands = true
SWEP.ShellRotate = false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

------------------------------------------

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.HoldType = "revolver"

------------------------------------------

SWEP.Slot					= 2
SWEP.SlotPos				= 0
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false

SWEP.ViewModel				= "models/district/w_smg_mac10.mdl"
SWEP.WorldModel				= "models/district/w_smg_mac10.mdl"

SWEP.addAng = Angle(1.9,0,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-14,1.8,5.1) -- Sight pos
SWEP.SightAng = Angle(5,7,0) -- Sight ang
