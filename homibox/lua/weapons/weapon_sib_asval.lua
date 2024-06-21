SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "AS-Val"
SWEP.Author 				= "Tula Arms Plant"
SWEP.Instructions			= "The ASM (6P30M) and VSSM (6P29M) are modernised variants of the AS and VSS respectively The VSSM is equipped with an aluminium buttstock with an adjustable cheek and butt pad and a new 30-round magazine was introduced to be intended for use with the ASM."
SWEP.Category 				= "SIB Rifles"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x39 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 35
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/m4a1s/fire.wav"
SWEP.Primary.FarSound = "weapons/m4a1s/distant.wav"
SWEP.Primary.Force = 15
SWEP.ReloadTime = 2.8
SWEP.ShootWait = 0.1
SWEP.ReloadSounds = {
    [0.3] = {"weapons/ak47/clipout.wav"},
    [1.3] = {"weapons/ak47/clipin.wav"},
    [1.8] = {"weapons/ak47/bolt.wav"},
}
SWEP.TwoHands = true
SWEP.DoFlash = false

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

SWEP.ViewModel				= "models/district/w_rif_asval.mdl"
SWEP.WorldModel				= "models/district/w_rif_asval.mdl"

SWEP.addAng = Angle(-0.02,-0.08,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-4,1.1,4.32) -- Sight pos
SWEP.SightAng = Angle(-10,0,0) -- Sight ang

SWEP.Mobility = 1.5
