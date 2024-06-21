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
		dlight.g = 50
		dlight.b = 0
		dlight.brightness = 1
		dlight.Decay = 1
		dlight.Size = math.random(150, 300)
		dlight.DieTime = CurTime()
	end

	local p = self.Emitter:Add("sprites/heatwave", self.Start - self.Forward * 4)
	p:SetVelocity(80 * self.Forward + 20 * VectorRand() * 2)
	p:SetGravity(Vector(0, 0, 100))
	p:SetAirResistance(160)
	p:SetStartAlpha(1)
	p:SetEndAlpha(0)
	p:SetDieTime(math.Rand(0.05, 0.1))
	p:SetStartSize(math.random(5, 12))
	p:SetEndSize(5)
	p:SetRoll(math.Rand(180, 480))
	p:SetRollDelta(math.Rand(-1, 1))

	local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)

	p:SetAirResistance(100)
	p:SetVelocity(self.Forward * 120 + VectorRand() * 4)
	p:SetGravity(Vector(0, 0, 10))
	p:SetDieTime(math.Rand(0.3, 0.6))
	p:SetStartAlpha(40)
	p:SetEndAlpha(0)
	p:SetStartSize(0)
	p:SetEndSize(15)
	p:SetRollDelta(math.Rand(-2, 2))
	p:SetColor(120, 120, 120)

	for i = 1, 5 do
		local p = self.Emitter:Add("effects/muzzleflash"..math.random(1, 4), self.Start + i * 6 * self.Forward)

		p:SetVelocity(10 * VectorRand())

		p:SetDieTime(math.Rand(0.04, 0.1))

		p:SetStartAlpha(50)

		p:SetStartSize(20 - i * 2)
		p:SetEndSize(0)

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





