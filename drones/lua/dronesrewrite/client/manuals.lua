DRONES_REWRITE.Manuals = { }

local function AddManual(lab, text)
	table.insert(DRONES_REWRITE.Manuals, {
		label = lab,
		text = text
	})
end

AddManual("F.A.Q.", [[
  Q: How to edit drones?
  A: Read "Customizing drones" guide here

  Q: How to drive mothership?!
  A: Sit down on chair on ship bridge and type
      control MSP

  Q: How to turn into Thirdperson?
  A: Press I key (by default)

  Q: I do not see where I shoot. 
      What to do?
  A: Press your WeaponView key 
      (T by default)

  Q: Where can I find a list of the
      console variables?
  A: All console variables you need can be
      changed in
      Q > Options > Drones Rewrite

  Q: I've just found a bug! What to do?
  A: Let us know and we will fix it. Go to
      Q > Options > Drones Settings > Help > Having issue? Let us know

  Q: How to fly farther than 10000 units without losing signal?
  A: Use "Controller" or "Control station"
      You can find them in Drones Rewrite Tools.
      Also you can just add module Signal booster
      or check No signal option in Q > Options > 
      Drones Rewrite > Server

  Q: How to refuel drone?
  A: Go to Q > Entities > Drones Rewrite Tools
      And find there entity called Gas Station
      Grab pump and put it on the drone
      After drone's refueling move drone away
      Also you can refuel other drones with GPRO Assistant Drone

  Q: How to change keyboard settings?
  A: Go to Q > Options > Drones Rewrite > Keys

  Q: When I am trying to get drone's controls it
      says "[Drones] You can't drive this drone!"
  A: It means that drone is destroyed or you're not
      owner of that drone or drone has AI installed.
      Repair the drone or hack it if you're not owner or 
      remove AI modules

  Q: Is it possible to change my HUD and Overlay?
  A: Yes, you can do it in Drones Settings > Client
      Uncheck Use Default HUD and Use Default Overlay
      then choose HUD from menu below

  Q: Drones are weak! Is there any way to
      increase their damage?
  A: Yes, go to Q > Options > Drones Rewrite > Server
      and move the Damage coefficient slider

  Q: Drone from Gift Box doesn't fly! What to do?
  A: Press [G] key

  Q: Miniguns are laggy!
  A: Disable shells by checking "No shells" in
      Q > Options > Drones Settings > Server
      also you can disable Muzzleflashes in Client tab there

  Q: How to let people control drones that are
      spawned by other players?
  A: Check "Allow stealing" in Q > Options > Drones Settings > Server

  Q: How to use left and right console screens? They just print
      "No signal"!
  A: They work only if there is selected drone in console
      type select DRONEID
]])

AddManual("Tips and hints", [[
  It is better to disable camera smoothing 
  (Check No camera smoothing) for best shooting
  experience

  No shells checked provides best FPS

  When using Homing Missile Launcher weapon you can
  click Right Mouse Button on the target to
  lock it, also you can control it's rocket by pressing RMB when the rocket flies

  Spider can climb on walls, but do that accurately

  If you prefer normal thirdperson check
  Default thirdperson in client settings

  You can repair console if it is not completely
  destroyed
  
  You can repair broken drones

  If you're adding Drones Rewrite to DarkRP server, you should
  setup drone's owner when it gets spawned.
  Use ENT:SetupOwner(player) function

  Best protection AI combination:
  • AI Check territory
  • AI Attack
  • AI Moving core
  • AI Follow enemy
  • AI Random moving

  Best owner protection AI combination:
  • AI Check territory
  • AI Attack
  • AI Follow owner
  • AI Moving core
]])

