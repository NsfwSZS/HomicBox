COMMANDS = COMMANDS or {}

local explosions = {
    ["models/props_junk/gascan001a.mdl"] = true,
	["models/props_junk/propane_tank001a.mdl"] = true,
	["models/props_junk/PropaneCanister001a.mdl"] = true,
    ["models/props_c17/oildrum001_explosive.mdl"] = true,
    ["models/props_junk/metalgascan.mdl"] = true,
    ["models/props_c17/canister02a.mdl"] = true,
    ["models/props_c17/canister01a.mdl"] = true,
    ["models/props_c17/oildrum001.mdl"] = true
}

local function BoomSmall(ent)
    local SelfPos,PowerMult = ent:LocalToWorld(ent:OBBCenter()),2

    timer.Simple(math.Rand(0,.1),function()
        ParticleEffect("pcf_jack_groundsplode_small",SelfPos,vector_up:Angle())
        util.ScreenShake(SelfPos,99999,99999,1,3000)
        sound.Play("BaseExplosionEffect.Sound", SelfPos,120,math.random(130,160))

        for i = 1,4 do
            sound.Play("explosions/doi_ty_01_close.wav",SelfPos,140,math.random(140,160))
        end

        timer.Simple(.1,function()
            for i = 1, 5 do
                local Tr = util.QuickTrace(SelfPos, VectorRand() * 20)

                if Tr.Hit then
                    util.Decal("Scorch", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
                end
            end
        end)

        JMod.WreckBuildings(ent, SelfPos, PowerMult/2)
        JMod.BlastDoors(ent, SelfPos, PowerMult)

		for i = 1, 3 do
			local FireVec = ( VectorRand() * .3 + Vector(0, 0, .3)):GetNormalized()
			FireVec.z = FireVec.z / 2
			local Flame = ents.Create("ent_jack_gmod_eznapalm")
			Flame:SetPos(SelfPos + Vector(0, 0, 50))
			Flame:SetAngles(FireVec:Angle())
			Flame:SetOwner(game.GetWorld())
			JMod.SetOwner(Flame, game.GetWorld())
			Flame.SpeedMul = 0.25
			Flame.Creator = game.GetWorld()
			Flame.HighVisuals = true
			Flame:Spawn()
			Flame:Activate()
		end

        timer.Simple(0,function()
            local ZaWarudo = game.GetWorld()
            local Infl, Att = (IsValid(ent) and ent) or ZaWarudo, (IsValid(ent) and IsValid(ent.Owner) and ent.Owner) or (IsValid(ent) and ent) or ZaWarudo
            util.BlastDamage(Infl,Att,SelfPos,120 * PowerMult,120 * PowerMult)

            util.BlastDamage(Infl,Att,SelfPos,20 * PowerMult,1000 * PowerMult)
        end)
    end)
end

hook.Add( "EntityTakeDamage", "EntityDamageExample", function( target, dmginfo )
    if explosions[target:GetModel()] then
        local r = math.random(1,55)
        if dmginfo:IsDamageType(DMG_GENERIC+DMG_SLASH+DMG_CLUB+DMG_BULLET+DMG_CRUSH+DMG_FALL) then
            dmginfo:SetDamage( 0 )
        elseif dmginfo:IsDamageType(DMG_BURN) and r == 55 then
            BoomSmall(target)
            target:Remove()
        elseif dmginfo:IsDamageType(DMG_BLAST) then
            BoomSmall(target)
            target:Remove()
        end
    end 
end )

COMMANDS.arm = {function(ply,args)
	if not ply:IsAdmin() then return end
    ply:GetEyeTrace().Entity:Arm()
    ply:GetEyeTrace().Entity:Activate()
end,1}

hook.Add("PlayerLoadout", "LoadOut", function(ply)
    ply:Give( "weapon_hands" )
    ply:SelectWeapon( "weapon_hands" )
    ply:SetHealth(150)
    return false
end)


hook.Add("PlayerCanPickupWeapon","PlayerManualPickup",function(ply,wep)
	local allow = false
	if wep.Spawned then
		local vec = ply:EyeAngles():Forward()
		local vec2 = (wep:GetPos() - ply:EyePos()):Angle():Forward()
	
		if vec:Dot(vec2) > 0.8 and not ply:HasWeapon(wep:GetClass()) then
			if ply:KeyDown(IN_USE) then
				allow = true
			end
		end
	else
		allow = true
	end
	
	if allow then
		return true
	end

	return false
end)

hook.Add("CanDrive","AntiDriveRewrite",function( p, e )
		p:ChatPrint("Неа...")
		return false
end)

-- DEATH TIMER

util.AddNetworkString("RespawnTimer")

local mintime = {
    ["superadmin"] = 10,
    ["admin"] = 10,
    ["premium"] = 15,
	["user"] = 25,
}

hook.Add("PlayerDeath", "identifier", function(ply)
    ply.timeOfDeath = CurTime() + (mintime[ply:GetUserGroup()] or 45)
    net.Start("RespawnTimer")
    	net.WriteFloat(ply.timeOfDeath)
    net.Send(ply)
end)

hook.Add("PlayerDeathThink", "pspawn", function(ply)
    if ply.timeOfDeath then
        ply.timeleft = math.abs(CurTime() - ply.timeOfDeath, 0)
        if ply.timeleft <= 0 then
            ply:Spawn()
			ply.timeOfDeath = nil
			return true
        end
        return false
    else
   	 	return true
    end
end)



