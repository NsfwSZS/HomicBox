SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "АК-74"
SWEP.Author 				= "Kalashnikov"
SWEP.Instructions			= "The AK-74, officially known as the Avtomat Kalashnikova is a gas-operated assault rifle that is chambered for the 5.45×39mm cartridge."
SWEP.Category 				= "SIB Rifles"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.45x39 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 45
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/ak47/fire.wav"
SWEP.Primary.FarSound = "weapons/ak47/distant.wav"
SWEP.Primary.Force = 30
SWEP.ReloadTime = 2.8
SWEP.ShootWait = 0.1
SWEP.ReloadSounds = {
    [0.3] = {"weapons/ak47/clipout.wav"},
    [1.3] = {"weapons/ak47/clipin.wav"},
    [1.8] = {"weapons/ak47/bolt.wav"},
}
SWEP.TwoHands = true
SWEP.Shell = "EjectBrass_762Nato"

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

SWEP.ViewModel				= "models/district/w_rif_ak47.mdl"
SWEP.WorldModel				= "models/district/w_rif_ak47.mdl"

SWEP.addAng = Angle(-0.02,-0.08,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-5,1.06,4.32) -- Sight pos
SWEP.SightAng = Angle(-7,-1,0) -- Sight ang

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