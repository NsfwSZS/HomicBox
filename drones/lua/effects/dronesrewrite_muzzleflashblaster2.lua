AddCSLuaFile()

function EFFECT:Init(data)
	if DRONES_REWRITE.ClientCVars.NoMuzzleFlash:GetBool() then return end
	
	self.Start = data:GetOrigin()
	self.Forward = data:GetNormal()

	self.Emitter = ParticleEmitter(self.Start)

	local dlight = DynamicLight(self:EntIndex())
	if dlight then
		dlight.pos = self.Start
		dlight.r = 255
		dlight.g = 0
		dlight.b = 0
		dlight.brightness = 1
		dlight.Decay = 1
		dlight.Size = math.random(150, 300)
		dlight.DieTime = CurTime()
	end

	local p = self.Emitter:Add("sprites/heatwave", self.Start - self.Forward * 2)
	p:SetVelocity(120 * self.Forward + 20 * VectorRand() * 2)
	p:SetGravity(Vector(0, 0, 100))
	p:SetAirResistance(160)
	p:SetDieTime(math.Rand(0.1, 0.15))
	p:SetStartSize(30)
	p:SetEndSize(0)
	p:SetRoll(math.Rand(180, 480))
	p:SetRollDelta(math.Rand(-1, 1))

	for a = 1, 12 do
		for i = 1, 4 do
			local p = self.Emitter:Add("sprites/light_glow02_add", self.Start + i * 4 * self.Forward)

			p:SetAirResistance(200)
			p:SetVelocity(6 * VectorRand())
			p:SetDieTime(math.Rand(0.05, 0.15))
			p:SetStartAlpha(155)
			p:SetStartSize(0)
			p:SetEndSize(34 - i * 6)
			p:SetRoll(math.Rand(180, 480))
			p:SetRollDelta(math.Rand(-1, 1))
			p:SetColor(255, 0, 0)	
		end
	end
	
	for i = 1, 4 do
		local p = self.Emitter:Add("sprites/light_glow02_add", self.Start + i * 4 * self.Forward)

		p:SetAirResistance(200)
		p:SetVelocity(6 * VectorRand())
		p:SetDieTime(math.Rand(0.05, 0.15))
		p:SetStartAlpha(155)
		p:SetStartSize(0)
		p:SetEndSize(34 - i * 6)
		p:SetRoll(math.Rand(180, 480))
		p:SetRollDelta(math.Rand(-1, 1))
		p:SetColor(255, 255, 255)	
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end




