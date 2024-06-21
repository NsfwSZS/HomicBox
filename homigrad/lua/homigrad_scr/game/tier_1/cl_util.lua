local function ToggleMenu(toggle)
    if toggle then
        local w,h = ScrW(), ScrH()
        if IsValid(wepMenu) then wepMenu:Remove() end
        local lply = LocalPlayer()
        local wep = lply:GetActiveWeapon() 
        if IsValid(wep) then
        wepMenu = vgui.Create("DMenu")
        wepMenu:SetPos(w/3,h/2)
        wepMenu:MakePopup()
        wepMenu:SetKeyboardInputEnabled(false)
		if wep:GetClass() ~= "weapon_hands" then
			local option = wepMenu:AddOption("Выкинуть",function()
				LocalPlayer():ConCommand("say *drop")
			end)
			option:SetIcon("icon16/gun.png")
		end
        if wep:Clip1() > 0 then
            local option = wepMenu:AddOption("Разрядить",function()
                net.Start("Unload")
                net.WriteEntity(wep)
                net.SendToServer()
            end)
			option:SetIcon("icon16/arrow_redo.png")
		end
		if wep:Clip1() > -1 then
            local option = wepMenu:AddOption("Проверить кол-во патрон",function()
                ply:ChatPrint("В магазине: "..wep:Clip1().."/"..wep:GetMaxClip1().." - "..game.GetAmmoData(wep:GetPrimaryAmmoType()).name)
				ply:EmitSound("snd_jack_hmcd_ammobox.wav")
            end)
			option:SetIcon("icon16/magnifier.png")
		end
        end

		plyMenu = vgui.Create("DMenu")
        plyMenu:SetPos(w/1.8,h/2)
        plyMenu:MakePopup()
        plyMenu:SetKeyboardInputEnabled(false)

        local submenu, parentmenu = plyMenu:AddSubMenu("Броня")
        parentmenu:SetIcon("icon16/user_green.png")
			local option = submenu:AddOption("Меню Брони",function()
	            LocalPlayer():ConCommand("jmod_ez_inv")
	        end)
	        option:SetIcon("icon16/table_gear.png")
	        local option = submenu:AddOption("Доп Меню Брони",function()
	            LocalPlayer():ConCommand("jmod_eft_inv")
	        end)
	        option:SetIcon("icon16/page_white_gear.png")
	        
		local option = plyMenu:AddOption("Меню Патрон",function()
			LocalPlayer():ConCommand("hg_ammomenu")
		end)
		option:SetIcon("icon16/box.png")
		local option = plyMenu:AddOption("Вызвать рвоту",function()
			LocalPlayer():ConCommand("hg_blevota")
		end)
		option:SetIcon("icon16/bug.png")
		local option = plyMenu:AddOption("Встать/Упасть",function()
			LocalPlayer():ConCommand("fake")
		end)
		option:SetIcon("icon16/bullet_arrow_up.png")
		local EZarmor = LocalPlayer().EZarmor
		if JMod.GetItemInSlot(EZarmor, "eyes") then
			local option = plyMenu:AddOption("Активировать Маску/Забрало",function()
				LocalPlayer():ConCommand("jmod_ez_toggleeyes")
			end)
			option:SetIcon("icon16/arrow_up.png")
		end
    else
		if IsValid(wepMenu) then
        	wepMenu:Remove()
		end
		if IsValid(plyMenu) then
        	plyMenu:Remove()
		end
    end
end

local active,oldValue
hook.Add("Think","Thinkhuyhuy",function()
	active = input.IsKeyDown(KEY_C)
	if oldValue ~= active then
		oldValue = active
		
		if active then
			ToggleMenu(true)
		else
			ToggleMenu(false)
		end
	end
end)


hook.Add("OnEntityCreated", "homigrad-colorragdolls", function(ent)
	if ent:IsRagdoll() then
		timer.Create("ragdollcolors-timer" .. tostring(ent), 0.1, 0, function()
			--ent.ply = ent.ply or RagdollOwner(ent)
			--local ply = ent.ply
			--if IsValid(ply) then
			if IsValid(ent) then
				ent.playerColor = ent:GetNWVector("plycolor")
				--print(ent.ply,ent.playerColor)
				ent.GetPlayerColor = function()
					return ent.playerColor
				end
				timer.Remove("ragdollcolors-timer" .. tostring(ent))
			end
		end)
	end
end)
--[[
surface.CreateFont( "Pornograpy", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 55,
	weight = 1500,
	blursize = 1,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

hook.Add( "HUDPaint", "Pornograpy", function()
	draw.DrawText( "Pornograpy", "Pornograpy", ScrW() * 0.5, ScrH() * 0.35, color_white, TEXT_ALIGN_CENTER )
end )

local g_station = nil
sound.PlayURL ( "https://cdn.discordapp.com/attachments/1154042672554725426/1159907648993497179/pornography.mp3?ex=6532bb2d&is=6520462d&hm=c494b690757c362f7d4a9dac6117f1502382d27972c44b54b485d70ef0696c91&", "mono", function( station )
	if ( IsValid( station ) ) then

		station:SetPos( LocalPlayer():GetPos() )
	
		station:Play()

		-- Keep a reference to the audio object, so it doesn't get garbage collected which will stop the sound
		g_station = station
	
	else

		LocalPlayer():ChatPrint( "Invalid URL!" )

	end
end )

timer.Simple(5,function()
	hook.Remove("HUDPaint", "Pornograpy") 
end)]]--

surface.CreateFont("Respawn_Text", {
    font = "Trebuchet24",
    size = 32,
    weight = 500,
    antialias = true
})


net.Receive("removeDhud", HideHUD)

net.Receive("RespawnTimer", function()
    timeLeft = net.ReadFloat()
    hook.Add("PostDrawHUD", "PostDrawHUD_DrawABox", function()
		local timer = timeLeft-CurTime()
        draw.SimpleText("ЖДИТЕ", "BodyCamFont", ScrW() * 0.5, ScrH() * 0.7, Color(210,210,210), TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        draw.SimpleText(string.ToMinutesSecondsMilliseconds(timer), "BodyCamFont", ScrW() * 0.5, ScrH() * 0.745, Color(210,210,210), TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        if timer <= 0 then
            hook.Remove("PostDrawHUD", "PostDrawHUD_DrawABox")
    	end
    end )  
end)

hook.Add( "OnPlayerChat", "HelloCommand", function( ply, strText, bTeam, bDead ) 
    --if ( ply != LocalPlayer() ) then return end


	if ( string.StartsWith(strText, "// ") ) then -- if the player typed /hello then
		chat.AddText(Color( 195, 195, 225), "[Общий] ", Color( 255, 255, 125),ply:Nick(),Color( 255, 255, 255),": "..string.sub(strText,4))
		return true -- this suppresses the message from being shown
	end
	chat.AddText(Color( 235, 195, 195), "[Рядом] ", Color( 255, 255, 125),ply:Nick(),Color( 255, 255, 255),": "..strText)
	return true -- this suppresses the message from being shown
end )

function Circle( x, y, radius, seg )
    local cir = {}

    table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
    for i = 0, seg do
        local a = math.rad( ( i / seg ) * -360 )
        table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
    end

    local a = math.rad( 0 ) -- This is needed for non absolute segment counts
    table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

    surface.DrawPoly( cir )
end