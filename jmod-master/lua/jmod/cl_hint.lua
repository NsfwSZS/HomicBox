net.Receive("JMod_Hint", function()
	local isLangKey = net.ReadBool()
	local str = net.ReadString()
	local iconType = net.ReadInt(8)
	local tiem = net.ReadInt(8)

	if isLangKey then
		str = JMod.Lang(str)
	end

	MsgC(Color(255, 255, 255), "[JMod] ", str, "\n")
	notification.AddLegacy(str, iconType, tiem)
end)

--if not(specific)then surface.PlaySound( "ambient/water/drip" .. math.random( 1, 4 ) .. ".wav" ) end
net.Receive("JMod_PlayerSpawn", function()
	local DoHints = tobool(net.ReadBit())

	if not input.LookupBinding("+walk") then
		chat.AddText(Color(255, 0, 0), "Ваша кнопка не привязана на +walk; Объекты JMod будут в основном непригодны для использования.")
		chat.AddText(Color(255, 0, 0), "Пожалуйста, привяжите её в настройках или с помощью команды - 'bind alt +walk'.")
	end
end)

concommand.Add("jmod_wiki", function()
	gui.OpenURL("https://github.com/Jackarunda/gmod/wiki")
end, nil, "Opens the Jmod Wiki page.")
