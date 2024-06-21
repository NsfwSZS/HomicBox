AddCSLuaFile()

function EFFECT:Init(data)
	if DRONES_REWRITE.ClientCVars.NoMuzzleFlash:GetBool() then return end

	self.Start = data:GetOrigin()
	self.Forward = data:GetNormal()

	self.Emitter = ParticleEmitter(self.Start)

	for i = 1, 4 do
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)

		p:SetAirResistance(100)
		p:SetVelocity(self.Forward * i * 20 + VectorRand() * 5)
		p:SetGravity(Vector(0, 0, 4))
		p:SetDieTime(math.Rand(0.5, 1))
		p:SetStartAlpha(64)
		p:SetEndAlpha(0)
		p:SetStartSize(0)
		p:SetEndSize(20)
		p:SetRollDelta(math.Rand(-2, 2))
		p:SetColor(120, 120, 120)
	end	

	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end





