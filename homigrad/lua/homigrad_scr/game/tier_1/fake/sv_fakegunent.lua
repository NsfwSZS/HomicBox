Guns = {
	"weapon_sib_famas",
	"weapon_sib_m3super90",
	"weapon_sib_beretta",
	"weapon_sib_deagle",
	"weapon_sib_glock",
	"weapon_sib_usp",
	"weapon_sib_usp-s",
	"weapon_sib_m1911",
	"weapon_sib_pm",
	"weapon_sib_p226",
	"weapon_sib_asval",
	"weapon_sib_fal",
	"weapon_sib_hk416",
	"weapon_sib_m4a1",
	"weapon_sib_ak",
	"weapon_sib_mp5",
	"weapon_sib_ump45",
	"weapon_sib_mac10",
	"weapon_sib_thompson",
	"weapon_sib_m249",
	"weapon_sib_aug",
	"weapon_sib_sg552",
	"weapon_sib_xm1014",
	"weapon_sib_remington870",
	"weapon_sib_sg550",
	"weapon_sib_scout",
	"weapon_sib_g3sg1",
	"weapon_sib_m98",
	"weapon_sib_m14",
	"weapon_sib_galil",
	"weapon_sib_p90"
}
bullets = {
	["weapon_sib_m3super90"] = 12,
	["weapon_sib_xm1014"] = 12,
	["weapon_sib_remington870"] = 12
}
cir = {
	["weapon_sib_m3super90"] = 0.02,
	["weapon_sib_xm1014"] = 0.04,
	["weapon_sib_remington870"] = 0.025
}
TwoHandedOrNo = {
	["weapon_sib_famas"] = true,
	["weapon_sib_m3super90"] = true,
	["weapon_sib_beretta"] = false,
	["weapon_sib_deagle"] = false,
	["weapon_sib_glock"] = false,
	["weapon_sib_usp"] = false,
	["weapon_sib_usp-s"] = false,
	["weapon_sib_m1911"] = false,
	["weapon_sib_pm"] = false,
	["weapon_sib_p226"] = false,
	["weapon_sib_asval"] = true,
	["weapon_sib_fal"] = true,
	["weapon_sib_hk416"] = true,
	["weapon_sib_m4a1"] = true,
	["weapon_sib_ak"] = true,
	["weapon_sib_mp5"] = true,
	["weapon_sib_ump45"] = true,
	["weapon_sib_mac10"] = false,
	["weapon_sib_thompson"] = true,
	["weapon_sib_m249"] = true,
	["weapon_sib_aug"] = true,
	["weapon_sib_sg552"] = true,
	["weapon_sib_xm1014"] = true,
	["weapon_sib_remington870"] = true,
	["weapon_sib_sg550"] = true,
	["weapon_sib_scout"] = true,
	["weapon_sib_g3sg1"] = true,
	["weapon_sib_m98"] = true,
	["weapon_sib_m14"] = true,
	["weapon_sib_galil"] = true,
	["weapon_sib_p90"] = true
}

