﻿local MskSndLops, MaskMats = {}, {}

hook.Add("HUDPaintBackground", "JMOD_HUDBG", function()
	local ply, Play = LocalPlayer(), false

	if ply.EZarmor then
		local Alive, ThirdPerson = ply:Alive(), false

		if ply.EZarmor.mskmat and Alive and not ThirdPerson then
			local Mat = MaskMats[ply.EZarmor.mskmat]

			if not Mat then
				Mat = Material(ply.EZarmor.mskmat)
				MaskMats[ply.EZarmor.mskmat] = Mat
			end

			local Col = render.GetLightColor(EyePos())
			surface.SetMaterial(Mat)
			surface.SetDrawColor(Col.r * 255, Col.g * 255, Col.b * 255, 255)
			surface.DrawTexturedRect(-1, -1, ScrW() + 2, ScrH() + 2)
			surface.DrawTexturedRect(-1, -1, ScrW() + 2, ScrH() + 2)
			surface.DrawTexturedRect(-1, -1, ScrW() + 2, ScrH() + 2)
		end

		Play = Alive and ply.EZarmor.sndlop and not ThirdPerson

		if Play then
			if not MskSndLops[ply.EZarmor.sndlop] then
				MskSndLops[ply.EZarmor.sndlop] = CreateSound(ply, ply.EZarmor.sndlop)
				MskSndLops[ply.EZarmor.sndlop]:Play()
			elseif not MskSndLops[ply.EZarmor.sndlop]:IsPlaying() then
				MskSndLops[ply.EZarmor.sndlop]:Play()
			end
		end
	end

	if not Play then
		for k, v in pairs(MskSndLops) do
			v:Stop()
			MskSndLops[k] = nil
		end
	end
end)

local function DrawNoise(amt, alpha)
	local W, H = ScrW(), ScrH()

	for i = 0, amt do
		local Bright = math.random(0, 255)
		surface.SetDrawColor(Bright, Bright, Bright, alpha)
		local X, Y = math.random(0, W), math.random(0, H)
		surface.DrawRect(X, Y, 1, 1)
	end
end

local blurMat2, Dynamic2 = Material("pp/blurscreen"), 0

local function BlurScreen()
	local layers, density, alpha = 1, .2, 255
	surface.SetDrawColor(255, 255, 255, alpha)
	surface.SetMaterial(blurMat2)
	local FrameRate, Num, Dark = 1 / FrameTime(), 3, 150

	for i = 1, Num do
		blurMat2:SetFloat("$blur", (i / layers) * density * Dynamic2)
		blurMat2:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
	end

	Dynamic2 = math.Clamp(Dynamic2 + (1 / FrameRate) * 7, 0, 1)
end

local GoggleDarkness, GogglesWereOn, CurVisionBlur, CurEyeClose = 0, false, 0, 0
local ThermalGlowMat = Material("models/debug/debugwhite")
local blurMaterial = Material('pp/bokehblur')

local RavebreakColors = {Color(255, 0, 0), Color(0, 255, 0), Color(0, 0, 255), Color(0, 255, 255), Color(255, 0, 255), Color(255, 255, 0)}

local NextRavebreakBeat, CurRavebreakColor, CurRavebreakLightPos = 0, math.random(1, 6), Vector(0, 0, 0)

