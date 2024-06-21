SWEP.Base = 'weapon_base' -- base

SWEP.PrintName 				= "weapon_sib_base"
SWEP.Author 				= "sadsalat"
SWEP.Instructions			= "Salatis Imersive Base"
SWEP.Purpose 				= "Raise weapon - Hold RMB\nOn Rised: Rise sight - MWUP, Down sight - MWDOWN\nShoot - LMB"
SWEP.Category 				= "SIB"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

SWEP.HoldType  =  "revolver"

SWEP.DrawWeaponSelection = DrawWeaponSelection
SWEP.OverridePaintIcon = OverridePaintIcon

------------------------------------------

SWEP.Primary.ClipSize		= 50
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 100
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/fiveseven/fiveseven-1.wav"
SWEP.Primary.FarSound = ""
SWEP.Primary.Force = 0
SWEP.ReloadTime = 2
SWEP.ShootWait = 0.12
SWEP.NextShot = 0
SWEP.Sight = false
SWEP.Shell = "EjectBrass_9mm"
SWEP.ShellRotate = true
SWEP.ShellRotateUp = false

SWEP.ReloadSounds = {                                   -- [0.1] = {""}
}           											-- playtime soundpatch
SWEP.TwoHands = false

SWEP.CSMuzzleFlashes = true

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

------------------------------------------

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.addAng = Angle(0,0,0) -- Barrel ang adjust
SWEP.addPos = Vector(0,0,0) -- Barrel pos adjust
SWEP.SightPos = Vector(-4,0,5) -- Sight pos
SWEP.SightAng = Angle(0,0,0) -- Sight ang

SWEP.DoFlash = true

SWEP.Mobility = 0.2

SWEP.setAng = Angle(0,0,0) -- dont change
SWEP.Sightded = false --dont change

sib_wep = sib_wep or {}
function SWEP:Initialize()
    sib_wep[self] = true
   -- PrintTable(sib_wep)
    
    self:SetHoldType(self.HoldType)
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
end

function SWEP:Reload()
    local ply = self:GetOwner()
	if timer.Exists("reload"..self:EntIndex())  or self:Clip1()>=self:GetMaxClip1() or self:GetOwner():GetAmmoCount( self:GetPrimaryAmmoType() )<=0 then return nil end
	if ply:IsSprinting() then return nil end
	if ( self.NextShot > CurTime() ) then return end
	self:SetNWBool("Reloading",true)
	if self.HoldType == "revolver" then
		self:SetHoldType("pistol")
		timer.Simple(.8,function()
			self:SetHoldType(self.HoldType)
		end)
	end
	timer.Simple(.1,function()
		ply:SetAnimation(PLAYER_RELOAD)
	end)
	timer.Create( "reload"..self:EntIndex(), self.ReloadTime, 1, function()
			if IsValid(self) and IsValid(ply) and ply:GetActiveWeapon()==self and self:GetNWBool("Reloading") then
			local oldclip = self:Clip1()
			self:SetClip1(math.Clamp(self:Clip1()+self:GetOwner():GetAmmoCount( self:GetPrimaryAmmoType() ),0,self:GetMaxClip1()))
			local needed = self:Clip1()-oldclip
			ply:SetAmmo(self:GetOwner():GetAmmoCount( self:GetPrimaryAmmoType() )-needed, self:GetPrimaryAmmoType())
			self:SetNWBool("Reloading",false)
		end
	end)
	if SERVER then
    	self:ReloadSound()
	end
end

function SWEP:PrimaryAttack()
	self.ShootNext = self.NextShot or NextShot
	if not IsFirstTimePredicted() then return end
	if self.NextShot > CurTime() then return end
	if timer.Exists("reload"..self:EntIndex()) then return end
	if self.Owner:IsSprinting() then return end
    if !self.Sightded then return end
	if self:Clip1()<1 then 
		self:EmitSound("snd_jack_hmcd_click.wav",55,100,1,CHAN_ITEM,0,0)
		self.NextShot = CurTime() + self.ShootWait return end

	local ply = self:GetOwner() 
	self.NextShot = CurTime() + self.ShootWait*1.2
	if SERVER then
		net.Start("huysound")
			net.WriteVector(self:GetPos())
			net.WriteString(self.Primary.Sound)
			net.WriteString(self.Primary.FarSound)
			net.WriteEntity(ply)
		net.Broadcast()
	else
		self:EmitSound(self.Primary.Sound,100,math.random(100,120),1,CHAN_WEAPON,0,0)
	end
	--self.Forearm = self.Forearm + Angle(self.Primary.Force/10,-self.Primary.Force/10,0)--RotateAroundAxis(ply:EyeAngles():Right()*1,self.Primary.Force/5)
	--self.Forearm:RotateAroundAxis(ply:EyeAngles():Up()*-1,self.Primary.Force/10) --+ Angle(1,-0.5,-2)*self.Primary.Force/30

	local dmg = self.Primary.Damage--self.TwoHands and self.Primary.Damage * 2 or self.Primary.Damage
    self:FireBullet(dmg, 1, 5)
    if CLIENT and ply == LocalPlayer() then
        self:ShootPunch(self.Primary.Force)
		lastShootSib = CurTime() + 0.25*self.Primary.Force/50
	end
	self:SetNWFloat("VisualRecoil", self:GetNWFloat("VisualRecoil")+3.5)
end


function easedLerpAng1(fraction, from, to)
	return LerpAngle(math.ease.OutBack(fraction), from, to)
end