AddManual("Binding weapons", [[
  You can bind your weapon only when you're adding it, only in 
  "Add / Remove weapons" window. There will be menu with weapons called 
  "DRONEID's weapons:", when you click on some button in that menu,
  another menu with options will appear:

  * Definitions:
    NEW weapon - weapon that you're adding at the moment
    SELECTED weapon - weapon that you want bind NEW weapon to 

  1 option binds NEW weapon attack1 to SELECTED weapon attack1
  2 option binds NEW weapon attack1 to SELECTED weapon attack2
  3 option binds NEW weapon attack2 to SELECTED weapon attack1
  4 option binds NEW weapon attack2 to SELECTED weapon attack2

  "Remove all chosen binds" undoes binds for SELECTED weapon that you've 
  just chosen with options above

  "Remove" removes SELECTED weapon

  So, adding 1 bind will make NEW weapon Attack1 to SELECTED weapon Attack1.
  So, when you're adding weapon you can bind it's attack keys to some 
  already existing weapon.

  Note: I recommend you to bind weapons by adding Empty weapon and bind all stuff to it

  Example: Binding weapons with Empty
  You've just added some weapons and want to make them all attack at one time.
  So, to do it, you should go to adding weapons menu and find Empty. Next, you
  bind all your weapons to Empty's attack1 with 1 option. (options are explained above)
  Done!

  Also, it's possible to change/add/remove attack keys on any weapon.
  Press C and right click on drone, choose "Bind weapons" and you will see
  menu with weapons. Click on some weapon with left mouse button, and menu with
  options will appear

  If you still do not understand how to bind weapons, ask developers
  in Questions and Answers thread, Q > Options > Drones Settings > Help > Online help
]])

AddManual("Using console and hacking drones", [[
  1. Spawn console (Drones Rewrite Tools)
  2. Press E
  3. Type "help"
  4. Find needed commands
  5. Type these commands
  6. Profit

  Some commands must come with drone's unit
  such as "destroy" command

  For example: destroy DXL171

  To get unit of drone that you want to hack 
  you must get the Remote Controller and look at 
  the drone

  If you want to do something with some drone you
  have to hack it at first

  For example: you want to destroy drone that
  named DXL171 that is not yours.
  At first type "hack DXL171" and after the drone's 
  hacking type "destroy DXL171"

  Also, if you're tired of typing drone's unit
  you can type "select UNIT" and next type
  any command coming with "-sel" but not drone's
  unit
]])

AddManual("Hacking guide", [[
  When you type hack DRONE in console it will give you
  a lot of symbols and words which length is depending on hacking difficulty. 
  You need to choose one of these words, just type it carefully. 
  You have 4 attempts, if you fail you'll need to wait some time to try again. 
  If you chose incorrect word console will say you how much letters are right. 
  For example: word BREED, password TRIED. There will be 3 correct letters: R, E and D. 
  Remember that DEIRT will give you 0 correct letters although it has every letter from TRIED. 
  All letters must be on their places. 

  For more info you can google "Fallout hacking guide" or something like that, 
  our hacking system is ALMOST the same. 
  Credit for it goes to Bethesda Softworks and Obsidian Entertainment. 
]])

