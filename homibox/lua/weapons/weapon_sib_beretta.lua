SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "Beretta M9"
SWEP.Author 				= "Beretta"
SWEP.Instructions			= "The Beretta M9, officially the Pistol, Semiautomatic, 9mm, M9, is the designation for the Beretta 92FS semi-automatic pistol used by the United States Armed Forces."
SWEP.Category 				= "SIB Pistols"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 15
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9х19 mm Parabellum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 25
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/elite/fire01.wav"
SWEP.Primary.FarSound = "snd_jack_hmcd_smp_far.wav"
SWEP.Primary.Force = 15
SWEP.ReloadTime = 2
SWEP.ShootWait = 0.1
SWEP.ReloadSounds = {
    [0.1] = {"weapons/elite/clipout.wav"},
    [0.8] = {"weapons/elite/rightclipin.wav"},
    [1.2] = {"weapons/elite/slideforward.wav"},
}
SWEP.ShellRotate = false

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

SWEP.ViewModel				= "models/district/w_pist_elite_single.mdl"
SWEP.WorldModel				= "models/district/w_pist_elite_single.mdl"

SWEP.addAng = Angle(-2.4,5.1,0) -- Barrel ang adjust
SWEP.addPos = Vector(0,0,0) -- Barrel pos adjust
SWEP.SightPos = Vector(-14,1.5,4.05) -- Sight pos
SWEP.SightAng = Angle(0,8,0) -- Sight ang
