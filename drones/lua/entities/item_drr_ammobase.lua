AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "AMMO"
ENT.Spawnable = false
ENT.Category = "Drones Rewrite Ammo"

ENT.Model = ""
ENT.Material = nil
ENT.Hp = 200
ENT.Amount = 0
ENT.RemoveTouched = false

ENT.IS_DRR_AMMO = true

function ENT:GetAmount()
	return self:GetNWInt("Amount")
end

function ENT:GetMaxAmount()
	return self:GetNWInt("MaxAmount")
end

if SERVER then
	function ENT:TakeAmount(n)
		self:SetAmount(self:GetAmount() - n)
	end

	function ENT:SetAmount(n)
		self:SetNWInt("Amount", n)
	end

	function ENT:OnTouched()
		if self.RemoveTouched then SafeRemoveEntity(self) end
	end

	function ENT:SpawnFunction(ply, tr, class)
		if not tr.Hit then return end

		local pos = tr.HitPos + tr.HitNormal * 32

		local ent = ents.Create(class)
		ent.Owner = ply
		ent:SetPos(pos)
		ent:SetAngles(Angle(0, (ply:GetPos() - tr.HitPos):Angle().y, 0))
		ent:Spawn()
		ent:Activate()

		return ent
	end

	function ENT:Initialize()
		local a = self.Amount
		self:SetAmount(a)
		self:SetNWInt("MaxAmount", a)

	    self:SetModel(self.Model)
	    if self.Material then self:SetMaterial(self.Material) end

	    self:SetMoveType(MOVETYPE_VPHYSICS)
	    self:SetSolid(SOLID_VPHYSICS)
	    self:PhysicsInit(SOLID_VPHYSICS)

	    self:GetPhysicsObject():Wake()
	end

	function ENT:Explode()
		self.OnTakeDamage = function() end

		ParticleEffect("splode_big_main", self:GetPos(), Angle(0, 0, 0))		
		
		self:EmitSound("ambient/explosions/explode_3.wav", 100)

		util.BlastDamage(self, self, self:GetPos(), 300, 100)
		util.ScreenShake(self:GetPos(), 60, 20, 1, 1000) 
		
		SafeRemoveEntity(self)
	end

	function ENT:PhysicsCollide(data, physobj)
		if data.DeltaTime < 0.5 or data.Speed < 200 then return end
		self:TakeDamage(data.Speed * 0.02)
	end

	function ENT:OnTakeDamage(dmg)
		self.Hp = self.Hp - dmg:GetDamage()
		if self.Hp <= 0 then self:Explode() end
	end
else
	function ENT:Draw()
		self:DrawModel()

		local ang = self:GetAngles()
		ang:RotateAroundAxis(ang:Up(), (LocalPlayer():GetPos() - self:GetPos()):Angle().y - ang.y + 90)
		ang:RotateAroundAxis(ang:Forward(), 90)

		local height = self:OBBMaxs().z * 1.5

		cam.Start3D2D(self:GetPos() + self:GetUp() * height, ang, 0.1)
			surface.SetDrawColor(Color(0, 150, 255))
			surface.DrawOutlinedRect(-100, -30, 200, 70)
			local amount = (self:GetAmount() / self:GetMaxAmount()) * 200
			surface.DrawRect(-95, -25, amount - 10, 60)

			draw.SimpleText(self.PrintName, "DronesRewrite_font1", -86, -86, nil, TEXT_ALIGN_LEFT)
			draw.SimpleText(self:GetAmount() .. " / " .. self:GetMaxAmount(), "DronesRewrite_font1", 110, -16, nil, TEXT_ALIGN_LEFT)
		cam.End3D2D()
	end
end