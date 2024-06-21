function EFFECT:Init(data)		
	self.Start = data:GetOrigin()
	
	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, 2 do
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)
		
		p:SetVelocity(VectorRand() * 30)
		p:SetAirResistance(200)
		p:SetDieTime(2)
		p:SetStartAlpha(30)
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(10, 20))
		p:SetEndSize(math.random(20, 30))	
		p:SetRollDelta(math.Rand(-2, 2))
		p:SetCollide(true)
		p:SetColor(150, 150, 150)
	end
	
	for i = 1, 4 do
		local p = self.Emitter:Add("particles/flamelet" .. math.random(1, 5), self.Start)
		
		p:SetDieTime(0.1)
		p:SetStartAlpha(100)
		p:SetEndAlpha(0)
		p:SetStartSize(math.Rand(3, 6))
		p:SetEndSize(1)	
		p:SetCollide(true)
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end