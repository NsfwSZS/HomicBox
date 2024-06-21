local CATEGORY_NAME = "Пользователи"

local function checkForValidId( calling_ply, id )
	if id == "BOT" or id == "NULL" then -- Bot check
		return true
	elseif id:find( "%." ) then -- Assume IP and check
	 	if not ULib.isValidIP( id ) then
			ULib.tsayError( calling_ply, "Неверный IP.", true )
			return false
		end
	elseif id:find( ":" ) then
	 	if not ULib.isValidSteamID( id ) then -- Assume steamid and check
			ULib.tsayError( calling_ply, "Неверный steamid.", true )
			return false
		end
	elseif not tonumber( id ) then -- Assume uniqueid and check
		ULib.tsayError( calling_ply, "Неверный Unique ID", true )
		return false
	end

	return true
end

ulx.group_names = {}
ulx.group_names_no_user = {}
local function updateNames()
	table.Empty( ulx.group_names ) -- Don't reassign so we don't lose our refs
	table.Empty( ulx.group_names_no_user )

	for group_name, _ in pairs( ULib.ucl.groups ) do
		table.insert( ulx.group_names, group_name )
		if group_name ~= ULib.ACCESS_ALL then
			table.insert( ulx.group_names_no_user, group_name )
		end
	end
end
hook.Add( ULib.HOOK_UCLCHANGED, "ULXGroupNamesUpdate", updateNames )
updateNames() -- Init

function ulx.usermanagementhelp( calling_ply )
	if calling_ply:IsValid() then
		ULib.clientRPC( calling_ply, "ulx.showUserHelp" )
	else
		ulx.showUserHelp()
	end
end
local usermanagementhelp = ulx.command( CATEGORY_NAME, "ulx usermanagementhelp", ulx.usermanagementhelp )
usermanagementhelp:defaultAccess( ULib.ACCESS_ALL )
usermanagementhelp:help( "Показ помощи в консоли." )

function ulx.adduser( calling_ply, target_ply, group_name )
	local userInfo = ULib.ucl.authed[ target_ply:UniqueID() ]

	local id = ULib.ucl.getUserRegisteredID( target_ply )
	if not id then id = target_ply:SteamID() end

	ULib.ucl.addUser( id, userInfo.allow, userInfo.deny, group_name )

	ulx.fancyLogAdmin( calling_ply, "#A добавил #T в группу #s", target_ply, group_name )
end
local adduser = ulx.command( CATEGORY_NAME, "ulx adduser", ulx.adduser, nil, false, false, true )
adduser:addParam{ type=ULib.cmds.PlayerArg }
adduser:addParam{ type=ULib.cmds.StringArg, completes=ulx.group_names_no_user, hint="group", error="invalid group \"%s\" specified", ULib.cmds.restrictToCompletes }
adduser:defaultAccess( ULib.ACCESS_SUPERADMIN )
adduser:help( "Дает игроку те или иные права доступа." )

function ulx.adduserid( calling_ply, id, group_name )
	id = id:upper() -- Steam id needs to be upper

	-- Check for valid and properly formatted ID
	if not checkForValidId( calling_ply, id ) then return false end

	-- Now add the fool!
	ULib.ucl.addUser( id, allows, denies, group_name )

	if ULib.ucl.users[ id ] and ULib.ucl.users[ id ].name then
		ulx.fancyLogAdmin( calling_ply, "#A добавил #s в группу #s", ULib.ucl.users[ id ].name, group_name )
	else
		ulx.fancyLogAdmin( calling_ply, "#A добавил #s в группу #s", id, group_name )
	end
end
local adduserid = ulx.command( CATEGORY_NAME, "ulx adduserid", ulx.adduserid, nil, false, false, true )
adduserid:addParam{ type=ULib.cmds.StringArg, hint="SteamID, IP, or UniqueID" }
adduserid:addParam{ type=ULib.cmds.StringArg, completes=ulx.group_names_no_user, hint="group", error="invalid group \"%s\" specified", ULib.cmds.restrictToCompletes }
adduserid:defaultAccess( ULib.ACCESS_SUPERADMIN )
adduserid:help( "Выдача игроку прав по steamid." )

