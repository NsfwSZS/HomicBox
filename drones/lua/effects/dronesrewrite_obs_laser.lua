AddCSLuaFile()

local mat3 = Material("sprites/orangecore1")
local mat2 = Material("particle/warp1_warp")

local mat = Material("cable/physbeam")

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.End = self.Start + vector_up * 90000
	self.Life = CurTime() + 1.4
	self.Size = 1000

	self:SetRenderBoundsWS(self.Start, self.End)
end

function EFFECT:Think()
	if CurTime() > self.Life then return false end
	self.Size = math.Approach(self.Size, 0, 15)

	return true
end

function EFFECT:Render()
	render.SetMaterial(mat)
	render.DrawBeam(self.Start, self.End, math.Rand(64, 256), 0, 0, Color(255, 255, 255, 255))

	render.SetMaterial(mat3)
	render.DrawSprite(self.Start, self.Size, self.Size, Color(255, 255, 255, 255 - (self.Size * 0.255)))

	render.SetMaterial(mat2)
	local new = 2000 - self.Size * 2
	render.DrawSprite(self.Start, new, new, Color(255, 255, 255, self.Size * 0.255))
end





