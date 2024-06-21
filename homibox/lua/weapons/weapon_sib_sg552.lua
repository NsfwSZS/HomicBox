SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "SG-552"
SWEP.Author 				= "SIG Sauer AG"
SWEP.Instructions			= "The SG 550 is a selective-fire 5.56×45mm NATO assault rifle firing from a closed bolt. It has a gas-actuated piston-driven long-stroke operating system derived from the SIG SG 540 series of rifles, which uses burnt powder gases vented through a port in the barrel to power the weapon's moving parts. Once inside the gas cylinder, propellant gases pass through an L-shaped channel machined in the piston head and are directed forward towards the gas valve."
SWEP.Category 				= "SIB Rifles"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 45
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/sg553/fire01.wav"
SWEP.Primary.FarSound = "weapons/sg553/distant.wav"
SWEP.Primary.Force = 15
SWEP.ReloadTime = 2.5
SWEP.ShootWait = 0.1
SWEP.ReloadSounds = {
    [0.1] = {"weapons/sg553/clipout.wav"},
    [1.3] = {"weapons/sg553/clipin.wav"},
    [2] = {"weapons/sg553/cliphit.wav"},
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

SWEP.ViewModel				= "models/district/w_rif_sg552.mdl"
SWEP.WorldModel				= "models/district/w_rif_sg552.mdl"

SWEP.addAng = Angle(-0.85,-0.59,1) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-5,0.96,5.5) -- Sight pos
SWEP.SightAng = Angle(-10,0,0) -- Sight ang

SWEP.Mobility = 1.3

SWEP.DrawScope = true 
SWEP.ScopePos = Vector(-0.9,0.92,6.2)
SWEP.ScopeSize = 0.7
SWEP.ScopeAdjust = Angle(-0.85,-0.5,-100)
SWEP.ScopeFov = 18
SWEP.ScopeMat = Material("decals/acog.png")
SWEP.ScopeRot = -189


if CLIENT then
    function SWEP:Initialize()
        sib_wep[self] = true
        PrintTable(sib_wep)
        self.rtmat = GetRenderTarget("huy-glass", 512, 512, false)  
        self.mat = Material("models/weapons/w_models/w_rif_sg552/433_glass")
        self.mat:SetTexture("$basetexture",self.rtmat)

        local texture_matrix = self.mat:GetMatrix("$basetexturetransform")
        texture_matrix:SetAngles( Angle(35,10,180) )
        self.mat:SetMatrix("$basetexturetransform",texture_matrix)
    end
    
end