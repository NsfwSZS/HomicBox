SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "SG-550"
SWEP.Author 				= "SIG Sauer AG"
SWEP.Instructions			= "The SG 550 is a selective-fire 5.56×45mm NATO assault rifle firing from a closed bolt. It has a gas-actuated piston-driven long-stroke operating system derived from the SIG SG 540 series of rifles, which uses burnt powder gases vented through a port in the barrel to power the weapon's moving parts. Once inside the gas cylinder, propellant gases pass through an L-shaped channel machined in the piston head and are directed forward towards the gas valve."
SWEP.Category 				= "SIB Sniper Rifles"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "5.56x45 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 45
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/scar20/fire01.wav"
SWEP.Primary.FarSound = "weapons/scar20/distant01.wav"
SWEP.Primary.Force = 15
SWEP.ReloadTime = 2.5
SWEP.ShootWait = 0.2
SWEP.ReloadSounds = {
    [0.1] = {"weapons/scar20/boltforward.wav"},
    [0.8] = {"weapons/scar20/clipout.wav"},
    [1.4] = {"weapons/scar20/clipin.wav"},
    [2] = {"weapons/scar20/boltback.wav"},
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

SWEP.ViewModel				= "models/district/w_snip_sg550.mdl"
SWEP.WorldModel				= "models/district/w_snip_sg550.mdl"

SWEP.addAng = Angle(0,0,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-4.8,0.8,5) -- Sight pos
SWEP.SightAng = Angle(-10,0,5) -- Sight ang

SWEP.Mobility = 1.3

SWEP.DrawScope = true 
SWEP.ScopePos = Vector(0,0,0)
SWEP.ScopeSize = 0.7
SWEP.ScopeAdjust = Angle(0,0,180) 
SWEP.ScopeFov = 2
SWEP.ScopeMat = Material("decals/hamr3x.png")
SWEP.ScopeRot = 86.5

if CLIENT then
    function SWEP:Initialize()
        sib_wep[self] = true
        PrintTable(sib_wep)
        self.rtmat = GetRenderTarget("huy-glass", 512, 512, false)  
        self.mat = Material("models/weapons/w_models/w_snip_sg550/g3_scope_sg1_lens")
        self.mat:SetTexture("$basetexture",self.rtmat)

        local texture_matrix = self.mat:GetMatrix("$basetexturetransform")
        texture_matrix:SetAngles( Angle(0,0,0) )
        self.mat:SetMatrix("$basetexturetransform",texture_matrix)
    end
    
    function SWEP:AdjustMouseSensitivity()
        return (self:GetOwner():KeyDown(IN_ATTACK2) and 0.3) or 1
    end
end