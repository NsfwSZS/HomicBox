AddCSLuaFile()
local viewmodeldraw = {
	["weapon_physgun"] = true,
	["gmod_tool"] = true,
	["gmod_camera"] = true,
	["sf_tool"] = true,
    ["weapon_drr_remote"] = true
}
local finalpos, finalang, dot
local gunPos, gunAng = Vector(0,0,0), Angle(0,0,0)
local InSights = 0
local gunInfo, gunSight
LerpEyeRagdoll = Angle(0,0,0)

local sightOR = true
sib_wep = sib_wep or {}

CreateClientConVar("hg_fakecam_mode","0",true,false,nil,0,1)
-- LOCAL SHIT!!!!

local function InSight(ply)
	if !ply:IsSprinting() and !timer.Exists("reload"..ply:GetActiveWeapon():EntIndex()) and ply:GetActiveWeapon():GetNWBool("Sighted") then
		return true
	end
	return false
end


hook.Add('StartCommand', 'wep-scope.Wheel', function(ply, cmd)
    if (cmd:GetMouseWheel() != 0 and InSight(ply)) then 
        if (cmd:GetMouseWheel() < 1) then
            sightOR = true 
        elseif (cmd:GetMouseWheel() > -1) then 
            sightOR = false 
        end
    end
end )

