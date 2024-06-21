DRONES_REWRITE.KeyNames = {
	[0] = "",
	[1] = "0",
	[2] = "1",
	[3] = "2",
	[4] = "3",
	[5] = "4",
	[6] = "5",
	[7] = "6",
	[8] = "7",
	[9] = "8",
	[10] = "9",
	[11] = "A",
	[12] = "B",
	[13] = "C",
	[14] = "D",
	[15] = "E",
	[16] = "F",
	[17] = "G",
	[18] = "H",
	[19] = "I",
	[20] = "J",
	[21] = "K",
	[22] = "L",
	[23] = "M",
	[24] = "N",
	[25] = "O",
	[26] = "P",
	[27] = "Q",
	[28] = "R",
	[29] = "S",
	[30] = "T",
	[31] = "U",
	[32] = "V",
	[33] = "W",
	[34] = "X",
	[35] = "Y",
	[36] = "Z",
	[37] = "keypad 0",
	[38] = "keypad 1",
	[39] = "keypad 2",
	[40] = "keypad 3",
	[41] = "keypad 4",
	[42] = "keypad 5",
	[43] = "keypad 6",
	[44] = "keypad 7",
	[45] = "keypad 8",
	[46] = "keypad 9",
	[47] = "keypad /",
	[48] = "keypad *",
	[49] = "keypad -",
	[50] = "keypad +",
	[51] = "keypad Enter",
	[52] = "keypad Del",
	[53] = "[",
	[54] = "]",
	[55] = ";",
	[56] = '"',
	[57] = "`",
	[58] = ",",
	[59] = ".",
	[60] = "/",
	[61] = "\\",
	[62] = "-",
	[63] = "=",
	[64] = "Enter",
	[65] = "Space",
	[66] = "Backspace",
	[67] = "Tab",
	[68] = "Caps Lock",
	[69] = "Num Lock",
	[71] = "Scroll Lock",
	[72] = "Insert",
	[73] = "Delete",
	[74] = "Home",
	[75] = "End",
	[76] = "Page Up",
	[78] = "Break",
	[79] = "Shift",
	[80] = "Shift Left",
	[81] = "ALT",
	[82] = "ALT Right",
	[83] = "Control",
	[84] = "Control Right",
	[88] = "Arrow Up",
	[89] = "Arrow Left",
	[90] = "Arrow Down",
	[91] = "Arrow Right",
	[92] = "F1",
	[93] = "F2",
	[94] = "F3",
	[95] = "F4",
	[96] = "F5",
	[97] = "F6",
	[98] = "F7",
	[99] = "F8",
	[100] = "F9",
	[101] = "F10",
	[102] = "F11",
	[103] = "F12",
	[107] = "Mouse Left",
	[108] = "Mouse Right",
	[109] = "Mouse 3",
	[110] = "Mouse 4",
	[111] = "Mouse 5",
	[112] = "Mouse Wheel Up",
	[113] = "Mouse Wheel Down"
}

