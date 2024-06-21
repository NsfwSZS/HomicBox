AddCSLuaFile()

local sin = math.sin
local cos = math.cos
local random = math.random
local Rand = math.Rand
local abs = math.abs

function EFFECT:Init(data)
	self.Start = data:GetOrigin()

	local ef = EffectData()
	ef:SetOrigin(self.Start)
	util.Effect("HelicopterMegaBomb", ef) 

	self.Emitter = ParticleEmitter(self.Start)
	if not self.Emitter then return end

	local p = self.Emitter:Add("particle/warp1_warp", self.Start)

	p:SetDieTime(0.4)
	p:SetStartAlpha(255)
	p:SetEndAlpha(0)
	p:SetStartSize(0)
	p:SetEndSize(2500)
	
	for i = 1, 15 do
		local vec = VectorRand()
		vec.z = abs(vec.z)

		local p = self.Emitter:Add("effects/fleck_cement" .. random(1, 2), self.Start)

		p:SetDieTime(random(7, 12))
		p:SetStartAlpha(random(120, 250))
		p:SetEndAlpha(0)
		p:SetStartSize(random(10, 40))
		p:SetRoll(Rand(-10, 10))
		p:SetRollDelta(Rand(-10, 10))	
		p:SetVelocity(vec * 1000)
		p:SetAirResistance(40)
		p:SetGravity(Vector(0, 0, random(-300, -100)))
		p:SetColor(0, 0, 0)
	end

	for i = 1, 5 do
		local p = self.Emitter:Add("particle/smokesprites_000" .. random(1, 3), self.Start)

		p:SetDieTime(1.8)
		p:SetStartAlpha(130)
		p:SetEndAlpha(0)
		p:SetStartSize(100)
		p:SetRollDelta(Rand(-1, 1))
		p:SetEndSize(1500)		
		p:SetVelocity(Vector(sin(i), cos(i), 0) * 2500)
		p:SetAirResistance(300)
		p:SetColor(50, 50, 20)

		local vec = VectorRand()
		local p = self.Emitter:Add("particles/fir21", self.Start + vec * 100)

		p:SetDieTime(0.15)
		p:SetStartAlpha(120)
		p:SetEndAlpha(0)
		p:SetStartSize(0)
		p:SetRoll(Rand(-10, 10))
		p:SetRollDelta(Rand(-32, 32))
		p:SetEndSize(1000)		
		p:SetVelocity(Vector(sin(i), cos(i), 0) * 3500)
		p:SetAirResistance(300)
		p:SetColor(255, 200, 0)
	end

	for i = 1, math.random(3, 5) do
		local vec = VectorRand()

		for a = 1, random(5, 8) do
			local p = self.Emitter:Add("particle/smokesprites_000" .. random(1, 3), self.Start)

			p:SetDieTime(Rand(0.4, 1))
			p:SetStartAlpha(255)
			p:SetEndAlpha(0)
			p:SetStartSize(80)
			p:SetRoll(Rand(-10, 10))
			p:SetRollDelta(Rand(-0.5, 0.5))
			p:SetEndSize(360 + a * 10)		
			p:SetGravity(Vector(0, 0, -random(10, 50) - a * 22))
			p:SetVelocity(vec * a * 850)
			p:SetAirResistance(350)
			p:SetColor(70, 70, 20)
		end
	end


	for i = 1, 30 do
		local vec = VectorRand()
		local p = self.Emitter:Add("particles/fir21", self.Start + vec * 100)

		p:SetDieTime(0.2)
		p:SetStartAlpha(60)
		p:SetEndAlpha(0)
		p:SetStartSize(100)
		p:SetRoll(Rand(-10, 10))
		p:SetRollDelta(Rand(-0.5, 0.5))
		p:SetEndSize(200)		
		p:SetVelocity(vec * 1500)
		p:SetAirResistance(40)
		p:SetColor(255, 200, 0)
	end	

	-- Exp core

	local vec = VectorRand()
	local p = self.Emitter:Add("sprites/orangecore1", self.Start + vec * 40)

	p:SetAirResistance(50)
	p:SetDieTime(0.2)
	p:SetStartAlpha(255)
	p:SetEndAlpha(0)
	p:SetStartSize(0)
	p:SetRoll(Rand(-1, 1))
	p:SetRollDelta(Rand(-15, 15))
	p:SetEndSize(800)		
	p:SetColor(255, 255, 255)

	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()

end





