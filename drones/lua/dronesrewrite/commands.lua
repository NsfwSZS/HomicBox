local function findDrone(console, args)
	if not args[1] then return NULL end

	local drone = args[1] == "-sel" and console.SelectedDrone or DRONES_REWRITE.FindDroneByUnit(args[1])
	if IsValid(drone) then 
		if drone.IS_DRONE and not drone.IS_DRR then
			console:AddLine("Unknown system protocol! Console only supports drones from Drones Rewrite!", Color(255, 0, 0)) 
		end
	else
		console:AddLine("Drone is not found!", Color(255, 0, 0)) 
	end

	return drone
end

local commands_buf = { }

DRONES_REWRITE.AddCommand = function(name, func)
	commands_buf[name] = func
end

DRONES_REWRITE.Words = {
	[1] = { -- Very easy
	        "FRIED",
	        "TREES",
	        "RIGID",
	        "HIRED",
	        "TRIES",
	        "WRITE",
	        "TRIED",
	        "GREED",
	        "DRIED",
	        "BRAIN",
	        "SKIES",
	        "LAWNS",
	        "GHOST",
	        "CAUSE",
	        "PAINT",
	        "SHINY",
	        "MAKES",
	        "GAINS",
	        "THIEF",
	        "BASES",
	        "RAISE",
	        "REFER",
	        "CARES",
	        "TAKEN",
	        "WAKES",
	        "WAVES",
	        "WARNS",
	        "SAVES"
	},

	[2] = { -- Easy
	        "STATING",
	        "HEALING",
	        "COSTING",
	        "REASONS",
	        "SEASIDE",
	        "SPARING",
	        "CAUSING",
	        "CRAFTED",
	        "PRISONS",
	        "PRESENT",
	        "DEALING",
	        "SETTING",
	        "LEAVING",
	        "VERSION",
	        "DEATHLY",
	        "BLAZING",
	        "GRANITE",
	        "TESTING",
	        "TRAITOR",
	        "STAMINA",
	        "TRINITY",
	        "CALLING",
	        "TALKING",
	        "ACQUIRE",
	        "WELCOME",
	        "DECRIES",
	        "FALLING",
	        "PACKING",
	        "ALLOWED",
	        "SELLING",
	        "AFFRONT",
	        "WALKING"
	},

	[3] = { -- Average
	        "CONQUORER",
	        "CONSISTED",
	        "WONDERFUL",
	        "COMMITTEE",
	        "SURRENDER",
	        "SUBJECTED",
	        "CONVICTED",
	        "FORBIDDEN",
	        "FORTIFIED",
	        "COLLECTED",
	        "CONTINUED",
	        "PERIMETER",
	        "SOUTHEAST",
	        "RELEASING",
	        "SOMETHING",
	        "ACCEPTING",
	        "MUTATIONS",
	        "GATHERING",
	        "LITERALLY",
	        "REPAIRING",
	        "INCESSANT",
	        "INTERIORS",
	        "REGARDING",
	        "TELEPHONE",
	        "OBTAINING",
	        "EXTENSIVE",
	        "DEFEATING",
	        "REQUIRING",
	        "UNLOCKING",
	        "RECYCLING",
	        "INSTINCTS",
	        "BARTERING",
	        "LEUTENANT",
	        "COMMUNITY",
	        "BATTERIES",
	        "RECIEVING",
	        "INCLUDING",
	        "INITIALLY",
	        "INVOLVING",
	        "MOUNTAINS"
	},

	[4] = { -- Hard
	        "DISCOVERING",
	        "ELIMINATING",
	        "UNIMPORTANT",
	        "MISTRUSTING",
	        "MANUFACTURE",
	        "RADIOACTIVE",
	        "EXCLUSIVELY",
	        "BOMBARDMENT",
	        "DECEPTIVELY",
	        "INDEPENDENT",
	        "UNBELIEVERS",
	        "EFFECTIVELY",
	        "IMMEDIATELY",
	        "INFESTATION",
	        "DESCRIPTION",
	        "INFORMATION",
	        "REMEMBERING",
	        "NIGHTVISION",
	        "DESTRUCTION",
	        "OVERLOOKING"
	},

	[5] = { -- Very hard
	        "INFILTRATION",
	        "ORGANIZATION",
	        "AUTHENTICITY",
	        "APPRECIATION",
	        "SPOKESPERSON",
	        "LABORATORIES",
	        "INITIATEHOOD",
	        "SUBTERRANEAN",
	        "PURIFICATION",
	        "TRANSMISSION",
	        "CIVILIZATION",
	        "CONSTRUCTION",
	        "RESURRECTION",
	        "REPRIMANDING",
	        "ACCOMPANYING",
	        "OVERWHELMING",
	        "CONVERSATION",
	        "NORTHERNMOST",
	        "TRANSCRIBING",
	        "ANNOUNCEMENT",
	        "SECLUTIONIST"
	}
}

