local validUserGroup = {
	--meagsponsor = true,
	megapenis = true
}

local BlackList = {
	["ent_jack_gmod_ezarmor_slcalf"] = true,
    ["ent_jack_gmod_ezarmor_srcalf"] = true,
	["ent_jack_gmod_ezarmor_slforearm"] = true,
	["ent_jack_gmod_ezarmor_srforearm"] = true,
    ["ent_jack_gmod_ezarmor_htorso"] = true,
    ["ent_jack_gmod_ezarmor_mhtorso"] = true,
	["ent_jack_gmod_ezarmor_mtorso"] = true,
	["ent_jack_gmod_ezarmor_llthigh"] = true,
	["ent_jack_gmod_ezarmor_lrthigh"] = true,
	["ent_jack_gmod_ezarmor_hlshoulder"] = true,
	["ent_jack_gmod_ezarmor_hrshoulder"] = true,
	["ent_jack_gmod_ezarmor_hlthigh"] = true,
	["ent_jack_gmod_ezarmor_hrthigh"] = true,
	["ent_jack_gmod_ezarmor_lrshoulder"] = true,
	["ent_jack_gmod_ezarmor_llshoulder"] = true,
	["ent_jack_gmod_ezarmor_maska"] = true,
	["ent_jack_gmod_ezarmor_spelvis"] = true,
    ["ent_jack_gmod_ezarmor_hhead"] = true,
    ["ent_jack_gmod_ezarmor_mltorso"] = true
}

if SERVER then
    COMMANDS.accessspawn = {function(ply,args)
        SetGlobalBool("AccessSpawn",tonumber(args[1]) > 0)

        PrintMessage(3,"Разрешение на взаимодействие Q меню : " .. tostring(GetGlobalBool("AccessSpawn")))
    end}

    local function CanUseSpawnMenu(ply,class,ent)
        if class == "swep" and timer.Exists( "cooldown"..ply:EntIndex() ) then
                ply:ChatPrint("Подожди немного")
                return false
        elseif class == "swep" then
            timer.Create("cooldown"..ply:EntIndex(),2.5,1,function() end)
            return true 
		end
        if class == "sent" then
			if BlackList[ent] then return false end
		end
    end

    hook.Add("PlayerSpawnVehicle","Cantspawnbullshit",function(ply) end)
    hook.Add("PlayerSpawnRagdoll","Cantspawnbullshit",function(ply) return CanUseSpawnMenu(ply,"ragdoll") end)
    hook.Add("PlayerSpawnEffect","Cantspawnbullshit",function(ply) return CanUseSpawnMenu(ply,"effect") end)
    hook.Add("PlayerSpawnProp","Cantspawnbullshit",function(ply) return CanUseSpawnMenu(ply,"prop") end)
    hook.Add("PlayerSpawnSENT","Cantspawnbullshit",function(ply,calss) return CanUseSpawnMenu(ply,"sent",calss) end)
    hook.Add("PlayerSpawnNPC","Cantspawnbullshit",function(ply) return ply:IsSuperAdmin() end)

    hook.Add("PlayerSpawnSWEP","SpawnBlockSWEP",function(ply) return CanUseSpawnMenu(ply,"swep") end)
    hook.Add("PlayerGiveSWEP","SpawnBlockSWEP",function(ply) return CanUseSpawnMenu(ply,"swep") end)

    local function spawn(ply,class,ent)
        return true
    end

    hook.Add("PlayerSpawnedVehicle","sv_round",function(ply,model,ent) end)
    hook.Add("PlayerSpawnedRagdoll","sv_round",function(ply,model,ent) spawn(ply,"ragdoll",ent) end)
    hook.Add("PlayerSpawnedEffect","sv_round",function(ply,model,ent) spawn(ply,"effect",ent) end)
    hook.Add("PlayerSpawnedProp","sv_round",function(ply,model,ent) spawn(ply,"prop",ent) end)
    hook.Add("PlayerSpawnedSENT","sv_round",function(ply,model,ent) spawn(ply,"sent",ent) end)
    hook.Add("PlayerSpawnedNPC","sv_round",function(ply,model,ent) return ply:IsSuperAdmin() end)

    --hook.Add("PlayerSpawnObject","dontspawn!!!",cant)--salat eblan
else
    local admin_menu = CreateClientConVar("hg_admin_menu","1",true,false,"enable admin menu",0,1)
    local function CanUseSpawnMenu(ply,class)
        return true
     end

    hook.Add("ContextMenuOpen", "hide_spawnmenu",CanUseSpawnMenu)
    hook.Add("SpawnMenuOpen", "hide_spawnmenu",CanUseSpawnMenu)
end
