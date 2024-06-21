local blurMat = Material("pp/blurscreen")
local Dynamic = 0
local MenuOpen = false
local YesMat = Material("icon16/accept.png")
local NoMat = Material("icon16/cancel.png")
local FavMat = Material("icon16/star.png")

local function BlurBackground(panel)
	if not((IsValid(panel))and(panel:IsVisible()))then return end
	local layers,density,alpha=1,1,255
	local x,y=panel:LocalToScreen(0,0)
	surface.SetDrawColor(255,255,255,alpha)
	surface.SetMaterial(blurMat)
	local FrameRate,Num,Dark=1/FrameTime(),5,150
	for i=1,Num do
		blurMat:SetFloat("$blur",(i/layers)*density*Dynamic)
		blurMat:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(-x,-y,ScrW(),ScrH())
	end
	surface.SetDrawColor(0,0,0,Dark*Dynamic)
	surface.DrawRect(0,0,panel:GetWide(),panel:GetTall())
	Dynamic=math.Clamp(Dynamic+(1/FrameRate)*7,0,1)
end

local function GetItemInSlot(armorTable,slot)
	if not(armorTable and armorTable.items)then return nil end
	for id,armorData in pairs(armorTable.items)do
		local ArmorInfo=JMod.ArmorTable[armorData.name]
		if(ArmorInfo.slots[slot])then
			return id,armorData,ArmorInfo
		end
	end
	return nil
end