local vecZero = Vector(0,0,0)
local tryaska = vecZero
local shootfov = 0
lastShootSib = 0
local function ImersiveCam(ply,pos,ang,fov)

	local lply = LocalPlayer()

	if !ply:Alive() and timer.Exists("DeathCam") and IsValid(deathrag) then
		--deathrag:ManipulateBoneScale(6,vecZero)
		
		local att = deathrag:GetAttachment(deathrag:LookupAttachment("eyes"))
		
		LerpEyeRagdoll = LerpAngleFT(0.08,LerpEyeRagdoll,att.Ang)

		LerpEyeRagdoll[3] = LerpEyeRagdoll[3]

		local view = {
			origin = att.Pos,
			angles = LerpEyeRagdoll,
			fov = fov,
			drawviewer = true
		}

		return view
	end

	local ragdoll = ply:GetNWEntity("Ragdoll")
	
	if ply:Alive() and ply:GetNWBool("fake") and IsValid(ragdoll) then
		ragdoll:ManipulateBoneScale(6,vecZero)
		
		local att = ragdoll:GetAttachment(ragdoll:LookupAttachment("eyes"))
		
		local eyeAngs = lply:EyeAngles()	
		local anghook = GetConVar("hg_fakecam_mode"):GetFloat()
		LerpEyeRagdoll = LerpAngleFT(0.08,LerpEyeRagdoll,LerpAngle(0.45,eyeAngs,att.Ang)+SIB_suppress.Ang)

		LerpEyeRagdoll[3] = LerpEyeRagdoll[3]

		local view = {
			origin = att.Pos,
			angles = LerpEyeRagdoll,
			fov = fov,
			drawviewer = true
		}

		return view
	end
    
    if ply:InVehicle() then
        local v=ply:GetVehicle()
		if IsValid(v) and IsValid(v:GetNWEntity("wac_aircraft")) then
            local _view = {
			origin = pos,
			angles = ang,
			fov = fov,
			drawviewer = false
			}
			return _view
        end

		local head = ply:GetAttachment(1)
		local eyePos = head.Pos+head.Ang:Forward()*-1+head.Ang:Up()*-1
		
		finalpos = eyePos
		headAng = LerpAngle( 1, ply:EyeAngles(), head.Ang )
		finalang = LerpAngle(2*FrameTime(), finalang or ply:EyeAngles(),headAng+SIB_suppress.Ang)

		local _view = {
			origin = finalpos,
			angles = finalang,
			fov = fov,
			drawviewer = true
		}

		return _view
	end

	if !ply:Alive() then return end
	if ply:GetActiveWeapon():IsValid() and viewmodeldraw[ply:GetActiveWeapon():GetClass()] then
		local _view = {
			origin = pos,
			angles = ang,
			fov = fov,
			drawviewer = false
		}
	return _view
	end


	local head = ply:LookupBone( "ValveBiped.Bip01_Head1" )
	-- Scale head
	
	ply:ManipulateBoneScale(head,Vector(0.1,0.1,0.1))

	-- This is imersive viewing lol
	local head = ply:GetAttachment(1) -- Head Bone Pos
	local hand = ply:GetAttachment(ply:LookupAttachment("anim_attachment_rh"))
	local vel = ply:GetVelocity()
	local eyePos = head.Pos+head.Ang:Forward()*1+head.Ang:Up()*2-(head.Ang:Forward()*viewShootPunch.x)

	finalpos = Lerp( InSights, eyePos+tryaska, gunPos+tryaska)
	headAng = LerpAngle( 0.1, ply:EyeAngles(), head.Ang )
	finalang = LerpAngle(5*FrameTime(), finalang or ply:EyeAngles(),LerpAngle( InSights/2, headAng, gunAng )-viewShootPunch*2+SIB_suppress.Ang)
	sway = LerpAngle(2.5*FrameTime(),sway or ply:EyeAngles(),LerpAngle( InSights/2, headAng, gunAng ) - finalang)

	-- This is SIB wep?

	if sib_wep[ply:GetActiveWeapon()] then
		gunInfo = weapons.Get(ply:GetActiveWeapon():GetClass())
		gunPos = hand.Pos + hand.Ang:Forward()*gunInfo.SightPos.x + hand.Ang:Right()*gunInfo.SightPos.y + hand.Ang:Up()*gunInfo.SightPos.z  + hand.Ang:Up()*-viewShootPunch.x/5 + hand.Ang:Right()*-viewShootPunch.y/5 - hand.Ang:Right()*sway.y/(15/gunInfo.Mobility) - hand.Ang:Up()*sway.x/(25/gunInfo.Mobility)+hand.Ang:Forward()*-viewShootPunch.x/2
		gunAng = hand.Ang + gunInfo.SightAng+viewShootPunch/10 - sway/5
		if InSight(ply) and !sightOR then
			gunSight = 1
		else
			gunSight = 0
		end
	else
		gunPos = hand.Pos
		gunAng = hand.Ang
		gunSight = 0
	end
	InSights = Lerp(2*FrameTime(),InSights,gunSight)
	
	if lastShootSib > CurTime() then
		tryaska = Vector(math.Rand(-0.02,0.02),math.Rand(-0.02,0.02),math.Rand(-0.02,0.02))
		shootfov = Lerp(1*FrameTime(),shootfov,2.5)
	else
		tryaska = LerpVector(0.5*FrameTime(),tryaska or vecZero,vecZero)
		shootfov = Lerp(0.5*FrameTime(),shootfov,0)
	end

	-- View Table
	local _view = {
		origin = finalpos,
		angles = finalang,
		fov = (fov-15*InSights)-shootfov,
		drawviewer = true
	}
	return _view
end

local adddis = 0

local fogMode = render.FogMode
local fogStart = render.FogStart
local fogEnd = render.FogEnd
local fogMaxDensity = render.FogMaxDensity
local fogColor = render.FogColor
local r,g,b = 255 * 0.6,255 * 0.7,255 * 0.8

local dataFogMap = {
    [1] = Vector(95,95,110),
    ["rp_asheville"] = 3000,
    ["rp_desert_conflict"] = 4000
}

hook.Add("SetupWorldFog","shlib",function()
    local distance = GetGlobalVar("Fog Dis")

	local upper = dataFogMap[game.GetMap()] or 9000

	local content = util.PointContents(EyePos())
	if
		((bit.band(content,CONTENTS_SOLID) == CONTENTS_SOLID) and
		(LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP and not LocalPlayer():InVehicle())) or (not distance and upper <= 0)
	then
		CAMERA_ZFAR = nil

		return
	end

	--adddis = math_sin(CurTime() / 100) * diffDis
	local custom = upper > 0
	if distance and upper > distance then custom = false end

	CAMERA_ZFAR = custom and (dataFogMap[game.GetMap()] or 9000) or distance

	fogMode(MATERIAL_FOG_LINEAR)
	fogStart(CAMERA_ZFAR / 16)
	fogEnd(CAMERA_ZFAR )
	fogMaxDensity(1)

    local color = custom and dataFogMap[1] or GetGlobalVar("Fog Color",fogdefault)
	fogColor(color[1],color[2],color[3],255)

	return true
end)

