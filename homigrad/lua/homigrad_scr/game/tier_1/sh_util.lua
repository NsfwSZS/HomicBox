gameevent.Listen( "player_connect" )

local EnterText = {
    " запрыгивает на сервер.",
    " воу он уже рядом!",
    " готовтесь, он уже прямо здесь.",
    " добро прибыл в хомис-бокс.",
    " привет друк!!",
    " ну встречайте, он уже почти приехал.",
    " опа а вот и он!",
    " уже не так весело. Но он рядом...",
    " его не зовут, он сам приходит."
}

hook.Add("player_connect", "AnnounceConnection", function( data )
    if CLIENT then
        chat.AddText(Color(25,155,255), data.name .. table.Random(EnterText) )
    end
end)

hook.Add( "PlayerConnect", "JoinGlobalMessage", function( name, ip )
	--PrintMessage( HUD_PRINTTALK, name .. " has joined the game." )
    return 
end )
