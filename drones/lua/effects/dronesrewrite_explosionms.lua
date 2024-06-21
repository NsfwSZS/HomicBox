AddCSLuaFile()

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.size = 320000

	self.Emitter = ParticleEmitter(self.Start)

	local p = self.Emitter:Add("particle/warp3_warp_noz", self.Start)

	p:SetDieTime(0.3)
	p:SetStartSize(200)
	
	for i = 1, 200 do
		local vec = VectorRand()
		local p = self.Emitter:Add("effects/fleck_cement" .. math.random(1, 2), self.Start)

		p:SetDieTime(math.random(8, 15))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(60, 90))
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		--p:SetEndSize(0)		
		p:SetVelocity(vec * 5000)
		p:SetAirResistance(10)
		p:SetGravity(Vector(0, 0, math.random(-500, -200)))
		p:SetColor(0, 0, 0)
	end

	for i = 1, 180 do
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 3), self.Start)

		p:SetDieTime(4)
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(1000, 2000))
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-5, 5))
		p:SetEndSize(math.random(7000, 8000))		

		local vec = Angle(0, i * 2, 0)
		p:SetVelocity(vec:Forward() * math.random(7000, 8000))
		p:SetColor(0, 0, 0)
	end

	for i = 6, math.random(5, 15) do
		local vec = VectorRand()

		for a = 1, 15 do
			local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 3), self.Start + vec * a * 300)

			p:SetDieTime(math.Rand(8, 14))
			p:SetStartAlpha(math.random(150, 200))
			p:SetEndAlpha(0)
			p:SetStartSize(300)
			p:SetRoll(math.Rand(-10, 10))
			p:SetRollDelta(math.Rand(-0.2, 0.2))
			p:SetEndSize(2000)		
			p:SetGravity(Vector(0, 0, -a * math.Rand(1, 2)))
			p:SetVelocity(VectorRand() * 100)
			p:SetAirResistance(a)
			p:SetCollide(true)
			p:SetColor(10, 10, 5)
		end
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	self.size = self.size - 5000

	return self.size > 0
end

function EFFECT:Render()
	render.SetMaterial(Material("sprites/light_ignorez"))
	render.DrawSprite(self.Start, self.size * 2, self.size, Color(255, 255, 255, 255))
end