local ArmorSlotButtons={
	{
		title="Drop",
		actionFunc=function(slot,itemID,itemData,itemInfo)
			net.Start("JMod_EFT_Inventory")
			net.WriteInt(1,8) -- drop
			net.WriteString(itemID)
			net.SendToServer()
		end
	},
	{
		title="Toggle",
		visTestFunc=function(slot,itemID,itemData,itemInfo)
			return itemInfo.tgl
		end,
		actionFunc=function(slot,itemID,itemData,itemInfo)
			net.Start("JMod_EFT_Inventory")
			net.WriteInt(2,8) -- toggle
			net.WriteString(itemID)
			net.SendToServer()
		end
	},
	{
		title="Repair",
		visTestFunc=function(slot,itemID,itemData,itemInfo)
			return itemData.dur<itemInfo.dur*.9
		end,
		actionFunc=function(slot,itemID,itemData,itemInfo)
			net.Start("JMod_EFT_Inventory")
			net.WriteInt(3,8) -- repair
			net.WriteString(itemID)
			net.SendToServer()
		end
	},
	{
		title="Recharge",
		visTestFunc=function(slot,itemID,itemData,itemInfo)
			if(itemInfo.chrg)then
				for resource,maxAmt in pairs(itemInfo.chrg)do
					if(itemData.chrg[resource]<maxAmt)then return true end
				end
			end
			return false
		end,
		actionFunc=function(slot,itemID,itemData,itemInfo)
			net.Start("JMod_EFT_Inventory")
			net.WriteInt(4,8) -- recharge
			net.WriteString(itemID)
			net.SendToServer()
		end
	}
}
local ArmorResourceNiceNames={
	chemicals="Chemicals",
	power="Electricity"
}
local OpenDropdown=nil
local function CreateArmorSlotButton(parent,slot,x,y)
	local Buttalony,Ply=vgui.Create("DButton",parent),LocalPlayer()
	Buttalony:SetSize(180,40)
	Buttalony:SetPos(x,y)
	Buttalony:SetText("")
	Buttalony:SetCursor("hand")
	local ItemID,ItemData,ItemInfo=GetItemInSlot(Ply.EZarmor,slot)
	function Buttalony:Paint(w,h)
		surface.SetDrawColor(50,50,50,100)
		surface.DrawRect(0,0,w,h)
		draw.SimpleText(JMod.ArmorSlotNiceNames[slot],"DermaDefault",Buttalony:GetWide()/2,10,Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		if(ItemID)then
			local Str=ItemData.name--..": "..math.Round(ItemData.dur/ItemInfo.dur*100).."%"
			if(ItemData.tgl and ItemInfo.tgl.slots[slot]==0)then Str="DISENGAGED" end
			draw.SimpleText(Str,"DermaDefault",Buttalony:GetWide()/2,25,Color(200,200,200,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
	end
	if(ItemID)then
		local str="Durability: "..math.Round(ItemData.dur,1).."/"..ItemInfo.dur
		if(ItemInfo.chrg)then
			for resource,maxAmt in pairs(ItemInfo.chrg)do
				str=str.."\n"..ArmorResourceNiceNames[resource]..": "..math.Round(ItemData.chrg[resource],1).."/"..maxAmt
			end
		end
		Buttalony:SetTooltip(str)
	else
		Buttalony:SetTooltip("slot is empty")
	end
	function Buttalony:DoClick()
		if(OpenDropdown)then OpenDropdown:Remove() end
		if not(ItemID)then return end
		local Options={}
		for k,option in pairs(ArmorSlotButtons)do
			if(not(option.visTestFunc)or(option.visTestFunc(slot,ItemID,ItemData,ItemInfo)))then
				table.insert(Options,option)
			end
		end
		local Dropdown=vgui.Create("DPanel",parent)
		Dropdown:SetSize(Buttalony:GetWide(),#Options*40)
		local ecks,why=gui.MousePos()
		local harp,darp=parent:GetPos()
		local fack,fock=parent:GetSize()
		local floop,florp=Dropdown:GetSize()
		Dropdown:SetPos(math.Clamp(ecks-harp,0,fack-floop),math.Clamp(why-darp,0,fock-florp))
		function Dropdown:Paint(w,h)
			surface.SetDrawColor(70,70,70,220)
			surface.DrawRect(0,0,w,h)
		end
		for k,option in pairs(Options)do
			local Butt=vgui.Create("DButton",Dropdown)
			Butt:SetPos(5,k*40-35)
			Butt:SetSize(floop-10,30)
			Butt:SetText(option.title)
			function Butt:DoClick()
				option.actionFunc(slot,ItemID,ItemData,ItemInfo)
				parent:Close()
			end
		end
		OpenDropdown=Dropdown
	end
end
net.Receive("JMod_EFT_Inventory",function()
	local Ply=LocalPlayer()
	local motherFrame=vgui.Create("DFrame")
	motherFrame:SetSize(600,400)
	motherFrame:SetVisible(true)
	motherFrame:SetDraggable(true)
	motherFrame:ShowCloseButton(true)
	motherFrame:SetTitle("EFT Accessories Inventory")
	function motherFrame:Paint()
		BlurBackground(self)
	end
	motherFrame:MakePopup()
	motherFrame:Center()
	function motherFrame:OnKeyCodePressed(key)
		if key==KEY_Q or key==KEY_ESCAPE or key == KEY_E then self:Close() end
	end
	function motherFrame:OnClose()
		if(OpenDropdown)then OpenDropdown:Remove() end
	end
	local PDispBG=vgui.Create("DPanel",motherFrame)
	PDispBG:SetPos(200,30)
	PDispBG:SetSize(200,360)
	function PDispBG:Paint(w,h)
		surface.SetDrawColor(50,50,50,100)
		surface.DrawRect(0,0,w,h)
	end
	local PlayerDisplay=vgui.Create("DModelPanel",PDispBG)
	PlayerDisplay:SetPos(0,0)
	PlayerDisplay:SetSize(PDispBG:GetWide(),PDispBG:GetTall())
	PlayerDisplay:SetModel(Ply:GetModel())
	PlayerDisplay:SetFOV(35)
	PlayerDisplay:SetCursor("arrow")
	local Ent=PlayerDisplay:GetEntity()
	if(Ply.EZarmor.suited and Ply.EZarmor.bodygroups)then
		PlayerDisplay:SetColor(Ply:GetColor())
		for k,v in pairs(Ply.EZarmor.bodygroups)do
			Ent:SetBodygroup(k,v)
		end
	end
	function PlayerDisplay:PostDrawModel(ent)
		ent.EZarmor=Ply.EZarmor
		JMod.ArmorPlayerModelDraw(ent)
	end
	function PlayerDisplay:DoClick()
		if(OpenDropdown)then OpenDropdown:Remove() end
	end
	---
	CreateArmorSlotButton(motherFrame,"acc_head",10,30)
	CreateArmorSlotButton(motherFrame,"acc_eyes",10,75)
	CreateArmorSlotButton(motherFrame,"acc_ears",10,120)
	CreateArmorSlotButton(motherFrame,"acc_neck",10,165)
--	CreateArmorSlotButton(motherFrame,"leftshoulder",10,210)
--	CreateArmorSlotButton(motherFrame,"leftforearm",10,255)
--	CreateArmorSlotButton(motherFrame,"leftthigh",10,300)
--	CreateArmorSlotButton(motherFrame,"leftcalf",10,345)
	---
	CreateArmorSlotButton(motherFrame,"acc_backpack",410,30)
	CreateArmorSlotButton(motherFrame,"acc_chestrig",410,75)
	CreateArmorSlotButton(motherFrame,"armband",410,120)
	CreateArmorSlotButton(motherFrame,"acc_rshoulder",410,165)
	CreateArmorSlotButton(motherFrame,"acc_lshoulder",410,210)
--	CreateArmorSlotButton(motherFrame,"rightthigh",410,255)
--	CreateArmorSlotButton(motherFrame,"rightcalf",410,300)
end)