-- Custom Think
hook.Add("Think","fwep-customThinker",function()
	for wep in pairs(sib_wep) do
		if not IsValid(wep) then sib_wep[wep] = nil continue end

		local owner = wep:GetOwner()
		if not IsValid(owner) or (owner:IsPlayer() and not owner:Alive()) or owner:GetActiveWeapon() ~= wep then continue end--wtf i dont know

		if wep.Step then wep:Step() end
	end
end)

function SWEP:HUDShouldDraw( hud )
	if hud == "CHudWeaponSelection" then
			return not self:GetNWBool("Sighted")
	end
end

-- Think Function
local zeroAng = Angle(0,0,0)

-- Ease Lerps...
local function easedLerpAng(fraction, from, to)
	return LerpAngle(math.ease.OutSine(fraction), from, to)
end

local function easedLerpAng1(fraction, from, to)
	return LerpAngle(math.ease.OutQuad(fraction), from, to)
end

function SWEP:Step()

	ply = self:GetOwner()
	self.Sightded = self:GetNWBool("Sighted")
	-- trDistance for walls
	local tr = util.TraceLine( {
		start = ply:EyePos()+Vector(0,0,15),
		endpos = ply:EyePos()+Vector(0,0,15) + ply:EyeAngles():Forward() * 60,
		filter = ply
	} )
	local trdistance = math.Clamp((tr.HitPos:Distance(tr.StartPos)/40),0,1)

	-- SightUp function

	if SERVER then
		self:SetNWBool("Sighted",trdistance > .9 and (!self.Osmotr) and ply:KeyDown(IN_ATTACK2))
	end

	if (!self.Sightded and !self:GetNWBool("Reloading") or ply:IsSprinting()) and !self.Osmotr then
		self.Clavicle = easedLerpAng(0.1-math.Clamp(self.Mobility/70,0,0.035),self.Clavicle or zeroAng,((self.HoldType == "revolver" and Angle(0,0,-38)) or Angle(5,20,-35)))
		self.Head = easedLerpAng(0.1,self.Head or zeroAng,zeroAng)
	else
		self.Clavicle = easedLerpAng1(0.1-math.Clamp(self.Mobility/70,0,0.035),self.Clavicle or zeroAng,(self.Osmotr and Angle(20,0,25) )or zeroAng)
		self.Head = easedLerpAng1(0.05,self.Head or zeroAng,((self.HoldType == "revolver" and Angle(-15,-10,15)) or Angle(-15,-5,5)))
	end
	if CLIENT then 
		ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Clavicle"),self.Clavicle,false)
		ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_Head1"),self.Head,false)	
	end
	-- Visual recoil 
	if self:GetNWFloat("VisualRecoil")>0 then
		self:SetNWFloat("VisualRecoil",Lerp(0.075,self:GetNWFloat("VisualRecoil") or 0,0))
	end
	if CLIENT and ply != LocalPlayer() then
		ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Finger11"),Angle(0,self:GetNWFloat("VisualRecoil")*-20,0),false)
		ply:ManipulateBonePosition(ply:LookupBone("ValveBiped.Bip01_R_Clavicle"),Vector(0,self:GetNWFloat("VisualRecoil")*-0.25,0),false)
		ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Hand"),(self.HoldType == "revolver" and Angle(self:GetNWFloat("VisualRecoil")*2.5,0,0)) or Angle(self:GetNWFloat("VisualRecoil")*0.5,0,0),false)		
	end

	if ply:KeyDown(IN_ALT1) then
		self:SetHoldType("slam")
		self.Osmotr = true
	elseif self:GetHoldType() == "slam" then
		self:SetHoldType(self.HoldType)
		self.Osmotr = false
	end
	-- Client recoil 

	if CLIENT and ply == LocalPlayer() then
        viewShootPunch = easedLerpAng1(0.01,viewShootPunch,Angle(0,0,0))
		self.eyeSpray = self.eyeSpray or Angle(0,0,0)
		self.Finger = Lerp(0.25, self.Finger or 0, (( ply:KeyDown(IN_ATTACK) and -1 ) or 0))
		
		ply:SetEyeAngles(ply:EyeAngles() + self.eyeSpray)
		ply:ManipulateBoneAngles( ply:LookupBone("ValveBiped.Bip01_R_Finger11"), Angle(0,self.Finger*40,0), false )
		ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Hand"),(self.Osmotr and (self.HoldType == "revolver" and (Angle(15,0,math.sin(CurTime()*0.5)*55)) or (Angle(15,-25,math.sin(CurTime()*0.5)*55))) )or Angle(0,0,0),false)
		
		self.eyeSpray = LerpAngle(0.2,self.eyeSpray,Angle(0,0,0))
	end

end
function SWEP:SecondaryAttack()
end

-- Holster bone manipulate remover
function SWEP:Holster()
	local ply = self:GetOwner()
	timer.Simple(0.1,function()
		ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Hand"),Angle(0,0,0),true)	
		ply:ManipulateBonePosition(ply:LookupBone("ValveBiped.Bip01_R_Clavicle"),Vector(0,0,0),true)
		ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Clavicle"),Angle(0,0,0),true)
		ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_Head1"),Angle(0,0,0),true)	
	end)
	self.Clavicle = Angle(0,0,0)
	self.Head = Angle(0,0,0)
	self:SetNWFloat("VisualRecoil",0)
	self:SetNWBool("Reloading",false)
	return true
end

-- Death bone manipulate remover
hook.Add( "PlayerDeath", "Resetbones", function( ply )
	ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Hand"),Angle(0,0,0),true)	
	ply:ManipulateBonePosition(ply:LookupBone("ValveBiped.Bip01_R_Clavicle"),Vector(0,0,0),true)
	ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_R_Clavicle"),Angle(0,0,0),true)
	ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_Head1"),Angle(0,0,0),true)
end )