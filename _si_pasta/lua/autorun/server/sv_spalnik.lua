
local function zalupa( ply )
	for k, v in ipairs( ents.FindByClass( "sleepnik" ) ) do
		if v:GetNW2Entity("sleeper_2281337") == ply then 
			ply:SetPos(v:GetPos())
			print("WORK")
		end
		print("A CHO VSMISLE")
		print(v:GetOwner())
	end
end


hook.Add( "PlayerSpawn", "spalnik_hook", zalupa )