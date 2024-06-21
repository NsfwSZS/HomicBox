--[[
	Drones Rewrite
	Drones Base

	https://github.com/Dexl/Drones-Rewrite
]]


local function Bomb(ent)
        local SelfPos,PowerMult,Model = ent:LocalToWorld(ent:OBBCenter()),6,ent:GetModel()

        
            ParticleEffect("pcf_jack_groundsplode_large",SelfPos,vector_up:Angle())
            util.ScreenShake(SelfPos,99999,99999,1,3000)
            sound.Play("BaseExplosionEffect.Sound", SelfPos,120,math.random(90,110))

            for i = 1,4 do
                sound.Play("explosions/doi_ty_01_close.wav",SelfPos,140,math.random(80,110))
            end

            if util.GetSurfaceIndex(ent:GetBoneSurfaceProp(0)) == 3 or util.GetSurfaceIndex(ent:GetBoneSurfaceProp(0)) == 66 then
                JMod.FragSplosion(ent, SelfPos + Vector(0, 0, 20), 1024, 50, 3500, ent.owner or game.GetWorld())
            end

            timer.Simple(.1,function()
                for i = 1, 5 do
                    local Tr = util.QuickTrace(SelfPos, VectorRand() * 20)

                    if Tr.Hit then
                        util.Decal("Scorch", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
                    end
                end
            end)

            JMod.WreckBuildings(ent, SelfPos, PowerMult)
            JMod.BlastDoors(ent, SelfPos, PowerMult)

            -- if BigFireModels[Model] then
            --     for i = 1, 25 do
            --         local FireVec = ( VectorRand() * .3 + Vector(0, 0, .3)):GetNormalized()
            --         FireVec.z = FireVec.z / 2
            --         local Flame = ents.Create("ent_jack_gmod_eznapalm")
            --         Flame:SetPos(SelfPos + Vector(0, 0, 50))
            --         Flame:SetAngles(FireVec:Angle())
            --         Flame:SetOwner(game.GetWorld())
            --         JMod.SetOwner(Flame, game.GetWorld())
            --         Flame.SpeedMul = 0.25
            --         Flame.Creator = game.GetWorld()
            --         Flame.HighVisuals = true
            --         Flame:Spawn()
            --         Flame:Activate()
            --     end
            -- elseif FireModels[Model] then
            --     for i = 1, 7 do
            --         local FireVec = ( VectorRand() * .3 + Vector(0, 0, .3)):GetNormalized()
            --         FireVec.z = FireVec.z / 2
            --         local Flame = ents.Create("ent_jack_gmod_eznapalm")
            --         Flame:SetPos(SelfPos + Vector(0, 0, 50))
            --         Flame:SetAngles(FireVec:Angle())
            --         Flame:SetOwner(game.GetWorld())
            --         JMod.SetOwner(Flame, game.GetWorld())
            --         Flame.SpeedMul = 0.25
            --         Flame.Creator = game.GetWorld()
            --         Flame.HighVisuals = true
            --         Flame:Spawn()
            --         Flame:Activate()
            --     end
            -- end

            if IsValid(ent) then
                ent:RemoveCallOnRemove("homigrad-bomb")
                --if RagdollOwner(ent) then RagdollOwner(ent):KillSilent() end
                timer.Simple(.6, function()
                	-- ent:Remove()
            	end)                
            end
            timer.Simple(0,function()
                local ZaWarudo = game.GetWorld()
                local Infl, Att = (IsValid(ent) and ent) or ZaWarudo, (IsValid(ent) and IsValid(ent.owner) and ent.owner) or (IsValid(ent) and ent) or ZaWarudo
                util.BlastDamage(Infl,Att,SelfPos,60 * PowerMult,120 * PowerMult)

                --util.BlastDamage(Infl,Att,SelfPos,20 * PowerMult,1000 * PowerMult)
            end)
        if IsValid(ent.parentBomb) then ent.parentBomb:Remove() end
    end

include("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

function ENT:Destroy()
	self:TakeDamage(self:GetHealth() + 1)

end

function ENT:ForceCoefficient() 
	if not self.Propellers then return 1 end

	local num1 = self:GetNWInt("NumPropellers")
	local num2 = #self.ValidPropellers

	local val = 1
	if num1 < num2 then val = (1 - (1 / num1)) * 0.55 end

	return (num1 / num2) * val * DRONES_REWRITE.ServerCVars.SpeedCoef:GetFloat()
end

function ENT:IsEnemy(class)
	local enemycheck = IsEnemyEntityName(class)
	if DRONES_REWRITE.ServerCVars.NPCReverse:GetBool() then enemycheck = IsFriendEntityName(class) end
	
	return self:GetHealth() > 0 and enemycheck and not DRONES_REWRITE.ServerCVars.NPCIgnore:GetBool() and not self.ShouldNpcsIgnore
end

function ENT:SetEnabled(n)
	local snd = self.Enabled and self.Sounds.SwitchOnSound or self.Sounds.ShutdownSound
	if snd then 
		local lvl = snd.Level or 75
		local pitch = snd.Pitch or 100
		
		self:EmitSound(snd.Name, lvl, pitch) 
	end

	self.Enabled = n
	self:SetNWBool("Enabled", n)

end

function ENT:AddKeyBind(bind, name, func)
	self:AddHook(bind, name, func)
	DRONES_REWRITE.LogDebug(string.format("Added key bind %s & %s", bind, name))
end

function ENT:RemoveKeyBind(bind, name)
	self:RemoveHook(bind, name)
	DRONES_REWRITE.LogDebug(string.format("Removed key bind %s & %s", bind, name))
end

function ENT:CallBinds(bind, ...)
	self:CallHook(bind, ...)
end

function ENT:AddUnpressKeyBind(bind, name, func) 
	self:AddKeyBind(bind .. "_unpressed", name, func) 
end

function ENT:RemoveUnpressKeyBind(bind, name) 
	self:RemoveKeyBind(bind .. "_unpressed", name) 
end

function ENT:CallUnpressBinds(bind, ...) 
	self:CallBinds(bind .. "_unpressed", ...) 
end

function ENT:FastRemoveBind(bind, name)
	self:RemoveUnpressKeyBind(bind, name)
	self:RemoveKeyBind(bind, name)
end

function ENT:DisableKeys()
	for k, v in pairs(self.Keys) do 
		self.Keys[k].Pressed = false 
	end
end

function ENT:CanUsePhysicsKeys()
	if self.DrrBaseType == "base" then
		return not self:IsDroneDestroyed() and self.EnginePower > 0 and self:HasPropellers()
	elseif self.DrrBaseType == "walker" then
		return self:IsDroneWorkable() and self:IsDroneOnGround()
	elseif self.DrrBaseType == "underwater" then
		return self:WaterLevel() >= 3
	end
end

function ENT:IsKeyDown(key)
	local a = self.Keys[key]
	return a and a.Pressed
end

function ENT:WasKeyPressed(key)
	local a = self.Keys[key]
	if not a then return false end

	return (a.Pressed and not a.Delta) or a.Click
end

function ENT:IsKeyReleased(key) return not self:IsKeyDown(key) end

function ENT:PressKey(key)
	if not self.Keys[key] then self.Keys[key] = { } end
	self.Keys[key].Pressed = not self.Keys[key].Pressed
end

function ENT:ClickKey(key)
	if not self.Keys[key] then self.Keys[key] = { } end
	self.Keys[key].Click = true
end

-- Actually this is not key pressing / clicking function
-- These functions are above ^
function ENT:Key(key)
	if self.BlockKeys and key != "Exit" then return end

	if self.KeysFuncs.Physics[key] then
		if self:CanUsePhysicsKeys() then self.KeysFuncs.Physics[key](self) end
	elseif self.KeysFuncs.Other[key] then
		self.KeysFuncs.Other[key](self)
	end
end

-- Better to use this function only with rotation 
function ENT:ControlMotion(key, elskey, value, filtermin, filtermax)
	if value >= filtermax or value <= filtermin then
		if value < 0 then
			self:ClickKey(key)
		else
			self:ClickKey(elskey)
		end
	end
end

function ENT:ControlsPhys()
	self.MoveDir = 0
	self.RotateDir = 0
	self.IsMoving = false
	self.IsRotating = false
	
	for k, v in pairs(self.Keys) do
		if self.KeysFuncs.Physics[k] then
			if self.BlockKeys and k != "Exit" then continue end

			if v.Pressed or v.Click then
				if self:CanUsePhysicsKeys() then self.KeysFuncs.Physics[k](self) end
				self:CallBinds(k)

				v._Pressed = true
				v.Click = false
			elseif v._Pressed then
				v._Pressed = false

				if self.KeysFuncs.UnPressed[k] then self.KeysFuncs.UnPressed[k](self) end
				self:CallUnpressBinds(k)
			end

			v.Delta = v.Pressed
		end
	end
end

function ENT:Controls()
	for k, v in pairs(self.Keys) do
		if self.KeysFuncs.Other[k] then
			if self.BlockKeys and k != "Exit" then continue end

			if v.Pressed or v.Click then
				self.KeysFuncs.Other[k](self)
				self:CallBinds(k)

				v._Pressed = true
				v.Click = false
			elseif v._Pressed then
				v._Pressed = false

				if self.KeysFuncs.UnPressed[k] then self.KeysFuncs.UnPressed[k](self) end
				self:CallUnpressBinds(k)
			end

			v.Delta = v.Pressed
		end
	end
end

function ENT:CanBeControlledBy_skipai(ply)
	local noOwner = not IsValid(self.Owner)
	local hacked = self.AllowControl
	local isOwner = ply == self.Owner
	local isStealable = DRONES_REWRITE.ServerCVars.AllowStealing:GetBool()
	local isAdmin = (ply:IsAdmin() and DRONES_REWRITE.ServerCVars.AllowAdmins:GetBool())
	local inFriends = (self.DRRFriendsControlling and table.HasValue(self.DRRFriendsControlling, ply:SteamID()))

	local control = (hacked or isOwner or isStealable or isAdmin or inFriends or noOwner)

	return IsValid(ply) and self.Useable and not self:IsDroneDestroyed() and control
end

function ENT:CanBeControlledBy(ply)
	return self:CanBeControlledBy_skipai(ply) and not self.AI_installed
end

function ENT:IsFarFarAway(ent, dist)
	if DRONES_REWRITE.ServerCVars.NoSignalLimit:GetBool() then return false end

	dist = (dist or self.DRRDefMaxDistance) * DRONES_REWRITE.ServerCVars.SignalCoef:GetFloat()
	return ent:GetPos():Distance(self:GetPos()) > dist
end

function ENT:CountModulesInSlot(slot)
	local count = 0
	for k, v in pairs(self.ValidModules) do if v.Slot == slot then count = count + 1 end end

	return count
end

function ENT:HasPropellers() 
	for k, v in pairs(self.ValidPropellers) do
		if v:IsValid() and not v.IsDestroyed then return true end
	end

	return false
end

-- Easy part deleting
function ENT:DeletePart(part)
	if not part then return end

	if type(part) == "table" then
		for k, v in pairs(part) do SafeRemoveEntity(v) end
	else
		SafeRemoveEntity(part)
	end

	DRONES_REWRITE.LogDebug(string.format("Deleted %s", tostring(part)))
end

function ENT:WaitWeps()
	for k, v in pairs(self.ValidWeapons) do v.InstantWait = CurTime() + 0.5 end
end

function ENT:SetCamera(cam, hud, supportangs, localpos, viewent)
	if localpos == nil then localpos = Vector(0, 0, 0) end
	if hud == nil then hud = true end
	if supportangs == nil then supportangs = true end
	if viewent == nil then viewent = true end
	
	if not IsValid(cam) then cam = self.Camera end

	if IsValid(cam) then
		self:SetNWBool("ThirdPerson", false)
		self:SetNWEntity("Camera", cam)
		self:SetNWBool("CameraHUD", hud)
		self:SetNWVector("CameraPositions", localpos)
		self:SetNWBool("SupportAngles", supportangs)

		if viewent then 
			local driver = self:GetDriver()
			if driver:IsValid() then driver:SetViewEntity(cam) end
		end
	end

	DRONES_REWRITE.LogDebug("Camera has set")
end

function ENT:SetDriver(ply, maxDistance, transmitter) 
	local driver = self:GetDriver()

	if driver:IsValid() and ply:IsValid() then return end
	if ply:GetNWEntity("DronesRewriteDrone"):IsValid() then return end

	if ply:IsValid() then
		DRONES_REWRITE.LogDebug(string.format("Trying to set driver to %s", ply:Name()))
		
		if not IsValid(self.Owner) then 
			ply:ChatPrint("[Drones] Now you're owner of " .. self:GetUnit())
			self:SetupOwner(ply) 
		end -- No owner? Ok, we steal it

		if self:CanBeControlledBy(ply) then
			if ply:GetMoveType() != MOVETYPE_NOCLIP then 
				if not ply:IsOnGround() or ply:WaterLevel() >= 3 then 
					ply:ChatPrint("[Drones] Вы не можете использовать доронов находясь в воздухе или воде.") 
					return 
				end
			end

			transmitter = transmitter or ply
			if transmitter.DRR_NotWorkableTransmitter then return end

			if self.BlockRemoteController and transmitter == ply then 
				ply:ChatPrint("[Drones] Контроль заблокирован...") 
				return 
			end

			maxDistance = maxDistance or (self.DRRDefMaxDistance or 10000)

			self.Transmitter = transmitter
			self.MaxDistance = maxDistance

			local weapon = ply:GetActiveWeapon()
			if weapon:IsValid() then self.PlyOldWeapon = weapon:GetClass() end

			if not ply:HasWeapon("weapon_drr_remote") then
				ply:Give("weapon_drr_remote")
			end
			ply:SelectWeapon("weapon_drr_remote")

			self.OldFov = ply:GetFOV()
			ply:SetFOV(90, 0)
	
			ply:AllowFlashlight(false)

			ply:SetNWEntity("DronesRewriteDrone", self)
			ply:SetViewEntity(self.Camera)

			local curWep = self:GetCurrentWeapon()
			if curWep:IsValid() then 
				curWep:SetPrimaryAmmo(0)
				curWep:SetSecondaryAmmo(0)

				if curWep.Tab.Deploy then curWep.Tab.Deploy(self, curWep) end
			end

			net.Start("dronesrewrite_updcam")
			net.Send(ply)

			if not ply.DRR_PrintedStuff2 and not tobool(ply:GetInfoNum("dronesrewrite_cl_nomessage", 0)) then
				timer.Simple(1, function() 
					if IsValid(ply) then 
						net.Start("dronesrewrite_helppls2")
						net.Send(ply)
						
						ply.DRR_PrintedStuff2 = true 
					end 
				end)
			end

			self:CallHook("DriverSet", ply)
			DRONES_REWRITE.LogDebug("Driver has set")
		else
			DRONES_REWRITE.LogDebug("Driver has not set")
			ply:ChatPrint("[Drones] Ты не можешь использовать этот дрон!")

			return
		end
	elseif driver:IsValid() then
		self:CallHook("DriverExit")

		driver:SetFOV(self.OldFov or 90, 0)
		driver:AllowFlashlight(true)

		driver:SetNWEntity("DronesRewriteDrone", NULL)
		driver:SetViewEntity(driver)

		if self.PlyOldWeapon then 
			if driver:HasWeapon(self.PlyOldWeapon) then
				driver:SelectWeapon(self.PlyOldWeapon) 
			end

			self.PlyOldWeapon = nil
		end

		DRONES_REWRITE.LogDebug("Driver exited")
	end

	self:WaitWeps()
	self:DisableKeys()
	self:SetNWEntity("DronesRewriteDriver", ply)

	self:SetCamera()
end

function ENT:SetFuel(num)
	if not self.ShouldConsumeFuel or DRONES_REWRITE.ServerCVars.NoFuel:GetBool() then
		num = self.MaxFuel
	end

	self.Fuel = math.Clamp(num, 0, self.MaxFuel)
	self:SetNWInt("Fuel", math.Round(self.Fuel))
end

function ENT:ReduceFuel()
	if not self.ShouldConsumeFuel or DRONES_REWRITE.ServerCVars.NoFuel:GetBool() then return end

	local velLen = self.EnginePower * self.MoveCoefficient * 80
	self:SetFuel(self:GetFuel() - (velLen * self.FuelReduction * 0.00004 * DRONES_REWRITE.ServerCVars.FuelConsumptionCoef:GetFloat())) 
end

function ENT:SetDefaultHealth(num)
	self:SetNWInt("DefHealth", num)
end

function ENT:SetHealthAmount(num) 
	if self.Immortal or DRONES_REWRITE.ServerCVars.NoDamage:GetBool() then
		num = self:GetDefaultHealth() * DRONES_REWRITE.ServerCVars.HealthCoef:GetFloat()
	end

	self.HealthAmount = math.Clamp(num, 0, self:GetDefaultHealth() * DRONES_REWRITE.ServerCVars.HealthCoef:GetFloat())
	self:SetNWInt("Health", math.floor(self.HealthAmount))
end

function ENT:HasModule(name)
	return self.ValidModules[name] and true or false
end

-- TODO: remake module system
function ENT:AddModule(name)
	if self:HasModule(name) then return end

	for k, v in pairs(self.Modules) do
		if k:lower() == name:lower() then name = k break end
	end

	local module = self.Modules[name]
	if not module then return end

	if module.AdminOnly and not (self.Owner:IsAdmin() or DRONES_REWRITE.ServerCVars.AllowAdminModules:GetBool()) then
		return
	end

	if not DRONES_REWRITE.ServerCVars.NoSlots:GetBool() and module.Slot then
		local limit = self.Slots[module.Slot]
		if not limit then

			return 
		end

		local count = self:CountModulesInSlot(module.Slot)

		if count >= limit then
			return
		end
	end

	self.ValidModules[name] = module
	module.Initialize(self)

	if not module.System then self:SetNWBool("hasModule" .. name, true) end
	if module.Slot then self:SetNWInt("SlotCount" .. module.Slot, self:CountModulesInSlot(module.Slot)) end

	self:EmitSound("npc/turret_floor/deploy.wav", 72, 85)
	timer.Simple(0.5, function()
		if IsValid(self) then
			self:EmitSound("npc/turret_floor/click1.wav", 68, 90)
		end
	end)

	DRONES_REWRITE.LogDebug(string.format("Added upgrade %s", name))

	return true -- successful
end

function ENT:RemoveModule(name)
	for k, v in pairs(self.ValidModules) do
		if k:lower() == name:lower() then name = k break end
	end

	local module = self.ValidModules[name]
	if not module then return end

	self.ValidModules[name] = nil
	module.OnRemove(self)

	if not module.System then self:SetNWBool("hasModule" .. name, false) end

	if module.Slot then self:SetNWInt("SlotCount" .. module.Slot, self:CountModulesInSlot(module.Slot)) end

	self:EmitSound("npc/turret_floor/click1.wav", 72, 85)
	timer.Simple(0.5, function()
		if IsValid(self) then
			self:EmitSound("npc/turret_floor/deploy.wav", 68, 90)
		end
	end)

	DRONES_REWRITE.LogDebug(string.format("Removed upgrade %s", name))

	return true -- successful
end

function ENT:RemoveAllModules()
	for k, v in pairs(self.ValidModules) do
		self:RemoveModule(k)
	end
end

function ENT:AddFirstPersonCamera()
	self:DeletePart(self.Camera)

	local pos = self:LocalToWorld(self.FirstPersonCam_pos)

	self.Camera = ents.Create("base_anim")
	self.Camera:SetPos(pos)
	self.Camera:SetModel(self.CameraModel)
	self.Camera:SetAngles(self:GetAngles())
	self.Camera:Spawn()
	self.Camera:DrawShadow(false)
	self.Camera:SetParent(self)
	self.Camera:SetNotSolid(true)
	self.Camera:PhysicsDestroy()
	
	if not self.RenderCam then 
		self.Camera:SetColor(Color(0, 0, 0, 0))
		self.Camera:SetRenderMode(RENDERMODE_TRANSALPHA)
	end

	self:SetNWEntity("MainCamera", self.Camera)
	self:SetCamera()

	DRONES_REWRITE.LogDebug("Added main camera entity")
end

function ENT:AddWeapon(name, tab)
	self:DeletePart(self.ValidWeapons[name])

	local e = tab.Initialize(self)
	e.Tab = tab

	self.ValidWeapons[name] = e

	--self:EmitSound("drones/camerawep.wav", 70, 120)
	DRONES_REWRITE.LogDebug(string.format("Added %s weapon", name))

	return e
end

function ENT:FastAddWeapon(wepName, wep, pos, sync, ang, select, prims, attachment)
	if pos == nil then pos = Vector(0, 0, 0) end
	if sync == nil then sync = { } end
	if select == nil then select = true end
	if ang == nil then ang = Angle(0, 0, 0) end

	if self.Attachments then
		local a = self.Attachments[attachment]
		if a then
			if a.Pos then pos = pos + a.Pos end
			if a.Angle then ang = ang + a.Angle end
		end
	end

	if not DRONES_REWRITE.Weapons[wep] then return end

	self:AddWeapon(wepName, {
		Initialize = function(self)
			local ent = DRONES_REWRITE.Weapons[wep].Initialize(self, pos, ang)
			ent.NoSelecting = not select
			
			if prims then
				ent.SecondaryAmmoMax = ent.PrimaryAmmoMax
				ent.SecondaryAmmo = ent.PrimaryAmmo

				ent.PrimaryAmmoMax = 0
				ent.PrimaryAmmo = 0

				local tab = { }
				table.Add(tab, ent.PrimaryAmmoType)

				ent.SecondaryAmmoType = tab
				ent.PrimaryAmmoType = { }
			end

			ent.PrimaryAsSecondary = prims

			return ent
		end,

		Attack = function(self, gun)
			if DRONES_REWRITE.Weapons[wep].Attack then
				DRONES_REWRITE.Weapons[wep].Attack(self, gun)
			end

			for k, v in pairs(sync) do
				if v.fire1 == "fire1" then
					self:Attack1(k)
				end

				if v.fire2 == "fire1" then
					self:Attack2(k)
				end
			end
		end,

		Attack2 = function(self, gun) 
			if DRONES_REWRITE.Weapons[wep].Attack2 then
				DRONES_REWRITE.Weapons[wep].Attack2(self, gun)
			end

			for k, v in pairs(sync) do
				if v.fire1 == "fire2" then
					self:Attack1(k)
				end

				if v.fire2 == "fire2" then
					self:Attack2(k)
				end
			end
		end,

		Think = function(self, gun) 
			if DRONES_REWRITE.Weapons[wep].Think then
				DRONES_REWRITE.Weapons[wep].Think(self, gun) 
			end
		end,

		OnAttackStopped = function(self, gun)
			if DRONES_REWRITE.Weapons[wep].OnAttackStopped then
				DRONES_REWRITE.Weapons[wep].OnAttackStopped(self, gun)
			end

			for k, v in pairs(sync) do
				if v.fire1 == "fire1" then
					self:OnAttackStopped(k)
				end

				if v.fire2 == "fire1" then
					self:OnAttackStopped2(k)
				end
			end
		end,

		OnAttackStopped2 = function(self, gun)
			if DRONES_REWRITE.Weapons[wep].OnAttackStopped2 then
				DRONES_REWRITE.Weapons[wep].OnAttackStopped2(self, gun)
			end

			for k, v in pairs(sync) do
				if v.fire1 == "fire2" then
					self:OnAttackStopped(k)
				end

				if v.fire2 == "fire2" then
					self:OnAttackStopped2(k)
				end
			end
		end,

		OnPrimaryAdded = function(self, gun, num)
			if DRONES_REWRITE.Weapons[wep].OnPrimaryAdded then
				DRONES_REWRITE.Weapons[wep].OnPrimaryAdded(self, gun, num)
			end
		end,

		OnSecondaryAdded = function(self, gun, num)
			if DRONES_REWRITE.Weapons[wep].OnSecondaryAdded then
				DRONES_REWRITE.Weapons[wep].OnSecondaryAdded(self, gun, num)
			end
		end,

		Holster = function(self, gun)
			if DRONES_REWRITE.Weapons[wep].Holster then
				DRONES_REWRITE.Weapons[wep].Holster(self, gun)
			end
		end,

		OnRemove = function(self, gun)
			if DRONES_REWRITE.Weapons[wep].OnRemove then
				DRONES_REWRITE.Weapons[wep].OnRemove(self, gun)
			end
		end,

		Deploy = function(self, gun)
			if DRONES_REWRITE.Weapons[wep].Deploy then
				DRONES_REWRITE.Weapons[wep].Deploy(self, gun)
			end
		end
	})
end

function ENT:RemoveWeapon(name)
	for k, v in pairs(self.ValidWeapons) do
		if k:lower() == name:lower() then name = k break end
	end

	local wep = self.ValidWeapons[name]

	if wep and wep:IsValid() then
		if wep.Handler then
			SafeRemoveEntity(wep.Handler)
		end

		if wep.Tab.OnRemove then wep.Tab.OnRemove(self, wep) end
	end

	self:DeletePart(wep)
	self.ValidWeapons[name] = nil

	self:SelectNextWeapon()

	DRONES_REWRITE.LogDebug(string.format("Removed weapon %s", name))
end

function ENT:RemoveWeapons()
	for k, v in pairs(self.ValidWeapons) do
		self:RemoveWeapon(k)
	end
end

function ENT:AddWeapons()
	self:DeletePart(self.ValidWeapons)

	self.CurrentWeapon = nil
	self.ValidWeapons = { }

	if not self.Weapons then return end

	for k, v in pairs(self.Weapons) do
		self:FastAddWeapon(k, v.Name, v.Pos, v.Sync, v.Angle, v.Select, v.PrimaryAsSecondary, v.Attachment)
	end
end

function ENT:SelectNextWeapon(name)
	local oldWep = self.ValidWeapons[self.CurrentWeapon]

	if name then
		self.CurrentWeapon = name
	else
		if IsValid(oldWep) then 
			local k, v = next(self.ValidWeapons, self.CurrentWeapon)
			self.CurrentWeapon = k
		else
			for k, v in pairs(self.ValidWeapons) do self.CurrentWeapon = k break end
		end
	end

	self:WaitWeps()

	local curWep = self.ValidWeapons[self.CurrentWeapon]
	if not curWep then return end

	curWep:SetPrimaryAmmo(0)
	curWep:SetSecondaryAmmo(0)

	if curWep == oldWep then return end

	if curWep.NoSelecting then
		self:SelectNextWeapon()
		return
	end

	if IsValid(oldWep) and oldWep.Tab.Holster then oldWep.Tab.Holster(self, oldWep) end
	if curWep.Tab.Deploy then curWep.Tab.Deploy(self, curWep) end

	-- Playing nice sound
	local driver = self:GetDriver()
	if driver:IsValid() then
		net.Start("dronesrewrite_playsound")
			net.WriteString("physics/metal/weapon_impact_soft2.wav")
		net.Send(driver)
	end

	-- For menu
	local i = 1
	for k, v in pairs(self.ValidWeapons) do
		if v.NoSelecting then continue end
		if k == self.CurrentWeapon then break end
		i = i + 1
	end

	self:SetNWInt("CurrentWeapon_sel", i)
	self:SetNWString("CurrentWeapon", self.CurrentWeapon)
end

--[[function ENT:SelectPreviousWeapon()
	local curWep = self.ValidWeapons[self.CurrentWeapon]

	while curWep !=
end
]]
function ENT:GetCurrentWeapon()
	return self.ValidWeapons[self.CurrentWeapon] or NULL
end

function ENT:Attack1(wep)
	wep = wep or self.CurrentWeapon

	if self:IsDroneWorkable() then
		local gun = self.ValidWeapons[wep]
		if gun and gun:IsValid() and CurTime() > gun.InstantWait then 
			gun.Tab.Attack(self, gun) 

			if not gun:HasPrimaryAmmo() then
				if not gun.WaitForEmpty then gun.WaitForEmpty = 0 end 

				if CurTime() > gun.WaitForEmpty then 
					gun:EmitSound("weapons/pistol/pistol_empty.wav", 55) 
					gun.WaitForEmpty = CurTime() + 0.1
				end
			end
		end
	end
end

function ENT:Attack2(wep) 
	wep = wep or self.CurrentWeapon
	
	if self:IsDroneWorkable() then
		local gun = self.ValidWeapons[wep]
		if gun and gun:IsValid() and CurTime() > gun.InstantWait then 
			gun.Tab.Attack2(self, gun) 
		end
	end
end

function ENT:OnAttackStopped(wep)
	wep = wep or self.CurrentWeapon

	local gun = self.ValidWeapons[wep]
	if gun and gun:IsValid() and gun.Tab.OnAttackStopped then 
		gun.Tab.OnAttackStopped(self, gun) 
	end
end

function ENT:OnAttackStopped2(wep)
	wep = wep or self.CurrentWeapon

	local gun = self.ValidWeapons[wep]
	if gun and gun:IsValid() and gun.Tab.OnAttackStopped2 then 
		gun.Tab.OnAttackStopped2(self, gun) 
	end
end

function ENT:AddPropellers()
	self:DeletePart(self.ValidPropellers)

	self.ValidPropellers = { }

	if not self.Propellers then return end

	for k, v in pairs(self.Propellers.Info) do
		local e = ents.Create("base_anim")
		e:SetModel(self.Propellers.Model)
		e:SetPos(self:LocalToWorld(v))
		e:SetAngles(self:GetAngles())
		e:Spawn()
		e:Activate()
		e:SetParent(self)
		e:SetNotSolid(true)
		e:PhysicsDestroy()

		if self.NoPropellers then e:SetNoDraw(true) end
		
		e.HealthAmount = self.Propellers.Health
		e:SetNWInt("HealthAmount", e.HealthAmount)

		if self.Propellers.Scale then 
			e:SetModelScale(self.Propellers.Scale, 0) 
		end

		if self.Propellers.InfoScale then
			if self.Propellers.InfoScale[k] then
				e:SetModelScale(self.Propellers.InfoScale[k], 0)
			end
		end

		if self.Propellers.InfoModel then
			if self.Propellers.InfoModel[k] then
				e:SetModel(self.Propellers.InfoModel[k])
			end
		end

		self:SetNWEntity("PropellerNum_" .. k, e)
		self.ValidPropellers[k] = e
	end

	self:SetNWInt("NumPropellers", table.Count(self.ValidPropellers))
	self.MoveCoefficient = self:ForceCoefficient()

	DRONES_REWRITE.LogDebug("Added propellers")
end

function ENT:DropPropeller(index)
	local v = self.ValidPropellers[index]
	if not IsValid(v) then return end

	local snd = self.Propellers.RandomLoseSounds and table.Random(self.Propellers.RandomLoseSounds) or "physics/metal/metal_solid_impact_hard1.wav"
	v:EmitSound(snd, self.Propellers.LoseLevel or 70, self.Propellers.LosePitch or 100)

	local fake = ents.Create("prop_physics")
	fake:SetPos(v:GetPos())
	fake:SetAngles(v:GetAngles())
	fake:SetModel(v:GetModel())
	fake:Spawn()
	fake:Activate()
	fake.IsDestroyed = true

	local vec = VectorRand()
	fake:GetPhysicsObject():ApplyForceCenter(vec * 400)
	fake:GetPhysicsObject():AddAngleVelocity(vec * 1337)

	self.ValidPropellers[index] = fake

	SafeRemoveEntity(v)

	self:SetNWInt("NumPropellers", self:GetNWInt("NumPropellers") - 1)
	self.MoveCoefficient = self:ForceCoefficient()

	self:CallHook("PropellerDestroyed")
end

function ENT:DropPropellers()
	for k, v in pairs(self.ValidPropellers) do
		self:DropPropeller(k)
	end
end

-- Makes NPCs hate a drone
function ENT:AddNpcTriggers()
	self:DeletePart(self.ValidNpcTriggers)

	self.ValidNpcTriggers = { }

	local vectors = { }
	vectors[1] = Vector(0, 0, self:OBBMaxs().z)
	vectors[2] = Vector(0, 0, self:OBBMins().z)

	vectors[3] = Vector(self:OBBMins().x, self:OBBCenter().y, self:OBBCenter().z)
	vectors[4] = Vector(-self:OBBMins().x, self:OBBCenter().y, self:OBBCenter().z)

	vectors[5] = Vector(self:OBBCenter().x, self:OBBMins().y, self:OBBCenter().z)
	vectors[6] = Vector(self:OBBCenter().x, -self:OBBMins().y, self:OBBCenter().z)

	for k, v in pairs(vectors) do
		local e = ents.Create("npc_bullseye")
		e:SetPos(self:LocalToWorld(v))
		e:Spawn()
		e:Activate()
		e:SetParent(self)
		e:SetNotSolid(true)

		self.ValidNpcTriggers[k] = e
	end
end

function ENT:AddLegs()
	self:DeletePart(self.ValidLegs)

	self.ValidLegs = { }

	if not self.Legs then return end

	for k, v in pairs(self.Legs) do
		local mdl = ents.Create("base_anim")
		mdl:SetModel(v.model)
		mdl:SetPos(self:GetPos())
		mdl:SetAngles(self:GetAngles())
		mdl:SetParent(self)
		mdl:SetNotSolid(true)
		mdl:PhysicsDestroy()

		self.ValidLegs[k] = mdl
	end
end

function ENT:InitCounts()
	for k, v in pairs(self.Slots) do
		self:SetNWInt("SlotCount" .. k, 0)
	end
end

function ENT:SetupOwner(ply)
	self.Owner = ply
end

function ENT:SpawnFunction(ply, tr, class)
	if not tr.Hit then return end

	local pos = tr.HitPos + tr.HitNormal * (self.SpawnHeight and self.SpawnHeight or 32)

	local ent = ents.Create(class)
	ent:SetupOwner(ply)
	ent:SetPos(pos)
	ent:SetAngles(Angle(0, (ply:GetPos() - tr.HitPos):Angle().y+180, 0))
	ent:Spawn()
	ent:Activate()

	if not ply.DRR_PrintedStuff1 and not tobool(ply:GetInfoNum("dronesrewrite_cl_nomessage", 0)) then
		timer.Simple(1, function() 
			if IsValid(ply) then 
				net.Start("dronesrewrite_helppls")
				net.Send(ply)
				
				ply.DRR_PrintedStuff1 = true 
			end 
		end)
	end

	if not IsValid(ent.Owner) then ent.Owner = ply end -- ?????????????????

	return ent
end

function ENT:SwitchLoopSound(name, n, string, pitch, volume, lvl)
	if not self.LoopSounds then self.LoopSounds = { } end

	if n then
		if not self.LoopSounds[name] then
			pitch = pitch or 100
			volume = volume or 0.4
			lvl = lvl or 75
			
			self.LoopSounds[name] = CreateSound(self, string)
			self.LoopSounds[name]:SetSoundLevel(lvl)
			self.LoopSounds[name]:Play()
			self.LoopSounds[name]:ChangePitch(pitch)
			self.LoopSounds[name]:ChangeVolume(volume)
			self.LoopSounds[name]:SetSoundLevel(lvl)
		end
	else
		if self.LoopSounds[name] then
			self.LoopSounds[name]:Stop()
			self.LoopSounds[name] = nil
		end
	end
end

function ENT:StopLoopSounds()
	if self.LoopSounds then
		for k, v in pairs(self.LoopSounds) do
			self:SwitchLoopSound(k, false)
		end
	end
end

function ENT:Initialize()
	self:SetEnabled(not DRONES_REWRITE.ServerCVars.SpawnAsDisabled:GetBool())

	self.Entity:SetModel(self.Model)
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetUseType(SIMPLE_USE)

	self.Physics = self.Entity:GetPhysicsObject()
	self.Physics:SetMass(self.Weight)
	self.Physics:Wake()

	self.CamAngles = self.Entity:GetAngles()
	self.Keys = { }
	self.ValidModules = { }
	self.Buffer = { } -- For stuff and shit
	self.DRONES_REWRITE_DELTA = 0
	self.DRRFriendsControlling = { }

	self.PropellersValue = 0

	if DRONES_REWRITE.ServerCVars.NoWeps:GetBool() then 
		self.AddWeapon = function() end
		self.FastAddWeapon = function() end
		self.AddWeapons = function() end

		self.ValidWeapons = { }
	end

	self:AddFirstPersonCamera()
	self:AddPropellers()
	self:AddWeapons()
	self:AddNpcTriggers()
	self:AddLegs() -- TODO: delete
	self:InitCounts()

	if DRONES_REWRITE.ServerCVars.EmptyFuel:GetBool() then
		self:SetFuel(0)
	else
		self:SetFuel(self.MaxFuel)
	end
	
	self:SetDefaultHealth(self.DefaultHealth * DRONES_REWRITE.ServerCVars.HealthCoef:GetFloat())
	self:SetHealthAmount(self.DefaultHealth * DRONES_REWRITE.ServerCVars.HealthCoef:GetFloat())

	self.EnginePower = self:IsDroneWorkable() and self:CalculateFlyConstant() or 0

	self:SelectNextWeapon()

	self:StartMotionController()


	local owner = self
        if IsValid(owner.bomb) then return end

        -- local tr = {}
        -- tr.start = owner:GetAttachment(owner:LookupAttachment("eyes")).Pos
        -- local dir = Vector(1,0,0)
        -- dir:Rotate(owner:EyeAngles())
        -- tr.endpos = tr.start + dir * 75
        -- tr.filter = owner
        
        self:GetOwner().gg = true
        ent = self
        owner = ent
        self:GetOwner().bomb = owner
        ent.parentBomb = self
        ent.owner = self:GetOwner()
        -- ent:CallOnRemove("homigrad-bomb",Bomb)
        -- ent:EmitSound("buttons/button24.wav",75,50)
        -- self:SetNWBool("hasbomb",true)

end

function ENT:Use(activator, caller)
	if CurTime() < self.NextAction then return end
	if not activator:IsPlayer() then return end

	self:SetDriver(activator)
	self.NextAction = CurTime() + 0.3 
end

function ENT:PhysicsSimulate(phys, dt)
	-- REMAKE OF PHYSICS
	-- THIS PEACE OF CODE REALLY SUCKS

	local force = Vector(0, 0, 0)
	local angForce = Vector(0, 0, 0)

	if self.DrrBaseType == "base" then
		local value = self:IsDroneWorkable() and self:CalculateFlyConstant() or 0
		local change = self:IsDroneWorkable() and 0.1 or 0.01
		self.EnginePower = math.Approach(self.EnginePower, value, self:CalculateFlyConstant() * change)

		if not self:IsDroneDestroyed() and self.EnginePower > 0 and self:HasPropellers() then
			local vel = phys:GetVelocity()
			local velLen = vel:Length()
			local angVel = phys:GetAngleVelocity()
			local ang = phys:GetAngles()
			local up = self:GetUp()

			for k, v in pairs(self.ValidPropellers) do
				if v:IsValid() and not v.IsDestroyed then
					local angp = math.NormalizeAngle(ang.p)
					local angr = math.NormalizeAngle(ang.r)

					angForce = angForce - Vector(angr, 0, 0) * 0.1 * self.AlignmentRoll - 
											Vector(0, angp, 0) * 0.1 * self.AlignmentPitch - 
											Vector(angr, angp, 0) * 0.1 * self.Alignment

					force = force + (self:GetUp() * self.EnginePower) / 2 + (vector_up * self.EnginePower) / 2
				else
					phys:ApplyForceOffset(-self:GetUp() * dt * 400, self:LocalToWorld(self.Propellers.Info[k]))
				end
			end

			if not DRONES_REWRITE.ServerCVars.NoNoise:GetBool() then
				local x = CurTime() * 2
				local sin, cos = math.sin(x) * math.Rand(0.2, 0.3), math.cos(x) * math.Rand(0.2, 0.3)

				if not self.RandomNoiseValue then self.RandomNoiseValue = math.random(-1, 1) end
				if self.RandomNoiseValue == 0 then self.RandomNoiseValue = 1 end -- ???

				local vec = Vector(cos, sin, (cos+sin) * math.Rand(-0.5, 1)) + VectorRand() * 0.2
				vec = vec * self.RandomNoiseValue

				force = force + vec * self.NoiseCoefficient + vec * self.NoiseCoefficientPos * 0.01
				angForce = angForce + vec * self.NoiseCoefficient + vec * self.NoiseCoefficientAng
			end

			if not DRONES_REWRITE.ServerCVars.NoFlyCor:GetBool() and self.IsMoving then
				force = force + vector_up * velLen * math.abs(ang.p) * 0.000825
			end

			force = force - vel * self.Damping * 0.035

			angVel.z = angVel.z * 0.9
			angForce = angForce - angVel * 0.05 * self.AngDamping -
									Vector(angVel.x * self.AngRollDamping, 
									angVel.y * self.AngPitchDamping, 
									angVel.z * self.AngYawDamping) * 0.05

			self:ReduceFuel()
		end
	elseif self.DrrBaseType == "walker" then
		local value = (self:IsDroneWorkable() and (self.IsMoving or self.IsRotating)) and self:CalculateFlyConstant() or 0
		local change = self:IsDroneWorkable() and 0.1 or 0.01
		self.EnginePower = math.Approach(self.EnginePower, value, self:CalculateFlyConstant() * change)

		if self:IsDroneWorkable() then
			local vel = phys:GetVelocity()
			local velLen = vel:Length()
			local angVel = phys:GetAngleVelocity()
			local mass = phys:GetMass()
			local up = self:GetUp()
			local ang = self:GetAngles()

			self.isDroneOnGround = false

			if not self.Dists then self.Dists = { } end

			if not self.UseSpiderPhysics then
				local tab = { }
				table.insert(tab, self)
				for k, v in pairs(player.GetAll()) do table.insert(tab, v) end
				for k, v in pairs(ents.FindByClass("npc_*")) do table.insert(tab, v) end

				for k, v in pairs(self.Corners) do
					local corner = self:LocalToWorld(v)

					-- Upforce
					local tr = util.TraceLine({
						start = corner,
						endpos = corner - up * self.Hover,
						filter = tab
					})

					local Dist = math.max(0, corner:Distance(tr.HitPos))
					local Delta = Dist - (self.Dists[k] or 0)

					if tr.Hit then 
						phys:ApplyForceOffset(up * (self.Hover - (Dist + Delta * 8)) * mass * 0.2, corner) 
						force = force - Vector(vel.x, vel.y, 0) * self.Slip * 0.00025
						angForce = angForce - angVel * self.AngSlip

					    self.isDroneOnGround = true 
					end

					self.Dists[k] = Dist
				end
			else
				local count = #self.Corners

				for k, v in pairs(self.Corners) do
					local corner = self:LocalToWorld(v)

					local tr = util.TraceLine({
						start = corner,
						endpos = corner - up * self.Hover,
						filter = self
					})

					if tr.HitSky then continue end

					local Dist = math.max(0, corner:Distance(tr.HitPos))
					local Delta = Dist - (self.Dists[k] or 0)

					phys:ApplyForceOffset(-up * mass * (Dist - self.Hover * 0.5 + Delta * 5) / count, corner)

					if tr.Hit then 
						angForce = angForce - angVel * self.AngSlip
						force = force - vel * 0.6 / count

					    self.isDroneOnGround = true 
					end

					self.Dists[k] = Dist
				end

				phys:EnableGravity(not self:IsDroneOnGround())
			end

			if (self.IsMoving or self.IsRotating or velLen > 60 or angVel:Length() > 20) and self:IsDroneOnGround() then
				if not DRONES_REWRITE.ServerCVars.NoNoise:GetBool() then
					local vec = VectorRand()

					force = force + vec * self.NoiseCoefficient + vec * self.NoiseCoefficientPos
					angForce = angForce + vec * self.NoiseCoefficient + vec * self.NoiseCoefficientAng
				end

				if not self.DoFootStepSound and (self.IsMoving or self.IsRotating) then
					timer.Simple(self.WaitForSound, function() 
						if IsValid(self) then
							if self.IsMoving or self.IsRotating then
								local pitch = self.Sounds.FootSound.Pitch
								
								if self.Sounds.FootSound.PitchMin or self.Sounds.FootSound.PitchMax then
									pitch = math.random(self.Sounds.FootSound.PitchMin, self.Sounds.FootSound.PitchMax)
								end

								self:EmitSound(table.Random(self.Sounds.FootSound.Sounds), self.Sounds.FootSound.Volume, pitch)
								self:CallHook("FootSound")
							end
							
							self.DoFootStepSound = false
						end
					end)

					self.DoFootStepSound = true
				end
			end

			self:ReduceFuel()
		elseif self.UseSpiderPhysics and self.isDroneOnGround then
			self.isDroneOnGround = false
			phys:EnableGravity(true)
		end
	elseif self.DrrBaseType == "underwater" then
		local value = (self:IsDroneWorkable() and (self.IsMoving or self.IsRotating)) and self:CalculateFlyConstant() or 0
		local change = self:IsDroneWorkable() and 0.1 or 0.01
		self.EnginePower = math.Approach(self.EnginePower, value, self:CalculateFlyConstant() * change)
		
		if self:IsDroneWorkable() and self:WaterLevel() >= 3 then
			local vel = phys:GetVelocity()
			local angVel = phys:GetAngleVelocity()
			local velLen = vel:Length()
			local ang = phys:GetAngles()

			local angp = math.NormalizeAngle(ang.p)
			local angr = math.NormalizeAngle(ang.r)

			angForce = angForce - Vector(angr, 0, 0) * 0.1 * self.AlignmentRoll - 
									Vector(0, angp, 0) * 0.1 * self.AlignmentPitch - 
									Vector(angr, angp, 0) * 0.1 * self.Alignment

			force = force + vector_up * 5.675
			force = force - vel / 25

			angVel.z = angVel.z * 0.9
			angForce = angForce - angVel * 0.08

			if not DRONES_REWRITE.ServerCVars.NoFlyCor:GetBool() and self.IsMoving then
				force = force + vector_up * velLen * math.abs(ang.p) * 0.00075
			end

			self:ReduceFuel()
		end
	end

	self.DRONES_REWRITE_DELTA = dt * 90-- * FrameTime() * 6000

	force = force * dt * 4290
	angForce = angForce * dt * 4290

	self:CallHook("Physics", phys)
	self:ControlsPhys()

	return angForce, force, SIM_GLOBAL_ACCELERATION 
end

function ENT:Think()
	if not self.DRONES_REWRITE_DELTA then self.DRONES_REWRITE_DELTA = 0 end

	if self.DrrBaseType != "underwater" and self:WaterLevel() >= 3 and self.Enabled and self.DisableInWater and not DRONES_REWRITE.ServerCVars.AllowWater:GetBool() then 
		self:SetEnabled(false)
	end

	if self.LoopSounds and self.LoopSounds["Rotor"] and not self.Sounds.PropellerSound.NoPitchChanges then 
		local pitch = self.Sounds.PropellerSound.PitchCoef or 0.3
		self.LoopSounds["Rotor"]:ChangePitch(math.Clamp(self.Sounds.PropellerSound.Pitch + self:GetVelocity():Length() * pitch, 0, 250)) 
	end

	for k, v in pairs(self.ValidModules) do
		v.Think(self)
	end

	for k, v in pairs(self.ValidWeapons) do
		if v.Tab.Think then v.Tab.Think(self, v) end

		if DRONES_REWRITE.ServerCVars.NoWaiting:GetBool() then
			v.NextShoot = 0
			v.NextShoot2 = 0
		end
	end

	if self:IsDroneWorkable() and not DRONES_REWRITE.ServerCVars.NoHitPropellers:GetBool() and not self.NoPropellers and self:GetCollisionGroup() != COLLISION_GROUP_WORLD then
		if not self.PropellerHitWait then self.PropellerHitWait = 0 end

		if CurTime() > self.PropellerHitWait then
			self.PropellerHitWait = CurTime() + math.Rand(0.06, 0.15)

			for k, v in pairs(self.ValidPropellers) do
				if v:IsValid() and not v.IsDestroyed then
					for i = 1, 360, 10 do
						local vec = (self:GetRight() * math.sin(i) * self.Propellers.HitRange) + (self:GetForward() * math.cos(i) * self.Propellers.HitRange)
						local tr = util.TraceLine({
							start = v:GetPos(),
							endpos = v:GetPos() + vec,
							filter = { self, v } 
						})

						if tr.Hit then
							local ent = tr.Entity

							if IsValid(ent) then
								if ent:IsPlayer() and ent:GetMoveType() == MOVETYPE_NOCLIP then continue end
								if ent:GetCollisionGroup() == COLLISION_GROUP_WORLD then continue end

								ent:TakeDamage(self.Propellers.Damage, self, v)

								local unfreeze = self.Propellers.UnFreeze
								local force = self.Propellers.Force
								if unfreeze or force then
									local phys = ent:GetPhysicsObject()
									if force then
										phys:ApplyForceCenter(VectorRand() * phys:GetMass() * self.Propellers.ForceVal)
										phys:AddAngleVelocity(VectorRand() * self.Propellers.ForceVal)
									end

									if unfreeze then
										phys:EnableMotion(true)
									end
								end
							end

							local snd = self.Propellers.RandomHitSounds and table.Random(self.Propellers.RandomHitSounds) or "physics/metal/metal_box_impact_bullet1.wav"
							v:EmitSound(snd, self.Propellers.HitLevel or 70, self.Propellers.HitPitch or 100)

							if not self:IsDroneImmortal() and not self.Propellers.Immortal then
								local phys = self:GetPhysicsObject()
								local velLen = phys:GetVelocity():Length()
								local force = math.Clamp(velLen * 1.2, 0, 100)

								phys:ApplyForceCenter(tr.HitNormal * phys:GetMass() * force * 0.5)
								phys:AddAngleVelocity(VectorRand() * phys:GetMass() * 0.03)

								v.HealthAmount = v.HealthAmount - 1
								v:SetNWInt("HealthAmount", v.HealthAmount)

								if v.HealthAmount <= 0 then
									self:DropPropeller(k)
								end

								self:CallHook("PropellerCollide", v)
							end

							break
						end
					end
				end
			end
		end
	end

	for k, v in pairs(self.ValidPropellers) do
		if v:IsValid() and not v.IsDestroyed then
			local ang = self:GetAngles()

			if self.Propellers.InfoAng and self.Propellers.InfoAng[k] then
				ang:RotateAroundAxis(ang:Forward(), self.Propellers.InfoAng[k].r)
				ang:RotateAroundAxis(ang:Right(), self.Propellers.InfoAng[k].p)
			end

			if not v.NewAngle then v.NewAngle = 0 end
			v.NewAngle = v.NewAngle + (10 * self.EnginePower) * FrameTime() * 70

			ang:RotateAroundAxis(ang:Up(), v.NewAngle)
			v:SetAngles(ang)
		end
	end

	if CurTime() > self.WaitNPCS then
		for k, trigger in pairs(self.ValidNpcTriggers) do
			if trigger:IsValid() then
				trigger:SetHealth(10000)

				for _, v in pairs(ents.FindByClass("npc_*")) do
					if v:IsNPC() then 
						if v.AddEntityRelationship then
							local statement = self:IsEnemy(v:GetClass()) and D_HT or D_LI
							v:AddEntityRelationship(trigger, statement, 99)
						end
					end
				end
			else
				self:AddNpcTriggers()
			end
		end

		self.WaitNPCS = CurTime() + 0.1
	end

	local driver = self:GetDriver()

	if driver:IsValid() then
		if not driver:Alive() then self:SetDriver(NULL) end

		-- Calculating angles SERVER-SIDE
		-- Without net
		local eang = driver:EyeAngles()

		local vehicle = driver:GetVehicle()
		if vehicle:IsValid() then eang = vehicle:WorldToLocalAngles(driver:EyeAngles()) end

		if not DRONES_REWRITE.ServerCVars.NoCameraRestrictions:GetBool() then 
			if DRONES_REWRITE.ServerCVars.StaticCam:GetBool() then
				local ang = self:GetAngles()
				ang.y = eang.y + math.AngleDifference(ang.y, eang.y)

				if self.AllowPitchRestrictions then
					if eang.p < ang.p + self.PitchMin then eang.p = ang.p + self.PitchMin end
					if eang.p > ang.p + self.PitchMax then eang.p = ang.p + self.PitchMax end
				end

				if self.AllowYawRestrictions then
					if eang.y < ang.y + self.YawMin then eang.y = ang.y + self.YawMin end
					if eang.y > ang.y + self.YawMax then eang.y = ang.y + self.YawMax end
				end
			else
				if self.AllowPitchRestrictions then
					if eang.p < self.PitchMin then eang.p = self.PitchMin end
					if eang.p > self.PitchMax then eang.p = self.PitchMax end
				end

				if self.AllowYawRestrictions then
					if eang.y < self.YawMin then eang.y = self.YawMin end
					if eang.y > self.YawMax then eang.y = self.YawMax end
				end
			end
		end

		local ang
		
		if self.SimplestCamera or DRONES_REWRITE.ServerCVars.StaticCam:GetBool() then
			ang = eang
		else
			ang = self:LocalToWorldAngles(eang)
		end

		if DRONES_REWRITE.ServerCVars.NoInterpolation:GetBool() then
			self.CamAngles = ang
		else
			self.CamAngles = LerpAngle(0.3, self.CamAngles, ang)
		end

		if tobool(driver:GetInfoNum("dronesrewrite_cl_mouserotation", 0)) then
			local val = driver:GetInfo("dronesrewrite_cl_mouselimit", 16)
			local min, max = math.max(-val, self.YawMin), math.min(val, self.YawMax)

			self:ControlMotion("Right", "Left", driver:EyeAngles().y, min, max)
		end

		local weapon = driver:GetActiveWeapon()
		if weapon:IsValid() then
			weapon:SetNextPrimaryFire(CurTime() + 0.8)
			weapon:SetNextSecondaryFire(CurTime() + 0.8)
		end

		if IsValid(self.Transmitter) then
			if self.Transmitter.DRR_NotWorkableTransmitter or (driver != self.Transmitter and driver:GetPos():Distance(self.Transmitter:GetPos()) > 120) then
				self:SetDriver(NULL)
			end

			if self:IsFarFarAway(self.Transmitter, self.MaxDistance) then
				driver:ChatPrint("[Drones] Signal lost! Maximum distance (" .. math.Round(self.MaxDistance * DRONES_REWRITE.ServerCVars.SignalCoef:GetFloat()) .. ") reached! To increase distance use controller or console")
				self:CallHook("SignalLost")
				self:SetDriver(NULL)
			end
		else
			self:SetDriver(NULL)
		end
	elseif not self.AI_installed then
		self.CamAngles = self.Camera:GetAngles()
	end

	if self.Camera:IsValid() and self:IsDroneWorkable() then self.Camera:SetAngles(self.CamAngles) end

	if self:IsDroneWorkable() and self:HasPropellers() and not DRONES_REWRITE.ServerCVars.NoLoopSound:GetBool() and self.PlayLoop then 
		local snd = self.Sounds.PropellerSound

		if snd then
			local pitch = snd.Pitch or 100
			local lvl = snd.Level or 75
			local volume = snd.Volume or 1

			self:SwitchLoopSound("Rotor", true, snd.Name, pitch, volume, lvl) 
			--self.LoopSounds["Rotor"]:ChangeVolume(0, 0)
			self.LoopSounds["Rotor"]:ChangeVolume(1, 12)
		end
	else 
		self:SwitchLoopSound("Rotor", false) 
	end

	if self:IsDroneWorkable() then
		if self.StopKeysFix then self.StopKeysFix = false end
	else
		if not self.StopKeysFix then
			self:DisableKeys()
			self.StopKeysFix = true
		end
	end

	if IsValid(self.Physics) then self.Physics:Wake() end

	self:CallHook("Think")
	self:Controls()

	--[[if DRONES_REWRITE.ServerCVars.UseUpdateRate:GetBool() then
		self:NextThink(CurTime() + DRONES_REWRITE.ServerCVars.UpdateRate:GetFloat())
		return true
	end]]

	self:NextThink(CurTime())
	return true
end

    --local cyka = {}


function ENT:OnTakeDamage(dmg)
	if self:IsDroneImmortal() then return end


	print("Damage da")



	self:TakePhysicsDamage(dmg)
	if self:IsDroneDestroyed() then return end

	local dmgAmount = dmg:GetDamage()
	if dmgAmount < self.DamageThreshold then return end

	self:SetHealthAmount(self:GetHealth() - dmgAmount)

	-- If after taking damage drone has been destroyed
	if self:IsDroneDestroyed() then
		local snd = self.Sounds.ExplosionSound
		if snd then 
			local lvl = snd.Level or 75
			local pitch = snd.Pitch or 100
			
			self:EmitSound(snd.Name, lvl, pitch) 
		end

		local vec = VectorRand()
		vec.z = math.abs(vec.z) + 0.1

		self:GetPhysicsObject():ApplyForceCenter(vec * self:GetPhysicsObject():GetMass() * self.ExplosionForce) 
		self:GetPhysicsObject():AddAngleVelocity(vec * self:GetPhysicsObject():GetMass() * self.ExplosionAngForce)

		if self.DoExplosionEffect then
			-- For pcf
			if isstring(self.DoExplosionEffect) then
				ParticleEffect(self.DoExplosionEffect, self:GetPos(), Angle(0, 0, 0))
			else
				ParticleEffect("splode_drone_main", self:GetPos(), Angle(0, 0, 0))
			end
		end

		self:RemoveAllModules()
		self:SetDriver(NULL)

		self:CallHook("DroneDestroyed")

		if DRONES_REWRITE.ServerCVars.RemoveOnDestroyed:GetBool() then
			SafeRemoveEntity(self)
		end
	end

	print("damage".. dmgAmount)

	if dmgAmount > 2.5 then
		self:GetOwner().gg = true
        ent = self
        owner = ent
        self:GetOwner().bomb = owner
        ent.parentBomb = self
        ent.owner = self:GetOwner()
        ent = self
        Bomb(ent)
        ent:EmitSound("buttons/button24.wav",75,50)
	end

	self:CallHook("TakeDamage", dmg, dmg:GetAttacker())
end

function ENT:PhysicsCollide(data, phys)
	if data.DeltaTime > 0.4 then
		if not DRONES_REWRITE.ServerCVars.NoAmmo:GetBool() and self:IsDroneWorkable() then
			DRONES_REWRITE.LogDebug("Trying to add ammo...")

			local ammo = data.HitEntity

			if IsValid(ammo) and ammo.IS_DRR_AMMO then
				DRONES_REWRITE.LogDebug("Found valid ammo...")

				local amount = ammo:GetAmount()

				for k, v in pairs(self.ValidWeapons) do
					if table.HasValue(v.PrimaryAmmoType, ammo:GetClass()) then
						local deal = amount

						local curammo = v:GetPrimaryAmmo()
						local max = v:GetPrimaryMax()
						
						if (curammo + deal) >= max then
							deal = max - curammo
						end

						deal = math.max(0, deal)

						v:SetPrimaryAmmo(deal, ammo:GetClass())
						ammo:TakeAmount(deal)
						ammo:OnTouched()

						if deal > 0 then 
							DRONES_REWRITE.LogDebug(string.format("Added %i %s ammo", deal, ammo.PrintName))
							self:EmitSound("items/ammo_pickup.wav") 
							break 
						end
					end

					if table.HasValue(v.SecondaryAmmoType, ammo:GetClass()) then
						local deal = amount

						local curammo = v:GetSecondaryAmmo()
						local max = v:GetSecondaryMax()
						
						if (curammo + deal) >= max then
							deal = max - curammo
						end

						deal = math.max(0, deal)

						v:SetSecondaryAmmo(deal, ammo:GetClass())
						ammo:TakeAmount(deal)
						ammo:OnTouched()

						if deal > 0 then 
							DRONES_REWRITE.LogDebug(string.format("Added %i %s ammo", deal, ammo.PrintName))
							self:EmitSound("items/ammo_pickup.wav") 
							break 
						end
					end
				end
			end
		end
		
		if data.Speed > 200 and not DRONES_REWRITE.ServerCVars.NoPhysDmg:GetBool() then 
			self:TakeDamage(math.Clamp(data.Speed * 0.005, 0, 50))
			self:EmitSound("physics/metal/metal_computer_impact_hard" .. math.random(1, 3) .. ".wav", 75, 70)
		end
	end

	self:CallHook("Collide", data, phys)
end

function ENT:OnRemove()
	self:SetDriver(NULL)

	self:DeletePart(self.ValidNpcTriggers)
	self:DeletePart(self.ValidPropellers)
	self:DeletePart(self.Camera)
	self:DeletePart(self.ValidLegs)
	self:DeletePart(self.JunkPropellers)

	self:RemoveWeapons()
	self:RemoveAllModules()
	self:StopLoopSounds()

	self:CallHook("Remove")
end