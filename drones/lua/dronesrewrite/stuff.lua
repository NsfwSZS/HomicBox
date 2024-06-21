game.AddDecal("DrrBigExpo", "stuff/decals/drrbigexp")

if SERVER then 	
	resource.AddFile("resource/fonts/gnuolanedr.ttf")
	resource.AddFile("resource/fonts/exodr.ttf")

	hook.Add("EntityTakeDamage", "dronesrewrite_dropplayer", function(ply, damage)
		if not DRONES_REWRITE.ServerCVars.DontKickPly:GetBool() and ply:IsPlayer() and damage:GetDamage() > 0 then
			local drone = ply:GetNWEntity("DronesRewriteDrone")

			if drone:IsValid() then
				drone:SetDriver(NULL)
			end
		end
	end)

	hook.Add("SetupPlayerVisibility", "dronesrewrite_droneview", function(ply)
		local drone = ply:GetNWEntity("DronesRewriteDrone")
		if drone:IsValid() then AddOriginToPVS(drone:GetPos()) end
	end)

	hook.Add("PlayerInitialSpawn", "dronesrewrite_precache", function(ply)
		net.Start("dronesrewrite_doprecache")
		net.Send(ply)
	end)
else
	surface.CreateFont("DronesRewrite_font1", { font = "Tahoma", size = 40, weight = 2000 })
	surface.CreateFont("DronesRewrite_font2", { font = "Tahoma", size = 12, weight = 2000 })
	surface.CreateFont("DronesRewrite_font3", { font = "Tahoma", size = 25, weight = 2000 })
	surface.CreateFont("DronesRewrite_font4", { font = "Tahoma", size = 18, weight = 1 })
	surface.CreateFont("DronesRewrite_font5", { font = "Lucida Console", size = 16, weight = 1 })
	surface.CreateFont("DronesRewrite_font6", { font = "Impact", size = 18, weight = 1 })

	surface.CreateFont("DronesRewrite_customfont1", { font = "Exo", size = 16, weight = 1 })
	surface.CreateFont("DronesRewrite_customfont1_1", { font = "Exo", size = 25, weight = 1 })

	surface.CreateFont("DronesRewrite_customfont2", { font = "Gnuolane RG", size = 25, weight = 1 })
	surface.CreateFont("DronesRewrite_customfont2_1", { font = "Gnuolane RG", size = 28, weight = 1 })

	surface.CreateFont("DronesRewrite_customfont1big", { font = "Exo", size = 100, weight = 1 })
	surface.CreateFont("DronesRewrite_customfont1big2", { font = "Exo", size = 60, weight = 1 })

	surface.CreateFont("DronesRewrite_font3_out", { font = "Tahoma", size = 30, weight = 1 })

	hook.Add("PlayerBindPress", "dronesrewrite_stopmenu", function(ply, bind, p)
		local drone = ply:GetNWEntity("DronesRewriteDrone")

		if drone:IsValid() then		
			local tools = {
				"phys_swap",
				"slot",
				"invnext",
				"invprev",
				"lastinv",
				"gmod_tool",
				"gmod_toolmode"
			}

			if p and (bind == "invnext" or bind == "invprev") then 
				if drone._SelectingWep == -1 then
					if bind == "invnext" then
						drone.selected = drone.selected + 1
					elseif bind == "invprev" then
						drone.selected = drone.selected - 1
					end
				else
					if bind == "invnext" then
						drone.selected = drone:GetNWInt("CurrentWeapon_sel") + 1
					elseif bind == "invprev" then
						drone.selected = drone:GetNWInt("CurrentWeapon_sel") - 1
					end

					net.Start("dronesrewrite_requestweapons")
						net.WriteEntity(drone)
						net.WriteString("dronesrewrite_openselectmenu")
						net.WriteBit(false)
					net.SendToServer()
				end
			end

			for k, v in pairs(tools) do if bind:find(v) then return true end end
		end
	end)
end

local nocollide = {
	"dronesrewrite_bl_laser",
	"dronesrewrite_rd_laser",
	"dronesrewrite_rd_laser_sm",
	"dronesrewrite_gr_laser_sm",
	"dronesrewrite_missile",
	"dronesrewrite_rocket",
	"dronesrewrite_rocketbig"
}

hook.Add("ShouldCollide", "dronesrewrite_physhandler", function(ent1, ent2)
	for k, v in pairs(nocollide) do
		if ent1:GetClass() == v and ent2:GetClass() == v then return false end
	end
end)

hook.Add("StartCommand", "dronesrewrite_locker", function(ply, cmd)
	local drone = ply:GetNWEntity("DronesRewriteDrone")

	if drone:IsValid() then
		cmd:ClearButtons()
		cmd:ClearMovement()
	end
end)
