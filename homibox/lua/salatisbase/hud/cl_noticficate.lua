--
local net_Recive = net.Receive
local net_ReadTable = net.ReadTable
local table_Insert = table.insert
local table_remove = table.remove
local draw_SimpleText = draw.SimpleText
local surface_DrawRect = surface.DrawRect
local surface_SetDrawColor = surface.SetDrawColor
local Notifications = {}

Notificate = Notificate or {}
Notificate.Create = function(str, time, color)
    local Send = {
        ["string"] = str,
        ["time"] = CurTime()+(time or 5),
        ["color"] = color
    }

    table_Insert(Notifications,Send)
end

Notificate.Create("Wellcome to Homice-Box!",20)

local function EaseLerp(fraction, from, to)
    return Lerp(math.ease.OutCubic(fraction), from, to)
end

net_Recive("notificate_created",function()
    local Table = net_ReadTable()

    table_Insert(Notifications,Table)
end)

hook.Add("HUDPaint", "SIB_Notificate", function()
    for k,v in pairs(Notifications) do
        v.startTime = v.startTime or v.time-CurTime()
        v.anim = Lerp(2.5*FrameTime(), v.anim or 0, math.Clamp(v.time - CurTime(),-1,1))
        v.posY = Lerp(5*FrameTime(),v.posY or (ScrH()-(k*45))-40,(ScrH()-(k*45)-40))
        v.txtSizeX,v.txtSizeY = surface.GetTextSize( v.string )
        v.posX = EaseLerp(v.anim, ScrW()+25*2.5, ScrW()-25)
        draw_SimpleText( v.string, "HomigradFontBig", v.posX, v.posY, v.color, TEXT_ALIGN_RIGHT )
        draw_SimpleText( string.Right(string.ToMinutesSecondsMilliseconds(v.time - CurTime()),5), "DermaDefault", v.posX, v.posY+22, Color(255,255,255), TEXT_ALIGN_RIGHT )
        if v.time+1 < CurTime() then table_remove(Notifications,k) end
    end
end)