local hints = {
  ["unselect"] = "unselects selected drone. Usage: unselect",
  ["health"] = "prints console health. Usage: health",
  ["kick"] = "kicks from drone driving. Usage: kick DRONEID",
  ["info"] = "prints info about drone. Usage: info DRONEID",
  ["imodules"] = "prints found modules. Usage: imodules DRONEID",
  ["modules"] = "prints list of available modules. Usage: modules DRONEID",
  ["dropweps"] = "removes all weapons. Usage: dropweps DRONEID",
  ["hack"] = "hacks drone. Usage: hack DRONEID",
  ["helpmenu"] = "opens this window. Usage: helpmenu",
  ["hints"] = "disables/enables hints for console. Usage: hints 1/0",
  ["addwep"] = "adds weapon. Usage: addwep DRONE WEAPON WEPNAME\n   X Y Z P Y R VISIBLE PRIMARYASSECONDARY ATTACHMENT",
  ["break"] = "breaks drone. Usage: break DRONEID",
  ["screamdriver"] = "makes nice scream. Usage: screamdriver DRONEID",
  ["help"] = "prints list of commands into console. Usage: help",
  ["enable"] = "enables drone. Usage: enable DRONEID",
  ["destroy"] = "destroys drone. Usage: destroy DRONEID",
  ["forcecontrol"] = "makes player control drone even if driver exists.\n   Usage: forcecontrol DRONEID PLAYERNICK",
  ["disable"] = "disables drone. Usage: disable DRONEID",
  ["presskeybind"] = "clicks keybind. Usage: presskeybind DRONEID BIND",
  ["exit"] = "exit from console. Usage: exit",
  ["dropfuel"] = "sets fuel to 0. Usage: dropfuel DRONEID",
  ["dropmodules"] = "removes installed modules. Usage: dropmodules DRONEID",
  ["blockkeys"] = "blocks all keys (w/o Exit) on drone from clicking.\n   Usage: blockkeys DRONEID",
  ["printlist"] = "finds drones and prints their IDs. Usage: printlist",
  ["addmodule"] = "adds module. Usage: addmodule DRONEID MODULENAME",
  ["lights"] = "disables/enables console lamps. Usage: lights 1/0",
  ["printbinds"] = "prints your key binding. Usage: printbinds DRONEID",
  ["overridepower"] = "overrides drone engine power.\n  Usage: overridepower DRONEID VALUE/old",
  ["me"] = "prints YOUR NICK TEXT. Usage: me TEXT or me TEXT COLOR",
  ["screen"] = "disables/enables side console screens. Usage: screen 1/0",
  ["droppropellers"] = "drops drone's propellers. Usage: droppropellers DRONEID",
  ["control"] = "makes you control drone. Usage: control DRONEID",
  ["print"] = "prints something into console.\n   Usage: print TEXT or print TEXT COLOR",
  ["select"] = "selects drone so you can use -sel instead of DRONEID.\n   Usage: select DRONEID",
  ["removemodule"] = "removes some module.\n  Usage: removemodule DRONEID MODULENAME",
  ["removewep"] = "removes some weapon.\n   Usage: removewep DRONEID WEAPONNAME",
  ["say"] = "says something into chat from you. Usage: say TEXT",
  ["clear"] = "clears console screen. Usage: clear",
  ["randscr"] = "disables/enables TV noise console screen. Usage: randscr 1/0"
}

DRONES_REWRITE.Hints = table.Copy(hints) -- ???

local function getcmd()
  local str = ""
  local i = 0

  for k, v in pairs(DRONES_REWRITE.GetCommands()) do
    i = i + 1
    local info = hints[k]
    if not info then info = "no info" end

    str = str .. "  " .. i .. ". " .. k .. " - " .. info .. "\n" .. "\n"
  end

  return str
end

AddManual("Console commands", [[
  Here is list of commands

  DRONEID might be replaced with -sel if you already selected drone
  with select DRONEID command
]] .. "\n" .. getcmd())

AddManual("Controlling drones", [[
  First of all you spawn drone

  There are 4 ways to take drone's controls

  1. You press use key (E) while looking at drone and
      standing afront of it

  2. You spawn Controller 
      (Q > Entities > Drones Rewrite Tools > Controller)
      and press use key (E) on this and after 
      the menu has been approached you type 
      drone's ID and press Control *****

  3. You spawn Console and use it's commands
      For example:
        > printlist

        -- Found drones --
        ARTL213
        G211

        > select G211
        Selected G211

        > control -sel


  4. You take Remote Controller weapon
      (Q > Weapons > Drones Rewrite Tools
       > Remote Controller) and press right mouse button
      until you found any drone. Also you can look at 
      the drone you want to control and press right 
      mouse button, remote controller will take 
      it's controls, but there is a limit of distance 
      that is 10000 units that allows you to get controls 
      just by looking at the drone.
      Also you can control drone's keys by clicking
      Reload key (Default: R)
]])

AddManual("Console chair", [[
  To use console from chair, place chair in front of 
  console and press E on the chair
]])

