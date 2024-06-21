AddCSLuaFile()

function EFFECT:Init(data)
	self.Start = data:GetOrigin()

	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, 128 do
		local vec = VectorRand()
		local p = self.Emitter:Add("particles/balloon_bit", self.Start + vec * 16)

		p:SetDieTime(math.random(2, 4))
		p:SetStartAlpha(math.random(50, 150))
		p:SetEndAlpha(0)
		p:SetStartSize(2)
		p:SetRoll(math.Rand(-180, 180))
		p:SetRollDelta(math.Rand(-5, 5))
		p:SetEndSize(4)		
		p:SetVelocity(vec * 64)
		p:SetAirResistance(128)
		p:SetGravity(Vector(0, 0, -40))
		p:SetCollide(true)
		p:SetColor(255, 255, 255)
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end





