SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "Steyr AUG"
SWEP.Author 				= "Steyr Arms"
SWEP.Instructions			= "The Steyr AUG (German: Armee-Universal-Gewehr, lit. 'army universal rifle') is an Austrian bullpup assault rifle chambered for the 5.56×45mm NATO intermediate cartridge, designed in the 1960s by Steyr-Daimler-Puch, and now manufactured by Steyr Arms GmbH & Co KG."
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
SWEP.Primary.Sound = "weapons/aug/fire01.wav"
SWEP.Primary.FarSound = "weapons/aug/distant.wav"
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

SWEP.ViewModel				= "models/district/w_rif_aug.mdl"
SWEP.WorldModel				= "models/district/w_rif_aug.mdl"

SWEP.addAng = Angle(-0.85,-0.59,1) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-9,0.7,5) -- Sight pos
SWEP.SightAng = Angle(-10,0,5) -- Sight ang

SWEP.Mobility = 1.3

SWEP.DrawScope = true 
SWEP.ScopePos = Vector(-4.5,0.67,5.7)
SWEP.ScopeSize = 0.5
SWEP.ScopeAdjust = Angle(-0.85,-0.59,91)
SWEP.ScopeFov = 12
SWEP.ScopeMat = Material("decals/acog.png")
SWEP.ScopeRot = 1.5

if CLIENT then
    function SWEP:Initialize()
        sib_wep[self] = true
        PrintTable(sib_wep)
        self.rtmat = GetRenderTarget("huy-glass", 512, 512, false)  
        self.mat = Material("models/weapons/w_models/w_rif_aug/433_glass")
        self.mat:SetTexture("$basetexture",self.rtmat)

        local texture_matrix = self.mat:GetMatrix("$basetexturetransform")
        texture_matrix:SetAngles( Angle(0,0,32) )
        self.mat:SetMatrix("$basetexturetransform",texture_matrix)
    end 
end