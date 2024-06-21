
SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "Thompson"
SWEP.Author 				= "Auto-Ordnance Company"
SWEP.Instructions			= "The Thompson saw early use by the United States Marine Corps during the Banana Wars, the United States Postal Inspection Service, the Irish Republican Army, the Republic of China, and the FBI following the Kansas City Massacre."
SWEP.Category 				= "SIB SMG"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ".45 acp"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 25
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/tec9/fire.wav"
SWEP.Primary.FarSound = "weapons/tec9/distant.wav"
SWEP.Primary.Force = 25
SWEP.ReloadTime = 1.8
SWEP.ShootWait = 0.05
SWEP.ReloadSounds = {
    [0.1] = {"weapons/tec9/boltback.wav"},
    [0.8] = {"weapons/tec9/clipout.wav"},
    [1.7] = {"weapons/tec9/clipin.wav"},
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

SWEP.HoldType = "ar2"

------------------------------------------

SWEP.Slot					= 2
SWEP.SlotPos				= 0
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false

SWEP.ViewModel				= "models/district/w_thompson.mdl"
SWEP.WorldModel				= "models/district/w_thompson.mdl"

SWEP.addAng = Angle(0.2,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-10.5,0.97,2.9) -- Sight pos
SWEP.SightAng = Angle(-10,0,0) -- Sight ang

SWEP.Mobility = 1.3

local hg_skins = CreateClientConVar("hg_skins","1",true,false,"ubrat govno",0,1)

SWEP.PremiumSkin = {
    [0] = "skins/goldmat/goldmaterial",
    [4] = "skins/goldmat/goldmaterial",
    [5] = "skins/goldmat/goldmaterial",
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