AddCSLuaFile()

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Forward = data:GetNormal()

	self.Emitter = ParticleEmitter(self.Start)

	local dlight = DynamicLight(self:EntIndex())
	if dlight then
		dlight.pos = self.Start
		dlight.r = 255
		dlight.g = 50
		dlight.b = 0
		dlight.brightness = 1
		dlight.Decay = 1
		dlight.Size = math.random(150, 300)
		dlight.DieTime = CurTime()
	end

	local p = self.Emitter:Add("sprites/heatwave", self.Start - self.Forward * 70)
	p:SetVelocity(self.Forward * 60 + VectorRand() * 20)
	p:SetAirResistance(200)
	p:SetDieTime(math.Rand(0.1, 0.3))
	p:SetStartSize(150)
	p:SetEndSize(0)
	p:SetRoll(math.Rand(180, 480))
	p:SetRollDelta(math.Rand(-4, 4))

	for i = 1, 16 do
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start - self.Forward * 6 * i)

		p:SetAirResistance(400)
		p:SetVelocity(-self.Forward * 300 + VectorRand() * 5)
		p:SetGravity(Vector(0, 0, 10))
		p:SetDieTime(math.Rand(2, 3) - i * 0.3)
		p:SetStartAlpha(150)
		p:SetEndAlpha(0)
		p:SetStartSize(0)
		p:SetEndSize(25)
		p:SetRollDelta(math.Rand(-1, 1))
		p:SetColor(80, 80, 80)
	end

	for i = 1, 40 do
		local p = self.Emitter:Add("effects/muzzleflash"..math.random(1, 4), self.Start - self.Forward * (45 + i * 1.3))

		p:SetVelocity(-self.Forward * i * 3 + VectorRand() * 2)

		p:SetDieTime(i * 0.005)

		p:SetStartAlpha(255)

		p:SetStartSize(50 - i)
		p:SetEndSize(0)

		p:SetRollDelta(math.Rand(-2, 2))

		p:SetColor(255, 255, 255)	
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end