function ulx.removeuser( calling_ply, target_ply )
	ULib.ucl.removeUser( target_ply:UniqueID() )

	ulx.fancyLogAdmin( calling_ply, "#A убрал весь доступ у #T", target_ply )
end
local removeuser = ulx.command( CATEGORY_NAME, "ulx removeuser", ulx.removeuser, nil, false, false, true )
removeuser:addParam{ type=ULib.cmds.PlayerArg }
removeuser:defaultAccess( ULib.ACCESS_SUPERADMIN )
removeuser:help( "Удаление доступа у игрока." )

function ulx.removeuserid( calling_ply, id )
	id = id:upper() -- Steam id needs to be upper

	-- Check for valid and properly formatted ID
	if not checkForValidId( calling_ply, id ) then return false end

	if not ULib.ucl.authed[ id ] and not ULib.ucl.users[ id ] then
		ULib.tsayError( calling_ply, "No player with id \"" .. id .. "\" exists in the ULib user list", true )
		return false
	end

	local name = (ULib.ucl.authed[ id ] and ULib.ucl.authed[ id ].name) or (ULib.ucl.users[ id ] and ULib.ucl.users[ id ].name)

	ULib.ucl.removeUser( id )

	if name then
		ulx.fancyLogAdmin( calling_ply, "#A удалил весь доступ #s", name )
	else
		ulx.fancyLogAdmin( calling_ply, "#A удалил весь доступ #s", id )
	end
end
local removeuserid = ulx.command( CATEGORY_NAME, "ulx removeuserid", ulx.removeuserid, nil, false, false, true )
removeuserid:addParam{ type=ULib.cmds.StringArg, hint="SteamID, IP, or UniqueID" }
removeuserid:defaultAccess( ULib.ACCESS_SUPERADMIN )
removeuserid:help( "Удалить доступ у игрока по steamid." )

function ulx.userallow( calling_ply, target_ply, access_string, access_tag )
	if access_tag then access_tag = access_tag end

	local accessTable
	if access_tag and access_tag ~= "" then
		accessTable = { [access_string]=access_tag }
	else
		accessTable = { access_string }
	end

	local id = ULib.ucl.getUserRegisteredID( target_ply )
	if not id then id = target_ply:SteamID() end

	local success = ULib.ucl.userAllow( id, accessTable )
	if not success then
		ULib.tsayError( calling_ply, string.format( "User \"%s\" already has access to \"%s\"", target_ply:Nick(), access_string ), true )
	else
		if not access_tag or access_tag == "" then
			ulx.fancyLogAdmin( calling_ply, "#A предоставил доступ #q к #T", access_string, target_ply )
		else
			ulx.fancyLogAdmin( calling_ply, "#A предоставил доступ #q с тегом #q к #T", access_string, access_tag, target_ply )
		end
	end
end
local userallow = ulx.command( CATEGORY_NAME, "ulx userallow", ulx.userallow, nil, false, false, true )
userallow:addParam{ type=ULib.cmds.PlayerArg }
userallow:addParam{ type=ULib.cmds.StringArg, hint="command" } -- TODO, add completes for this
userallow:addParam{ type=ULib.cmds.StringArg, hint="access tag", ULib.cmds.optional }
userallow:defaultAccess( ULib.ACCESS_SUPERADMIN )
userallow:help( "Выдача доступа." )

