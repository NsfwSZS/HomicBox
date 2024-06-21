AddCSLuaFile()	
CreateConVar("jmod_eft_durmult", 1, {FCVAR_ARCHIVE}, "EFT Armor Durability Multiplier")
CreateConVar("jmod_eft_wghtmult", 1, {FCVAR_ARCHIVE}, "EFT Armor Weight Multiplier")
JMod.BodyPartDamageMults={ -- only used if JMod.Config.QoL.RealisticLocationalDamage is true
	[HITGROUP_HEAD]=3,
	[HITGROUP_CHEST]=1,
	[HITGROUP_GENERIC]=1,
	[HITGROUP_STOMACH]=.5,
	[HITGROUP_GEAR]=.5,
	[HITGROUP_LEFTARM]=.2,
	[HITGROUP_RIGHTARM]=.2,
	[HITGROUP_LEFTLEG]=.2,
	[HITGROUP_RIGHTLEG]=.2
}

JMod.ArmorSlotNiceNames={
	eyes="Eyes",
	mouthnose="Mouth & Nose",
	ears="Ears",
	head="Head",
	chest="Chest",
	back="Back",
	abdomen="Abdomen",
	pelvis="Pelvis",
	waist = "Waist",
	leftthigh="Left Thigh",
	leftcalf="Left Calf",
	rightthigh="Right Thigh",
	rightcalf="Right Calf",
	rightshoulder="Right Shoulder",
	rightforearm="Right Forearm",
	leftshoulder="Left Shoulder",
	leftforearm="Left Forearm",
	acc_head ="Facecover",
	acc_eyes ="Eyewear",
	acc_backpack ="Backpack",
	acc_chestrig ="Chest Rig",
	acc_ears ="Headphones",
	acc_neck ="Aventail",
	armband = "Armband",
	acc_rshoulder = "R. Shoulderguard",
	acc_lshoulder = "L. Shoulderguard",
}

local Class1 = {
	[DMG_BUCKSHOT] = .2,
	[DMG_BLAST] = .05,
	[DMG_BULLET] = .15,
	[DMG_SNIPER] = .01,
	[DMG_AIRBOAT] = .1,
	[DMG_CLUB] = .1,
	[DMG_SLASH] = .3,
	[DMG_CRUSH] = .1,
	[DMG_VEHICLE] = .1,
	[DMG_BURN] = .1,
	[DMG_PLASMA] = .1,
	[DMG_ACID] = .1
}
local Class2 = {
	[DMG_BUCKSHOT] = .35,
	[DMG_BLAST] = .2,
	[DMG_BULLET] = .25,
	[DMG_SNIPER] = .1,
	[DMG_AIRBOAT] = .25,
	[DMG_CLUB] = .25,
	[DMG_SLASH] = .35,
	[DMG_CRUSH] = .35,
	[DMG_VEHICLE] = .25,
	[DMG_BURN] = .25,
	[DMG_PLASMA] = .25,
	[DMG_ACID] = .25
}
local Class3 = {
	[DMG_BUCKSHOT] = .45,
	[DMG_BLAST] = .35,
	[DMG_BULLET] = .45,
	[DMG_SNIPER] = .2,
	[DMG_AIRBOAT] = .45,
	[DMG_CLUB] = .5,
	[DMG_SLASH] = .5,
	[DMG_CRUSH] = .5,
	[DMG_VEHICLE] = .25,
	[DMG_BURN] = .25,
	[DMG_PLASMA] = .45,
	[DMG_ACID] = .45
}
local Class4 = {
	[DMG_BUCKSHOT] = .65,
	[DMG_BLAST] = .5,
	[DMG_BULLET] = .6,
	[DMG_SNIPER] = .35,
	[DMG_AIRBOAT] = .6,
	[DMG_CLUB] = .6,
	[DMG_SLASH] = .6,
	[DMG_CRUSH] = .6,
	[DMG_VEHICLE] = .3,
	[DMG_BURN] = .35,
	[DMG_PLASMA] = .6,
	[DMG_ACID] = .6
}
local Class5 = {
	[DMG_BUCKSHOT] = .9,
	[DMG_BLAST] = .7,
	[DMG_BULLET] = .75,
	[DMG_SNIPER] = .5,
	[DMG_AIRBOAT] = .75,
	[DMG_CLUB] = .75,
	[DMG_SLASH] = .8,
	[DMG_CRUSH] = .75,
	[DMG_VEHICLE] = .4,
	[DMG_BURN] = .35,
	[DMG_PLASMA] = .75,
	[DMG_ACID] = .75
}
local Class6 = {
	[DMG_BUCKSHOT] = .95,
	[DMG_BLAST] = .8,
	[DMG_BULLET] = .9,
	[DMG_SNIPER] = .75,
	[DMG_AIRBOAT] = .9,
	[DMG_CLUB] = .9,
	[DMG_SLASH] = 0.95,
	[DMG_CRUSH] = .9,
	[DMG_VEHICLE] = .6,
	[DMG_BURN] = .45,
	[DMG_PLASMA] = .9,
	[DMG_ACID] = .9
}

local NonArmorProtectionProfile = {
	[DMG_BUCKSHOT] = .1,
	[DMG_BLAST] = .05,
	[DMG_BULLET] = .05,
	[DMG_SNIPER] = .05,
	[DMG_AIRBOAT] = .05,
	[DMG_CLUB] = .05,
	[DMG_SLASH] = .05,
	[DMG_CRUSH] = .05,
	[DMG_VEHICLE] = .05,
	[DMG_BURN] = .05,
	[DMG_PLASMA] = .05,
	[DMG_ACID] = .05
}

local durmult = GetConVarNumber( "jmod_eft_durmult" )
local wgtmult = GetConVarNumber( "jmod_eft_wghtmult" )

local ArmorSounds = {
eq = "eft_gear_sounds/gear_armor_use.wav",
uneq = "eft_gear_sounds/gear_armor_drop.wav"
}
local BackpackSounds = {
eq = "eft_gear_sounds/gear_backpack_use.wav",
uneq = "eft_gear_sounds/gear_backpack_drop.wav"
}
local GenericSounds = {
eq = "eft_gear_sounds/gear_generic_use.wav",
uneq = "eft_gear_sounds/gear_generic_drop.wav"
}
local GogglesSounds = {
eq = "eft_gear_sounds/gear_goggles_use.wav",
uneq = "eft_gear_sounds/gear_goggles_drop.wav"
}
local HelmetSounds = {
eq = "eft_gear_sounds/gear_helmet_use.wav",
uneq = "eft_gear_sounds/gear_helmet_drop.wav"
}
local FShieldSounds = {
eq = "eft_gear_sounds/glassshield_on.wav",
uneq = "eft_gear_sounds/glassshield_off.wav"
}
-- keep in mind that all armor model names must be all lower-case

JMod.AdditionalArmorTable = JMod.AdditionalArmorTable or {}