hook.Add("RenderScreenspaceEffects", "JMOD_SCREENSPACE", function()
	local ply, FT, SelfPos, Time, W, H = LocalPlayer(), FrameTime(), EyePos(), CurTime(), ScrW(), ScrH()
	local AimVec, FirstPerson, Ravebreakin = ply:GetAimVector(), true, ply.JMod_RavebreakEndTime and ply.JMod_RavebreakEndTime > Time and ply.JMod_RavebreakStartTime < Time

	--CreateClientLag(10000) -- for debugging the effect at low framerates
	--JMod.MeasureFramerate()
	if Ravebreakin then
		if NextRavebreakBeat < Time then
			NextRavebreakBeat = Time + JMod.RavebreakBeatTime
			CurRavebreakColor = CurRavebreakColor + 1

			if CurRavebreakColor > 6 then
				CurRavebreakColor = 1
			end

			local Offset = VectorRand() * math.random(100, 1000)
			Offset.z = Offset.z / 2
			CurRaveBreakLightPos = EyePos() + Offset
		end

		local Col = RavebreakColors[CurRavebreakColor]

		DrawColorModify({
			["$pp_colour_addr"] = Col.r / 1000,
			["$pp_colour_addg"] = Col.g / 1000,
			["$pp_colour_addb"] = Col.b / 1000,
			["$pp_colour_brightness"] = 0,
			["$pp_colour_contrast"] = 1,
			["$pp_colour_colour"] = 1,
			["$pp_colour_mulr"] = Col.r / 2000,
			["$pp_colour_mulg"] = Col.g / 2000,
			["$pp_colour_mulb"] = Col.b / 2000
		})

		local CurAng = ply:EyeAngles()
		local PartyinEyeAngles = Angle(0, CurAng.y, 0)
		PartyinEyeAngles.y = PartyinEyeAngles.y - FrameTime() * 30
		PartyinEyeAngles.p = math.sin(Time * 8 / JMod.RavebreakBeatTime) * 10
		ply:SetEyeAngles(PartyinEyeAngles)
		local DLight, BrightnessMul = DynamicLight(ply:EntIndex()), (FirstPerson and 10) or 5

		if DLight then
			DLight.pos = CurRaveBreakLightPos
			DLight.r = Col.r
			DLight.g = Col.g
			DLight.b = Col.b
			DLight.brightness = (math.sin(Time * 8 / JMod.RavebreakBeatTime) / 2 + .5) * BrightnessMul
			DLight.Size = 1000
			DLight.Decay = 4000
			DLight.DieTime = Time + 1
		end
	end

	if FirstPerson then
		if ply:Alive() and ply.EZarmor and ply.EZarmor.effects then
			if ply.EZarmor.blackvision then
				surface.SetDrawColor(0, 0, 0, 255)
				surface.DrawRect(-1, -1, W + 2, H + 2)
				draw.SimpleText("vision device is dead; please recharge", "JMod-Display", W / 2, H * .8, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				--GoggleDarkness=100
			elseif ply.EZarmor.effects.nightVision then
				if not GogglesWereOn then
					GogglesWereOn = true
					GoggleDarkness = 100
				end

				DrawColorModify({
					["$pp_colour_addr"] = 0,
					["$pp_colour_addg"] = 0,
					["$pp_colour_addb"] = 0,
					["$pp_colour_brightness"] = .01,
					["$pp_colour_contrast"] = 7,
					["$pp_colour_colour"] = 0,
					["$pp_colour_mulr"] = 0,
					["$pp_colour_mulg"] = 0,
					["$pp_colour_mulb"] = 0
				})

				DrawColorModify({
					["$pp_colour_addr"] = 0,
					["$pp_colour_addg"] = .1,
					["$pp_colour_addb"] = 0,
					["$pp_colour_brightness"] = 0,
					["$pp_colour_contrast"] = 1,
					["$pp_colour_colour"] = 1,
					["$pp_colour_mulr"] = 0,
					["$pp_colour_mulg"] = 0,
					["$pp_colour_mulb"] = 0
				})

				if not ply.EZflashbanged then
					--BlurScreen()
					DrawMotionBlur(FT * 50, .8, .01)
					DrawNoise(4024,55)
				end
			elseif ply.EZarmor.effects.nightVisionWP then
				if not GogglesWereOn then
					GogglesWereOn = true
					GoggleDarkness = 100
				end

				DrawColorModify({
					["$pp_colour_addr"] = 0,
					["$pp_colour_addg"] = 0,
					["$pp_colour_addb"] = 0,
					["$pp_colour_brightness"] = .01,
					["$pp_colour_contrast"] = 7,
					["$pp_colour_colour"] = 0,
					["$pp_colour_mulr"] = 0,
					["$pp_colour_mulg"] = 0,
					["$pp_colour_mulb"] = 0
				})

				DrawColorModify({
					["$pp_colour_addr"] = 0,
					["$pp_colour_addg"] = .2,
					["$pp_colour_addb"] = .3,
					["$pp_colour_brightness"] = -.1,
					["$pp_colour_contrast"] = .8,
					["$pp_colour_colour"] = 1,
					["$pp_colour_mulr"] = 0,
					["$pp_colour_mulg"] = 0,
					["$pp_colour_mulb"] = 0
				})

				if not ply.EZflashbanged then
					DrawMotionBlur(FT * 50, .8, .01)
					DrawNoise(1024,55)
				end
			elseif ply.EZarmor.effects.thermalVision then
				if not GogglesWereOn then
					GogglesWereOn = true
					GoggleDarkness = 100
				end

				DrawColorModify({
					["$pp_colour_addr"] = 0,
					["$pp_colour_addg"] = 0,
					["$pp_colour_addb"] = 0,
					["$pp_colour_brightness"] = 0,
					["$pp_colour_contrast"] = 1.5,
					["$pp_colour_colour"] = 0,
					["$pp_colour_mulr"] = 0,
					["$pp_colour_mulg"] = 0,
					["$pp_colour_mulb"] = 0
				})

				if not ply.EZflashbanged then
					BlurScreen()
					DrawNoise(1024,55)
				end
			else
				if GogglesWereOn then
					GogglesWereOn = false
					GoggleDarkness = 100
				end
			end
		else
			if GogglesWereOn then
				GogglesWereOn = false
				GoggleDarkness = 100
			end
		end

		if GoggleDarkness > 0 then
			local Alpha = 255 * (GoggleDarkness / 100) ^ .5
			surface.SetDrawColor(0, 0, 0, Alpha)
			surface.DrawRect(-1, -1, W + 2, H + 2)
			surface.DrawRect(-1, -1, W + 2, H + 2)
			surface.DrawRect(-1, -1, W + 2, H + 2)
			GoggleDarkness = math.Clamp(GoggleDarkness - FT * 100, 0, 100)
		end

		if ply.EZflashbanged then
			if ply:Alive() then
				DrawMotionBlur(.001, math.Clamp(ply.EZflashbanged / 20, 0, 1), .01)
				ply.EZflashbanged = ply.EZflashbanged - 7 * FT
			else
				ply.EZflashbanged = 0
			end

			if ply.EZflashbanged <= 0 then
				ply.EZflashbanged = nil
			end
		end
	end

	if JMod.NukeFlashEndTime > Time then
		local Dist = EyePos():Distance(JMod.NukeFlashPos)

		if Dist < JMod.NukeFlashRange then
			local TimeFrac, DistFrac = (JMod.NukeFlashEndTime - Time) / 10, 1 - Dist / JMod.NukeFlashRange
			local Frac = TimeFrac * DistFrac

			DrawColorModify({
				["$pp_colour_addr"] = Frac * .5 * JMod.NukeFlashIntensity,
				["$pp_colour_addg"] = 0,
				["$pp_colour_addb"] = 0,
				["$pp_colour_brightness"] = Frac * .5 * JMod.NukeFlashIntensity,
				["$pp_colour_contrast"] = 1 + Frac * .5,
				["$pp_colour_colour"] = 1,
				["$pp_colour_mulr"] = 0,
				["$pp_colour_mulg"] = 0,
				["$pp_colour_mulb"] = 0
			})
		end
	end

	if CurVisionBlur > 0 and FirstPerson then
		render.UpdateScreenEffectTexture()
		blurMaterial:SetTexture("$BASETEXTURE", render.GetScreenEffectTexture())
		blurMaterial:SetTexture("$DEPTHTEXTURE", render.GetResolvedFullFrameDepth())
		blurMaterial:SetFloat("$size", (CurVisionBlur * 40) ^ .5)
		blurMaterial:SetFloat("$focus", 1)
		blurMaterial:SetFloat("$focusradius", 1)
		render.SetMaterial(blurMaterial)
		render.DrawScreenQuad()
		-- also add an eye-closing effect
		-- todo
	end

	ply.EZvisionBlur = math.Clamp((ply.EZvisionBlur or 0) - FT * 2, 0, 75)
	CurVisionBlur = Lerp(FT * .5, CurVisionBlur, ply.EZvisionBlur)

	if CurVisionBlur < .01 then
		CurVisionBlur = 0
	end

	if not ply:Alive() then
		ply.EZvisionBlur = 0
		CurVisionBlur = 0
	end
end)

local FPSData = {
	frameTimeSum = 0,
	framesCounted = 0,
	latestAverage = 0,
	nextReadingTime = 0,
	historicalAverages = {}
}

hook.Add("PostDrawHUD", "JMod_PostDrawHUD", function()
	if not(GetConVar("jmod_debug_display"):GetBool()) then return end

	local FT, Time = FrameTime(), CurTime()

	-- record data
	FPSData.frameTimeSum = FPSData.frameTimeSum + FT
	FPSData.framesCounted = FPSData.framesCounted + 1
	if (FPSData.framesCounted >= 10) then
		FPSData.latestAverage = math.Round(1 / (FPSData.frameTimeSum / 10))
		FPSData.framesCounted = 0
		FPSData.frameTimeSum = 0
	end
	if (FPSData.nextReadingTime < Time) then
		table.insert(FPSData.historicalAverages, 1, FPSData.latestAverage)
		table.remove(FPSData.historicalAverages, 51)
		FPSData.nextReadingTime = Time + .1
	end

	-- display the current average
	surface.SetDrawColor( 0, 0, 0, 200 )
	surface.DrawRect( 10, 10, 256, 256 )
	draw.SimpleText("avg FPS", "JMod-Debug-S", 138, 50, Color(255, 255, 255, 120), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(FPSData.latestAverage, "JMod-Debug", 138, 160, Color(255, 255, 255, 120), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	-- display the FPS Graph
	surface.SetDrawColor( 0, 0, 0, 200 )
	surface.DrawRect( 276, 10, 276, 256 )
	draw.SimpleText("graph", "JMod-Debug-S", 276+276/2, 50, Color(255, 255, 255, 120), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	surface.SetDrawColor( 50, 50, 50, 100 )
	surface.DrawRect( 286, 95, 236, 161 )
		
	local fpsMax = GetConVar("fps_max"):GetInt()

	local unpacked = unpack(FPSData.historicalAverages)
	local max, min = math.max(unpacked), math.min(unpacked)
	draw.SimpleTextOutlined("min", "DebugFixedSmall", 522+14, 245-15, Color(255, 255, 255, 120), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1,Color(0,0,0,50))
	draw.SimpleTextOutlined(minFPS, "DebugFixedSmall", 522+14, 245, Color(255, 255, 255, 120), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1,Color(0,0,0,50))
	draw.SimpleTextOutlined("max", "DebugFixedSmall", 522+14, 100, Color(255, 255, 255, 120), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1,Color(0,0,0,50))
	draw.SimpleTextOutlined(maxFPS, "DebugFixedSmall", 522+14, 100+15, Color(255, 255, 255, 120), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1,Color(0,0,0,50))

	local MaxPoints = #FPSData.historicalAverages

	for fpsIndex, fpsAvg in pairs(FPSData.historicalAverages) do
		-- get XY data for current data point
		local IndexFraction, FPSfraction = fpsIndex / MaxPoints, fpsAvg / fpsMax
		local R, G, B = JMod.GoodBadColor(FPSfraction)
		local PixelX, PixelY = IndexFraction * 236 + 280, (1 - FPSfraction) * 161 + 95
		-- get XY data for previous data point
		local PreviousIndex = math.Clamp(fpsIndex - 1, 1, MaxPoints)
		local PreviousAvg = FPSData.historicalAverages[PreviousIndex]
		local PreviousIndexFraction, PreviousFPSfraction = PreviousIndex / MaxPoints, PreviousAvg / fpsMax
		local PreviousPixelX, PreviousPixelY = PreviousIndexFraction * 236 + 280, (1 - PreviousFPSfraction) * 161 + 95
		-- draw a line between them
		surface.SetDrawColor(JMod.GoodBadColor(FPSfraction))
		surface.DrawLine(PixelX, PixelY, PreviousPixelX, PreviousPixelY)
	end
end )