function ulx.userallowid( calling_ply, id, access_string, access_tag )
	if access_tag then access_tag = access_tag end
	id = id:upper() -- Steam id needs to be upper

	-- Check for valid and properly formatted ID
	if not checkForValidId( calling_ply, id ) then return false end

	if not ULib.ucl.authed[ id ] and not ULib.ucl.users[ id ] then
		ULib.tsayError( calling_ply, "No player with id \"" .. id .. "\" exists in the ULib user list", true )
		return false
	end

	local accessTable
	if access_tag and access_tag ~= "" then
		accessTable = { [access_string]=access_tag }
	else
		accessTable = { access_string }
	end

	local success = ULib.ucl.userAllow( id, accessTable )
	local name = (ULib.ucl.authed[ id ] and ULib.ucl.authed[ id ].name) or (ULib.ucl.users[ id ] and ULib.ucl.users[ id ].name) or id
	if not success then
		ULib.tsayError( calling_ply, string.format( "User \"%s\" already has access to \"%s\"", name, access_string ), true )
	else
		if not access_tag or access_tag == "" then
			ulx.fancyLogAdmin( calling_ply, "#A предоставил доступ #q к #s", access_string, name )
		else
			ulx.fancyLogAdmin( calling_ply, "#A предоставил доступ #q с тегом #q к #s", access_string, access_tag, name )
		end
	end
end
local userallowid = ulx.command( CATEGORY_NAME, "ulx userallowid", ulx.userallowid, nil, false, false, true )
userallowid:addParam{ type=ULib.cmds.StringArg, hint="SteamID, IP, or UniqueID" }
userallowid:addParam{ type=ULib.cmds.StringArg, hint="command" } -- TODO, add completes for this
userallowid:addParam{ type=ULib.cmds.StringArg, hint="access tag", ULib.cmds.optional }
userallowid:defaultAccess( ULib.ACCESS_SUPERADMIN )
userallowid:help( "Выдача доступа." )

function ulx.userdeny( calling_ply, target_ply, access_string, should_use_neutral )
	local success = ULib.ucl.userAllow( target_ply:UniqueID(), access_string, should_use_neutral, true )
	if should_use_neutral then
		success = success or ULib.ucl.userAllow( target_ply:UniqueID(), access_string, should_use_neutral, false ) -- Remove from both lists
	end

	if should_use_neutral then
		if success then
			ulx.fancyLogAdmin( calling_ply, "#A создал доступ #q нейтральный к #T", access_string, target_ply )
		else
			ULib.tsayError( calling_ply, string.format( "User \"%s\" isn't denied or allowed access to \"%s\"", target_ply:Nick(), access_string ), true )
		end
	else
		if not success then
			ULib.tsayError( calling_ply, string.format( "User \"%s\" is already denied access to \"%s\"", target_ply:Nick(), access_string ), true )
		else
			ulx.fancyLogAdmin( calling_ply, "#A убрал доступ #q у #T", access_string, target_ply )
		end
	end
end
local userdeny = ulx.command( CATEGORY_NAME, "ulx userdeny", ulx.userdeny, nil, false, false, true )
userdeny:addParam{ type=ULib.cmds.PlayerArg }
userdeny:addParam{ type=ULib.cmds.StringArg, hint="command" } -- TODO, add completes for this
userdeny:addParam{ type=ULib.cmds.BoolArg, hint="", ULib.cmds.optional }
userdeny:defaultAccess( ULib.ACCESS_SUPERADMIN )
userdeny:help( "Удаление доступа." )

function ulx.userdenyid( calling_ply, id, access_string, should_use_neutral )
	id = id:upper() -- Steam id needs to be upper

	-- Check for valid and properly formatted ID
	if not checkForValidId( calling_ply, id ) then return false end

	if not ULib.ucl.authed[ id ] and not ULib.ucl.users[ id ] then
		ULib.tsayError( calling_ply, "No player with id \"" .. id .. "\" exists in the ULib user list", true )
		return false
	end

	local success = ULib.ucl.userAllow( id, access_string, should_use_neutral, true )
	if should_use_neutral then
		success = success or ULib.ucl.userAllow( id, access_string, should_use_neutral, false ) -- Remove from both lists
	end

	local name = (ULib.ucl.authed[ id ] and ULib.ucl.authed[ id ].name) or (ULib.ucl.users[ id ] and ULib.ucl.users[ id ].name) or id
	if should_use_neutral then
		if success then
			ulx.fancyLogAdmin( calling_ply, "#A создал доступ #q нейтральный к #s", access_string, name )
		else
			ULib.tsayError( calling_ply, string.format( "User \"%s\" isn't denied or allowed access to \"%s\"", name, access_string ), true )
		end
	else
		if not success then
			ULib.tsayError( calling_ply, string.format( "User \"%s\" is already denied access to \"%s\"", name, access_string ), true )
		else
			ulx.fancyLogAdmin( calling_ply, "#A убрал доступ #q to #s", access_string, name )
		end
	end
