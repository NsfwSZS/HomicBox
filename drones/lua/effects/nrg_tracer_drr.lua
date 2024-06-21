AddCSLuaFile()
AddCSLuaFile( "effects/fxbase.lua" )
include( "effects/fxbase.lua" )

EFFECT.Speed	= 6500 --16000
EFFECT.Length	= 64

function EFFECT:Think()

	util.ParticleTracerEx( 
		"nrg_tracer_drr", --particle system
		self.StartPos, --startpos
		self.EndPos, --endpos
		self.Parent:EntIndex(), --entity index
		1, --do whiz effect
		-1  --attachment
	)
	
end

function EFFECT:Render()

end