JMod.AdditionalArmorTable["ACHHC Black"] = {
		PrintName = "[HLM-4] ACHHC Black",
		mdl = "models/helmet_achhc_black/achhc_black.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1.05, 1, 1.05),
		pos = Vector(1.3, -2.6, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 15,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_achhcblack"
	}

JMod.AdditionalArmorTable["ACHHC Olive"] = {
		PrintName = "[HLM-4] ACHHC Olive",
		mdl = "models/helmet_acchc_green/achhc.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1.05, 1, 1.05),
		pos = Vector(1.3, -2.6, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * wgtmult * 15,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_achhcolive"
	}

JMod.AdditionalArmorTable["LShZ"] = {
		PrintName = "[HLM-3] LShZ L. Helm",
		mdl = "models/helmet_lshz/lshz.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.35, -2.7, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9.5,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_lshz"
	}


JMod.AdditionalArmorTable["KiverM"] = {
		PrintName = "[HLM-3] Kiver-M",
		mdl = "models/helmet_kiverm/kiverm.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1,
			acc_ears = 1,
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.5, -2.05, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 12,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_kiverm"
	}

		JMod.AdditionalArmorTable["Kiver Shield"] = {
		PrintName = "[GC-3] Kiver-M FShield",
		mdl = "models/helmet_kiverm/kiverm_shield.mdl", -- tarkov
		snds = FShieldSounds,
		slots = {
			eyes = .9,
			mouthnose = .9,
		},

		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		mskmat = "mask_overlays/dirty_glass",
		siz = Vector(1, 1, 1),
		pos = Vector(1.5, -2.05, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 12,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_kivermshield",
		bdg = {
			[0] = 0,
			[1] = 1
		},
		tgl = {
			slots = {
				eyes=0,
				mouthnose=0
			},
			bdg = {
				[0] = 1,
				[1] = 1
			},
			mskmat = ""
		}

	}

	JMod.AdditionalArmorTable["Gzhel-K"] = {
		PrintName = "[AR-5] Gzhel-K",
		mdl = "models/eft_gjel/gjel.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1.05, 1.05, 1),
		pos = Vector(-3.1, -8.1, 0),
		ang = Angle(-88, 0, 90),
		wgt = wgtmult * 89,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_gzhelk",
		gayPhysics = true
	}


	JMod.AdditionalArmorTable["6B47"] = {
		PrintName = "[HLM-3] 6B47",
		mdl = "models/helmet_6b47/6b47.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.3, -3.5, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 13,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_6b47"
	}

		JMod.AdditionalArmorTable["6B47 Cover"] = {
		PrintName = "[HLM-3] 6B47 (Cover)",
		mdl = "models/helmet_6b47_camo/6b47_camo.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.6, -2.3, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 13,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_6b47chehol"
	}

	JMod.AdditionalArmorTable["6B516"] = {
		PrintName = "[ACR-3] 6B5-16",
		mdl = "models/armor_6b5_khaki/6b5_khaki.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
			acc_chestrig = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1.05, 1.05, 1),
		pos = Vector(-3.3, -12.2, 0),
		ang = Angle(-88, 0, 90),
		wgt = wgtmult * 71,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_6b516"
	}

	JMod.AdditionalArmorTable["6B515"] = {
		PrintName = "[ACR-4] 6B5-15",
		mdl = "models/armor_6b5_flora/6b5.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
			acc_chestrig = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1.05, 1.05, 1),
		pos = Vector(-3.3, -12.2, 0),
		ang = Angle(-88, 0, 90),
		wgt = wgtmult * 112,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_6b515"
	}

	JMod.AdditionalArmorTable["6B13"] = {
		PrintName = "[AR-4] 6B13 (Digi)",
		mdl = "models/armor_6b13_digital/6b13.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(.97, .97, .97),
		pos = Vector(-3.1, -13.1, 0),
		ang = Angle(-88, 0, 90),
		wgt = wgtmult * 105,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_6b13"
	}

	JMod.AdditionalArmorTable["6B13 Flora"] = {
		PrintName = "[AR-4] 6B13 (Flora)",
		mdl = "models/armor_6b13_flora/6b13_flora.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(.97, .97, .97),
		pos = Vector(-3.1, -13.1, 0),
		ang = Angle(-88, 0, 90),
		wgt = wgtmult * 105,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_6b13flora"
	}

	JMod.AdditionalArmorTable["6B13 M"] = {
		PrintName = "[AR-5] 6B13M (Killa)",
		mdl = "models/eft_6b13_killa/6b13_killa.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(.93, .93, .93),
		pos = Vector(-3, 0, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 80,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_6b13m"
	}

	JMod.AdditionalArmorTable["6B23"] = {
		PrintName = "[AR-3] 6B23-1",
		mdl = "models/armor_6b23_digital/6b23.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1.1, 1.05, 1.05),
		pos = Vector(-3.1, -14.3, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 79,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_6b23"
	}

	JMod.AdditionalArmorTable["6B232"] = {
		PrintName = "[AR-4] 6B23-2",
		mdl = "models/armor_6b23_mflora/6b23_mflora.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1.1, 1.05, 1.05),
		pos = Vector(-3.1, -14.3, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 72,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_6b232"
	}


	JMod.AdditionalArmorTable["Module 3M"] = {
		PrintName = "[AR-2] Module 3M",
		mdl = "models/armor_module3m/module3m.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class2,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-2.8, -9, 0),
		ang = Angle(-91, 0, 90),
		wgt = wgtmult * 55,
		dur = durmult * 50,
		ent = "ent_jack_gmod_ezarmor_module3m"
	}

		JMod.AdditionalArmorTable["PACA"] = {
		PrintName = "[AR-2] Paca Soft Armor",
		mdl = "models/eft_paca_armor/paca_soft_armor.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class2,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(0.92, 0.92, 0.92),
		pos = Vector(-2.1, -0.4, 0),
		ang = Angle(-92, 0, 90),
		wgt = wgtmult * 35,
		dur = durmult * 75,
		ent = "ent_jack_gmod_ezarmor_paca"
	}


			JMod.AdditionalArmorTable["TV110"] = {
		PrintName = "[ACR-4] WT TV-110",
		mdl = "models/eft_wartechtv110/wartechtv110.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			acc_chestrig = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(0.94, 0.94, 0.94),
		pos = Vector(-4.9, 1.4, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 73,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_tv110"
	}

	JMod.AdditionalArmorTable["BNTI Zhuk-6a"] = {
		PrintName = "[AR-6] Zhuk-6a",
		mdl = "models/armor_zhuk6a/beetle6a.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -9, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 100,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_zhuk6a"
	}

	JMod.AdditionalArmorTable["Untar Vest"] = {
		PrintName = "[AR-3] Untar Vest",
		mdl = "models/armor_un/un.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-2.1, -8.05, 0),
		ang = Angle(-94, 0, 90),
		wgt = wgtmult * 85,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_untar"
	}

	JMod.AdditionalArmorTable["Untar-Helmet"] = {
		PrintName = "[HLM-3] Untar Helmet",
		mdl = "models/helmet_un/un_helmet.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1.05),
		pos = Vector(1, -2.85, 0),
		ang = Angle(-85, 0, -90),
		wgt = wgtmult * 22,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_untarhelm"
	}

	JMod.AdditionalArmorTable["Zhuk3 Press"] = {
		PrintName = "[AR-3] Zhuk-3 Press",
		mdl = "models/armor_zhuk3/beetle3.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3, -9, 0),
		ang = Angle(-91, 0, 90),
		wgt = wgtmult * 52,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_zhukpress"
	}


	JMod.AdditionalArmorTable["Shlem Maska 1SH"] = {
		PrintName = "[HLM-4] ShMaska",
		mdl = "models/helmet_maska_1sh/maska.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1,
			acc_ears = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1.05),
		pos = Vector(1.8, -2.8, 0.2),
		ang = Angle(-75, 0, -90),
		wgt = wgtmult * 30,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_maska1sh",
	}

	JMod.AdditionalArmorTable["Shmaska 1SH Shield"] = {
		PrintName = "[GC-6] ShMaska FS",
		mdl = "models/helmet_maska_1sh_shield/maska_shield.mdl", -- csgo misc
		snds = GenericSounds,
		slots = {
			eyes = .9,
			mouthnose = .9
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1.05, 1, 1.05),
		pos = Vector(1.7, -2.3, 0.2),
		ang = Angle(-75, 0, -90),
		wgt = wgtmult * 11,
		dur = durmult * 500,
		mskmat = "mats_jack_gmod_sprites/slit_vignette.png",
		ent = "ent_jack_gmod_ezarmor_shlemmask",
		tgl = {
			pos = Vector(6.2, 3, 0.2),
			ang = Angle(180, 180, 90),
			mskmat = "",
			slots = {
				eyes = 0,
				mouthnose = 0
			}
		}
	}


	JMod.AdditionalArmorTable["Shlem Maska 1SH (Killa)"] = {
		PrintName = "[HLM-4] ShMaska (K)",
		mdl = "models/helmet_maska_1sh_killa/maska_killa.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1,
			acc_ears = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1.05),
		pos = Vector(2.05, -2.85, 0),
		ang = Angle(-75, 0, -90),
		wgt = wgtmult * 30,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_maska1shkilla",
	}

	JMod.AdditionalArmorTable["Shmaska 1SH Shield (Killa)"] = {
		PrintName = "[GC-6] ShMaska FS (K)",
		mdl = "models/helmet_maska_1sh_shield_killa/maska_shield_killa.mdl", -- csgo misc
		snds = GenericSounds,
		slots = {
			eyes = .9,
			mouthnose = .9
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1.05, 1, 1.05),
		pos = Vector(1.7, -2.3, 0),
		ang = Angle(-75, 0, -90),
		wgt = wgtmult * 11,
		dur = durmult * 500,
		mskmat = "mats_jack_gmod_sprites/slit_vignette.png",
		ent = "ent_jack_gmod_ezarmor_shlemmaskkilla",
		tgl = {
			pos = Vector(6.2, 3, 0),
			ang = Angle(180, 180, 90),
			mskmat = "",
			slots = {
				eyes = 0,
				mouthnose = 0
			}
		}
	}

	JMod.AdditionalArmorTable["ZSH-1-2M"] = {
		PrintName = "[HLM-4] ZSH-1-2M",
		mdl = "models/helmet_zsh_1var/zsh1-2m.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1,
			acc_ears = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1.02, 1, 1.05),
		pos = Vector(1, -2.6, 0),
		ang = Angle(-85, 0, -90),
		wgt = wgtmult * 30,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_zshhelm"
	}

	JMod.AdditionalArmorTable["ZSH-1-2M v2"] = {
		PrintName = "[HLM-4] ZSH-1-2M v2",
		mdl = "models/helmet_zsh_2var/zsh1-2m_v2.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1,
			acc_ears = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1.02, 1, 1.05),
		pos = Vector(1, -2.6, 0),
		ang = Angle(-85, 0, -90),
		wgt = wgtmult * 30,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_zshhelmv2"
	}


		JMod.AdditionalArmorTable["ZSH-1-2M Face Shield"] = {
		PrintName = "[GC-3] ZSH-1-2M FShield",
		mdl = "models/helmet_zsh_shield/zsh_shield.mdl", -- csgo misc
		snds = FShieldSounds,
		slots = {
			eyes = .85,
			mouthnose = .85
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1.02, 1, 1.05),
		pos = Vector(1, -2.6, 0),
		ang = Angle(-85, 0, -90),
		bdg = {
			[0] = 0
		},
		wgt = wgtmult * 10,
		dur = durmult * 200,
		mskmat = "mask_overlays/dirty_glass",
		ent = "ent_jack_gmod_ezarmor_zshface",
		tgl = {
			bdg = {
			[0] = 1
			},
			mskmat = "",
			slots = {
				eyes = 0,
				mouthnose = 0
			}
		}
	}



		JMod.AdditionalArmorTable["SHPM Firefighter Helmet"] = {
		PrintName = "[HLM-2] SHPM Firefighter",
		mdl = "models/helmet_shpm/shpm.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = .9,
			ears = .8,
			acc_ears = .8,
		},
		def = Class2,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.05, -6.65, 0),
		ang = Angle(-85, 0, -90),
		wgt = wgtmult * 12,
		dur = durmult * 50,
		ent = "ent_jack_gmod_ezarmor_shpmhelm"
	}


		JMod.AdditionalArmorTable["SHPM Faceshield"] = {
		PrintName = "[GC-0] SHPM FShield",
		mdl = "models/helmet_shpm_shield/shpm_shield.mdl", -- csgo misc
		snds = FShieldSounds,
		slots = {
			eyes = .5,
			mouthnose = .5
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(0.9, 0.9, 0.9),
		pos = Vector(1.15, -3.5, 0),
		ang = Angle(-85, 0, -90),
		wgt = wgtmult * 3,
		dur = durmult * 10,
		mskmat = "mask_overlays/dirty_glass",
		ent = "ent_jack_gmod_ezarmor_shpmface",
		tgl = {
		pos = Vector(5, -1.5, 0),
		ang = Angle(-25, 0, -90),
			mskmat = "",
			slots = {
				eyes = 0,
				mouthnose = 0
			}
		}
	}

	JMod.AdditionalArmorTable["Trooper TFO"] = {
		PrintName = "[AR-4] Trooper TFO",
		mdl = "models/eft_trooper/trooper.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-2.7, -6.6, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 50,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_trooper"
	}

	JMod.AdditionalArmorTable["ULACH B"] = {
		PrintName = "[HLM-4] ULACH B",
		mdl = "models/helmet_ulach_black/ulach.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1.03, 1.03, 1.03),
		pos = Vector(1.2, -2.75, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 19,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_ulach"
	}

	JMod.AdditionalArmorTable["ULACH C"] = {
		PrintName = "[HLM-4] ULACH C",
		mdl = "models/helmet_ulach_black/ulach_coyote.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1.03, 1.03, 1.03),
		pos = Vector(1.2, -2.75, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 19,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_ulachcoyote"
	}


	JMod.AdditionalArmorTable["6B43 Vest"] = {
		PrintName = "[AR-6] 6B43 6A V",
		mdl = "models/armor_6b43/6b43_body.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1.05, 1, 1),
		pos = Vector(-2.6, -16.7, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 130,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_6b43vest",
		gayPhysics = true
	}

	JMod.AdditionalArmorTable["6B43 Pelvis"] = {
		PrintName = "[AR-6] 6B43 6A P",
		mdl = "models/armor_6b43/6b43_pelvis.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			pelvis = 1
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1.05, 1, 1),
		pos = Vector(-3.5, -16.7, 0),
		ang = Angle(-86, 0, 90),
		wgt = wgtmult * 10,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_6b43pelvis"
	}

	JMod.AdditionalArmorTable["6B43 Left Shoulder"] = {
		PrintName = "[AR-6] 6B43 L.Sh",
		mdl = "models/armor_6b43/6b43_larm.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			leftshoulder = 1
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_L_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(3.2, -1, -4.5),
		ang = Angle(100, -80, 90),
		wgt = wgtmult * 15,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_6b43lshoulder"
	}

	JMod.AdditionalArmorTable["6B43 RightShoulder"] = {
		PrintName = "[AR-6] 6B43 R.Sh",
		mdl = "models/armor_6b43/6b43_rarm.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			rightshoulder = 1
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_R_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(3.2, -1, 4.5),
		ang = Angle(100, 80, 90),
		wgt = wgtmult * 15,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_6b43rhoulder"
	}

	JMod.AdditionalArmorTable["Altyn"] = {
		PrintName = "[HLM-5] Altyn",
		mdl = "models/helmet_altyn/helmlet_altyn_lod1.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1,
			acc_ears = 1,
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1, -2.38, 0.1),
		ang = Angle(-85, 0, -90),
		wgt = wgtmult * 40,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_altyn"
	}


		JMod.AdditionalArmorTable["Altyn Face Shield"] = {
		PrintName = "[GC-5] Altyn Face Shield",
		mdl = "models/helmet_altynshield/helmet_altyn_face_shield_metal_lod0.mdl", -- csgo misc
		snds = GenericSounds,
		slots = {
			eyes = .9,
			mouthnose = .9
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1, -2.38, 0.1),
		ang = Angle(-85, 0, -90),
		wgt = wgtmult * 14,
		dur = durmult * 400,
		mskmat = "mask_overlays/altyn.png",
		ent = "ent_jack_gmod_ezarmor_altynface",
		tgl = {
		mskmat = "",
		pos = Vector(5.4, -0.18, 0.1),
		ang = Angle(-35, 0, -90),
			slots = {
				eyes = 0,
				mouthnose = 0
			}
		}
	}

	JMod.AdditionalArmorTable["SSh-68"] = {
		PrintName = "[HLM-3] SSh-68 Steel Helmet",
		mdl = "models/helmet_ssh_68/item_equipment_helmet_ssh-68_lod0.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.52, 0.15, 0.1),
		ang = Angle(-90, 0, -90),
		wgt = wgtmult * 15,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_ssh68"
	}


	JMod.AdditionalArmorTable["Sordin"] = {
		PrintName = "[HS] Sordin Supreme PRO-X/L",
		mdl = "models/helmet_sordins/headphones_msa_lod0.mdl", -- sci fi lt
		snds = GenericSounds,
		slots = {
			acc_ears = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(.75, 0, 0.12),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 6.5,
		dur = durmult * 25,
		ent = "ent_jack_gmod_ezarmor_sordin",
	}

	JMod.AdditionalArmorTable["ComTac"] = {
		PrintName = "[HS] Peltor ComTac 2",
		mdl = "models/helmet_comtac/item_equipment_headset_comtacii_lod0.mdl", -- sci fi lt
		snds = GenericSounds,
		slots = {
			acc_ears = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(.75, 0, 0.12),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 7,
		dur = durmult * 25,
		chrg = {
			power = 10
		},
		ent = "ent_jack_gmod_ezarmor_comtac",
		eff = {
			teamComms = true,
			earPro = true
		},
		tgl = {
		bon = "ValveBiped.Bip01_Head1",
			eff = {},
			slots = {
				acc_ears = 0
			},
		}
	}


	JMod.AdditionalArmorTable["ComTac 4"] = {
		PrintName = "[HS] Peltor ComTac 4",
		mdl = "models/headset_comtaciv/headset_comtaciv.mdl", -- sci fi lt
		snds = GenericSounds,
		slots = {
			acc_ears = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(-0.1, 0, 0.12),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 6,
		dur = durmult * 25,
		chrg = {
			power = 10
		},
		ent = "ent_jack_gmod_ezarmor_comtac4",
		eff = {
			teamComms = true,
			earPro = true
		},
		tgl = {
		bon = "ValveBiped.Bip01_Head1",
			eff = {},
			slots = {
				acc_ears = 0
			},
		}
	}

	JMod.AdditionalArmorTable["Crye AirFrame"] = {
		PrintName = "[HLM-4] Crye AirFrame",
		mdl = "models/helmet_cryeairframe/helmet_crye_airframe.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.25, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 8.8,
		dur = durmult * 80,
		ent = "ent_jack_gmod_ezarmor_cryeairframe"
	}

	JMod.AdditionalArmorTable["Crye AirFrame Ears"] = {
		PrintName = "[GC-3] Crye AirFrame Ears",
		mdl = "models/helmet_cryeairframe/item_equipment_helmet_crye_airframe_ears.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			ears = 1,
			acc_ears = 1,
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.25, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 8.8,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_cryeairframeears"
	}

	JMod.AdditionalArmorTable["Crye AirFrame Chops"] = {
		PrintName = "[GC-3] Crye AirFrame Chops",
		mdl = "models/helmet_cryeairframe/item_equipment_helmet_crye_airframe_chops.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			mouthnose = .9,
			ears = .9,
			acc_ears = 1,
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.25, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 8.8,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_cryeairframechops"
	}


	JMod.AdditionalArmorTable["IOTV Gen4 Vest"] = {
		PrintName = "[AR-5] IOTV Gen4 Vest",
		mdl = "models/armor_iotv/iotv_body.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-1.5, -18, 0),
		ang = Angle(-92.5, 0, 90),
		wgt = wgtmult * 136,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_iotvvest",
		gayPhysics = true
	}

	JMod.AdditionalArmorTable["IOTV Gen4 Pelvis"] = {
		PrintName = "[AR-5] IOTV Gen4 Pelvis",
		mdl = "models/armor_iotv/iotv_pelvis.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			pelvis = 1
		},
		bdg = {
			[1] = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-1.5, -18, 0),
		ang = Angle(-92.5, 0, 90),
		wgt = wgtmult * 15,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_iotvpelvis"
	}

	JMod.AdditionalArmorTable["IOTV Gen4 Left Shoulder"] = {
		PrintName = "[AR-5] IOTV Gen4 L.Shoulder",
		mdl = "models/armor_iotv/iotv_larm.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			leftshoulder = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_L_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(1.8, -2.5, -5.2),
		ang = Angle(100, -80, 90),
		wgt = wgtmult * 15,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_iotvlshoulder"
	}

	JMod.AdditionalArmorTable["IOTV Gen4 RightShoulder"] = {
		PrintName = "[AR-5] IOTV Gen4 R.Shoulder",
		mdl = "models/armor_iotv/iotv_rarm.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			rightshoulder = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_R_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(1.8, -2.5, 5.2),
		ang = Angle(100, 80, 90),
		wgt = wgtmult * 15,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_iotvrhoulder"
	}

			JMod.AdditionalArmorTable["TSh-4M-L"] = {
		PrintName = "[HLM-1] TSh-4M-L",
		mdl = "models/helmet_tsh_4m2/tsh_4m2.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1,
			acc_ears = 1,
		},
		def = Class1,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.15, -2.4, 0.1),
		ang = Angle(-90, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 5,
		ent = "ent_jack_gmod_ezarmor_shlemofon",
		chrg = {
			power = 60
		},
		eff = {
			teamComms = true,
			earPro = true
		},
		tgl = {
		slots = {
			head = 1,
			ears = 1,
			acc_ears = 1,
		},
			eff = {},
		},
	}

	JMod.AdditionalArmorTable["Left Armband"] = {
		PrintName = "[ARM] Armband (Colorable) (L)",
		mdl = "models/eft_armbands/armband_colorable.mdl", -- aegis
		snds = GenericSounds,
		slots = {
			armband = 1
		},
		def = NonArmorProtectionProfile,
		bon = "ValveBiped.Bip01_L_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(0.3, 7, -1),
		ang = Angle(0, 90, -45),
		wgt = wgtmult * 1,
		dur = durmult * 99999999,
		ent = "ent_jack_gmod_ezarmor_larmbandcolor"
	}

	JMod.AdditionalArmorTable["Hexgrid"] = {
		PrintName = "[AR-6] 5.11 Hexgrid",
		mdl = "models/armor_custom_hexgrid/custom_hexgrid.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-2.2, -1.8, 0),
		ang = Angle(-95, 0, 90),
		wgt = wgtmult * 77,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_hexgrid",
		gayPhysics = true
	}

		JMod.AdditionalArmorTable["Condor Glasses"] = {
		PrintName = "[EW] NPP KlASS Condor",
		mdl = "models/glasses_npp/compilushki/models/glasses_npp_condor.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = Class1,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(2.5, 1.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 0.03,
		dur = durmult * 15,
		ent = "ent_jack_gmod_ezarmor_condorglass",

	}

	JMod.AdditionalArmorTable["6B3TM"] = {
		PrintName = "[ACR-4] 6B3TM-01M",
		mdl = "models/armor_6b3/compilushki/models/ar_6b3.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
			acc_chestrig = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -10.6, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 92,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_6b3tm",
		gayPhysics = true
	}

	JMod.AdditionalArmorTable["Respirator 3M"] = {
		PrintName = "[FW] Respirator",
		mdl = "models/facecover_gasmask_3m/respirator_3m.mdl", -- MGSV
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		snds = GenericSounds,
		slots = {
			mouthnose = 1
		},
		def = table.Inherit({
			[DMG_NERVEGAS] = .35,
			[DMG_RADIATION] = .75
		}, NonArmorProtectionProfile),
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -2.95, 0),
		ang = Angle(100, 180, 90),
		chrg = {
			chemicals = 10
		},
		wgt = wgtmult * 5,
		dur = durmult * 2,
		sndlop = "snds_jack_gmod/mask_breathe.wav",
		ent = "ent_jack_gmod_ezarmor_3m",
	}

		JMod.AdditionalArmorTable["SOTR"] = {
		PrintName = "[FW] Ops-Core SOTR",
		mdl = "models/facecover_gasmask_opscore/ops_core_sotr_respirator.mdl", -- MGSV
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		snds = GenericSounds,
		slots = {
			mouthnose = 1
		},
		def = table.Inherit({
			[DMG_NERVEGAS] = .35,
			[DMG_RADIATION] = .75
		}, NonArmorProtectionProfile),
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.2, -2.8, 0),
		ang = Angle(100, 180, 90),
		chrg = {
			chemicals = 10
		},
		wgt = wgtmult * 5,
		dur = durmult * 2,
		sndlop = "snds_jack_gmod/mask_breathe.wav",
		ent = "ent_jack_gmod_ezarmor_sotr",
	}

	JMod.AdditionalArmorTable["GP-5"] = {
		PrintName = "[FW] GP-5",
		mdl = "models/facecover_gasmask_gp5/gasmask_gp5.mdl", -- kf2
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		snds = GenericSounds,
		slots = {
			head = 1,
			acc_head = 1,
			acc_eyes = 1,
			eyes = 1,
			mouthnose = 1
		},
		def = table.Inherit({
			[DMG_NERVEGAS] = 1,
			[DMG_RADIATION] = .75
		}, NonArmorProtectionProfile),
		dur = durmult * 2,
		chrg = {
			chemicals = 25
		},
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -2.95, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 5,
		sndlop = "snds_jack_gmod/mask_breathe.wav",
		ent = "ent_jack_gmod_ezarmor_gp5"
	}

	JMod.AdditionalArmorTable["GP-7"] = {
		PrintName = "[FW] GP-7",
		mdl = "models/facecover_gasmask_gp7/gasmask_gp7.mdl", -- kf2
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		snds = GenericSounds,
		slots = {
			acc_eyes = 1,
			eyes = 1,
			mouthnose = 1
		},
		def = table.Inherit({
			[DMG_NERVEGAS] = 1,
			[DMG_RADIATION] = .75
		}, NonArmorProtectionProfile),
		dur = durmult * 2,
		chrg = {
			chemicals = 25
		},
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.23, -2.9, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 5,
		sndlop = "snds_jack_gmod/mask_breathe.wav",
		ent = "ent_jack_gmod_ezarmor_gp7"
	}

	JMod.AdditionalArmorTable["Fast MT Black"] = {
		PrintName = "[HLM-4] FAST MT Black",
		mdl = "models/helmet_ops_core_pack/helmet_ops_core_fast_black.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_fastmtblack"
	}

		JMod.AdditionalArmorTable["Fast MT Tan"] = {
		PrintName = "[HLM-4] FAST MT Tan",
		mdl = "models/helmet_ops_core_pack/helmet_ops_core_fast_tan.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_fastmttan"
	}

	JMod.AdditionalArmorTable["Fast MT Black SLAAP"] = {
		PrintName = "[HLM-5] FAST MT Black SLAAP",
		mdl = "models/helmet_ops_core_pack/helmet_ops_core_fast_black_slaap.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 24,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_fastmtblackslaap"
	}

		JMod.AdditionalArmorTable["Fast MT Tan SLAAP"] = {
		PrintName = "[HLM-5] FAST MT Tan SLAAP",
		mdl = "models/helmet_ops_core_pack/helmet_ops_core_fast_tan_slaap.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 24,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_fastmttanslaap"
	}

	JMod.AdditionalArmorTable["Fast MT Shield"] = {
		PrintName = "[GC-4] FAST MT Face Shield",
		mdl = "models/helmet_ops_core_pack/helmet_ops_core_handgun_face_shield.mdl", -- tarkov
		snds = FShieldSounds,
		slots = {
			eyes = .8,
			mouthnose = .8,
		},

		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		mskmat = "mask_overlays/dirty_glass",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 12,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_fastmtshield",
		bdg = {
			[0] = 0,
			[1] = 1
		},
		tgl = {
			slots = {
				eyes=0,
				mouthnose = 0,
			},
			bdg = {
				[0] = 1,
				[1] = 1
			},
			mskmat = ""
		}

	}

		JMod.AdditionalArmorTable["FAST Visor"] = {
		PrintName = "[GC-2] FAST MT Visor",
		mdl = "models/helmet_ops_core_pack/helmet_ops_core_fast_visor.mdl", -- tarkov
		snds = FShieldSounds,
		slots = {
			eyes = .9,
		},

		def = Class2,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		mskmat = "mask_overlays/dirty_glass",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 3,
		dur = durmult * 25,
		ent = "ent_jack_gmod_ezarmor_fastmtvisor",
		bdg = {
			[0] = 0,
			[1] = 1
		},
		tgl = {
			slots = {
				eyes=0,
			},
			bdg = {
				[0] = 1,
				[1] = 1
			},
			mskmat = ""
		}

	}

		JMod.AdditionalArmorTable["Fast Mandible"] = {
		PrintName = "[GC-2] FAST Gunsight Mandible",
		mdl = "models/helmet_ops_core_pack/helmet_ops_core_fast_gunsight_mandible.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			mouthnose = 1,
		},
		def = Class2,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 12,
		dur = durmult * 25,
		ent = "ent_jack_gmod_ezarmor_fastmandible"
	}

		JMod.AdditionalArmorTable["Fast Side Armor Tan"] = {
		PrintName = "[GC-3] FAST Side Armor Tan",
		mdl = "models/helmet_ops_core_pack/helmet_ops_core_fast_side_armor_tan.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			ears = 1,
			acc_ears = 1,
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 12,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_fastsidearmortan"
	}

		JMod.AdditionalArmorTable["Fast Side Armor Black"] = {
		PrintName = "[GC-3] FAST Side Armor Black",
		mdl = "models/helmet_ops_core_pack/helmet_ops_core_fast_side_armor_black.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			ears = 1,
			acc_ears = 1,
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 12,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_fastsidearmorblack"
	}

	JMod.AdditionalArmorTable["FAST RAC Headset"] = {
		PrintName = "[HS] FAST RAC Headset",
		mdl = "models/helmet_ops_core_pack/helmet_ops_core_rac_headset.mdl", -- sci fi lt
		snds = GenericSounds,
		slots = {
			ears = 1,
			acc_ears = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 6.5,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_fastracheadset",
		chrg = {
			power = 10
		},
		eff = {
			teamComms = true,
			earPro = true
		},
		tgl = {
		slots = {
			ears = 0,
			acc_ears = 0,
		},
			eff = {},
		}
	}

	JMod.AdditionalArmorTable["Slick Black"] = {
		PrintName = "[AR-6] Slick Black",
		mdl = "models/armor_slick/armor_slick_black.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -6.8, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 97,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_slickblack",
		gayPhysics = false
	}

		JMod.AdditionalArmorTable["Slick Tan"] = {
		PrintName = "[AR-6] Slick Tan",
		mdl = "models/armor_slick/armor_slick_tan.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -6.8, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 97,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_slicktan",
		gayPhysics = true
	}

	JMod.AdditionalArmorTable["Slick Olive"] = {
		PrintName = "[AR-6] Slick Olive",
		mdl = "models/armor_slick/armor_slick_olive.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -6.8, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 97,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_slickolive",
		gayPhysics = true
	}

		JMod.AdditionalArmorTable["Korund"] = {
		PrintName = "[AR-5] Korund-VM",
		mdl = "models/armor_korundvm/armor_korundvm.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -6.8, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 98,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_korundvm",
		gayPhysics = true
	}

	JMod.AdditionalArmorTable["SFERA-S"] = {
		PrintName = "[HLM-3] SFERA-S",
		mdl = "models/helmet_sfera/helmet_sphera_c.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.6, -4.2, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 35,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_sferas"
	}

	JMod.AdditionalArmorTable["PSh-97 DJETA"] = {
		PrintName = "[HLM-2] PSh-97 DJETA",
		mdl = "models/helmet_psh97_jeta/item_equipment_helmet_psh97_jeta.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1,
			eyes = 1,
			acc_ears = 1,
		},
		def = Class2,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(2.2, -4.45, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 13,
		dur = durmult * 50,
		mskmat = "mask_overlays/dirty_glass",
		ent = "ent_jack_gmod_ezarmor_djeta",
		bdg = {
		[1] = 0
		},
		tgl = {
		slots = {
				head = 1,
				ears = 1,
				acc_ears = 1,
			},
		bdg = {
			[1] = 1
		},
		mskmat = "",
		}
	}

		JMod.AdditionalArmorTable["NFM THOR CRV"] = {
		PrintName = "[AR-4] NFM THOR CRV",
		mdl = "models/armor_custom_thorcrv/ar_thorcrv.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.35, -5.5, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 90,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_thorcrv",
		gayPhysics = true
	}

	JMod.AdditionalArmorTable["Bastion"] = {
		PrintName = "[HLM-4] Bastion",
		mdl = "models/helmet_diamond_age_bastion/helmet_diamond_age_bastion.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.31, -3.95, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9.6,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_bastion"
	}

	JMod.AdditionalArmorTable["Bastion Shield"] = {
		PrintName = "[HLM-6] Bastion + Plate",
		mdl = "models/helmet_diamond_age_bastion/helmet_diamond_age_bastion_shield.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.31, -3.95, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 19.5,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_bastionshield"
	}

	JMod.AdditionalArmorTable["MSA ACH TC-2001"] = {
		PrintName = "[HLM-4] TC-2001",
		mdl = "models/helmet_mich/helmet_mich2001.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.4, -3.95, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 14,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_mich2001"
	}

	JMod.AdditionalArmorTable["MSA ACH TC-2002"] = {
		PrintName = "[HLM-4] TC-2002",
		mdl = "models/helmet_mich/helmet_mich2002.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.4, -3.95, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 14.5,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_mich2002"
	}

	JMod.AdditionalArmorTable["DevTac Ronin"] = {
		PrintName = "[HLM-3] DevTac Ronin",
		mdl = "models/facecover_devtac/facecover_devtac.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1,
			acc_ears = 1,
			eyes = 1,
			mouthnose = 1,
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.3, -3, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_devtacronin"
	}

	JMod.AdditionalArmorTable["TC 800"] = {
		PrintName = "[HLM-4] Gallet TC 800",
		mdl = "models/helmet_tc800/helmet_tc800.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.4, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 11.7,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_tc800"
	}

	JMod.AdditionalArmorTable["TW EXFIL B"] = {
		PrintName = "[HLM-4] TW EXFIL",
		mdl = "models/helmet_team_wendy_exfil/helmet_team_wendy_exfil_black.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.2, -3.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 11.8,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_twexfilb"
	}

		JMod.AdditionalArmorTable["TW EXFIL Shield B"] = {
		PrintName = "[GC-3] TW EXFIL FS",
		mdl = "models/helmet_team_wendy_exfil/helmet_team_wendy_exfil_face_shield_black.mdl", -- tarkov
		snds = FShieldSounds,
		slots = {
			eyes = .7,
			mouthnose = .7,
		},

		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		mskmat = "mask_overlays/dirty_glass",
		siz = Vector(1, 1, 1),
		pos = Vector(1.2, -3.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 2.52,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_twexfilshieldb",
		bdg = {
			[0] = 1,
			[1] = 0
		},
		tgl = {
			slots = {
				eyes= 0,
				mouthnose = 0,
			},
			bdg = {
				[0] = 1,
				[1] = 1
			},
			mskmat = ""
		}

	}

		JMod.AdditionalArmorTable["TW EXFIL Ears B"] = {
		PrintName = "[GC-3] TW EXFIL EC",
		mdl = "models/helmet_team_wendy_exfil/helmet_team_wendy_exfil_ear_covers_black.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			ears = 1,
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.2, -3.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 1.72,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_twexfilearb"
	}




	JMod.AdditionalArmorTable["TW EXFIL C"] = {
		PrintName = "[HLM-4] TW EXFIL",
		mdl = "models/helmet_team_wendy_exfil/helmet_team_wendy_exfil_coyote.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.2, -3.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 11.8,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_twexfilc"
	}

		JMod.AdditionalArmorTable["TW EXFIL Shield C"] = {
		PrintName = "[GC-3] TW EXFIL FS",
		mdl = "models/helmet_team_wendy_exfil/helmet_team_wendy_exfil_face_shield_coyote.mdl", -- tarkov
		snds = FShieldSounds,
		slots = {
			eyes = .7,
			mouthnose = .7,
		},

		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		mskmat = "mask_overlays/dirty_glass",
		siz = Vector(1, 1, 1),
		pos = Vector(1.2, -3.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 2.52,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_twexfilshieldc",
		bdg = {
			[0] = 1,
			[1] = 0
		},
		tgl = {
			slots = {
				eyes= 0,
				mouthnose = 0,
			},
			bdg = {
				[0] = 1,
				[1] = 1
			},
			mskmat = ""
		}

	}

		JMod.AdditionalArmorTable["TW EXFIL Ears C"] = {
		PrintName = "[GC-3] TW EXFIL EC",
		mdl = "models/helmet_team_wendy_exfil/helmet_team_wendy_exfil_ear_covers_coyote.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			ears = 1,
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.2, -3.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 1.72,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_twexfilearc"
	}

		JMod.AdditionalArmorTable["6B2"] = {
		PrintName = "[AR-2] 6B2",
		mdl = "models/armor_6b2/armor_6b2.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
		},
		def = Class2,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.4, -10.3, 0),
		ang = Angle(-88, 0, 90),
		wgt = wgtmult * 54,
		dur = durmult * 50,
		ent = "ent_jack_gmod_ezarmor_6b2",
		gayPhysics = true
	}

			JMod.AdditionalArmorTable["AACPC"] = {
		PrintName = "[ACR-5] Ars Arma CPC MOD.2",
		mdl = "models/rig_arscpc/cr_arscpc_lod0.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			acc_chestrig = 1,
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(0.94, 0.94, 0.94),
		pos = Vector(-3, -5, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 85,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_aacpc"
	}

		JMod.AdditionalArmorTable["FORT Defender-2"] = {
		PrintName = "[AR-5] FORT Defender-2",
		mdl = "models/armor_def2/armor_def2.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
			pelvis = 1,
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -7.4, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 115,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_defender2",
	}

		JMod.AdditionalArmorTable["FORT Redut-M"] = {
		PrintName = "[AR-5] FORT Redut-M",
		mdl = "models/armor_redut_m/armor_redut_m.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
			pelvis = 1,
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -7.4, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 135,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_redutm",
	}

			JMod.AdditionalArmorTable["TacTec"] = {
		PrintName = "[ACR-5] 5.11 TacTec",
		mdl = "models/rig_carriertactec/rig_carriertactec.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			acc_chestrig = 1,
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(0.94, 0.94, 0.94),
		pos = Vector(-3.3, -3.9, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 95,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_tactec"
	}

		JMod.AdditionalArmorTable["Crye Precision AVS"] = {
		PrintName = "[ACR-4] AVS",
		mdl = "models/rig_cryeavs/rig_cryeavs.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
			pelvis = 1,
			acc_chestrig = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -7.4, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 87,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_cryeavs",
	}

			JMod.AdditionalArmorTable["Eagle Industries MMAC"] = {
		PrintName = "[ACR-4] MMAC",
		mdl = "models/rig_mmac/rig_mmac.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			acc_chestrig = 1,

		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(0.94, 0.94, 0.94),
		pos = Vector(-3.3, -3, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 72,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_mmac"
	}

	JMod.AdditionalArmorTable["Rys-T"] = {
		PrintName = "[HLM-5] Rys-T",
		mdl = "models/helmet_rys_t/helmet_rys_t.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1,
			acc_ears = 1,
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1, -3.4, 0.1),
		ang = Angle(-85, 0, -90),
		wgt = wgtmult * 40,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_ryst"
	}


		JMod.AdditionalArmorTable["Rys-T Face Shield"] = {
		PrintName = "[GC-5] Rys-T FShield",
		mdl = "models/helmet_rys_t/helmet_rys_t_shield.mdl", -- csgo misc
		snds = GenericSounds,
		slots = {
			eyes = .9,
			mouthnose = .9
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1, -3.4, 0.1),
		ang = Angle(-85, 0, -90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 12,
		dur = durmult * 400,
		mskmat = "mask_overlays/altyn.png",
		ent = "ent_jack_gmod_ezarmor_rystface",
		tgl = {
		mskmat = "",
		bdg = {
		[0] = 1
		},
			slots = {
				eyes = 0,
				mouthnose = 0
			}
		}
	}
	JMod.AdditionalArmorTable["PNV-10T NVG"] = {
		PrintName = "[GC] PNV-10T NVG",
		mdl = "models/customizable/nvg_alfa_pnv-10t/nvg_alfa_pnv_10t.mdl", -- scp something
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		slots = {
			eyes = 1
		},
		bdg = {
		[0] = 0,
		[1] = 1,
		[2] = 1,
		},
		def = NonArmorProtectionProfile,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = 5,
		dur = 2,
		chrg = {
			power = 80
		},
		mskmat = "mask_overlays/mask_binocular.png",
		eqsnd = "snds_jack_gmod/tinycapcharge.wav",
		ent = "ent_jack_gmod_ezarmor_pnv10t",
		eff = {
			nightVision = true
		},
		blackvisionwhendead=true,
		tgl = {
			bdg = {
		[0] = 1,
		[1] = 2,
		[2] = 1,
		},
			blackvisionwhendead=false,
			mskmat = "",
			eff = {},
			slots = {
				eyes = 0
			}
		}
	}

	JMod.AdditionalArmorTable["T-7 Thermal Goggles"] = {
		PrintName = "[GC] T-7 Thermal",
		mdl = "models/customizable/thermal_spi_t7/thermal_spi_t7.mdl", -- scp something
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		slots = {
			eyes = 1
		},
		bdg = {
		[0] = 0,
		[1] = 1,
		[2] = 1,
		},
		def = NonArmorProtectionProfile,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.15, -4, 0),
		ang = Angle(-80, 0, -90),
		wgt = 5,
		dur = 2,
		chrg = {
			power = 80
		},
		mskmat = "mask_overlays/thermal.png",
		eqsnd = "snds_jack_gmod/tinycapcharge.wav",
		ent = "ent_jack_gmod_ezarmor_t7thermal",
		eff = {
			thermalVision = true
		},
		blackvisionwhendead=true,
		tgl = {
			bdg = {
		[0] = 1,
		[1] = 2,
		[2] = 1,
		},
			blackvisionwhendead=false,
			mskmat = "",
			eff = {},
			slots = {
				eyes = 0
			}
		}
	}

		JMod.AdditionalArmorTable["UMTBS 6sh112"] = {
		PrintName = "[CR] UMTBS 6sh112",
		mdl = "models/rig_6h112/rig_6h112.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -6.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 17,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_6h112",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Alpha CR"] = {
		PrintName = "[CR] Alpha CR",
		mdl = "models/rig_alpha/rig_alpha.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -7.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 17,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_alphacr",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Azimut B"] = {
		PrintName = "[CR] Azimut",
		mdl = "models/rig_azimut/rig_azimut_black.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -7.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 16,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_azimutb",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Azimut S"] = {
		PrintName = "[CR] Azimut",
		mdl = "models/rig_azimut/rig_azimut_surpat.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -7.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 16,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_azimuts",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Bank Robber"] = {
		PrintName = "[CR] Bank Robber",
		mdl = "models/rig_bankrobber/rig_bankrobber.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -7.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 7,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_bankrobber",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["LBT-1961A"] = {
		PrintName = "[CR] LBT-1961A",
		mdl = "models/rig_bearing/rig_bearing.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -7.5, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 13.6,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_bearing",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["BeltAB"] = {
		PrintName = "[CR] Belt-A+B",
		mdl = "models/rig_beltab/rig_beltab.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -7.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 17,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_beltab",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["BlackRock"] = {
		PrintName = "[CR] BlackRock",
		mdl = "models/rig_blackrock/rig_blackrock.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -7.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 18,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_blackrock",
		tgl = {
		mskmat = "",
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Scav Vest"] = {
		PrintName = "[CR] Scav Vest",
		mdl = "models/rig_vestwild/rig_scavvest.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -10, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 18,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_scavvest",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

			JMod.AdditionalArmorTable["MBAV Tagilla"] = {
		PrintName = "[ACR-6] AVS MBAV",
		mdl = "models/rig_tagilla/rig_tagilla.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			acc_chestrig = 1,
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(0.94, 0.94, 0.94),
		pos = Vector(-3.3, -2, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 78,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_tagilla"
	}











		JMod.AdditionalArmorTable["Dundukk sunglasses"] = {
		PrintName = "[EW] Dundukk",
		mdl = "models/glasses_sport/glasses_sport.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = NonArmorProtectionProfile		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.4, 0.1, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 0.03,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_dundukglass",

	}
JMod.AdditionalArmorTable["UBEY"] = {
		PrintName = "[FW-5] Welding Mask",
		mdl = "models/facecover_welding/facecover_tagilla_kill.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1,
			acc_ears = 1,
			eyes = 1,
			mouthnose = 1,
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.4, -2.7, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 15,
		dur = durmult * 400,
		mskmat = "mask_overlays/altyn.png",
		ent = "ent_jack_gmod_ezarmor_weldingkill"
	}

JMod.AdditionalArmorTable["GORILLA"] = {
		PrintName = "[FW-5] Welding Mask",
		mdl = "models/facecover_welding/facecover_tagilla_gorilla.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1,
			acc_ears = 1,
			eyes = 1,
			mouthnose = 1,
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.4, -2.7, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 15,
		dur = durmult * 400,
		mskmat = "mask_overlays/altyn.png",
		ent = "ent_jack_gmod_ezarmor_weldinggorilla"
	}

JMod.AdditionalArmorTable["Shattered"] = {
		PrintName = "[FW-1] Shattered",
		mdl = "models/facecover_shatteredmask/facecover_shatteredmask.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			acc_ears = 1,
			eyes = 1,
			mouthnose = 1,
		},
		def = Class1,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0, -0.3, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 3,
		dur = durmult * 5,
		ent = "ent_jack_gmod_ezarmor_shattered"
	}

JMod.AdditionalArmorTable["Death Knight"] = {
		PrintName = "[FW-1] Death Knight",
		mdl = "models/facecover_boss_blackknight/facecover_boss_blackknight.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			eyes = 1,
		},
		def = Class1,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.7, -0.6, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 7.8,
		dur = durmult * 5,
		ent = "ent_jack_gmod_ezarmor_deathknight"
	}

JMod.AdditionalArmorTable["Hockey Brawler"] = {
		PrintName = "[FW] Hockey Brawler",
		mdl = "models/facecover_hockey/facecover_hockey_brawler.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			eyes = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.3, -0.4, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 5,
		ent = "ent_jack_gmod_ezarmor_hockeybrawler"
	}

JMod.AdditionalArmorTable["Hockey Captain"] = {
		PrintName = "[FW] Hockey Captain",
		mdl = "models/facecover_hockey/facecover_hockey_captain.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			eyes = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.3, -0.4, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 5,
		ent = "ent_jack_gmod_ezarmor_hockeycaptain"
	}

JMod.AdditionalArmorTable["Hockey Quiet"] = {
		PrintName = "[FW] Hockey Quiet",
		mdl = "models/facecover_hockey/facecover_hockey_quiet.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			eyes = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.3, -0.4, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 5,
		ent = "ent_jack_gmod_ezarmor_hockeyquiet"
	}

			JMod.AdditionalArmorTable["Strandhogg"] = {
		PrintName = "[ACR-4] Strandhogg",
		mdl = "models/rig_strandhogg/rig_strandhogg.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
			acc_chestrig = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(0.94, 0.94, 0.94),
		pos = Vector(-3, -3, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 65,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_strandhogg"
	}

		JMod.AdditionalArmorTable["MK3 Chest Rig"] = {
		PrintName = "[CR] WT MK3 TV-104",
		mdl = "models/rig_mk3/rig_mk3.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.1, -5.7, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 16.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_mk3chestrig",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

	JMod.AdditionalArmorTable["THOR IC Vest"] = {
		PrintName = "[AR-6] NFM THOR IC Vest",
		mdl = "models/armor_thorintcar/armor_thorintcar_body.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -5.6, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 110,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_thoricvest",
		gayPhysics = true
	}

	JMod.AdditionalArmorTable["THOR IC Pelvis"] = {
		PrintName = "[AR-6] NFM THOR IC Pelvis",
		mdl = "models/armor_thorintcar/armor_thorintcar_pelvis.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			pelvis = 1
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -5.6, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 30,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_thoricpelvis"
	}

	JMod.AdditionalArmorTable["NFM THOR IC Left Shoulder"] = {
		PrintName = "[AR-6] NFM THOR IC Left Shoulder",
		mdl = "models/armor_thorintcar/armor_thorintcar_lshoulder.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			leftshoulder = 1
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_L_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(3.2, -1, -5.2),
		ang = Angle(100, -80, 90),
		wgt = wgtmult * 20,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_thoriclshoulder"
	}

	JMod.AdditionalArmorTable["NFM THOR IC Right Shoulder"] = {
		PrintName = "[AR-6] NFM THOR IC Right Shoulder",
		mdl = "models/armor_thorintcar/armor_thorintcar_rshoulder.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			rightshoulder = 1
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_R_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(3.2, -1, 5.2),
		ang = Angle(100, 80, 90),
		wgt = wgtmult * 20,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_thoricrhoulder"
	}

		JMod.AdditionalArmorTable["DIY IDEA CR"] = {
		PrintName = "[CR] IDEA CR",
		mdl = "models/rig_idea/rig_idea.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.55, -5.7, 0),		
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 16.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_ideacr",
		tgl = {	
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["TV-109"] = {
		PrintName = "[CR] WT TV-109",
		mdl = "models/rig_tv109/rig_tv109.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -5.8, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 16.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_wtrig",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

JMod.AdditionalArmorTable["Ghost Balaclava"] = {
		PrintName = "[FW] Ghost Balaclava",
		mdl = "models/facecover_balaclavaskull/facecover_balaclavaskull.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			acc_head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 0.95, 1),
		pos = Vector(1.38, -3.85, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * wgtmult * 5,
		dur = durmult * 9999,
		ent = "ent_jack_gmod_ezarmor_ghostbalacvlava"
	}

JMod.AdditionalArmorTable["Balaclava"] = {
		PrintName = "[FW] Balaclava",
		mdl = "models/facecover_balaclava/facecover_balaclava.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			acc_head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 0.95, 1),
		pos = Vector(1.41, -3.82, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * wgtmult * 5,
		dur = durmult * 9999,
		ent = "ent_jack_gmod_ezarmor_balaclava"
	}

	JMod.AdditionalArmorTable["Lower Half-Mask"] = {
		PrintName = "[FW] Lower Half-Mask",
		mdl = "models/facecover_buffalo/facecover_buffalo.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			acc_head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.41, -3.85, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * wgtmult * 5,
		dur = durmult * 9999,
		ent = "ent_jack_gmod_ezarmor_halfmask"
	}

	JMod.AdditionalArmorTable["Tac-Kek FAST MT"] = {
		PrintName = "[HLM-1] Tac-Kek FAST MT",
		mdl = "models/helmet_tackek/helmet_hops_core_fast.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class1,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.6, -3.6, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 4,5,
		dur = durmult * 25,
		ent = "ent_jack_gmod_ezarmor_tackekfastmt"
	}

		JMod.AdditionalArmorTable["Tac-Kek Heavy Trooper"] = {
		PrintName = "[GC-2] Tac-Kek Heavy Trooper",
		mdl = "models/helmet_tackek/helmet_tk_heavy_trooper.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			eyes = 1,
			mouthnose = 1,
		},
		def = Class2,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.6, -3.6, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 4,
		dur = durmult * 50,
		ent = "ent_jack_gmod_ezarmor_tackekhtrooper"
	}

		JMod.AdditionalArmorTable["Kolpak-1S"] = {
		PrintName = "[HLM-2] Kolpak-1S",
		mdl = "models/helmet_k1c/helmet_k1c.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			ears = 1,
			acc_ears = 1,
		},
		def = Class2,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(.95, .95, .95),
		pos = Vector(1.5, -3.49, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 19,
		dur = durmult * 50,
		ent = "ent_jack_gmod_ezarmor_kolpak1s"
	}


		JMod.AdditionalArmorTable["Kolpak-1S Visor"] = {
		PrintName = "[GC-2] Kolpak-1S Visor",
		mdl = "models/helmet_k1c/helmet_k1c_shield.mdl", -- csgo misc
		snds = FShieldSounds,
		slots = {
			eyes = .8,
			mouthnose = .8
		},
		def = Class2,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(.95, .95, .95),
		pos = Vector(1.5, -3.49, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 10,
		dur = durmult * 50,
		bdg = {
		[0] = 0
		},
		mskmat = "mask_overlays/dirty_glass",
		ent = "ent_jack_gmod_ezarmor_koplak1svisor",
		tgl = {
			bdg = {
			[0] = 1
			},
			mskmat = "",
			slots = {
				eyes = 0,
				mouthnose = 0
			}
		}
	}

	JMod.AdditionalArmorTable["Shemagh (Green)"] = {
		PrintName = "[FW] Shemagh (Green)",
		mdl = "models/facecover_shemagh/facecover_shemagh.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			acc_head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, .96, .96),
		pos = Vector(1.5, -4.05, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * wgtmult * 5,
		dur = durmult * 9999,
		ent = "ent_jack_gmod_ezarmor_shemaghgreen"
	}

	JMod.AdditionalArmorTable["Shemagh (Tan)"] = {
		PrintName = "[FW] Shemagh (Tan)",
		mdl = "models/facecover_shemagh_02/facecover_shemagh_02.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			acc_head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, .96, .98),
		pos = Vector(1.4, -3.9, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * wgtmult * 5,
		dur = durmult * 9999,
		ent = "ent_jack_gmod_ezarmor_shemaghtan",
		bdg = {
		[0] = 0
		},
		tgl = {
			slots = {
			acc_head = 1
			},
			pos = Vector(1.45, -3.8, -0.1),
			bdg = {
			[0] = 1
			},
		},
	}

		JMod.AdditionalArmorTable["Pyramex Proximity"] = {
		PrintName = "[EW] Proximity",
		mdl = "models/glasses_proximity/glasses_proximity.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = NonArmorProtectionProfile		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.4, 0.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 0.03,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_proximityglasses",

	}

		JMod.AdditionalArmorTable["Galvion Caiman"] = {
		PrintName = "[HLM-4] Caiman",
		mdl = "models/helmet_galvion_pack/helmet_galvion_caiman.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(.95, .95, .95),
		pos = Vector(1.85, -3.6, 0),
		ang = Angle(-75, 0, -90),
		wgt = wgtmult * 11.2,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_caiman"
	}

	JMod.AdditionalArmorTable["Galvion Caiman Applique"] = {
		PrintName = "[HLM-4] Caiman + Applique",
		mdl = "models/helmet_galvion_pack/helmet_galvion_caimanapplique.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(.95, .95, .95),
		pos = Vector(1.85, -3.6, 0),
		ang = Angle(-75, 0, -90),
		wgt = wgtmult * 18,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_caimanapplique"
	}

		JMod.AdditionalArmorTable["Caiman FA Visor"] = {
		PrintName = "[GC-2] Caiman FA Visor",
		mdl = "models/helmet_galvion_pack/helmet_galvion_fixed_arm_visor.mdl", -- tarkov
		snds = FShieldSounds,
		slots = {
			eyes = .9,
		},

		def = Class2,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		mskmat = "mask_overlays/dirty_glass",
		siz = Vector(.95, .95, .95),
		pos = Vector(1.85, -3.6, 0),
		ang = Angle(-75, 0, -90),
		wgt = wgtmult * 2.7,
		dur = durmult * 25,
		ent = "ent_jack_gmod_ezarmor_caimanvisor",

	}

		JMod.AdditionalArmorTable["Caiman Mandible"] = {
		PrintName = "[GC-2] Caiman Mandible",
		mdl = "models/helmet_galvion_pack/helmet_galvion_mandible.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			mouthnose = 1,
		},
		def = Class2,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(.95, .95, .95),
		pos = Vector(1.85, -3.6, 0),
		ang = Angle(-75, 0, -90),
		wgt = wgtmult * 11,
		dur = durmult * 50,
		ent = "ent_jack_gmod_ezarmor_caimanmandible"
	}

		JMod.AdditionalArmorTable["Security Vest"] = {
		PrintName = "[CR] Security Vest",
		mdl = "models/rig_ctactical/rig_ctactical.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -7.1, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 5.1,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_securityvest",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

	JMod.AdditionalArmorTable["Leather cap"] = {
		PrintName = "[HW] Leather cap",
		mdl = "models/head_leather/head_leather.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.45, -3.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_leathercap",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(1.45, -3.8, 0),

		}
	}

	JMod.AdditionalArmorTable["USEC cap black"] = {
		PrintName = "[HW] USEC cap (Black)",
		mdl = "models/head_usec/cap_usec_black.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.45, -3.7, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_useccapblack",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(1.45, -3.7, 0),

		}
	}

	JMod.AdditionalArmorTable["USEC cap tan"] = {
		PrintName = "[HW] USEC cap (Tan)",
		mdl = "models/head_usec/cap_usec_sand.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.45, -3.7, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_useccaptan",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(1.45, -3.7, 0),

		}
	}

	JMod.AdditionalArmorTable["BEAR cap black"] = {
		PrintName = "[HW] BEAR cap (Black)",
		mdl = "models/head_bear/cap_bear_black.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.45, -3.7, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_bearcapblack",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(1.45, -3.7, 0),

		}
	}

	JMod.AdditionalArmorTable["BEAR cap green"] = {
		PrintName = "[HW] BEAR cap (Green)",
		mdl = "models/head_bear/cap_bear_khaki.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.45, -3.7, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_bearcapgreen",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(1.45, -3.7, 0),

		}
	}

	JMod.AdditionalArmorTable["Army Cap"] = {
		PrintName = "[HW] Army Cap",
		mdl = "models/head_military/head_military.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0, 0, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_armycap",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0, 0, 0),

		}
	}

	JMod.AdditionalArmorTable["Army Cap Black"] = {
		PrintName = "[HW] Army Cap (Black)",
		mdl = "models/head_military2/head_military2_black.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(-0.1, 0.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_armycapblack",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(-0.1, 0.8, 0),

		}
	}

	JMod.AdditionalArmorTable["Army Cap Brown"] = {
		PrintName = "[HW] Army Cap (Brown)",
		mdl = "models/head_military2/head_military2_brown.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(-0.1, 0.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_armycapbrown",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(-0.1, 0.8, 0),

		}
	}

	JMod.AdditionalArmorTable["Army Cap CADPAT"] = {
		PrintName = "[HW] Army Cap (CADPAT)",
		mdl = "models/head_military2/head_military2_cadpat.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(-0.1, 0.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_armycapcadpat",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(-0.1, 0.8, 0),

		}
	}

	JMod.AdditionalArmorTable["Army Cap Flora"] = {
		PrintName = "[HW] Army Cap (Flora)",
		mdl = "models/head_military2/head_military2_flora.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(-0.1, 0.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_armycapflora",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(-0.1, 0.8, 0),

		}
	}

	JMod.AdditionalArmorTable["Army Cap Sand"] = {
		PrintName = "[HW] Army Cap (Sand)",
		mdl = "models/head_military2/head_military2_sand.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(-0.1, 0.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_armycapsand",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(-0.1, 0.8, 0),

		}
	}

	JMod.AdditionalArmorTable["Army Cap UCP"] = {
		PrintName = "[HW] Army Cap (UCP)",
		mdl = "models/head_military2/head_military2_ucp.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(-0.1, 0.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_armycapucp",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(-0.1, 0.8, 0),

		}
	}


	JMod.AdditionalArmorTable["Tagilla Cap"] = {
		PrintName = "[HW] BOSS Cap",
		mdl = "models/head_tagillacap/head_tagillacap.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.9, -3.2, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 10,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_bosscap",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.9, -3.2, 0),

		}
	}

	JMod.AdditionalArmorTable["Bomber"] = {
		PrintName = "[HW-1] Bomber Beanie",
		mdl = "models/head_bomber/head_bomber.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = Class1,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(-0.5, 1, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 10,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_bomber",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(-0.5, 1, 0),

		}
	}


	JMod.AdditionalArmorTable["Beret Olive"] = {
		PrintName = "[HW] Beret (Olive)",
		mdl = "models/head_beret/head_beret_od.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.75, -5.6, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_beretolive",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(1.75, -5.6, 0),

		}
	}

	JMod.AdditionalArmorTable["Beret Blue"] = {
		PrintName = "[HW] Beret (Blue)",
		mdl = "models/head_beret/head_beret_blue.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.75, -5.6, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_beretblue",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(1.75, -5.6, 0),

		}
	}

	JMod.AdditionalArmorTable["Beret Black"] = {
		PrintName = "[HW] Beret (Black)",
		mdl = "models/head_beret/head_beret_black.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.75, -5.6, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_beretblack",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(1.75, -5.6, 0),

		}
	}


		JMod.AdditionalArmorTable["Vulkan-5"] = {
		PrintName = "[HLM-6] Vulkan-5",
		mdl = "models/helmet_vulkan_5/helmet_vulkan_5.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.5, -5, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 45,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_vulkan5"
	}

	JMod.AdditionalArmorTable["Vulkan-5 Shield"] = {
		PrintName = "[GC-4] Vulkan-5 Shield",
		mdl = "models/helmet_vulkan_5/helmet_vulkan_shield.mdl", -- tarkov
		snds = FShieldSounds,
		slots = {
			eyes = .9,
			mouthnose = .9,
		},

		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		mskmat = "mask_overlays/dirty_glass",
		siz = Vector(1, 1, 1),
		pos = Vector(1.5, -5, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 18,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_vulkan5shield",
		bdg = {
			[0] = 1,
			[1] = 0
		},
		tgl = {
			slots = {
				eyes=0,
				mouthnose = 0,
			},
			bdg = {
				[0] = 1,
				[1] = 1
			},
			mskmat = ""
		}
	}



	JMod.AdditionalArmorTable["LShZ-2DTM"] = {
		PrintName = "[HLM-4] LShZ-2DTM",
		mdl = "models/helmet_lshz2dtm/helmet_lshz2dtm.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.5, -5, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 34,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_lshz2dtm"
	}

	JMod.AdditionalArmorTable["LShZ-2DTM Cover"] = {
		PrintName = "[HLM-4] LShZ-2DTM (w/Cover)",
		mdl = "models/helmet_lshz2dtm/helmet_lshz2dtm_damper.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.5, -5, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 35,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_lshz2dtmcovered"
	}

	JMod.AdditionalArmorTable["LShZ-2DTM Aventail"] = {
		PrintName = "[GC] LShZ-2DTM Aventail",
		mdl = "models/helmet_lshz2dtm/helmet_lshz2dtm_aventail.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			acc_neck = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.5, -5, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 35,
		dur = durmult * 50,
		ent = "ent_jack_gmod_ezarmor_lshz2dtmaventail"
	}

	JMod.AdditionalArmorTable["LShZ-2DTM Shield"] = {
		PrintName = "[GC-4] LShZ-2DTM FShield",
		mdl = "models/helmet_lshz2dtm/helmet_lshz2dtm_shield.mdl", -- tarkov
		snds = FShieldSounds,
		slots = {
			eyes = .9,
			mouthnose = .9,
		},

		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		mskmat = "mask_overlays/dirty_glass",
		siz = Vector(1, 1, 1),
		pos = Vector(1.5, -5, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 10,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_lshz2dtmshield",
		bdg = {
			[0] = 0
		},
		tgl = {
			slots = {
				eyes=0,
				mouthnose = 0,
			},
			bdg = {
				[0] = 1
			},
			mskmat = ""
		}
	}

	JMod.AdditionalArmorTable["PlateFrame GE"] = {
		PrintName = "[ACR-5] PlateFrame GE",
		mdl = "models/rig_ss_precision_boss_big_pipe/rig_ss_precision_boss_big_pipe.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			acc_chestrig = 1,
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -4.8, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 64,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_plateframege"
	}

	JMod.AdditionalArmorTable["M1"] = {
		PrintName = "[ACR-4] M1",
		mdl = "models/rig_m1/rig_m1.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
			acc_chestrig = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3, -5, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 83,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_m1"
	}

	JMod.AdditionalArmorTable["M2"] = {
		PrintName = "[ACR-4] M2",
		mdl = "models/rig_m2/rig_m2.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
			acc_chestrig = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3, -5, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 70,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_m2"
	}

	JMod.AdditionalArmorTable["TT SK"] = {
		PrintName = "[ACR-6] TT SK",
		mdl = "models/rig_tt_plate_carrier/rig_tt_plate_carrier.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			acc_chestrig = 1,
		},
		def = Class6,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3, -4.6, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 75,
		dur = durmult * 500,
		ent = "ent_jack_gmod_ezarmor_ttsk"
	}

	JMod.AdditionalArmorTable["Bagariy"] = {
		PrintName = "[ACR-5] Bagariy",
		mdl = "models/rig_bagarii/rig_bagarii.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
			acc_chestrig = 1,
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3, -4.8, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 130,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_bagariy"
	}

	JMod.AdditionalArmorTable["RBAV-AF"] = {
		PrintName = "[ACR-4] RBAV-AF",
		mdl = "models/rig_bae_rbav_af/rig_bae_rbav_af.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
			acc_chestrig = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3, -4.8, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 75,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_rbavaf"
	}

	JMod.AdditionalArmorTable["CPC GE"] = {
		PrintName = "[ACR-5] CPC GE",
		mdl = "models/rig_boss_blackknight/rig_boss_blackknight.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			acc_chestrig = 1,
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -5, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 86,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_cpcge"
	}

	JMod.AdditionalArmorTable["CPC GE L.Brassard"] = {
		PrintName = "[ACR-0] CPC GE L.Brassard",
		mdl = "models/rig_boss_blackknight/rig_boss_blackknight_brassard_l.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			leftshoulder = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_L_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(1.3, 0.6, -3.5),
		ang = Angle(14, -88, 7),
		wgt = wgtmult * 5,
		dur = durmult * 25,
		ent = "ent_jack_gmod_ezarmor_cpcgelbrassard"
	}

	JMod.AdditionalArmorTable["CPC GE R.Brassard"] = {
		PrintName = "[ACR-0] CPC GE R.Brassard",
		mdl = "models/rig_boss_blackknight/rig_boss_blackknight_brassard_r.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			rightshoulder = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_R_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(1.3, 0.6, 3.5),
		ang = Angle(14, 88, 173),
		wgt = wgtmult * 5,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_cpcgerbrassard"
	}

	JMod.AdditionalArmorTable["Osprey MK4A P"] = {
		PrintName = "[ACR-5] Osprey MK4A P",
		mdl = "models/rig_custom_osprey/rig_osprey_defence.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			acc_chestrig = 1,
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -5.2, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 95,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_ospreyprotec"
	}

	JMod.AdditionalArmorTable["Osprey MK4A A"] = {
		PrintName = "[ACR-4] Osprey MK4A A",
		mdl = "models/rig_custom_osprey/rig_osprey_assault.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			acc_chestrig = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -5.2, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 77,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_ospreyass"
	}




	JMod.AdditionalArmorTable["MK4A L.SH.Guard"] = {
		PrintName = "[GC-0] MK4A L.Sh.Guard",
		mdl = "models/rig_custom_osprey/rig_custom_osprey_shoulderguard_l.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			acc_lshoulder = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -5.2, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 5,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_ospreylshguard"
	}

	JMod.AdditionalArmorTable["MK4A R.SH.Guard"] = {
		PrintName = "[GC-0] MK4A R.Sh.Guard",
		mdl = "models/rig_custom_osprey/rig_custom_osprey_shoulderguard_r.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			acc_rshoulder = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -5.2, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 5,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_ospreyrshguard"
	}

	JMod.AdditionalArmorTable["MK4A P L.Brassard"] = {
		PrintName = "[ACR-5] MK4A P L.Brassard",
		mdl = "models/rig_custom_osprey/rig_custom_osprey_brassard_l.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			leftshoulder = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_L_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(0.4, 0.6, -2.5),
		ang = Angle(14, -90, 7),
		wgt = wgtmult * 10,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_mk4aplbrassard"
	}

	JMod.AdditionalArmorTable["MK4A P R.Brassard"] = {
		PrintName = "[ACR-5] MK4A P R.Brassard",
		mdl = "models/rig_custom_osprey/rig_custom_osprey_brassard_r.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			rightshoulder = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_R_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(0.4, 0.6, 2.5),
		ang = Angle(14, 90, 173),
		wgt = wgtmult * 10,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_mk4aprbrassard"
	}

	JMod.AdditionalArmorTable["MK4A A L.Brassard"] = {
		PrintName = "[ACR-4] MK4A A L.Brassard",
		mdl = "models/rig_custom_osprey/rig_custom_osprey_brassard_l.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			leftshoulder = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_L_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(0.4, 0.6, -2.5),
		ang = Angle(14, -90, 7),
		wgt = wgtmult * 10,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_mk4aalbrassard"
	}

	JMod.AdditionalArmorTable["MK4A A R.Brassard"] = {
		PrintName = "[ACR-4] MK4A A R.Brassard",
		mdl = "models/rig_custom_osprey/rig_custom_osprey_brassard_r.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			rightshoulder = 1
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_R_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(0.4, 0.6, 2.5),
		ang = Angle(14, 90, 173),
		wgt = wgtmult * 10,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_mk4aarbrassard"
	}


		JMod.AdditionalArmorTable["SProfi MK2 A"] = {
		PrintName = "[CR] SProfi MK2 (A)",
		mdl = "models/rig_sprofi_mk2/rig_sprofi_mk2_assault.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3, -5.4, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 14,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_sprofiass",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}


		JMod.AdditionalArmorTable["SProfi MK2 R"] = {
		PrintName = "[CR] SProfi MK2 (R)",
		mdl = "models/rig_sprofi_mk2/rig_sprofi_mk2_recon.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3, -5.4, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 17.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_sprofirecon",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}


		JMod.AdditionalArmorTable["Commando Black"] = {
		PrintName = "[CR] Commando B",
		mdl = "models/rig_commando/rig_commando_black.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3, -5.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 13.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_commandoblack",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Commando Tan"] = {
		PrintName = "[CR] Commando T",
		mdl = "models/rig_commando/rig_commando_tan.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3, -5.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 13.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_commandotan",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["LBCR GE"] = {
		PrintName = "[CR] LBT-1961A GE",
		mdl = "models/rig_boss_birdeye/rig_boss_birdeye.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.1, -5.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 13.6,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_birdeyerig",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}










		JMod.AdditionalArmorTable["Kirasa-N"] = {
		PrintName = "[AR-3] BNTI Kirasa-N",
		mdl = "models/armor_kirasa/kirasa.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1,
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-2.6, -10.1, 0),
		ang = Angle(-91, 0, 90),
		wgt = wgtmult * 71,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_kirasan",
		gayPhysics = true
	}

	JMod.AdditionalArmorTable["GPNVG-18"] = {
		PrintName = "[GC] GPNVG-18",
		mdl = "models/customizable/gpnvg/gpnvg.mdl", -- scp something
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		slots = {
			eyes = 1
		},
		bdg = {
		[0] = 1,
		[1] = 0,
		},
		def = NonArmorProtectionProfile,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.1, -3.7, 0),
		ang = Angle(-80, 0, -90),
		wgt = 5,
		dur = 2,
		chrg = {
			power = 80
		},
		mskmat = "mask_overlays/mask_anvis.png",
		eqsnd = "snds_jack_gmod/tinycapcharge.wav",
		ent = "ent_jack_gmod_ezarmor_gpnvg18",
		eff = {
			nightVision = true
		},
		blackvisionwhendead=true,
		tgl = {
			bdg = {
		[0] = 1,
		[1] = 1,
		},
			blackvisionwhendead=false,
			mskmat = "",
			eff = {},
			slots = {
				eyes = 0
			}
		}
	}

	JMod.AdditionalArmorTable["PVS-14 NVM"] = {
		PrintName = "[GC] PVS-14 NVM",
		mdl = "models/customizable/nvg_pvs14/nvg_pvs14.mdl", -- scp something
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		slots = {
			eyes = 1
		},
		bdg = {
		[0] = 0,
		[1] = 1,
		[2] = 1,
		},
		def = NonArmorProtectionProfile,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(1.4, -4, 0),
		ang = Angle(-75, 0, -90),
		wgt = 5,
		dur = 2,
		chrg = {
			power = 80
		},
		mskmat = "mask_overlays/mask_old_monocular.png",
		eqsnd = "snds_jack_gmod/tinycapcharge.wav",
		ent = "ent_jack_gmod_ezarmor_pvs14nvm",
		eff = {
			nightVision = true
		},
		blackvisionwhendead=true,
		tgl = {
			bdg = {
		[0] = 1,
		[1] = 2,
		[2] = 1,
		},
			blackvisionwhendead=false,
			mskmat = "",
			eff = {},
			slots = {
				eyes = 0
			}
		}
	}

	JMod.AdditionalArmorTable["M32"] = {
		PrintName = "[HS] M32",
		mdl = "models/headset_m32/headset_m32.mdl", -- sci fi lt
		snds = GenericSounds,
		slots = {
			acc_ears = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(-0.38, 0.13, 0.12),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 7,
		dur = durmult * 200,
		chrg = {
			power = 10
		},
		ent = "ent_jack_gmod_ezarmor_m32",
		eff = {
			teamComms = true,
			earPro = true
		},
		tgl = {
		bon = "ValveBiped.Bip01_Head1",
			eff = {},
			slots = {
				acc_ears = 0
			},
		pos = Vector(-0.38, 0.13, 0.12),
		ang = Angle(-80, 0, -90),
		}
	}

	JMod.AdditionalArmorTable["GSSh-01"] = {
		PrintName = "[HS] GSSh-01",
		mdl = "models/headset_gsh01/headset_gsh01.mdl", -- sci fi lt
		snds = GenericSounds,
		slots = {
			acc_ears = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(.95, .95, .95),
		pos = Vector(0.25, 0, 0.12),
		ang = Angle(-75, 0, -90),
		wgt = wgtmult * 6.5,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_gssh01",
	}

	JMod.AdditionalArmorTable["Tactical Sport"] = {
		PrintName = "[HS] Tactical Sport",
		mdl = "models/headset_tactical_sport/headset_tactical_sport.mdl", -- sci fi lt
		snds = GenericSounds,
		slots = {
			acc_ears = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.1, 0, 0.12),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 6.5,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_tacticalsport",
	}


	JMod.AdditionalArmorTable["Razor"] = {
		PrintName = "[HS] Razor",
		mdl = "models/headset_walkers_razor/headset_walkers_razor.mdl", -- sci fi lt
		snds = GenericSounds,
		slots = {
			acc_ears = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0, -0.05, 0.12),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 6.5,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_razor",
	}

	JMod.AdditionalArmorTable["XCEL"] = {
		PrintName = "[HS] XCEL 500BT",
		mdl = "models/headset_xcel/headset_xcel.mdl", -- sci fi lt
		snds = GenericSounds,
		slots = {
			acc_ears = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(-0.05, -0.05, 0.12),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 6.5,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_xcel",
	}

		JMod.AdditionalArmorTable["6B34"] = {
		PrintName = "[EW] 6B34",
		mdl = "models/glasses_6b34/glasses_6b34.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = NonArmorProtectionProfile		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.45, 0.8, 0.12),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 0.3,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_6b34",

	}

		JMod.AdditionalArmorTable["AF Glasses"] = {
		PrintName = "[EW] AF Glasses",
		mdl = "models/glasses_grom/glasses_grom.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = NonArmorProtectionProfile		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.52, 0.8, 0.12),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 0.3,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_afglasses",

	}

		JMod.AdditionalArmorTable["Round Sunglasses"] = {
		PrintName = "[EW] Round",
		mdl = "models/glasses_round/glasses_round.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = NonArmorProtectionProfile		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.52, 0.8, 0.12),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 0.3,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_roundglasses",

	}

		JMod.AdditionalArmorTable["Gas Welder Glasses"] = {
		PrintName = "[EW] Gas Welder",
		mdl = "models/glasses_welder/glasses_welder.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = NonArmorProtectionProfile		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.52, 0.8, 0.12),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 0.3,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_gaswelderglass",

	}

		JMod.AdditionalArmorTable["Aviator Glasses"] = {
		PrintName = "[EW] Aviator",
		mdl = "models/glasses_aviator/glasses_aviator.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = NonArmorProtectionProfile		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.6, -0.3, 0.12),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 0.3,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_aviators",

	}

		JMod.AdditionalArmorTable["Crossbow Glasses"] = {
		PrintName = "[EW] Crossbow",
		mdl = "models/glasses_ess/glasses_crossbow.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = NonArmorProtectionProfile		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.6, -0.3, 0.12),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 0.3,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_crossbow",

	}

		JMod.AdditionalArmorTable["RayBench Glasses"] = {
		PrintName = "[EW] RayBench",
		mdl = "models/glasses_classic/glasses_classic.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = NonArmorProtectionProfile		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.6, -0.3, 0.12),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 0.3,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_raybench",

	}

		JMod.AdditionalArmorTable["Gascan Glasses"] = {
		PrintName = "[EW] Gascan",
		mdl = "models/glasses_gascan/glasses_gascan.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = NonArmorProtectionProfile		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.6, -0.3, 0.12),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 0.3,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_gascan",

	}

		JMod.AdditionalArmorTable["JohnB Glasses"] = {
		PrintName = "[EW] JohnB Liquid DNB",
		mdl = "models/glasses_johnb/glasses_johnb.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = NonArmorProtectionProfile		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.6, -0.3, 0.12),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 0.3,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_johnb",

	}

		JMod.AdditionalArmorTable["M Frame Glasses"] = {
		PrintName = "[EW] M Frame",
		mdl = "models/glasses_m_frame/glasses_m_frame.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = NonArmorProtectionProfile		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.6, -0.3, 0.12),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 0.3,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_mframe",

	}

		JMod.AdditionalArmorTable["Batwolf Glasses"] = {
		PrintName = "[EW] Batwolf",
		mdl = "models/glasses_oakley/glasses_oakley.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = Class1		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.6, -0.3, 0.12),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 0.5,
		dur = durmult * 25,
		ent = "ent_jack_gmod_ezarmor_batwolf",

	}

		JMod.AdditionalArmorTable["Tactical Glasses"] = {
		PrintName = "[EW] Tactical",
		mdl = "models/glasses_protective/glasses_protective.mdl", -- tarkov
		snds = GogglesSounds,
		slots = {
			acc_eyes = 1,
		},

		def = NonArmorProtectionProfile		,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.6, -0.3, 0.12),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 0.3,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_tactical",

	}

			JMod.AdditionalArmorTable["Ars Arma A18"] = {
		PrintName = "[ACR-4] A18 Skanda",
		mdl = "models/rig_ars_arma_a18/rig_ars_arma_a18.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			acc_chestrig = 1,
		},
		def = Class4,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(0.94, 0.94, 0.94),
		pos = Vector(-3.1, -6.4, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 82,
		dur = durmult * 300,
		ent = "ent_jack_gmod_ezarmor_arsarmaa18"
	}

		JMod.AdditionalArmorTable["CSA"] = {
		PrintName = "[CR] CSA CR",
		mdl = "models/rig_cs_assault/rig_cs_assault.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(.95, .95, .95),
		pos = Vector(-3, -6.2, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 16.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_csa",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["D3CRX"] = {
		PrintName = "[CR] D3CRX",
		mdl = "models/rig_d3crx/rig_d3crx.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(.95, .95, .95),
		pos = Vector(-3, -6.25, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 16.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_d3crx",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["MRig"] = {
		PrintName = "[CR] Micro Rig",
		mdl = "models/rig_micro_rig_series/rig_micro_rig_series.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(.98, .98, .98),
		pos = Vector(-3.05, -7.2, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 16.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_microrig",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["MPPV"] = {
		PrintName = "[CR] MPPV",
		mdl = "models/rig_patrol/rig_patrol.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.05, -7.4, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 16.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_mppv",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Thunderbolt"] = {
		PrintName = "[CR] Thunderbolt",
		mdl = "models/rig_thunderbolt/rig_thunderbolt.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.05, -7.4, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 16.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_thunderbolt",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Triton"] = {
		PrintName = "[CR] Triton",
		mdl = "models/rig_triton/rig_triton.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.05, -7.4, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 16.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_triton",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Umka"] = {
		PrintName = "[CR] Umka M33-SET1",
		mdl = "models/rig_umka_m33/rig_umka_m33.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.05, -7.4, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 16.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_umka",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

	JMod.AdditionalArmorTable["HJELM"] = {
		PrintName = "[HLM-3] HJELM",
		mdl = "models/helmet_nfm_hjelm/helmet_nfm_hjelm.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1
		},
		def = Class3,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0, 0.25, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 8,
		dur = durmult * 200,
		ent = "ent_jack_gmod_ezarmor_hjelm"
	}

	JMod.AdditionalArmorTable["BSS-MK1"] = {
		PrintName = "[CR] BSS-MK1",
		mdl = "models/rig_bssmk1/rig_bssmk1.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.35, -6.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 10,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_bssmk1",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

	JMod.AdditionalArmorTable["Tarzan"] = {
		PrintName = "[CR] Tarzan",
		mdl = "models/rig_tarzan/rig_tarzan.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_chestrig = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.5, -6, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 0
		},
		wgt = wgtmult * 14.5,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_tarzan",
		tgl = {
		bdg = {
		[0] = 1
		},
			slots = {
			acc_chestrig = 1,
			}
		}
	}

	JMod.AdditionalArmorTable["Redut-T5 Vest"] = {
		PrintName = "[AR-5] Redut-T5 Vest",
		mdl = "models/armor_redut_t5/armor_redut_t5_armor.mdl", -- tarkov
		snds = ArmorSounds,
		slots = {
			chest = 1,
			abdomen = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -6.7, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 125,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_redutt5vest",
		gayPhysics = true
	}

	JMod.AdditionalArmorTable["Redut-T5 Pelvis"] = {
		PrintName = "[AR-5] Redut-T5 Pelvis",
		mdl = "models/armor_redut_t5/armor_redut_t5_pelvis.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			pelvis = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -6.7, 0),
		ang = Angle(-90, 0, 90),
		wgt = wgtmult * 20,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_redutt5pelvis"
	}

	JMod.AdditionalArmorTable["Redut-T5 L. Brassard"] = {
		PrintName = "[AR-5] Redut-T5 L. Brassard",
		mdl = "models/armor_redut_t5/armor_redut_t5_brassard_l.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			leftshoulder = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_L_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(0, 2, -3),
		ang = Angle(0, -90, 0),
		wgt = wgtmult * 15,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_redutt5lshoulder"
	}

	JMod.AdditionalArmorTable["Redut-T5 R. Brassard"] = {
		PrintName = "[AR-5] Redut-T5 R. Brassard",
		mdl = "models/armor_redut_t5/armor_redut_t5_brassard_r.mdl", -- csgo hydra
		snds = ArmorSounds,
		slots = {
			rightshoulder = 1
		},
		def = Class5,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_R_UpperArm",
		siz = Vector(1, 1, 1),
		pos = Vector(0, 2, 3),
		ang = Angle(0, 90, 180),
		wgt = wgtmult * 15,
		dur = durmult * 400,
		ent = "ent_jack_gmod_ezarmor_redutt5rshoulder"
	}

	JMod.AdditionalArmorTable["Baseball cap"] = {
		PrintName = "[HW] Baseball cap",
		mdl = "models/head_capsuperman/head_cap.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.8, 0, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 80,
		ent = "ent_jack_gmod_ezarmor_scavcap",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.8, 0, 0),

		}
	}

	JMod.AdditionalArmorTable["Beanie"] = {
		PrintName = "[HW] Beanie",
		mdl = "models/head_knitcap/pidorka.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.8, 0, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_scavbeanie",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.8, 0, 0),

		}
	}

	JMod.AdditionalArmorTable["Cowboy"] = {
		PrintName = "[HW] Cowboy",
		mdl = "models/head_cowboy/head_cowboy.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.4, 0.8, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_cowboy",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.4, 0.8, 0),

		}
	}

	JMod.AdditionalArmorTable["Door Kicker"] = {
		PrintName = "[HW] Door Kicker",
		mdl = "models/head_doorkicker/head_doorkicker.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.4, 0.8, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_doorkicker",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.4, 0.8, 0),

		}
	}

	JMod.AdditionalArmorTable["Skull Lock"] = {
		PrintName = "[HW] Skull Lock",
		mdl = "models/customizable/nvg_skull_lock/nvg_skull_lock.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.4, -0.2, 0),
		ang = Angle(-75, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_slock",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.4, 0.8, 0),

		}
	}

	JMod.AdditionalArmorTable["N-15 NVG"] = {
		PrintName = "[GC] N-15 NVG + Strap",
		mdl = "models/customizable/nvg_armasight_n_15/nvg_armasight_n_15.mdl", -- scp something
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		slots = {
			head = 1,
			eyes = 1
		},
		bdg = {
		[0] = 1,
		},
		def = NonArmorProtectionProfile,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0, 0.3, 0),
		ang = Angle(-80, 0, -90),
		wgt = 5,
		dur = 2,
		chrg = {
			power = 80
		},
		mskmat = "mask_overlays/mask_binocular.png",
		eqsnd = "snds_jack_gmod/tinycapcharge.wav",
		ent = "ent_jack_gmod_ezarmor_n15nvg",
		eff = {
			nightVision = true
		},
		blackvisionwhendead=true,
		tgl = {
			bdg = {
		[0] = 0,
		},
			blackvisionwhendead=false,
			mskmat = "",
			eff = {},
			slots = {
				head = 0,
				eyes = 0
			}
		}
	}

