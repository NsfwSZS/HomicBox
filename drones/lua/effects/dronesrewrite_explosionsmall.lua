AddCSLuaFile()

function EFFECT:Init(data)
	self.Start = data:GetOrigin()

	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, 30 do
		local vec = VectorRand()
		local p = self.Emitter:Add("effects/fleck_cement" .. math.random(1, 2), self.Start)

		p:SetDieTime(math.random(1, 6))
		p:SetStartAlpha(math.random(50, 150))
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(1, 2))
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetEndSize(0)		
		p:SetVelocity(vec * 200)
		p:SetGravity(Vector(0, 0, -100))
		p:SetColor(0, 0, 0)
	end

	for i = 1, 10 do
		local vec = VectorRand()
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 3), self.Start + vec * 10)

		p:SetDieTime(math.random(1, 2))
		p:SetStartAlpha(math.random(50, 150))
		p:SetEndAlpha(0)
		p:SetStartSize(10)
		--p:SetRoll(math.Rand(-10, 10))
		--p:SetRollDelta(math.Rand(-10, 10))
		p:SetEndSize(70)		
		p:SetVelocity(vec * 10)
		p:SetGravity(Vector(0, 0, 40))
		p:SetCollide(true)
		p:SetColor(50, 50, 20)
	end

	for i = 1, 20 do
		local vec = VectorRand()
		local p = self.Emitter:Add("particles/fir21", self.Start + vec * 2)

		p:SetDieTime(0.2)
		p:SetStartAlpha(20)
		p:SetEndAlpha(0)
		p:SetStartSize(5)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-4, 4))
		p:SetEndSize(10)		
		p:SetVelocity(vec * 50)
		p:SetAirResistance(40)
	end	
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end