local ang = Angle(0,0,0)

local mat = Material("color")

local surface_SetMaterial = surface.SetMaterial
local surface_SetDrawColor = surface.SetDrawColor
local render_SetColorMaterial = render.SetColorMaterial
local render_DrawQuadEasy = render.DrawQuadEasy

hook.Add("PostDrawOpaqueRenderables","shlib",function()
	if not CAMERA_ZFAR then return end

	local vec = Vector(CAMERA_ZFAR,0,0)
	local lply = LocalPlayer()

	vec:Rotate(EyeAngles())

	lply = EyePos()

	vec = lply + vec

	local normal = Vector(1,0,0)
	normal:Rotate((lply - vec):Angle())

    local color = GetGlobalVar("Fog Color",fogdefault)
	surface_SetDrawColor(155,155,155,255)
	surface_SetMaterial(mat)
	render_SetColorMaterial()

	render_DrawQuadEasy(vec,normal,100000,100000,color_white)
end)

hook.Add("RenderScene","fwep-viewbobfix",function(pos,angle,fov)

	local view = hook.Run("CalcView", LocalPlayer(), pos, angle, fov)

	local view = {
		x = 0,
		y = 0,
		drawhud = true,
		drawviewmodel = false,
		dopostprocess = true,
		drawmonitors = true
	}

	local calcView = ImersiveCam(LocalPlayer(),pos,angle,fov)
	if not calcView then return end

	view.fov = calcView.fov
	view.origin = calcView.origin
	view.angles = calcView.angles
	view.drawviewmodel = not calcView.drawviewer
	if CAMERA_ZFAR then
           view.zfar = CAMERA_ZFAR + 25
	else
        view.zfar = nil   
    end
	render.Clear(0,0,0,255,true,true,true)
	render.RenderView(view)
	
	return true
end)

hook.Add( "CalcView", "fwep-camera", ImersiveCam )

hook.Add( "HUDPaint", "CrosshairPhysgun", function()
	local lply = LocalPlayer() 
	if lply:Alive() and IsValid(lply:GetActiveWeapon()) and viewmodeldraw[ lply:GetActiveWeapon():GetClass() ] and lply:GetActiveWeapon():GetClass()!="weapon_drr_remote" then
		local hairpos = lply:GetEyeTrace().HitPos:ToScreen() 
		local wepcolor = lply:GetWeaponColor()*255
		surface.SetDrawColor(wepcolor.x,wepcolor.y,wepcolor.z)
		surface.DrawLine( hairpos.x, hairpos.y-10, hairpos.x, hairpos.y-2 )
		surface.DrawLine( hairpos.x, hairpos.y+10, hairpos.x, hairpos.y+2 )
		surface.DrawLine( hairpos.x+10, hairpos.y, hairpos.x+2, hairpos.y )
		surface.DrawLine( hairpos.x-10, hairpos.y, hairpos.x-2, hairpos.y )
	end
end )


print('Simple Smart-Render by Retro')

-- Configuration
local BlackList = {
	'prop_',
	'bw_',
	'item_', 
	'gmod_', 
	'ent', 
	'weapon_',
	'sent_', 
	'base_', 
	'npc', 
	'func_'
}
local minDistance = 7500 ^ 2 -- Возведение в степень нужно для корректной дистанции
local maxDistance = 8000 ^ 2

-- Runtime variables
SmartRenderEntities = SmartRenderEntities or {}
local directionAngle
local me
local playerPosition
local aimVector
local shootPosition

