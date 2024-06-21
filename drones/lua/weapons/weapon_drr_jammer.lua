AddCSLuaFile()

SWEP.PrintName	= "Signal Jammer"
SWEP.Category = "Drones Rewrite Tools"
SWEP.Purpose = "Tool that allows you to jam signals"

SWEP.Spawnable	= false
SWEP.UseHands	= true
SWEP.DrawAmmo	= false

SWEP.ViewModelFOV	= 55
SWEP.Slot			= 0
SWEP.SlotPos		= 6

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"

SWEP.ViewModel = "models/dronesrewrite/jammer/c_jammer.mdl"
SWEP.WorldModel = "models/dronesrewrite/jammer/w_jammer.mdl"

SWEP.TURNON = "buttons/button17.wav"
SWEP.SCREEN = {}
SWEP.SCREEN.ENABLED = false


function SWEP:Initialize()
	self:SetHoldType("pistol")
end

function SWEP:PostDrawViewModel(viewmodel)
	if SERVER then return end
	
	local pos, ang = viewmodel:GetBonePosition(39), self.Owner:EyeAngles()

end

function SWEP:Think()

end

function SWEP:PrimaryAttack()
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

-- egor opyat nichego ne sdelal
	timer.Simple(self:SequenceDuration(), function()
		if not IsValid(self) or not IsValid(self.Owner) then return end

		for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
			if not v.IS_DRONE then continue end
			if v == self then continue end

			local phys = v:GetPhysicsObject()

			phys:SetVelocity((v:GetPos() - self:GetPos()):GetNormal() * 450)
			phys:AddAngleVelocity(VectorRand() * 1200)
			
			v:TakeDamage(math.random(45,60) * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat(), self.Owner, self)

			if v.IS_DRR then
				v:SetEnabled(false)
				timer.Simple(10, function()
					if v:IsValid() then 
						v:SetEnabled(true)
					end
				end)
			end

			ParticleEffect("vapor_collapse_drr", v:GetPos(), Angle(0, 0, 0))
			v:TakeDamage(math.random(10,15) * DRONES_REWRITE.ServerCVars.DmgCoef:GetFloat(), self.Owner, self)
		end

		self:EmitSound("drones/nio_dissolve.wav", 100, 90)
	end)

	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
end

function SWEP:SecondaryAttack()
	self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
end

function SWEP:OnRemove()
	timer.Stop("DRR_J_weapon_idle")
	timer.Stop("DRR_J_doBeep")
end

function SWEP:Holster()
	self:OnRemove()
	self.SCREEN.ENABLED = false
	return true
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self:DoIdle()
	self:SetDeploySpeed(1)

	timer.Create("DRR_J_doBeep", self:SequenceDuration()-0.8, 1, function()
		self.Owner:EmitSound(self.TURNON, 65, 150)
		self.SCREEN.ENABLED = true
	end)
	
	if CLIENT then
		timer.Create("DRR_J_weapon_idle", self:SequenceDuration(), 2, function() 
			if IsValid(self) then 
				self:SendWeaponAnim(ACT_VM_IDLE) 
				self:DoIdle()
			end 
		end)
		
		
	end
	
	return true
end



function SWEP:DoIdle()
	timer.Create("DRR_J_weapon_idle", self:SequenceDuration(), 2, function() 
		if IsValid(self) then 
			self:SendWeaponAnim(ACT_VM_IDLE) 
			self:DoIdle()
		end 
	end)
end