DRONES_REWRITE.DefaultKeys = function()
	local keys = { }


	----------------
	-- Basic keys --
	----------------

	keys.Other = { }

	keys.Other["Zoom"] = function(self)
		local driver = self:GetDriver()

		if driver:IsValid() and not self.Zoom then 
			self.Zoom = true
			driver:SetFOV(self.CamZoom, 0.25) 
		end
	end

	keys.Other["Enable"] = function(self)
		if self:WasKeyPressed("Enable") and self:WaterLevel() < 3 then
			self:SetEnabled(not self.Enabled)
		end
	end

	keys.Other["Exit"] = function(self)
		if self:WasKeyPressed("Exit") then
			self:SetDriver(NULL)
			self.NextAction = CurTime() + 0.3
		end
	end

	keys.Other["SelfDestruct"] = function(self)
		if self:WasKeyPressed("SelfDestruct") then
			self:Destroy()
		end
	end

	keys.Other["NightVision"] = function(self)
		if self:WasKeyPressed("NightVision") and self:IsDroneWorkable() and self.UseNightVision then
			local val = self:GetNWBool("NightVision")

			self:SetNWBool("NightVision", not val)

			local driver = self:GetDriver()
			if driver:IsValid() then
				net.Start("dronesrewrite_playsound")
					net.WriteString(val and "drones/nightvisionoff.wav" or "drones/nightvisionon.wav")
				net.Send(driver)
			end
		end
	end

	keys.Other["SpecialKey"] = function(self)
	end

	keys.Other["WeaponView"] = function(self)
		if self:WasKeyPressed("WeaponView") then
			local driver = self:GetDriver()

			if driver:IsValid() then
				local wep = self:GetCurrentWeapon()
				if wep:IsValid() and not wep.NoDrawWeapon then
					local newCam = wep
					local pos
					local viewent = false

					local cam = driver:GetInfo("dronesrewrite_cl_wvcamorientation", 0)
					if cam == "Right" then
						pos = Vector(0, wep:OBBMins().y - 15, wep:OBBMaxs().z) * (wep.CamOffset or 1)
					elseif cam == "Left" then
						pos = Vector(0, -wep:OBBMins().y + 15, wep:OBBMaxs().z) * (wep.CamOffset or 1)
					elseif cam == "Down" then
						pos = Vector(0, 0, -8) * (wep.CamOffset or 1)
					end

					if self:GetCamera() == newCam then
						newCam = self.Camera
						pos = Vector(0, 0, 0)
						viewent = true
					end

					self:SetCamera(newCam, true, true, pos, viewent)
				end
			end
		end
	end

	keys.Other["Fire1"] = function(self)
		self:Attack1()
	end

	keys.Other["Fire2"] = function(self)
		self:Attack2()
	end

	keys.Other["Flashlight"] = function(self)
		if self:WasKeyPressed("Flashlight") and self:IsDroneWorkable() and self.UseFlashlight then
			self:SetNWBool("Flashlight", not self:GetNWBool("Flashlight"))

			if self.flashlight then
				SafeRemoveEntity(self.flashlight)
				self.flashlight = nil
			else
				self.flashlight = ents.Create("env_projectedtexture")
				
				self.flashlight:SetParent(self.Camera)
					
				self.flashlight:SetLocalPos(self:WorldToLocal(self.Camera:GetPos()))
				self.flashlight:SetLocalAngles(Angle(0, 0, 0))

				self.flashlight:SetKeyValue("enableshadows", 1)
				self.flashlight:SetKeyValue("farz", 500)
				self.flashlight:SetKeyValue("nearz", 12)
				self.flashlight:SetKeyValue("lightfov", 100)
				self.flashlight:SetKeyValue("lightcolor", Format("%i %i %i 255", 255, 255, 255))

				self.flashlight:Spawn()
		
				self.flashlight:Input("SpotlightTexture", NULL, NULL, "effects/flashlight001")
			end

			self:EmitSound("buttons/lightswitch2.wav", 80, 160)
		end
	end

	keys.Other["ThirdPerson"] = function(self)
		if self:WasKeyPressed("ThirdPerson") then
			self:SetNWBool("ThirdPerson", not self:GetNWBool("ThirdPerson"))
		end
	end


	------------------------
	-- Physics control keys
	------------------------

	keys.Physics = { }

	keys.Physics["Sprint"] = function(self)
		if self:WasKeyPressed("Sprint") then 
			self.MoveCoefficient = self.SprintCoefficient * self:ForceCoefficient()
		end
	end

	keys.Physics["MoveSlowly"] = function(self)
		if self:WasKeyPressed("MoveSlowly") then 
			self.MoveCoefficient = 0.3 * self:ForceCoefficient()
		end
	end

	keys.Physics["Forward"] = function(self)
		local forward = self:GetForward()
		local phys = self:GetPhysicsObject()
		local angOffset = self.Speed * self.MoveCoefficient * 0.0005 * self.PitchOffset * self.DRONES_REWRITE_DELTA * 0.5

		phys:ApplyForceCenter(forward * self.Speed * self.MoveCoefficient * self.DRONES_REWRITE_DELTA)
		phys:AddAngleVelocity(Vector(0, angOffset, 0))

		self.MoveDir = 1
		self.IsMoving = true
	end

	keys.Physics["Back"] = function(self)
		local forward = self:GetForward()
		local phys = self:GetPhysicsObject()
		local angOffset = self.Speed * self.MoveCoefficient * 0.0005 * self.PitchOffset * self.DRONES_REWRITE_DELTA * 0.5

		phys:ApplyForceCenter(-forward * self.Speed * self.MoveCoefficient * self.DRONES_REWRITE_DELTA)
		phys:AddAngleVelocity(Vector(0, -angOffset, 0))

		self.MoveDir = -1
		self.IsMoving = true
	end

	keys.Physics["StrafeRight"] = function(self)
		if self.DrrBaseType != "base" then return end

		local right = self:GetRight()
		local phys = self:GetPhysicsObject()

		phys:ApplyForceCenter(right * self.Speed * self.MoveCoefficient * self.DRONES_REWRITE_DELTA)
		phys:AddAngleVelocity(Vector(self.AngOffset, 0, 0))

		self.MoveDir = 1
		self.IsMoving = true
	end

	keys.Physics["StrafeLeft"] = function(self)
		if self.DrrBaseType != "base" then return end

		local right = self:GetRight()
		local phys = self:GetPhysicsObject()

		phys:ApplyForceCenter(-right * self.Speed * self.MoveCoefficient * self.DRONES_REWRITE_DELTA)
		phys:AddAngleVelocity(Vector(-self.AngOffset, 0, 0))

		self.MoveDir = -1
		self.IsMoving = true
	end

	keys.Physics["Right"] = function(self)
		local phys = self:GetPhysicsObject()
		local vellen = math.Clamp(phys:GetVelocity():Length() * self.VelCoefficientOffset, 1, self.VelCoefficientMax) * self.AngOffsetVel

		phys:AddAngleVelocity(Vector(0, 0, -1) * self.RotateSpeed * DRONES_REWRITE.ServerCVars.RotSpeedCoef:GetFloat() * self.DRONES_REWRITE_DELTA * 0.7)
		phys:AddAngleVelocity(Vector(self.AngOffset * vellen * self.DRONES_REWRITE_DELTA * 0.5, 0, 0))

		self.RotateDir = 1
		self.IsRotating = true
	end
		
	keys.Physics["Left"] = function(self)
		local phys = self:GetPhysicsObject()
		local vellen = math.Clamp(phys:GetVelocity():Length() * self.VelCoefficientOffset, 1, self.VelCoefficientMax) * self.AngOffsetVel

		phys:AddAngleVelocity(Vector(0, 0, 1) * self.RotateSpeed * DRONES_REWRITE.ServerCVars.RotSpeedCoef:GetFloat() * self.DRONES_REWRITE_DELTA * 0.7)
		phys:AddAngleVelocity(Vector(-self.AngOffset * vellen * self.DRONES_REWRITE_DELTA * 0.5, 0, 0))

		self.RotateDir = -1
		self.IsRotating = true
	end

	keys.Physics["Up"] = function(self)
		local up = self:GetUp()
		local phys = self:GetPhysicsObject()

		phys:ApplyForceCenter(up * self.UpSpeed * self.MoveCoefficient * 0.2 * self.DRONES_REWRITE_DELTA)

		self.IsMoving = true
	end

	keys.Physics["Down"] = function(self)
		local up = self:GetUp()
		local phys = self:GetPhysicsObject()

		phys:ApplyForceCenter(-up * self.UpSpeed * self.MoveCoefficient * 0.2 * self.DRONES_REWRITE_DELTA)

		self.IsMoving = true
	end


	-----------------------
	-- Unpress functions --
	-----------------------
	keys.UnPressed = { }

	keys.UnPressed["Sprint"] = function(self)
		self.MoveCoefficient = self:ForceCoefficient()
	end

	keys.UnPressed["MoveSlowly"] = function(self)
		self.MoveCoefficient = self:ForceCoefficient()
	end

	keys.UnPressed["Zoom"] = function(self)
		local driver = self:GetDriver()

		if driver:IsValid() then driver:SetFOV(90, 0.2) end
		self.Zoom = false
	end

	keys.UnPressed["Fire1"] = function(self)
		self:OnAttackStopped()
	end

	keys.UnPressed["Fire2"] = function(self)
		self:OnAttackStopped2()
	end

	return keys
end