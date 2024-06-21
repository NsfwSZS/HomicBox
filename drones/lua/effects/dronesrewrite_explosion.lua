AddCSLuaFile()

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.size = 4000

	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, 30 do
		local vec = VectorRand()
		local p = self.Emitter:Add("effects/fleck_cement" .. math.random(1, 2), self.Start)

		p:SetDieTime(math.random(1, 15))
		p:SetStartAlpha(math.random(50, 150))
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(1, 3))
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetEndSize(0)		
		p:SetVelocity(vec * 450)
		p:SetGravity(Vector(0, 0, -50))
		p:SetColor(0, 0, 0)
	end

	for i = 1, 10 do
		local vec = VectorRand()
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start + vec)

		p:SetDieTime(math.random(2, 3))
		p:SetStartAlpha(math.random(50, 150))
		p:SetEndAlpha(0)
		p:SetStartSize(20)
		--p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-1, 1))
		p:SetEndSize(80)		
		p:SetVelocity(vec * 40)
		p:SetGravity(Vector(0, 0, 20))
		p:SetCollide(true)
		p:SetColor(50, 50, 20)
	end

	for i = 3, math.random(3, 6) do
		local vec = VectorRand()

		for a = 1, math.random(4, 8) do
			local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 3), self.Start + vec * 15)

			p:SetDieTime(math.Rand(0.6, 1.5))
			p:SetStartAlpha(math.random(40, 80))
			p:SetEndAlpha(0)
			p:SetStartSize(20)
			p:SetRoll(math.Rand(-180, 180))
			--p:SetRollDelta(math.Rand(-1, 1))
			p:SetEndSize(150)		
			p:SetVelocity(((self.Start + vec * a * 15) - self.Start):GetNormal() * a * 200)
			p:SetAirResistance(300 + a * 20)
			p:SetCollide(true)
			p:SetColor(0, 0, 0)

			local p = self.Emitter:Add("particles/fir21", self.Start + vec * a * math.Rand(10, 18) + VectorRand() * 40)

			p:SetDieTime(0.05)
			p:SetStartAlpha(40)
			p:SetEndAlpha(0)
			p:SetStartSize(20)
			p:SetRoll(math.Rand(-10, 10))
			p:SetRollDelta(math.Rand(-1, 1))
			p:SetEndSize(70)		
			p:SetVelocity(((self.Start + vec * a * 15) - self.Start):GetNormal() * 500)
			p:SetAirResistance(20)
			p:SetColor(200, 150, 0)
		end
	end

	for i = 1, 30 do
		local vec = VectorRand()
		local p = self.Emitter:Add("particles/fir21", self.Start + vec * 25)

		p:SetDieTime(0.1)
		p:SetStartAlpha(60)
		p:SetEndAlpha(0)
		p:SetStartSize(20)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-0.5, 0.5))
		p:SetEndSize(60)		
		p:SetVelocity(vec * 155)
		p:SetAirResistance(40)
		p:SetColor(255, 200, 0)
	end	
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	self.size = self.size - 500

	return self.size > 0
end

function EFFECT:Render()
	render.SetMaterial(Material("sprites/light_ignorez"))
	render.DrawSprite(self.Start, self.size*2, self.size, Color(255, 100, 0, 50))
end





