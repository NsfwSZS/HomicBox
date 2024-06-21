SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "IMI Galil"
SWEP.Author 				= "Israel Military Industries"
SWEP.Instructions			= "The IMI Galil (Hebrew: גליל) is a family of Israeli-made automatic rifles chambered for the 5.56×45mm NATO and 7.62×51mm NATO cartridges. Originally designed by Yisrael Galili and Yakov Lior in the late 1960s, the Galil was first produced by the state-owned Israel Military Industries and is now exported by the privatized Israel Weapon Industries."
SWEP.Category 				= "SIB Rifles"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 35
SWEP.Primary.DefaultClip	= 35
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 35
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/galil/fire01.wav"
SWEP.Primary.FarSound = "weapons/galil/distant.wav"
SWEP.Primary.Force = 20
SWEP.ReloadTime = 2.8
SWEP.ShootWait = 0.1
SWEP.ReloadSounds = {
    [0.3] = {"weapons/galil/clipout.wav"},
    [1.3] = {"weapons/galil/clipin.wav"},
    [1.8] = {"weapons/galil/boltforward.wav"},
    [2] = {"weapons/galil/boltback.wav"},
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

SWEP.ViewModel				= "models/district/w_rif_galil.mdl"
SWEP.WorldModel				= "models/district/w_rif_galil.mdl"

SWEP.addAng = Angle(0,0,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,4,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-5,0.7675,5.17) -- Sight pos
SWEP.SightAng = Angle(-10,0,0) -- Sight ang

SWEP.Mobility = 1.4

local hg_skins = CreateClientConVar("hg_skins","1",true,false,"ubrat govno",0,1)

SWEP.PremiumSkin = {
    [0] = "skins/goldmat/goldmaterial", 
    [1] = "skins/goldmat/goldmaterial",
    [2] = "skins/goldmat/goldmaterial",
    [3] = "skins/goldmat/goldmaterial",
    [4] = "skins/goldmat/goldmaterial",
    [6] = "skins/goldmat/goldmaterial",
    [8] = "skins/goldmat/goldmaterial", 
}

function SWEP:DrawWorldModel()
    self:DrawModel()
	
	if not hg_skins:GetBool() then return end

    if (IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() and skins[self:GetOwner():GetUserGroup()]) then
        for k,v in pairs(self.PremiumSkin) do
            self:SetSubMaterial( k, v )
        end
        self:DrawModel()
    end
end