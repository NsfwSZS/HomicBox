if SERVER then AddCSLuaFile() end

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.size = data:GetScale()
	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, 100 do
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)

		p:SetDieTime(math.Rand(2, 4))
		p:SetStartAlpha(80)
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(150, 200) * self.size)
		p:SetEndSize(150 * self.size)
		p:SetRoll(math.Rand(-1, 1))
		p:SetRollDelta(math.Rand(-1, 1))
		//p:SetCollide(true)
			
		p:SetVelocity(VectorRand():GetNormal() * 550 * self.size)
		p:SetColor(25, 25, 25)
			
		timer.Simple(0.5, function() p:SetVelocity(p:GetVelocity() / 4) end)
	end
		
	for i = 1, math.random(50, 150) do
		local p = self.Emitter:Add("particles/fir21", self.Start)

		p:SetDieTime(math.Rand(0.4, 0.6))
		p:SetStartAlpha(60)
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(100, 200) * self.size)
		p:SetEndSize(100 * self.size)
		//p:SetRoll(math.Rand(-10, 10))
		//p:SetRollDelta(math.Rand(-10, 10))
		p:SetCollide(true)
			
		p:SetVelocity(VectorRand():GetNormal() * math.random(650, 850) * self.size)
		p:SetColor(255, 150, 0)
	end
		
	for i = 1, math.random(20, 50) do
		local p = self.Emitter:Add("effects/muzzleflash"..math.random(1,4), self.Start)

		p:SetDieTime(math.Rand(0.4, 0.6))
		p:SetStartAlpha(60)
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(50, 150) * self.size)
		p:SetEndSize(50 * self.size)
		//p:SetRoll(math.Rand(-10, 10))
		//p:SetRollDelta(math.Rand(-10, 10))
		p:SetCollide(true)
			
		p:SetVelocity(VectorRand():GetNormal() * math.random(150, 350) * self.size)
		p:SetColor(255, 150, 0)
	end
		
	for i = 1, math.random(10, 30) do
		local vec = VectorRand():GetNormal()
		//vec.z = 0
		local pos = (self.Start + vec)
		
		local p = self.Emitter:Add("effects/fleck_cement" .. math.random(1, 2), self.Start + vec * 100)

		p:SetDieTime(math.Rand(5, 10))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(10, 25) * self.size)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetEndSize(0 * self.size)		
		p:SetVelocity((Vector(0, 0, math.random(450, 800)) + vec * math.random(350, 1000)) + (pos - self.Start):GetNormal() * math.random(100, 100) * self.size)
		p:SetGravity(Vector(0, 0, math.random(-300, -200)))
		p:SetColor(80, 80, 80)
		p:SetCollide(true)
	end
		
	for i = 1, math.random(40, 70) do
		local vec = VectorRand():GetNormal()
		vec.z = 0
		local pos = (self.Start + vec * 5)
		
		local p = self.Emitter:Add("sprites/orangeflare1", self.Start + vec * 100)
			
		p:SetDieTime(math.Rand(1, 5))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(15 * self.size)
		p:SetEndSize(0 * self.size)
		p:SetVelocity(((pos - self.Start):GetNormal() * math.random(100, 200)) + Vector(0, 0, math.random(-200, 500)) * self.size)
		p:SetGravity(Vector(0, 0, -40))
		p:SetColor(80, 80, 80)
		p:SetCollide(true)
		
		timer.Simple(0.5, function() p:SetVelocity(p:GetVelocity() / 10) end)
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end