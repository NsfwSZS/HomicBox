--
local util_AddNetString = util.AddNetworkString
local net_Start = net.Start 
local net_Sent = net.Send
local net_WriteTable = net.WriteTable

util_AddNetString("notificate_created")

Notificate = Notificate or {}

Notificate.Create = function(ply, str, time, color)
    local Send = {
        ["string"] = str,
        ["time"] = CurTime()+(time or 5),
        ["color"] = color
    }

    net_Start("notificate_created")
        net_WriteTable(Send)
    net_Sent(ply)
end