Vectors = {
["weapon_sib_famas"]=Vector(13,-1,2.5),
["weapon_sib_m3super90"]=Vector(13,-1,2.5),
["weapon_sib_beretta"] = Vector(4,-1,2),
["weapon_sib_deagle"] = Vector(4,-1,2),
["weapon_sib_glock"] = Vector(4,-1.2,2.4),
["weapon_sib_usp"] = Vector(4,-1.2,2.2),
["weapon_sib_usp-s"] = Vector(4,-1.2,2.2),
["weapon_sib_m1911"] = Vector(14,-1,2.2),
["weapon_sib_pm"] = Vector(4,-1,2.2),
["weapon_sib_p226"] = Vector(4,-1,2.2),
["weapon_sib_asval"] = Vector(12,-2,2),
["weapon_sib_fal"] = Vector(12,-2,2),
["weapon_sib_hk416"] = Vector(4,-2,2),
["weapon_sib_m4a1"] = Vector(12,-2,2),
["weapon_sib_ak"] = Vector(12,-2,2),
["weapon_sib_mp5"] = Vector(5,-2,2),
["weapon_sib_ump45"] = Vector(5,-2,2),
["weapon_sib_mac10"] = Vector(3,-1,3),
["weapon_sib_thompson"] = Vector(13,-2,2),
["weapon_sib_m249"] = Vector(12,0,2),
["weapon_sib_aug"] = Vector(12,-2,3),
["weapon_sib_sg552"] = Vector(14,-2,3),
["weapon_sib_xm1014"] = Vector(14,-2,3),
["weapon_sib_remington870"] = Vector(0,-2,0),
["weapon_sib_sg550"] = Vector(12,-2,2),
["weapon_sib_scout"] = Vector(12,-2,3),
["weapon_sib_g3sg1"] = Vector(12,-2,2),
["weapon_sib_m98"] = Vector(12,-2,3),
["weapon_sib_m14"] = Vector(-2,-2,1),
["weapon_sib_galil"] = Vector(12,-2,1),
["weapon_sib_p90"] = Vector(2,-1,3)
}

Vectors2 = {
["weapon_sib_famas"]=Vector(9,-4,-4),
["weapon_sib_m3super90"]=Vector(12,-3,-2),
["weapon_sib_asval"] = Vector(10,-4,-4),
["weapon_sib_fal"] = Vector(10,-4,-4),
["weapon_sib_hk416"] = Vector(10,-4,-3),
["weapon_sib_m4a1"] = Vector(10,-4,-4),
["weapon_sib_ak"] = Vector(10,-4,-4),
["weapon_sib_mp5"] = Vector(10,-4,-4),
["weapon_sib_ump45"] = Vector(7,-4,-4),
["weapon_sib_thompson"] = Vector(10,-4,-4),
["weapon_sib_m249"] = Vector(12,-6,-4),
["weapon_sib_aug"] = Vector(10,-3,0),
["weapon_sib_sg552"] = Vector(12,-4,-3),
["weapon_sib_xm1014"] = Vector(12,-4,-3),
["weapon_sib_remington870"] = Vector(12,-4,-3),
["weapon_sib_sg550"] = Vector(12,-4,-3),
["weapon_sib_scout"] = Vector(12,-2,-3),
["weapon_sib_g3sg1"] = Vector(12,-4,-5),
["weapon_sib_m98"] = Vector(8,-4,-4),
["weapon_sib_m14"] = Vector(12,-4,-2),
["weapon_sib_galil"] = Vector(12,-4,-4),
["weapon_sib_p90"] = Vector(5,-3,-2)
}