end
local userdenyid = ulx.command( CATEGORY_NAME, "ulx userdenyid", ulx.userdenyid, nil, false, false, true )
userdenyid:addParam{ type=ULib.cmds.StringArg, hint="SteamID, IP, or UniqueID" }
userdenyid:addParam{ type=ULib.cmds.StringArg, hint="command" } -- TODO, add completes for this
userdenyid:addParam{ type=ULib.cmds.BoolArg, hint="remove explicit allow or deny instead of outright denying", ULib.cmds.optional }
userdenyid:defaultAccess( ULib.ACCESS_SUPERADMIN )
userdenyid:help( "Удаление доступа." )

function ulx.addgroup( calling_ply, group_name, inherit_from )
	if ULib.ucl.groups[ group_name ] ~= nil then
		ULib.tsayError( calling_ply, "Эта группа уже существует!", true )
		return
	end

	if not ULib.ucl.groups[ inherit_from ] then
		ULib.tsayError( calling_ply, "Группа, которую вы указали для наследования, не существует!", true )
		return
	end

	ULib.ucl.addGroup( group_name, _, inherit_from )
	ulx.fancyLogAdmin( calling_ply, "#A создал группу #s из #s", group_name, inherit_from )
end
local addgroup = ulx.command( CATEGORY_NAME, "ulx addgroup", ulx.addgroup, nil, false, false, true )
addgroup:addParam{ type=ULib.cmds.StringArg, hint="group" }
addgroup:addParam{ type=ULib.cmds.StringArg, completes=ulx.group_names, hint="inherits from", error="invalid group \"%s\" specified", ULib.cmds.restrictToCompletes, default="user", ULib.cmds.optional }
addgroup:defaultAccess( ULib.ACCESS_SUPERADMIN )
addgroup:help( "Создать группу." )

function ulx.renamegroup( calling_ply, current_group, new_group )
	if ULib.ucl.groups[ new_group ] then
		ULib.tsayError( calling_ply, "Целевая группа уже существует!", true )
		return
	end

	ULib.ucl.renameGroup( current_group, new_group )
	ulx.fancyLogAdmin( calling_ply, "#A сменил имя группы #s на #s", current_group, new_group )
end
local renamegroup = ulx.command( CATEGORY_NAME, "ulx renamegroup", ulx.renamegroup, nil, false, false, true )
renamegroup:addParam{ type=ULib.cmds.StringArg, completes=ulx.group_names_no_user, hint="current group", error="invalid group \"%s\" specified", ULib.cmds.restrictToCompletes }
renamegroup:addParam{ type=ULib.cmds.StringArg, hint="new group" }
renamegroup:defaultAccess( ULib.ACCESS_SUPERADMIN )
renamegroup:help( "Переименовать группу." )

function ulx.setGroupCanTarget( calling_ply, group, can_target )
	if can_target and can_target ~= "" and can_target ~= "*" then
		ULib.ucl.setGroupCanTarget( group, can_target )
		ulx.fancyLogAdmin( calling_ply, "#A сменил группу #s которая имеет доступ к #s", group, can_target )
	else
		ULib.ucl.setGroupCanTarget( group, nil )
		ulx.fancyLogAdmin( calling_ply, "#A сменил группу #s которая имеет доступ ко всему", group )
	end