JMod.AdditionalArmorTable["Jason"] = {
		PrintName = "[FW] Jason",
		mdl = "models/facecover_halloween/facecover_halloween_jason.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			acc_head = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.1, 0.4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_jason"
	}

JMod.AdditionalArmorTable["Slender"] = {
		PrintName = "[FW] Slender",
		mdl = "models/facecover_halloween/facecover_halloween_slander.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			acc_head = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.1, 0.4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_slender"
	}

JMod.AdditionalArmorTable["Misha Mayorov"] = {
		PrintName = "[FW] Misha Mayorov",
		mdl = "models/facecover_halloween/facecover_halloween_micheal.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			acc_head = 1,
			eyes = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.45, 0.2, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_misha"
	}

JMod.AdditionalArmorTable["Ghoul"] = {
		PrintName = "[FW] Ghoul",
		mdl = "models/facecover_halloween/facecover_halloween_vampire.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			eyes = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.1, 0.8, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_ghoul"
	}

JMod.AdditionalArmorTable["Faceless"] = {
		PrintName = "[FW] Faceless",
		mdl = "models/facecover_halloween/facecover_halloween_kaonasi.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			head = 1,
			acc_head = 1,
			eyes = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.4, 0.4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_faceless"
	}

JMod.AdditionalArmorTable["Glorious"] = {
		PrintName = "[FW-1] Glorious",
		mdl = "models/facecover_glorious/facecover_glorious.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			acc_head = 1,
			head = 1,
			acc_eyes = 1,
			eyes = 1,
			mouthnose = 1,
		},
		def = Class1,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.3, 0, 0),
		ang = Angle(-75, 0, -90),
		wgt = wgtmult * 2.8,
		dur = durmult * 50,
		ent = "ent_jack_gmod_ezarmor_glorious"
	}