DRONES_REWRITE.GetCommands = function()
	local terminal = { }

	table.Add(terminal, commands_buf)

	terminal["health"] = function(self, args)
		self:AddLine(self.Hp)
	end

	terminal["break"] = function(self, args)
		self:Explode()
	end

	terminal["blockkeys"] = function(self, args)
		if not args[2] or (args[2] != "1" and args[2] != "0") then
			self:AddLine("Incorrect format! blockkeys DRONEID 1 or blockkeys DRONEID 0.", Color(255, 0, 0))
			return 
		end

		local drone = findDrone(self, args)

		if drone:IsValid() and self.User:IsAdmin() then
			local val = tobool(args[2])
			drone.BlockKeys = val
			val = val and "blocked" or "unblocked"
			self:AddLine("Keys has been " .. val .. ".")
		end
	end

	terminal["hints"] = function(self, args)
		if not args[1] or (args[1] != "1" and args[1] != "0") then
			self:AddLine("Incorrect format! hints 1 or hints 0.", Color(255, 0, 0))
			return 
		end

		self:SetNWBool("noHints", not tobool(args[1]))
	end

	terminal["say"] = function(self, args)
		if not args[1] then
			self:AddLine("Incorrect format! say TEXT.")
			return
		end

		local str = ""
		for k, v in pairs(args) do str = str .. v .. " " end
		self.User:Say(str)
	end

	terminal["randscr"] = function(self, args)
		if not args[1] or (args[1] != "1" and args[1] != "0") then
			self:AddLine("Incorrect format! randscr 1 or randscr 0.", Color(255, 0, 0))
			return 
		end

		self:SetNWBool("noRandomScr", not tobool(args[1]))
	end

	terminal["exit"] = function(self, args)
		self:Exit()
	end

	terminal["lights"] = function(self, args)
		if not args[1] or (args[1] != "1" and args[1] != "0") then
			self:AddLine("Incorrect format! lights 1 or lights 0.", Color(255, 0, 0))
			return 
		end

		self:SetNWBool("noLights", not tobool(args[1]))
	end

	terminal["screen"] = function(self, args)
		if not args[1] or (args[1] != "1" and args[1] != "0") then
			self:AddLine("Incorrect format! screen 1 or screen 0.", Color(255, 0, 0))
			return 
		end

		self:SetNWBool("noScreen", not tobool(args[1]))
	end

	terminal["printbinds"] = function(self, args)
		for k, v in pairs(DRONES_REWRITE.Keys) do
			self:AddLine(k .. " binded to " .. DRONES_REWRITE.KeyNames[v] .. ".")
		end
	end

	terminal["overridepower"] = function(self, args)
		if not args[2] then
			self:AddLine("Incorrect format! overridepower DRONEID NUMBER or overridepower DRONEID OLD.", Color(255, 0, 0))
			return 
		end

		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			if args[2] == "old" then args[2] = 2.2535 end

			drone.FlyConstant = args[2]
			self:AddLine("Overrided to " .. args[2] .. ".")
		end
	end

	terminal["presskeybind"] = function(self, args)
		if not args[2] then
			self:AddLine("Incorrect format! presskeybind DRONEID _KEY or presskeybind DRONEID _BIND.", Color(255, 0, 0))
			self:AddLine("You can find binds by typing printbinds.", Color(255, 0, 0))
			return 
		end

		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			drone:ClickKey(args[2])
			self:AddLine("Clicked.")
		end
	end

	terminal["kick"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			drone:SetDriver(NULL)
			self:AddLine("Driver has been kicked.")
		end
	end

	terminal["forcecontrol"] = function(self, args)
		if not args[2] then 
			self:AddLine("Incorrect format! forcecontrol DRONEID PLAYERNICK.", Color(255, 0, 0))
			return 
		end

		local ply = NULL

		for k, v in pairs(player.GetAll()) do
			if string.find(string.lower(v:Name()), string.lower(args[2])) then
				ply = v
				break
			end
		end

		if not ply:IsValid() then
			self:AddLine("Could not find player with name " .. args[2] .. ".", Color(255, 0, 0))
			return 
		end

		local drone = findDrone(self, args)

		if drone:IsValid() and self.User:IsAdmin() then
			drone:SetDriver(NULL)
			drone:SetDriver(ply, 1000000, self)
			self:AddLine("Driver has been changed.")
		end
	end

	terminal["helpmenu"] = function(self, args)
		self.User:ConCommand("dronesrewrite_help")
	end

	terminal["screamdriver"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			drone:EmitSound("npc/stalker/go_alert2.wav")
			self:AddLine("Screamed as hell!")
		end
	end

	terminal["info"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() then
			self:AddLine("Getting info...")
			self:AddLine("------------------------------------------")

			self:AddLine("Security level: " .. drone.HackValue)
			self:AddLine("HP: " .. drone:GetHealth())
			self:AddLine("Weapons: ")

			for k, v in pairs(drone.ValidWeapons) do
				self:AddLine("" .. k .. ": ")

				self:AddLine("    Primary ammo: " .. v.PrimaryAmmo)
				self:AddLine("    Secondary ammo: " .. v.SecondaryAmmo)

				self:AddLine("")
			end

			local name = "no driver"
			if drone:GetDriver():IsValid() then name = drone:GetDriver():Name() end
			self:AddLine("Driver: " .. name)

			local name = "no owner"
			if drone.Owner:IsValid() then name = drone.Owner:Name() end
			self:AddLine("Owner: " .. name)

			self:AddLine("Enabled: " .. tostring(drone.Enabled))
			self:AddLine("Public: " .. tostring(drone.AllowControl))
			self:AddLine("Speed: " .. (drone.Speed + drone.UpSpeed + drone.RotateSpeed) / 3)
			self:AddLine("Fuel: " .. drone:GetFuel())
			self:AddLine("Selected weapon: " .. drone.CurrentWeapon)

			self:AddLine("")

			self:AddLine("Installed modules: ")
			self.Commands["imodules"](self, args)

			self:AddLine("")

			self:AddLine("Hooks: ")

			for k, v in pairs(drone.hooks) do
				self:AddLine("Hook: " .. k)

				for name, foo in pairs(v) do
					self:AddLine("    " .. name)
				end

				self:AddLine("")
			end

			self:AddLine("------------------------------------------")
		end
	end

	terminal["print"] = function(self, args)
		if not args[1] then 
			self:AddLine("Incorrect format! print TEXT or print TEXT COLOR.", Color(255, 0, 0))
			return 
		end

		local color = { 255, 255, 255 }
		local str = ""

		local buf = { }
		table.Add(buf, args)

		if #args > 3 then
			for i = 0, 2 do
				local statement = args[#args - i]

				if tonumber(statement) then
					color[3 - i] = statement
					buf[#args - i] = nil
				else
					buf = { }
					table.Add(buf, args)

					color = { 255, 255, 255 }
					break
				end
			end
		end

		for k, v in pairs(buf) do str = str .. " " .. v end

		self:AddLine(str, Color(color[1], color[2], color[3]))
	end

	terminal["me"] = function(self, args)
		if not args[1] then 
			self:AddLine("Incorrect format! me TEXT or me TEXT COLOR.", Color(255, 0, 0))
			return 
		end

		args[1] = self.User:Name() .. " " .. args[1]
		self.Commands["print"](self, args)
	end

	terminal["control"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			drone:SetDriver(self.User, 1000000, self)
			self:Exit()
		end
	end

	terminal["addmodule"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			if not args[2] then
				self:AddLine("Incorrect format! removewep DRONEID MODULENAME.", Color(255, 0, 0))
				return
			end

			local a = { }
			for i = 2, #args do a[i - 1] = args[i] end
			local str = string.lower(table.concat(a, " "))

			drone:AddModule(str)
			self:AddLine(str .. " has been added.")
		end
	end

	terminal["removemodule"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			if not args[2] then
				self:AddLine("Incorrect format! removewep DRONEID MODULENAME", Color(255, 0, 0))
				return
			end

			local a = { }
			for i = 2, #args do a[i - 1] = args[i] end
			local str = string.lower(table.concat(a, " "))

			drone:RemoveModule(str)
			self:AddLine(str .. " has been removed.")
		end
	end

	terminal["imodules"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() then
			self:AddLine("-- Found modules --")

			for k, v in pairs(drone.ValidModules) do
				self:AddLine(k)
			end
		end
	end

	terminal["removewep"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			if not args[2] then
				self:AddLine("Incorrect format! removewep DRONEID WEPNAME.", Color(255, 0, 0))
				return
			end

			local a = { }
			for i = 2, #args do a[i - 1] = args[i] end
			local str = string.lower(table.concat(a, " "))

			drone:RemoveWeapon(str)
			self:AddLine(str .. " has been removed")
		end
	end

	terminal["addwep"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) and self.User:IsAdmin() then
			-- TODO: FIX SPACE BUG

			if not args[2] or not args[3] then
				self:AddLine("Incorrect format! addwep DRONEID WEPNAME YOURWEPNAME X Y Z P Y R VISIBLE PRIMARYASSECONDARY ATTACHMENT or addwep DRONEID WEAPON", Color(255, 0, 0))
				return
			end

			local wep = args[2]
			local name = args[3]
			
			local x = tonumber(args[4])
			local y = tonumber(args[5])
			local z = tonumber(args[6])

			local p = tonumber(args[7])
			local ya = tonumber(args[8])
			local r = tonumber(args[9])

			local select = tobool(args[10])
			local prims = tobool(args[11])
			local attachment = args[12]

			drone:FastAddWeapon(name, wep, Vector(x, y, z), { }, Angle(p, ya, r), select, prims, attachment)

			self:AddLine(name .. " has been added.")
		end
	end

	terminal["select"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() then
			self:AddLine("Selected " .. drone:GetUnit() .. ".")
			self:SetDrone(drone)
		end
	end

	terminal["unselect"] = function(self, args)
		if IsValid(self.SelectedDrone) then 
			self:AddLine(self.SelectedDrone:GetUnit() .. " has been unselected.") 
		end

		self:SetDrone(NULL)
	end

	terminal["clear"] = function(self, args)
		self:Clear()
	end

	terminal["printlist"] = function(self, args)
		self:AddLine("-- Found drones --")

		for k, v in pairs(ents.GetAll()) do
			if v.IS_DRONE then self:AddLine(v:GetUnit()) end
		end
	end

	terminal["hack"] = function(self, args)
		if self.Failed then
			self.CatchCommand = function(self, args, cmd) 
				if cmd == "exit" then return true end
				return false 
			end

			self:AddLine(" ")
			self:AddLine("Waiting for protection system to reboot...")

			timer.Create("dronesrewrite_console_cooldown" .. self:EntIndex(), math.random(10, 12), 1, function()
				if IsValid(self) then 
					self.CatchCommand = nil 
					self.Failed = false 

					self:AddLine("Done.")
				end
			end)

			return
		end

		if self.Hacking then
			self:AddLine("Type exithack command first!")
			return
		end

		if self.CatchCommand then
			self:AddLine("Something went wrong...")
			return
		end

		local drone = findDrone(self, args)

		if drone:IsValid() then
			self:AddLine("Please wait. Getting info...")

			timer.Simple(math.Rand(2, 4), function()
				if not IsValid(self) then return end
				if not IsValid(drone) then return end

				local Words = DRONES_REWRITE.Words[drone.HackValue]
				if not Words then 
					self:AddLine("Something went wrong. Hacking failed.")
					return
				end

				self.Attempts = 4

				if drone.AllowControl then
					self:AddLine("Already hacked!")
					return
				end

				self:EmitSound("buttons/button24.wav", 60)

				self:AddLine(" ")
				self:AddLine("4 ATTEMPT(S) LEFT")
				self:AddLine(" ")

				local vals = { }
				local _vals = "!@#%^*()_-=+\\|/[]{}?\"\':;,.<>"
				for i = 1, string.len(_vals) do vals[i] = string.sub(_vals, i, i) end

				local left = math.floor(#Words * 0.7)
				local entered = { }
				local line = ""

				while left > 0 do
					local word = table.Random(Words)
					if entered[word] then continue end

					for i = 4, math.random(0, 20) + string.len(word) do line = line .. table.Random(vals) end
					line = line .. word

					entered[word] = word

					left = left - 1
				end

				-- Getting password
				local pass = table.Random(entered)
				local len = string.len(pass)

				local hex = math.random(1, 200) + 63744
				for i = 1, string.len(line), 51 do
					self:AddLine("0x" .. string.format("%x", hex):upper() .. "   " .. string.sub(line, i, i + 50))
					hex = hex + 12
				end

				self.CatchCommand = function(self, args, cmd)
					if not IsValid(drone) then 
						self:AddLine("Drone's signal was lost!", Color(255, 0, 0))
						self.Commands["exithack"](self)

						return false
					end
					
					if cmd == "show_password" then
						if drone:CanBeControlledBy_skipai(self.User) then
							self:AddLine("Password for this session: " .. pass)
						else
							self:AddLine("Access denied!")
						end

						return false
					elseif cmd == "exit" or cmd == "exithack" then
						return true
					elseif self.Commands[cmd] then
						self:AddLine("Type exithack command first!")
						return false
					end
					
					local checkpass = string.lower(pass)

					if checkpass == cmd then
						self:AddLine("Hacked!", Color(0, 255, 0))
						self:EmitSound("buttons/button5.wav")
						self.Commands["exithack"](self)
						drone.AllowControl = true
					else
						self:AddLine("Incorrect password.", Color(255, 0, 0))

						local count = 0
						for i = 1, len do
							if string.sub(cmd, i, i) == string.sub(checkpass, i, i) then
								count = count + 1
							end
						end

						self:AddLine(count .. " / " .. len .. " correct.")

						self:EmitSound("buttons/button10.wav")
						self.Attempts = self.Attempts - 1

						self:AddLine(self.Attempts .. " ATTEMPT(S) LEFT")

						if self.Attempts <= 0 then
							self.Commands["exithack"](self)
							self.Failed = true
						end
					end

					return false
				end

				self.Hacking = true
			end)
		end
	end

	terminal["exithack"] = function(self, args)
		if not self.Hacking then
			self:AddLine("We aren't hacking right now!")
			return
		end

		self:AddLine("Exiting from hacking...")

		self.Attempts = 4
		self.Hacking = false
		self.CatchCommand = nil
	end

	terminal["disable"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			drone:SetEnabled(false)
			self:AddLine(drone:GetUnit() .. " has been disabled.")
		end
	end

	terminal["enable"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			drone:SetEnabled(true)
			self:AddLine(drone:GetUnit() .. " has been enabled.")
		end
	end

	terminal["dropfuel"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			drone:SetFuel(0)
			self:AddLine(drone:GetUnit() .. " has dropped fuel.")
		end
	end

	terminal["droppropellers"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			drone:DropPropellers()
			self:AddLine(drone:GetUnit() .. " has dropped propellers.")
		end
	end

	terminal["destroy"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			drone:Destroy()
			self:AddLine(drone:GetUnit() .. " has been destroyed.")
		end
	end

	terminal["modules"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() then
			self:AddLine("-- Found modules --")

			for k, v in pairs(drone.Modules) do
				self:AddLine(k)
			end
		end
	end

	terminal["dropmodules"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			drone:RemoveAllModules()
			self:AddLine(drone:GetUnit() .. " has dropped modules.")
		end
	end

	terminal["dropweps"] = function(self, args)
		local drone = findDrone(self, args)

		if drone:IsValid() and drone:CanBeControlledBy_skipai(self.User) then
			drone:RemoveWeapons()
			self:AddLine(drone:GetUnit() .. " has dropped weapons.")
		end
	end

	terminal["help"] = function(self, args)
		local i = 1
		for k, v in pairs(DRONES_REWRITE.GetCommands()) do
			self:AddLine(i .. ". " .. k)
			i = i + 1
		end
	end

	return terminal
end