local SysTime = SysTime
local timerSimple = timer.Simple
local tableInsert = table.insert
local tableRemove = table.remove
local StartWith = string.StartWith

-- Общее включение и выключение рендера
CreateClientConVar('SmartRender', '1')
--local SmartRenderConVar = GetConVar('SmartRender')
local SmartRenderEnabled = cvars.Bool('SmartRender')
-- Рендер по дальности
CreateClientConVar('SmartRender_DistanceRender', '1')
local DistanceRenderEnabled = cvars.Bool('SmartRender_DistanceRender')
-- Рендер только того что видет игрок
CreateClientConVar('SmartRender_ViewRender', '1')
local ViewRenderEnabled = cvars.Bool('SmartRender_ViewRender')

local function EntityCreated(ent)
	if ( not IsValid(ent) ) then return end

	local className = ent.GetClass and ent:GetClass()
	if ( not className ) then return end

	-- Check entity class
	local shouldIgnore = true
	for _, class in ipairs(BlackList) do
		if (StartWith(className, class) ) then shouldIgnore = false; break end
	end
	if ( shouldIgnore ) then return end

	timer.Simple(0, function() -- fix unexpected problems with entity
		tableInsert(SmartRenderEntities, ent)
	end)
end

local function DisableEntityRender(ent, value)
	ent:SetNoDraw(value)
	--ent:DrawShadow(not value)
end

local function EntityVisible(entPos)
	local entVector = entPos - shootPosition
	local dot = aimVector:Dot(entVector) / entVector:Length()
	return dot < directionAngle
end

local function SmartRender(ent)
	if ( (not DistanceRenderEnabled and not ViewRenderEnabled ) or ent:IsVehicle() ) then return end

	-- Check entity distance
	local entPos = ent:GetPos()
	local Distance = playerPosition:DistToSqr(entPos)

	if ( Distance < minDistance ) then
		DisableEntityRender(ent, false)
	return end

	if ( DistanceRenderEnabled and Distance > maxDistance ) then
		DisableEntityRender(ent, true)
	return end

	if ( ViewRenderEnabled ) then
		-- Ingore entity view check
		if ( ent:IsWeapon() or ent:IsVehicle() ) then
			--DisableEntityRender(ent, false)
		return end
	
		-- Check entity view
		--DisableEntityRender(ent, EntityVisible(entPos))
	end
end

local function Think()
	-- Check smart render enabled
	if ( not SmartRenderEnabled ) then return end

	-- Getting player entity
	if ( not me or not IsValid(me) ) then
		me = LocalPlayer() 
	return end

	-- Calculating direction angle using player fov
	if ( not directionAngle ) then
		local fov = me:GetFOV()
		directionAngle = math.pi / (360 / (( fov-50 )/ 2 ))
	end

	-- Check player in vehicle
	if ( me:InVehicle() ) then return end

	DistanceRenderEnabled = cvars.Bool('SmartRender_DistanceRender')
	ViewRenderEnabled = cvars.Bool('SmartRender_ViewRender')

	-- Get player data
	playerPosition = me:GetPos()
	aimVector = me:GetAimVector()
	shootPosition = me:GetShootPos()

	for k, ent in ipairs(SmartRenderEntities) do
		if ( IsValid(ent) ) then
			-- Entity is valid
			SmartRender(ent)
		else
			-- Entity isn't valid
			tableRemove(SmartRenderEntities, k) 
		end
	end
end

hook.Add('OnEntityCreated', 'SmartRender.EntityCreated', EntityCreated)
timer.Create('SmartRender.Think', 0.1, 0, Think)

local function ShowEveryEntity()
	for k, ent in ipairs(SmartRenderEntities) do
		if ( not IsValid(ent) ) then return end
		DisableEntityRender(ent, false)
	end
end

cvars.AddChangeCallback('SmartRender', function(name, old, new)
	SmartRenderEnabled = tobool(new)
	
	-- Rendering entities after disabling smart render
	if ( not SmartRenderEnabled ) then
		ShowEveryEntity()
	end
end, 'test')