JMod.AdditionalArmorTable["Pestily"] = {
		PrintName = "[FW] Pestily",
		mdl = "models/facecover_pestily/facecover_pestily.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			acc_head = 1,
			eyes = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0, 0.4, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_pestily"
	}

JMod.AdditionalArmorTable["Baddie"] = {
		PrintName = "[FW] B. Baddie",
		mdl = "models/facecover_beard/facecover_beard_baddie.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			acc_head = 1,
			eyes = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0, 0.3, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_baddie"
	}

JMod.AdditionalArmorTable["Santa"] = {
		PrintName = "[FW] B. Santa",
		mdl = "models/facecover_beard/facecover_beard_santa.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			acc_head = 1,
			eyes = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0, 0.3, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_santa"
	}

JMod.AdditionalArmorTable["Mustache"] = {
		PrintName = "[FW] Mustache",
		mdl = "models/facecover_mustache/facecover_mustache.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			acc_head = 1,
			eyes = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0, 0.3, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_mustache"
	}

JMod.AdditionalArmorTable["Pipe"] = {
		PrintName = "[FW] Pipe",
		mdl = "models/facecover_pipe/facecover_pipe.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			acc_head = 1,
			eyes = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0, 0.3, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_pipe"
	}

JMod.AdditionalArmorTable["Deadly Skull"] = {
		PrintName = "[FW] Deadly Skull",
		mdl = "models/facecover_skullmask/facecover_skullmask.mdl", -- tarkov
		snds = HelmetSounds,
		slots = {
			acc_head = 1,
			eyes = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.35, 0.1, 0),
		ang = Angle(-75, 0, -90),
		wgt = wgtmult * 1,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_deadlyskull"
	}

	JMod.AdditionalArmorTable["Ushanka"] = {
		PrintName = "[HW] Ushanka",
		mdl = "models/head_ushanka/head_ushanka.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.1, 0.1, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 50,
		ent = "ent_jack_gmod_ezarmor_ushanka",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.1, 0.1, 0),

		}
	}

	JMod.AdditionalArmorTable["Panama"] = {
		PrintName = "[HW] Panama",
		mdl = "models/head_panama/head_panama.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(-0.1, 0.5, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_panama",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(-0.1, 0.4, 0),

		}
	}

	JMod.AdditionalArmorTable["Chimera"] = {
		PrintName = "[HW] Chimera",
		mdl = "models/head_panama_stichprofi/head_panama_stichprofi.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(-0.1, 0.5, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_chimera",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(-0.1, 0.4, 0),

		}
	}

	JMod.AdditionalArmorTable["LLCS"] = {
		PrintName = "[HW] LLCS",
		mdl = "models/head_panama_jackpyke/head_panama_jackpyke.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1,
			acc_head = 1,
			acc_ears = 1,
			acc_eyes = 1,
			eyes = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.4, 0.7, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 25,
		ent = "ent_jack_gmod_ezarmor_jackpyke",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(-0.1, 0.4, 0),

		}
	}

	JMod.AdditionalArmorTable["Fleece"] = {
		PrintName = "[HW] Fleece",
		mdl = "models/head_fleece/head_fleece.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.5, 0.6, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_fleece",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.5, 0.6, 0),

		}
	}

	JMod.AdditionalArmorTable["Kotton"] = {
		PrintName = "[HW] Kotton",
		mdl = "models/head_kotton/head_kotton.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.4, 0.6, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_kotton",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.4, 0.6, 0),

		}
	}

	JMod.AdditionalArmorTable["EMERCOM"] = {
		PrintName = "[HW] EMERCOM",
		mdl = "models/head_mhs/head_mhs.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.4, 0.6, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_emercom",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.4, 0.6, 0),

		}
	}

	JMod.AdditionalArmorTable["UX PRO"] = {
		PrintName = "[HW] UX PRO",
		mdl = "models/head_ufpro/head_ufpro.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.5, 0.6, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_uxpro",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.5, 0.6, 0),

		}
	}

	JMod.AdditionalArmorTable["Pompon"] = {
		PrintName = "[HW] Pompon",
		mdl = "models/head_pompon/head_pompon.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.5, 0.6, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_pompon",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.5, 0.6, 0),

		}
	}

	JMod.AdditionalArmorTable["Police"] = {
		PrintName = "[HW] Police",
		mdl = "models/head_police/head_police.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.5, 0.6, 0),
		ang = Angle(-70, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_police",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.5, 0.6, 0),

		}
	}

	JMod.AdditionalArmorTable["Ski Hat"] = {
		PrintName = "[HW] Ski Hat",
		mdl = "models/head_skihat/head_skihat.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.6, 0.6, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_skihat",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.6, 0.6, 0),

		}
	}

	JMod.AdditionalArmorTable["Bandana"] = {
		PrintName = "[HW] Bandana",
		mdl = "models/head_bandana/head_bandana.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.2, 0.6, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_bandana",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.2, 0.6, 0),

		}
	}

	JMod.AdditionalArmorTable["Big Pipe's Bandana"] = {
		PrintName = "[HW] Big Pipe's Bandana",
		mdl = "models/head_bandana/head_bandana_boss_big_pipe.mdl", -- tarkov
		snds = GenericSounds,
		slots = {
			head = 1
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(0.2, 0.6, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 9,
		dur = durmult * 10,
		ent = "ent_jack_gmod_ezarmor_bossbandana",
		tgl = {
		slots = {
			head = 1
		},
		siz = Vector(1.05, 1.05, 1.05),
		pos = Vector(0.2, 0.6, 0),

		}
	}




















































	JMod.AdditionalArmorTable["White Catphones"] = {
		PrintName = "[HS] Catears [W]",
		mdl = "models/maku/catearheadphones_white.mdl", -- sci fi lt
		snds = GeneralSounds,
		slots = {
			acc_ears = 1
		},
		def = NonArmorProtectionProfile,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(.75, -.5, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 5,
		dur = durmult * 200,
		chrg = {
			power = 10
		},
		ent = "ent_jack_gmod_ezarmor_catphonewhite",
		eff = {
			teamComms = true,
			earPro = true
		},
		tgl = {
		bon = "ValveBiped.Bip01_Head1",
			eff = {},
			slots = {
				acc_ears = 0
			},
			pos = Vector(.75, -.5, 0),
			ang = Angle(-80, 0, -90),
		}
	}


		JMod.AdditionalArmorTable["Black Catphones"] = {
		PrintName = "[HS] Catears [B]",
		mdl = "models/maku/catearheadphones_black.mdl", -- sci fi lt
		snds = GeneralSounds,
		slots = {
			acc_ears = 1
		},
		def = NonArmorProtectionProfile,
		bon = "ValveBiped.Bip01_Head1",
		siz = Vector(1, 1, 1),
		pos = Vector(.75, -.5, 0),
		ang = Angle(-80, 0, -90),
		wgt = wgtmult * 5,
		dur = durmult * 200,
		chrg = {
			power = 10
		},
		ent = "ent_jack_gmod_ezarmor_catphoneblack",
		eff = {
			teamComms = true,
			earPro = true
		},
		tgl = {
		bon = "ValveBiped.Bip01_Head1",
			eff = {},
			slots = {
				acc_ears = 0
			},
			pos = Vector(.75, -.5, 0),
			ang = Angle(-80, 0, -90),
		}
	}

		JMod.AdditionalArmorTable["Berkut BP"] = {
		PrintName = "[BP] WT Berkut",
		mdl = "models/backpack_wartech/backpack_wartech.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -7.9, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 9.6,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_berkutbp",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["6Sh118"] = {
		PrintName = "[BP] 6Sh118",
		mdl = "models/backpack_6sh118/backpack_6sh118.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -11.4, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 63.6,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_6sh118",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Mechanism"] = {
		PrintName = "[BP] Mechanism",
		mdl = "models/backpack_mech/backpack_mech.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.3, -8.2, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 15,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_mechanismbp",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Pillbox"] = {
		PrintName = "[BP] Pillbox",
		mdl = "models/backpack_pillbox/backpack_pillbox.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3, -9.2, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 25.2,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_pillboxbp",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Takedown Black"] = {
		PrintName = "[BP] Takedown",
		mdl = "models/backpack_takedown_sling/backpack_takedown_sling_b.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -12.7, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 16.8,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_takedownbbp",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Takedown Multicam"] = {
		PrintName = "[BP] Takedown",
		mdl = "models/backpack_takedown_sling/backpack_takedown_sling_m.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -12.7, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 16.8,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_takedownmbp",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["LBT-2670 SFMP"] = {
		PrintName = "[BP] LBT-2670 SFMP",
		mdl = "models/backpack_medpack/backpack_medpack.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.4, -8.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 19.2,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_sfmp",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Blackjack"] = {
		PrintName = "[BP] Blackjack",
		mdl = "models/backpack_blackjack/backpack_blackjack.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.4, -9, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 30,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_blackjack",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["F4 Terminator"] = {
		PrintName = "[BP] F4 Terminator",
		mdl = "models/backpack_f4terminator/backpack_f4terminator.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.4, -11, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 43.56,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_f4terminator",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["SSO Attack 2"] = {
		PrintName = "[BP] SSO Attack 2",
		mdl = "models/backpack_sso/backpack_sso.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.4, -9.8, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 61.2,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_attack2",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Pilgrim"] = {
		PrintName = "[BP] Pilgrim",
		mdl = "models/backpack_pilgrim/backpack_pilgrim.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.4, -12, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 34.8,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_piligrim",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Paratus 3-Day"] = {
		PrintName = "[BP] Paratus 3-Day",
		mdl = "models/backpack_paratus_3_day/backpack_paratus_3_day.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -8, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 15.6,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_paratus",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Gunslinger"] = {
		PrintName = "[BP] G2 Gunslinger II",
		mdl = "models/backpack_g2_gunslinger/backpack_g2_gunslinger.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -8, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 33.6,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_gunslinger",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Beta 2 Battle BP"] = {
		PrintName = "[BP] Beta 2 Battle BP",
		mdl = "models/backpack_betav2/backpack_betav2.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.5, -9.4, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 13.2,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_beta2bp",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Gruppa 99 T30 (B)"] = {
		PrintName = "[BP] Gruppa 99 T30 (B)",
		mdl = "models/backpack_gr99t30/backpack_gr99t30_b.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -9.4, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 22.2,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_gruppa99t30b",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Gruppa 99 T30 (M)"] = {
		PrintName = "[BP] Gruppa 99 T30 (M)",
		mdl = "models/backpack_gr99t30/backpack_gr99t30_m.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -9.4, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 22.2,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_gruppa99t30m",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Tri-Zip"] = {
		PrintName = "[BP] Tri-Zip",
		mdl = "models/backpack_trizip/backpack_trizip.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -7.5, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 15.6,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_trizip",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["F5 Switchblade"] = {
		PrintName = "[BP] F5 Switchblade",
		mdl = "models/backpack_f5switchblade/backpack_f5switchblade.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -7.5, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 15.72,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_switchblade",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["LBT-1476A"] = {
		PrintName = "[BP] LBT-1476A",
		mdl = "models/backpack_lbt1476a/backpack_lbt1476a.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -8.9, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 13.56,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_lbt1476a",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Gruppa 99 T20 (T)"] = {
		PrintName = "[BP] Gruppa 99 T20 (T)",
		mdl = "models/backpack_gr99t20/backpack_gr99t20_o.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -10, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 18,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_gruppa99t20t",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Gruppa 99 T20 (M)"] = {
		PrintName = "[BP] Gruppa 99 T20 (M)",
		mdl = "models/backpack_gr99t20/backpack_gr99t20_m.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -10, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 18,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_gruppa99t20m",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Drawbridge"] = {
		PrintName = "[BP] Drawbridge",
		mdl = "models/backpack_drawbridge/backpack_drawbridge.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -9.9, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 15.6,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_drawbridge",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["LBT-8005A Day Pack"] = {
		PrintName = "[BP] LBT-8005A Day Pack",
		mdl = "models/backpack_daypack/backpack_daypack.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -9, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 6.72,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_daypack",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Scav Backpack"] = {
		PrintName = "[BP] Scav Backpack",
		mdl = "models/backpack_baselardwild/backpack_baselardwild.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.1, -15.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 16.8,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_scavbackpack",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Flyye MBSS"] = {
		PrintName = "[BP] Flyye MBSS",
		mdl = "models/backpack_baselard/backpack_baselard.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.15, -7.3, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 6,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_flyyembss",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Sanitar's Bag"] = {
		PrintName = "[BP] Sanitar's Bag",
		mdl = "models/backpack_sanitar_medbag/backpack_sanitar_medbag.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.25, -10, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 6,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_sanitarbag",
	}

		JMod.AdditionalArmorTable["NICE COMM 3 BVS"] = {
		PrintName = "[BP] NICE COMM 3 BVS",
		mdl = "models/backpack_boss_birdeye/backpack_boss_birdeye.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.25, -10.9, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 150,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_birdeyebackpack",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Duffle Bag"] = {
		PrintName = "[BP] Duffle Bag",
		mdl = "models/backpack_sportbag/backpack_sportbag.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.22, -12, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 10.8,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_dufflebag",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["LolKek 3F"] = {
		PrintName = "[BP] LolKek 3F",
		mdl = "models/backpack_redfox/backpack_redfox.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -7, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 9.84,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_lolkek3f",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Tactical Sling Bag"] = {
		PrintName = "[BP] Tactical Sling Bag",
		mdl = "models/backpack_molle/backpack_molle.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.2, -6, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 4.8,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_tacticalslingb",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["Transformer Bag"] = {
		PrintName = "[BP] Transformer Bag",
		mdl = "models/backpack_tactical/backpack_tactical.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3.25, -15.7, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 8.4,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_transformerbag",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}

		JMod.AdditionalArmorTable["VKBO Army Bag"] = {
		PrintName = "[BP] VKBO Army Bag",
		mdl = "models/backpack_vkbo/backpack_vkbo.mdl", -- csgo misc
		snds = ArmorSounds,
		slots = {
			acc_backpack = 1,
		},
		def = NonArmorProtectionProfile,
		clr = { r = 255, g = 255, b = 255 },
		clrForced = true,
		bon = "ValveBiped.Bip01_Spine2",
		siz = Vector(1, 1, 1),
		pos = Vector(-3, -12.15, 0),
		ang = Angle(-90, 0, 90),
		bdg = {
		[0] = 1
		},
		wgt = wgtmult * 9.6,
		dur = durmult * 999,
		ent = "ent_jack_gmod_ezarmor_vkboarmybag",
		tgl = {
		bdg = {
		[0] = 2
		},
			slots = {
			acc_backpack = 1,
			}
		}
	}













function JMod.GenerateArmorEntities(tbl)
	for class, info in pairs(tbl) do
		if info.noent then continue end
		local armorent = {}
		armorent.Base = "ent_jack_gmod_ezarmor"
		armorent.PrintName = info.PrintName or class
		armorent.Spawnable = info.Spawnable or true
		armorent.AdminOnly = info.AdminOnly or false
		armorent.Category = info.Category or "JMod - EZ EFT Armor"
		armorent.ArmorName = class
		armorent.ModelScale = info.gayPhysics and nil or info.entsiz -- or math.max(info.siz.x, info.siz.y, info.siz.z)
		scripted_ents.Register( armorent, info.ent )
	end
end
JMod.GenerateArmorEntities(JMod.AdditionalArmorTable)

local function LoadAdditionalArmor()
	if JMod.AdditionalArmorTable then
		table.Merge(JMod.ArmorTable, JMod.AdditionalArmorTable)
		JMod.GenerateArmorEntities(JMod.AdditionalArmorTable)
	end
end
hook.Add("Initialize","JMod_LoadAdditionalArmor", LoadAdditionalArmor)

LoadAdditionalArmor()