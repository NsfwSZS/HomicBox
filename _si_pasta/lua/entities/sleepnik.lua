AddCSLuaFile()

ENT.Type                = "anim"
ENT.Base                = "base_entity"
ENT.PrintName           = "Картонка"

ENT.Spawnable           = true
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
ENT.Model = "models/props_junk/garbage_carboard002a.mdl"

if SERVER then

    function ENT:Initialize()
        self:SetModel(self.Model)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Sleep()
        end
        print(self:GetOwner())
        
    end


    function ENT:Think()
    end

    function ENT:Use(ply)
        -- timer.Create("LKADSAdsasdadsaAS", .3, 1, function ()
            self:SetNW2Entity("sleeper_2281337", ply)
            if IsValid( self:GetNW2Entity("sleeper_2281337") ) then
                
                ply:PrintMessage(3, "Спавн тута терь у тебя.")
                print(self:GetNW2Entity("sleeper_2281337"))
            elseif not self:GetNW2Entity("sleeper_2281337") == ply then
                ply:PrintMessage(3, "Это спальник " .. self:GetNW2Entity("sleeper_2281337"):Name() )
                print(self:GetNW2Entity("sleeper_2281337"))
            else
                ply:PrintMessage(3, "Ты уже занял этот спальник." )
                print(self:GetNW2Entity("sleeper_2281337"))
            end
            -- timer.Remove("LKADSAdsasdadsaAS")
        -- end)

        self:NextThink( CurTime() + 0.5 )

    end

    function ENT:PhysicsCollide(data)
    end

    function ENT:OnTakeDamage( dmginfo )
    -- Make sure we're not already applying damage a second time
    -- This prevents infinite loops
    if ( not self.m_bApplyingDamage ) then
        self.m_bApplyingDamage = true
        self:TakeDamageInfo( dmginfo )
        if dmginfo:GetDamageType() == 8194 then
            self:Remove()
            print("DADA")
        end
        print(dmginfo:GetDamageType())
        print(self:GetNW2Entity("sleeper_2281337"))
        self.m_bApplyingDamage = false
    end
end

    function ENT:OnRemove()
        if IsValid(self:GetNW2Entity("sleeper_2281337")) then       
            self:GetNW2Entity("sleeper_2281337"):PrintMessage(3, "Ваш спальник сломан!")
        end
    end
else

    function ENT:Draw()
        self:DrawModel()
    end

end