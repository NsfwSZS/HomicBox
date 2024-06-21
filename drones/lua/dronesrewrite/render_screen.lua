if CLIENT then
	--DRONES_REWRITE.RenderingScreen = false

	--hook.Add("ShouldDrawLocalPlayer", "dronesrewrite_renderscreendrawply", function(ply)
		--if DRONES_REWRITE.RenderingScreen then 
			--return true 
		--end
	--end)

	hook.Add("RenderScene", "dronesrewrite_renderscreen", function(pos, ang)
		if DRONES_REWRITE.ClientCVars.NoScreen:GetBool() then return end

		local mdl = { }
		table.Add(mdl, ents.FindByClass("dronesrewrite_controller"))
		table.Add(mdl, ents.FindByClass("dronesrewrite_console"))

		for k, v in pairs(mdl) do
	        if LocalPlayer():GetAimVector():Dot((v:GetPos() - pos):GetNormal()) < 0.3 then continue end
	        if v:GetUp():Dot((v:GetPos() - pos):GetNormal()) > 0 then continue end

			if not v.Rt then continue end

			local drone = v:GetNWEntity("DronesRewriteDrone")
			if not drone:IsValid() then continue end

			local cam = drone:GetCamera()
			if not cam:IsValid() then continue end

			local pos = cam:GetPos()
			local ang = cam:GetAngles()
			local oldRT = render.GetRenderTarget()

			render.SetRenderTarget(v.Rt)

			render.Clear(0, 0, 0, 255)
			render.ClearDepth()
			render.ClearStencil()

			--DRONES_REWRITE.RenderingScreen = true
			render.RenderView({
				x = 0,
				y = 0,
				w = 1024,
				h = 1024,
				fov = 70,
				origin = pos,
				angles = ang,
				drawpostprocess = true,
				drawhud = false,
				drawmonitors = false,
				drawviewmodel = false,
			})
			--DRONES_REWRITE.RenderingScreen = false

			render.SetRenderTarget(oldRT)
		end
	end)
end

if SERVER then
	hook.Add("SetupPlayerVisibility", "dronesrewrite_renderscreendrawdrone", function(ply)
		for k, v in pairs(ents.FindByClass("dronesrewrite_controller")) do
			if v.Drone and v.Drone:IsValid() then
				AddOriginToPVS(v.Drone:GetPos())
			end
		end

		for k, v in pairs(ents.FindByClass("dronesrewrite_console")) do
			if v.SelectedDrone and v.SelectedDrone:IsValid() then
				AddOriginToPVS(v.SelectedDrone:GetPos())
			end
		end
	end)
end