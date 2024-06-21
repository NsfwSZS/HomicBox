function EFFECT:Init(data)
	self.startPos = data:GetStart()
	self.endPos = data:GetOrigin()
	local clr = data:GetAngles()
	self.entity = data:GetEntity()

	self.color = Color(clr.x, clr.y, clr.z)

	self.dieTime = CurTime() + 0.05

	self:SetRenderBoundsWS(self.entity:LocalToWorld(self.startPos), self.endPos)
end

function EFFECT:Think()
	return CurTime() < self.dieTime
end

function EFFECT:Render()
	if not self.entity:IsValid() then return end

	local start = self.entity:LocalToWorld(self.startPos)

	render.SetMaterial(Material("effects/laser1"))
	render.DrawBeam(start, self.endPos, math.Rand(6, 16), 1, math.Rand(1, 5), self.color)

	render.SetMaterial(Material("sprites/light_glow02_add"))
	render.DrawSprite(self.endPos, math.random(32, 64), math.random(32, 64), self.color)

	render.DrawSprite(self.endPos + (start - self.endPos):GetNormal() * 8, 32, 32, self.color)
	render.DrawSprite(self.endPos + (start - self.endPos):GetNormal() * 16, 16, 16, self.color)
end
