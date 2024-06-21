SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "M-1911"
SWEP.Author 				= "Israel Military Industries"
SWEP.Instructions			= "The M1911 (Colt 1911 or Colt Government) is a single-action, recoil-operated, semi-automatic pistol chambered for the .45 ACP cartridge."
SWEP.Category 				= "SIB Pistols"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".45 acp"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 35
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/cz75/fire01.wav"
SWEP.Primary.FarSound = "snd_jack_hmcd_sht_far.wav"
SWEP.Primary.Force = 15
SWEP.ReloadTime = 2
SWEP.ShootWait = 0.1
SWEP.ReloadSounds = {
    [0.1] = {"weapons/tec9/clipout.wav"},
    [0.8] = {"weapons/tec9/clipin.wav"},
    [1.2] = {"weapons/tec9/boltforward.wav"},
    [1.4] = {"weapons/tec9/boltback.wav"},
}

------------------------------------------

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.HoldType = "revolver"

------------------------------------------

SWEP.Slot					= 1
SWEP.SlotPos				= 2
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false

SWEP.ViewModel				= "models/district/w_pist_m1911.mdl"
SWEP.WorldModel				= "models/district/w_pist_m1911.mdl"

SWEP.addAng = Angle(0.2,0,0) -- Barrel ang adjust
SWEP.addPos = Vector(0,0,0) -- Barrel pos adjust
SWEP.SightPos = Vector(-14,0.42,1.5) -- Sight pos
SWEP.SightAng = Angle(-15,0,0) -- Sight ang