end
local setgroupcantarget = ulx.command( CATEGORY_NAME, "ulx setgroupcantarget", ulx.setGroupCanTarget, nil, false, false, true )
setgroupcantarget:addParam{ type=ULib.cmds.StringArg, completes=ulx.group_names, hint="group", error="invalid group \"%s\" specified", ULib.cmds.restrictToCompletes }
setgroupcantarget:addParam{ type=ULib.cmds.StringArg, hint="target string", ULib.cmds.optional }
setgroupcantarget:defaultAccess( ULib.ACCESS_SUPERADMIN )
setgroupcantarget:help( "Указывает доступ к цели" )

function ulx.removegroup( calling_ply, group_name )
	ULib.ucl.removeGroup( group_name )
	ulx.fancyLogAdmin( calling_ply, "#A rудалить группу #s", group_name )
end
local removegroup = ulx.command( CATEGORY_NAME, "ulx removegroup", ulx.removegroup, nil, false, false, true )
removegroup:addParam{ type=ULib.cmds.StringArg, completes=ulx.group_names_no_user, hint="group", error="invalid group \"%s\" specified", ULib.cmds.restrictToCompletes }
removegroup:defaultAccess( ULib.ACCESS_SUPERADMIN )
removegroup:help( "Удалить группу. БУДЬ ВНИМАТЕЛЬНЕЙ С ЭТИМ!" )

function ulx.groupallow( calling_ply, group_name, access_string, access_tag )
	access_tag = access_tag

	local accessTable
	if access_tag and access_tag ~= "" then
		accessTable = { [access_string]=access_tag }
	else
		accessTable = { access_string }
	end

	local success = ULib.ucl.groupAllow( group_name, accessTable )
	if not success then
		ULib.tsayError( calling_ply, string.format( "Group \"%s\" already has access to \"%s\"", group_name, access_string ), true )
	else
		if not access_tag or access_tag == "" then
			ulx.fancyLogAdmin( calling_ply, "#A выдал доступ #q группе #s", access_string, group_name )
		else
			ulx.fancyLogAdmin( calling_ply, "#A выдал доступ #q с тегом #q к #s", access_string, access_tag, group_name )
		end
	end
end
local groupallow = ulx.command( CATEGORY_NAME, "ulx groupallow", ulx.groupallow, nil, false, false, true )
groupallow:addParam{ type=ULib.cmds.StringArg, completes=ulx.group_names, hint="group", error="invalid group \"%s\" specified", ULib.cmds.restrictToCompletes }
groupallow:addParam{ type=ULib.cmds.StringArg, hint="command" } -- TODO, add completes for this
groupallow:addParam{ type=ULib.cmds.StringArg, hint="access tag", ULib.cmds.optional }
groupallow:defaultAccess( ULib.ACCESS_SUPERADMIN )
groupallow:help( "Добавление группового доступа." )

function ulx.groupdeny( calling_ply, group_name, access_string )
	local accessTable
	if access_tag and access_tag ~= "" then
		accessTable = { [access_string]=access_tag }
	else
		accessTable = { access_string }
	end

	local success = ULib.ucl.groupAllow( group_name, access_string, true )
	if success then
		ulx.fancyLogAdmin( calling_ply, "#A изменил доступ #q к группе #s", access_string, group_name )
	else
		ULib.tsayError( calling_ply, string.format( "Group \"%s\" doesn't have access to \"%s\"", group_name, access_string ), true )
	end
end
local groupdeny = ulx.command( CATEGORY_NAME, "ulx groupdeny", ulx.groupdeny, nil, false, false, true )
groupdeny:addParam{ type=ULib.cmds.StringArg, completes=ulx.group_names, hint="group", error="invalid group \"%s\" specified", ULib.cmds.restrictToCompletes }
groupdeny:addParam{ type=ULib.cmds.StringArg, hint="command" } -- TODO, add completes for this
groupdeny:defaultAccess( ULib.ACCESS_SUPERADMIN )
groupdeny:help( "Удаление доступа" )