vecZero = Vector(0,0,0)
function SpawnWeapon(ply,clip1)
	--local guninfo = ply.GunInfo
	--local guninfo = ply.GunInfo луа очень легкий

	if !IsValid(ply.wep) and table.HasValue(Guns,ply.curweapon) then
		local rag = ply:GetNWEntity("Ragdoll")

		if IsValid(rag) then
			ply.FakeShooting=true

			ply.wep=ents.Create("wep")

			ply.wep:SetModel(weapons.Get(ply.curweapon).WorldModel or nil)

			ply.wep:SetOwner(ply)

			local vec1=rag:GetPhysicsObjectNum(rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" ))):GetPos()
			local vec2 = vecZero
			vec2:Set((Vectors[ply.curweapon] or Vector(0,0,0)))

			vec2:Rotate(rag:GetPhysicsObjectNum(rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" ))):GetAngles())
			ply.wep:SetPos(vec1+vec2)

			ply.wep:SetAngles(rag:GetPhysicsObjectNum(rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" ))):GetAngles()-Angle(0,0,180))


			--[[local hand = rag:GetBoneMatrix(rag:LookupBone("ValveBiped.Bip01_R_Hand"))
			local handPos,handAng = hand:GetTranslation(),hand:GetAngles()

			ply.wep:SetPos(handPos)
			ply.wep:SetAngles(handAng)

			local handWep = ply.wep:GetBoneMatrix(0)
			local wepPos,wepAng = handWep:GetTranslation(),handWep:GetAngles()
			
			local lpos = ply.wep:GetPos() - wepPos

			ply.wep:SetPos(wepPos + lpos)
			ply.wep:SetAngles(handAng - Angle(20,0,180))
--]]
			ply.wep:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			ply.wep:Spawn()
			ply:SetNWEntity("wep",ply.wep)
			--ply.wep:GetPhysicsObject():SetMass(0)
			--ply.wep.GunInfo = guninfo
			CheckAmmo(ply, ply.wep)
			if !IsValid(ply.WepCons) then
				local cons = constraint.Weld(ply.wep,rag,0,rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" )),0,true)
				if IsValid(cons) then
					ply.WepCons=cons
				end
			end

			ply.wep.curweapon = ply.curweapon
			net.Start("ebal_chellele")
			net.WriteEntity(ply)
			net.WriteString(ply.curweapon)
			net.Broadcast()
			rag.wep = ply.wep
			rag.wep:CallOnRemove("inv",remove,rag)
			ply.wep.rag = rag
			ply.wep.Clip = ply.Info.Weapons[ply.curweapon].Clip1
			ply.wep.AmmoType = ply.Info.Weapons[ply.curweapon].AmmoType

			ply:SetNWString("curweapon",ply.wep.curweapon)
			if (TwoHandedOrNo[ply.curweapon]) then
				ply.wep:GetPhysicsObject():SetMass(1)
				local vec1=rag:GetPhysicsObjectNum(rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" ))):GetPos()
				local vec22 = vecZero
				vec22:Set(Vectors2[ply.curweapon])
				vec22:Rotate(rag:GetPhysicsObjectNum(rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" ))):GetAngles())
				rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_L_Hand" )) ):SetPos(vec1+vec22)
				local modelhuy = ply:GetModel() == "models/knyaje pack/dibil/sso_politepeople.mdl"
				rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_L_Hand" )) ):SetAngles(ply:GetNWEntity("Ragdoll"):GetPhysicsObjectNum( 7 ):GetAngles()-Angle(0,0,modelhuy and 90 or 180))
				if !IsValid(ply.WepCons2) then
					local cons2 = constraint.Weld(ply.wep,rag,0,rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_L_Hand" )),0,true)			--2hand constraint
					if IsValid(cons2) then
						ply.WepCons2=cons2
					end
				end
			end
		end
	end
end

function DespawnWeapon(ply)
	if not ply.Info then return end

	if not ply.Info.Weapons[ply.Info.ActiveWeapon] then return end
	ply.Info.Weapons[ply.Info.ActiveWeapon].Clip1 = ply.wep.Clip
	ply.Info.ActiveWeapon2=ply.curweapon
	--if ply:Alive() and !ply.wep.pickable then

		if IsValid(ply.wep) and ply:Alive() then
			ply.wep:Remove()
			ply.wep=nil
		elseif IsValid(ply.wep) and !ply:Alive() then
            ply.wep.canpickup=true
            ply.wep:SetOwner(nil)
            ply.wep.curweapon=ply.curweapon
            ply.wep=nil
        end

		if IsValid(ply.WepCons) and ply:Alive() then
			ply.WepCons:Remove()
			ply.WepCons=nil
		elseif IsValid(ply.WepCons) then
			ply.WepCons=nil
		end

		if IsValid(ply.WepCons2) and ply:Alive() then
			ply.WepCons2:Remove()
			ply.WepCons2=nil
		elseif IsValid(ply.WepCons2) then
			ply.WepCons2=nil
		end
		ply.FakeShooting=false
	--[[else
		ply.wep.pickable=true
		ply.wep=nil
		ply.FakeShooting=false
	end--]]
end
Items = {
	['bandage']=1
}
function CheckAmmo(ply, wep)
	--print(ply.Info.ActiveWeapon)
	--print(ply.Info.Weapons[ply.Info.ActiveWeapon].Clip1)
	--print(ply.Info.ActiveWeapon2:GetMaxClip1())
	--if Items[wep] then return end
	--if ply.curweapon=="bandage" then wep:SetModelScale(0.4) end
	if ply:Alive() then
		wep.Clip = ply.Info.Weapons[ply.Info.ActiveWeapon].Clip1 or 0
		wep.MaxClip = ply.Info.ActiveWeapon2:GetMaxClip1() or 0
		--print(ply:GetAmmoCount(ply.Info.ActiveWeapon2:GetPrimaryAmmoType()))
		wep.Amt=ply:GetAmmoCount(ply.Info.ActiveWeapon2:GetPrimaryAmmoType()) or 0
		wep.AmmoType=ply.Info.ActiveWeapon2:GetPrimaryAmmoType() or 0
	else
		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) then return end

		wep.Clip = wep:Clip1()
		wep.AmmoType=wep:GetPrimaryAmmoType()
		--print(wep.Clip, wep.AmmoType)
	end
end

function SpawnWeaponEnt(weapon, pos, ply)
    local wep = ents.Create("wep")
    wep:SetModel(GunsModel[weapon])
    wep:SetPos(pos)
    wep:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    wep:Spawn()
    wep:SetAngles(ply:EyeAngles() or Angle(0,0,0))
    wep:GetPhysicsObject():ApplyForceOffset(VectorRand(-2,2),wep:GetPos())
	--wep:GetPhysicsObject():SetMass(500)
    wep.curweapon = ply.curweapon
    wep.Clip = ply.Clip
    wep.AmmoType = ply.AmmoType
    wep.canpickup=true
    return wep
end

function ReloadSound(wep)
    local ply = wep:GetOwner()
	local weptable = weapons.Get(wep.curweapon)
    for k,v in pairs(weptable.ReloadSounds) do
        if istable(k) then return end
        timer.Create(k.."snd"..wep:EntIndex(),tonumber( k, 10 ) or 0.1,1,function()
            if wep:IsValid() then
				wep:GetPhysicsObject():ApplyForceCenter(wep:GetAngles():Up()*100+wep:GetAngles():Forward()*-200)
                if v[1] then
                    wep:EmitSound(v[1], 55, 100, 1, CHAN_AUTO)
                end
            end
        end)
    end
end

function Reload(wep)
	if not wep then return end
	local weptable = weapons.Get(wep.curweapon)
	if !IsValid(wep) then return nil end
	local ply = wep:GetOwner()
	if !timer.Exists("reload"..wep:EntIndex()) and wep.Clip ~= wep.MaxClip and wep.Amt > 0 then
		ReloadSound(wep)
		timer.Create("reload"..wep:EntIndex(), weptable.ReloadTime, 1, function()
			if IsValid(wep) then
				local oldclip = wep.Clip
				wep.Clip = math.Clamp(wep.Clip + wep.Amt, 0, wep.MaxClip)
				local needed = wep.Clip - oldclip
				wep.Amt=wep.Amt-needed
				ply.Info.Ammo[wep.AmmoType]=wep.Amt
				--print(ply.Info.Ammo[wep.AmmoType])
			end
		end)
	end
end

NextShot = 0

HMCD_SurfaceHardness={
    [MAT_METAL]=.85,[MAT_COMPUTER]=.85,[MAT_VENT]=.85,[MAT_GRATE]=.85,[MAT_FLESH]=.5,[MAT_ALIENFLESH]=.3,
    [MAT_SAND]=.1,[MAT_DIRT]=.3,[74]=.1,[85]=.2,[MAT_WOOD]=.5,[MAT_FOLIAGE]=.5,
    [MAT_CONCRETE]=.9,[MAT_TILE]=.8,[MAT_SLOSH]=.05,[MAT_PLASTIC]=.3,[MAT_GLASS]=.6
}

local pos = Vector(0,0,0)

function FireShot(wep)
	if not IsValid(wep) then return end

	local weptable = weapons.Get(wep.curweapon)

	function wep:BulletCallbackFunc(dmgAmt,ply,tr,dmg,tracer,hard,multi)
		if(tr.MatType==MAT_FLESH)then
			util.Decal("Blood",tr.HitPos+tr.HitNormal,tr.HitPos-tr.HitNormal)
			local vPoint = tr.HitPos
			local effectdata = EffectData()
			effectdata:SetOrigin( vPoint )
			util.Effect( "BloodImpact", effectdata )
		end
		if(self.NumBullet or 1>1)then return end
		if(tr.HitSky)then return end
		if(hard)then self:RicochetOrPenetrate(tr) end
	end
	function wep:RicochetOrPenetrate(initialTrace)
		local AVec,IPos,TNorm,SMul=initialTrace.Normal,initialTrace.HitPos,initialTrace.HitNormal,HMCD_SurfaceHardness[initialTrace.MatType]
		if not(SMul)then SMul=.5 end
		local ApproachAngle=-math.deg(math.asin(TNorm:DotProduct(AVec)))
		local MaxRicAngle=80*SMul
		if(ApproachAngle>(MaxRicAngle*1.25))then -- all the way through
			local MaxDist,SearchPos,SearchDist,Penetrated=(weapons.Get(wep.curweapon).Primary.Damage/SMul)*.15,IPos,5,false
			while((not(Penetrated))and(SearchDist<MaxDist))do
				SearchPos=IPos+AVec*SearchDist
				local PeneTrace=util.QuickTrace(SearchPos,-AVec*SearchDist)
				if((not(PeneTrace.StartSolid))and(PeneTrace.Hit))then
					Penetrated=true
				else
					SearchDist=SearchDist+5
				end
			end
			if(Penetrated)then
				self:FireBullets({
					Attacker=self:GetOwner(),
					Damage=1,
					Force=1,
					Num=1,
					Tracer=0,
					TracerName="",
					Dir=-AVec,
					Spread=Vector(0,0,0),
					Src=SearchPos+AVec
				})
				self:FireBullets({
					Attacker=self:GetOwner(),
					Damage=weapons.Get(wep.curweapon).Primary.Damage*.65,
					Force=weapons.Get(wep.curweapon).Primary.Force/40,
					Num=1,
					Tracer=0,
					TracerName="",
					Dir=AVec,
					Spread=Vector(0,0,0),
					Src=SearchPos+AVec
				})
			end
		elseif(ApproachAngle<(MaxRicAngle*.75))then -- ping whiiiizzzz
			sound.Play("snd_jack_hmcd_ricochet_"..math.random(1,2)..".wav",IPos,70,math.random(90,100))
			local NewVec=AVec:Angle()
			NewVec:RotateAroundAxis(TNorm,180)
			NewVec=NewVec:Forward()
			self:FireBullets({
				Attacker=self:GetOwner(),
				Damage=weapons.Get(wep.curweapon).Primary.Damage*.85,
				Force=weapons.Get(wep.curweapon).Primary.Force/40,
				Num=1,
				Tracer=0,
				TracerName="",
				Dir=-NewVec,
				Spread=Vector(0,0,0),
				Src=IPos+TNorm
			})
		end
	end

	if weapons.Get(wep.curweapon).ShootWait == nil then return nil end
	if !IsValid(wep) then return nil end
	if timer.Exists("reload"..wep:EntIndex()) then return nil end
	local guninfo = wep.GunInfo
	
	wep.NextShot=wep.NextShot or NextShot

	if ( wep.NextShot > CurTime() ) then return end
	if wep.Clip<=0 then
		sound.Play("snd_jack_hmcd_click.wav",wep:GetPos(),65,100)
		wep.NextShot = CurTime() + weptable.ShootWait
	return nil end

	wep.NextShot = CurTime() + weptable.ShootWait*1.2

	local Attachment = wep:GetAttachment(wep:LookupAttachment("muzzle"))

	local shootOrigin = Attachment.Pos
	local shootAngles = Attachment.Ang--wep:GetAngles()
	local shootDir = shootAngles:Forward()
	local damage = weapons.Get(wep.curweapon).Primary.Damage
	local ply = wep:GetOwner()
	local bullet = {}
		bullet.Num 			= (weptable.NumBullet or 1)
		bullet.Src 			= shootOrigin
		bullet.Dir 			= shootDir
		bullet.Spread 		= Vector(cir[wep.curweapon] or 0,cir[wep.curweapon]or 0,0)
		bullet.Tracer		= 1
		bullet.TracerName 	= 4
		bullet.Force		= weptable.Primary.Force / 5
		bullet.Damage		= damage
		bullet.Attacker 	= ply
		bullet.Callback=function(ply,tr,dmgInfo)
			wep:BulletCallbackFunc(damage,ply,tr,damage,false,true,false)
			net.Start("shoot_huy")
				net.WriteTable(tr)
			net.Broadcast()

			if weptable.NumBullet and weptable.NumBullet > 1 then
				local k = math.max(1 - tr.StartPos:Distance(tr.HitPos) / 750,0)
	
				dmgInfo:ScaleDamage(k)
			end

				local ef = EffectData()
				ef:SetEntity( wep )
				ef:SetAttachment( 1 ) -- self:LookupAttachment( "muzzle" )
				ef:SetScale(0.1)
				ef:SetFlags( 1 ) -- Sets the Combine AR2 Muzzle flash
		
				util.Effect( "MuzzleFlash", ef )

		end

	--[[local bullet = {}
		bullet.Num 			= 1
		bullet.Src 			= shootOrigin
		bullet.Dir 			= shootDir
		bullet.Spread 		= 0.05
		bullet.Tracer		= guninfo.Trace
		bullet.TracerName 	= nil
		bullet.Force		= 10
		bullet.Damage		= guninfo.Damage
		bullet.Attacker 	= ply
	--]]
	wep:FireBullets( bullet )
	--wep:EmitSound(weptable.Primary.Sound,511,math.random(100,120),1,CHAN_WEAPON,0,0)
	if SERVER then
		net.Start("huysound")
		net.WriteVector(wep:GetPos())
		net.WriteString(weptable.Primary.Sound)
		net.WriteString(weptable.Primary.FarSound)
		net.WriteEntity(wep)
		net.Broadcast()
	end
	local ply = wep:GetOwner()
	local rag = ply:GetNWEntity("Ragdoll")
	rag:GetPhysicsObjectNum(0):ApplyForceCenter(ply:EyeAngles():Forward()*-weapons.Get(wep.curweapon).Primary.Force*0.35)
	wep:GetPhysicsObject():ApplyForceCenter(wep:GetAngles():Forward()*-weapons.Get(wep.curweapon).Primary.Force*5+wep:GetAngles():Right()*VectorRand(-90,90)+wep:GetAngles():Up()*weapons.Get(wep.curweapon).Primary.Force*15)
	ply:SetEyeAngles(ply:EyeAngles()+Angle(-weapons.Get(wep.curweapon).Primary.Force/10,math.random(-weapons.Get(wep.curweapon).Primary.Force,weapons.Get(wep.curweapon).Primary.Force)/5,0))
	wep.Clip=wep.Clip-1
	-- Make a muzzle flash
	local obj = wep:LookupAttachment("shell")
	local Attachment = wep:GetAttachment(obj)
	if Attachment then
		local Angles = Attachment.Ang
		if weptable.ShellRotate then Angles:RotateAroundAxis(vector_up,180)  end
		local ef = EffectData()
		ef:SetOrigin(Attachment.Pos)
		ef:SetAngles(Angles)
		ef:SetFlags( 140 ) -- Sets the Combine AR2 Muzzle flash

		util.Effect( weptable.Shell, ef )
	end
end