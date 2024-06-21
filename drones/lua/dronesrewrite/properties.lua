properties.Add("drr-openupgr", {
	MenuLabel =	"Upgrades and Modules",
	MenuIcon = "icon16/cog.png",

	Filter = function(self, ent, ply)
		return ent.IS_DRR
	end,

	Action = function(self, ent)
		ent:OpenUpgradesMenu()
	end
})

properties.Add("drr-openweps", {
	MenuLabel =	"Add / Remove weapons",
	MenuIcon = "icon16/add.png",

	Filter = function(self, ent, ply)
		return ent.IS_DRR
	end,

	Action = function(self, ent)
		ent:CallWeaponsMenu()
	end
})

properties.Add("drr-openbinds", {
	MenuLabel =	"Add additional weapons' keys",
	MenuIcon = "icon16/key_add.png",

	Filter = function(self, ent, ply)
		return ent.IS_DRR
	end,

	Action = function(self, ent)
		ent:CallBindMenu()
	end
})

properties.Add("drr-openguide", {
	MenuLabel =	"Drones Help",
	MenuIcon = "icon16/book.png",

	Filter = function(self, ent, ply)
		return ent.IS_DRR
	end,

	Action = function(self, ent)
		DRONES_REWRITE.ShowHelpWindow("F.A.Q.")
	end
})