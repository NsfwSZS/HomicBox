function EFFECT:Init(data)		
	self.Start = data:GetOrigin()
	
	self.Emitter = ParticleEmitter(self.Start)
	
	local p = self.Emitter:Add("particle/particle_glow_04_additive", self.Start)
		
	p:SetVelocity(VectorRand() * 100)
	p:SetAirResistance(200)
	p:SetDieTime(0.5)
	p:SetStartAlpha(255)
	p:SetEndAlpha(0)
	p:SetStartSize(math.random(1, 5))
	p:SetEndSize(math.random(10, 15))	
	p:SetRollDelta(math.Rand(-2, 2))
	p:SetCollide(true)
	p:SetColor(255, 0, 0)
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end