AddManual("Customizing drones", [[
  In Drones Rewrite you can add weapons to drone,
  add modules, bind weapons

  And the question arises: "How to do it?"

  First of all you spawn drone
  Press C key to see context menu, right click on drone and
  menu will appear, choose needed option in that menu

  Options:

  "Bind weapons"
  "Add / Remove weapons"
  "Upgrades"
]])

AddManual("Customizing drones with CVars", [[
  To see power of drones customizing, you can use CVars.
  We made a lot of CVars to customize your drones on your server or
  client.

  To see all server CVars, go to Q > Options > Drones Settings > Server
  Server CVars are CVars, that can change such things as damage, speed,
  health, etc.

  To see all client CVars, go to Q > Options > Drones Settings > Client
  Client CVars are CVars, that work on every server you join. (they're only
  for your GMod client) These CVars can change such things as HUD, Overlay,
  render stuff, etc.

  Also it's possible to customize AI a bit, 
  go to Q > Options > Drones Settings > AI
]])

AddManual("Known bugs", [[
  When in multiplayer you fly on drone far from yourself 
  almost all sounds disappear. This is because of Source 
  and we probably cant fix that. 

  When you are controlling drone from an isolated place 
  like admin room all effects and other stuff can disappear. 
  That is also because of Source. 

  AI is kinda stupid. 
]])

AddManual("Changelog. Last update: 11/01/2016", [[
  Current addon version: ]] .. DRONES_REWRITE.Version .. [[

  Update: 11/01/2016 changes:

  • Added Supply Drone
  • Added Artillery Drone
  • Added Signal Jammer - it works like microwave drone
  • Added modes for Multitool: physgun mode and keypad hacker mode
  • Common bug fix
  • New Warrior Drone model
  • New upgrades system
  • Optimized network system
  • Optimized effects (FPS+)
  • Optimized precaching system - no more lags when spawn a drone
  • Volume of sounds was reduced
  • Removed useless hints

  Update: 08/11/2016 changes:

  • Added dronesrewrite_copy_clcvars and dronesrewrite_copy_svcvars console commands
  • Added debug mode
  • Added checkbox to disable hell
  • Added version checker
  • Added cool hell ending
  • Fixed DarkRP bug
  • Fixed problem where drones without owner cannot be controlled
  • Fixed hints
  • Fixed some animations
  • Fixed bug with owners in DarkRP
  • Possible fix for networked variables conflicts
  • New module - Decrease fuel consumption
  • New module - Increase fuel capacity
  • New modules system (Perhaps we will add upgrade boxes in next update)
  • New controls / keys tab menu
  • Moved physics controls to physics functions
  • Walker Drone was remaked

  Update: 07/03/2016 changes:

  • Added AR Drone Light
  • Added Laser Commando Drone
  • Added Racing Drone
  • Added realism when lose propellers
  • Added shells for all guns
  • Added laser minigun
  • Added colored blasters
  • Fixed rotors rotation
  • Fixed PLOT-130 animation
  • Fixed issue with addmodule and removemodule commands
  • Fixed removewep command
  • Fixed civil drones propeller model
  • Fixed some manuals
  • Fixed conflict with Skyrim SNPCS
  • New module - Decrease engine noise
  • New module - Increase up speed
  • New module - Invisible for radar
  • New rotors sound for civil drones
  • New camera click sound
  • New VGUI design
  • New Sniper Rifle model
  • New ammo crate for blasters - Blaster Batteries
  • New radar
  • Increased distance (8000 -> 10000)
  • Major AI fix
  • Removed Apply settings button
  • 666 Hell sound as offline sound
  • Smoothed noise
]])

AddManual("Credits", [[
  Code:
    ProfessorBear
    calafex
    EgrOnWire

  Models:
    ProfessorBear
    calafex
    EgrOnWire

  Textures:
    ProfessorBear
    calafex
    EgrOnWire

  Effects:
    Darken217
    calafex
    ProfessorBear

  Balance:
    calafex

  Testers:
    DoomSpy

  Addon is under MIT license
  Copyright (c) 2016 ProfessorBear
]])