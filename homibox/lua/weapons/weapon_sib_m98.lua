SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "Barrett Model 98B"
SWEP.Author 				= "Barrett Firearms Manufacturing"
SWEP.Instructions			= "The Barrett Model 98B (also known as the Barrett Model 98 Bravo) is a bolt-action sniper rifle chambered in 12.7x99 mm and manufactured by Barrett Firearms Manufacturing. The Model 98B was officially announced in October 2008, and became available for sale in early 2009, with an MSRP of $4,495.00."
SWEP.Category 				= "SIB Sniper Rifles"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12.7×99 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 1500
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/awp/fire01.wav"
SWEP.Primary.FarSound = "weapons/awp/distant.wav"
SWEP.Primary.Force = 300
SWEP.ReloadTime = 2.5
SWEP.ShootWait = 0.9
SWEP.ReloadSounds = {
    [0.1] = {"weapons/awp/clipout.wav"},
    [1.3] = {"weapons/awp/clipin.wav"},
    [2] = {"weapons/awp/boltback.wav"},
    [2.3] = {"weapons/awp/boltforward.wav"},
}
SWEP.TwoHands = true
SWEP.Shell = "EjectBrass_338Mag"
SWEP.ShellRotate = false 

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

SWEP.ViewModel				= "models/pwb/w_m98b/w_m98b.mdl"
SWEP.WorldModel				= "models/pwb/w_m98b/w_m98b.mdl"

SWEP.addAng = Angle(0,0,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-4,0.96,6.6) -- Sight pos
SWEP.SightAng = Angle(-5,-1,0) -- Sight ang

SWEP.Mobility = 2

SWEP.DrawScope = true 
SWEP.ScopePos = Vector(0,0,0)
SWEP.ScopeSize = 0.7
SWEP.ScopeAdjust = Angle(0,0,0)
SWEP.ScopeFov = 3.5
SWEP.ScopeMat = Material("decals/perekrestie3.png")
SWEP.ScopeRot = -79.5

if CLIENT then
    function SWEP:Initialize()
        sib_wep[self] = true
        PrintTable(sib_wep)
        self.rtmat = GetRenderTarget("huy-glass", 512, 512, false)  
        self.mat = Material("huy-glass")
        self.mat:SetTexture("$basetexture",self.rtmat)

        local texture_matrix = self.mat:GetMatrix("$basetexturetransform")
        texture_matrix:SetAngles( Angle(0,-90,0) )
        self.mat:SetMatrix("$basetexturetransform",texture_matrix)
    end
    
    function SWEP:AdjustMouseSensitivity()
        return (self:GetOwner():KeyDown(IN_ATTACK2) and 0.3) or 1
    end
end


local hg_skins = CreateClientConVar("hg_skins","1",true,false,"ubrat govno",0,1)


SWEP.PremiumSkin = {
    [0] = "skins/goldmat/goldmaterial", 
    [1] = "skins/goldmat/goldmaterial",
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