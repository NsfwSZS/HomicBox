JMod = JMod or {}
JMod.LuaConfig = JMod.LuaConfig or {}
JMod.LuaConfig.ArmorOffsets = JMod.LuaConfig.ArmorOffsets or {}

-- eyewear (glasses)
local eye_siz = Vector(.987, .987, .987)
local eye_pos = Vector(-0.25, 0.05, 0)
local eye_ang = Angle(0, 0, 0)

-- headsets
local ear_siz = Vector(.987, .987, .987)
local ear_pos = Vector(-0.2, -0.2, 0)
local ear_ang = Angle(0, 0, 0)

-- head (helmets and everything attached to them (mandible, nvg, face shields))
local head_siz = Vector(.987, .987, .987)
local head_pos = Vector(0.1, 0, 0)
local head_ang = Angle(0, 0, 0)

-- mask (balaclavas)
local mask_siz = Vector(.987, .987, .987)
local mask_pos = Vector(0, -0.2, 0)
local mask_ang = Angle(0, 0, 0)

-- body (armor, rigs, backpacks)
local armor_siz = Vector(.987, .987, .987)
local armor_pos = Vector(1.1, 4, 0)
local armor_ang = Angle(0, 0, 0)

local armotable = {

    -- armor
    ["Hexgrid"]={
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-2.2, -1.8, 0) + armor_pos,
        ang = Angle(-95, 0, 90) + armor_ang,
    },
    ["6B13"] = {
        siz = Vector(1.05, 1, 1) * armor_siz,
        pos = Vector(-3.58, -13.8, 0) + armor_pos,
        ang = Angle(-88, 0, 90) + armor_ang,
    },
    ["Gzhel-K"] = {
        siz = Vector(1.05, 1.05, 1) * armor_siz,
        pos = Vector(-3.1, -8.1, 0) + armor_pos,
        ang = Angle(-88, 0, 90)+ armor_ang,
    },
    ["6B515"] = {
        siz = Vector(1.05, 1.05, 1) * armor_siz,
        pos = Vector(-3.3, -12.2, 0) + armor_pos,
        ang = Angle(-88, 0, 90) + armor_ang,
    },
    ["6B13"] = {
        siz = Vector(.97, .97, .97) * armor_siz,
        pos = Vector(-3.1, -13.1, 0) + armor_pos,
        ang = Angle(-88, 0, 90) + armor_ang,
    },
    ["6B13 Flora"] = {
        siz = Vector(.97, .97, .97) * armor_siz,
        pos = Vector(-3.1, -13.1, 0) + armor_pos,
        ang = Angle(-88, 0, 90) + armor_ang,
    },
    ["6B13 M"] = {
        siz = Vector(.93, .93, .93) * armor_siz,
        pos = Vector(-3, 0, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["6B23"] = {
        siz = Vector(1.1, 1.05, 1.05) * armor_siz,
        pos = Vector(-3.1, -14.3, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["6B232"] = {
        siz = Vector(1.1, 1.05, 1.05) * armor_siz,
        pos = Vector(-3.1, -14.3, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["Module 3M"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-2.8, -9, 0) + armor_pos,
        ang = Angle(-91, 0, 90) + armor_ang,
    },
    ["PACA"] = {
        siz = Vector(0.92, 0.92, 0.92) * armor_siz,
        pos = Vector(-2.1, -0.4, 0) + armor_pos,
        ang = Angle(-92, 0, 90) + armor_ang,
    },
    ["TV110"] = {
        siz = Vector(0.94, 0.94, 0.94) * armor_siz,
        pos = Vector(-4.9, 1.4, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["BNTI Zhuk-6a"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3.2, -9, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["Untar Vest"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3, -8.05, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["Zhuk3 Press"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3, -9, 0) + armor_pos,
        ang = Angle(-91, 0, 90) + armor_ang,
    },
    ["Trooper TFO"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-2.7, -6.8, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["6B3TM"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3.2, -10.6, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["Slick Black"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3.3, -6.8, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["Slick Tan"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3.3, -6.8, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },

    ["Slick Olive"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3.3, -6.8, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["Korund"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3.3, -6.8, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["NFM THOR CRV"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3.35, -5.5, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["6B2"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3.4, -10.3, 0) + armor_pos,
        ang = Angle(-88, 0, 90) + armor_ang,
    },
    ["AACPC"] = {
        siz = Vector(0.94, 0.94, 0.94) * armor_siz,
        pos = Vector(-3, -5, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },

    ["FORT Defender-2"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3.2, -7.4, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["FORT Redut-M"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3.3, -7.4, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["TacTec"] = {
        siz = Vector(0.94, 0.94, 0.94) * armor_siz,
        pos = Vector(-3.3, -3.9, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["Crye Precision AVS"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3.3, -7.4, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["Eagle Industries MMAC"] = {
        siz = Vector(0.94, 0.94, 0.94) * armor_siz,
        pos = Vector(-3.3, -3, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["MBAV Tagilla"] = {
        siz = Vector(0.94, 0.94, 0.94) * armor_siz,
        pos = Vector(-3.3, -2, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["Strandhogg"] = {
        siz = Vector(0.94, 0.94, 0.94) * armor_siz,
        pos = Vector(-3, -3, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["Kirasa-N"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-2.6, -10.1, 0) + armor_pos,
        ang = Angle(-91, 0, 90) + armor_ang,
    },
    ["Ars Arma A18"] = {
        siz = Vector(0.94, 0.94, 0.94) * armor_siz,
        pos = Vector(-3.1, -6.4, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["6B43 Vest"] = {
        siz = Vector(1.05, 1, 1) * armor_siz,
        pos = Vector(-2.6, -16.7, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["6B43 Pelvis"] = {
        siz = Vector(1.05, 1, 1) * armor_siz,
        pos = Vector(-3.5, -16.7, 0) + armor_pos,
        ang = Angle(-86, 0, 90) + armor_ang,
    },
    ["THOR IC Vest"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3.3, -5.6, 0) + armor_pos,
        ang = Angle(-90, 0, 90) + armor_ang,
    },
    ["THOR IC Pelvis"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3.3, -5.6, 0) + armor_pos,
        ang = Angle(-86, 0, 90) + armor_ang,
    },
    ["IOTV Gen4 Vest"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3, -18, 0) + armor_pos,
        ang = Angle(-88, 0, 90) + armor_ang,
    },
    ["IOTV Gen4 Pelvis"] = {
        siz = Vector(1, 1, 1) * armor_siz,
        pos = Vector(-3, -18, 0) + armor_pos,
        ang = Angle(-88, 0, 90) + armor_ang,
    },

    ["PlateFrame GE"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.2, -4.9, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["CPC GE"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.2, -5, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },


    ["M1"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3, -5, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["M2"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3, -5, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["TT SK"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3, -4.8, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },


    ["Bagariy"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-2.9, -4.7, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["RBAV-AF"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3, -4.8, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["Osprey MK4A P"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3, -5.2, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["Osprey MK4A A"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3, -5.2, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["6B516"] = {
        siz = armor_siz * Vector(1.05, 1.05, 1),
        pos = armor_pos + Vector(-3.3, -12, 0),
        ang = armor_ang + Angle(-88, 0, 90),
    },

    ["Redut-T5 Vest"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.3, -6.3, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["Redut-T5 Pelvis"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.3, -6.3, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    -- chest rigs

    ["BSS-MK1"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.35, -6.1, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["Tarzan"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.5, -5.8, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },



        ["UMTBS 6sh112"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.3, -6.3, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["Alpha CR"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.3, -7.3, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["Azimut B"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.3, -7.3, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["Azimut S"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.3, -7.3, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["Bank Robber"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.3, -7.3, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["LBT-1961A"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.3, -7.5, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["BeltAB"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.3, -7.3, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["BlackRock"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.3, -7.3, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["Scav Vest"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.3, -10, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["MK3 Chest Rig"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.1, -5.7, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["DIY IDEA CR"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.55, -5.7, 0),       
        ang = armor_ang + Angle(-90, 0, 90),
    },
         ["TV-109"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.2, -5.8, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["Security Vest"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.2, -7.1, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["CSA"] = {
        siz = armor_siz * Vector(.95, .95, .95),
        pos = armor_pos + Vector(-3, -6.2, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["D3CRX"] = {
        siz = armor_siz * Vector(.95, .95, .95),
        pos = armor_pos + Vector(-3, -6.25, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["MRig"] = {
        siz = armor_siz * Vector(.98, .98, .98),
        pos = armor_pos + Vector(-3.05, -7.2, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["MPPV"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.05, -7.4, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["Thunderbolt"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.05, -7.4, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["Triton"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.05, -7.4, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },
        ["Umka"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.05, -7.4, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },


    ["SProfi MK2 A"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.1, -5.2, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["SProfi MK2 R"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.1, -5.2, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },


    ["Commando Black"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3, -5.1, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["Commando Tan"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3, -5.1, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["LBCR GE"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3.1, -5.1, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    -- backpacks

    ["Berkut BP"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.3, -7.9, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },
    ["6Sh118"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.3, -11.4, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },
    ["Mechanism"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.3, -8.2, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },
    ["Pillbox"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3, -9.2, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },
    ["Takedown Black"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -12.7, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },
    ["Takedown Multicam"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -12.7, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["LBT-2670 SFMP"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.4, -8.3, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Blackjack"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.4, -9, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["F4 Terminator"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.4, -11, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["SSO Attack 2"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.4, -9.8, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Pilgrim"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.4, -12, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Paratus 3-Day"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -8, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Gunslinger"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -8, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Beta 2 Battle BP"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.5, -9.4, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Gruppa 99 T30 (B)"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -9.4, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Gruppa 99 T30 (M)"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -9.4, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Tri-Zip"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -7.5, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["F5 Switchblade"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -7.5, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["LBT-1476A"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -8.9, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Gruppa 99 T20 (T)"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -10, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Gruppa 99 T20 (M)"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -10, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Drawbridge"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -9.9, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["LBT-8005A Day Pack"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -9, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Scav Backpack"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.1, -15.3, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Flyye MBSS"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.15, -7.3, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Sanitar's Bag"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.25, -10, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["NICE COMM 3 BVS"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.25, -10.9, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Duffle Bag"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.22, -12, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["LolKek 3F"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -7, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Tactical Sling Bag"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.2, -6, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["Transformer Bag"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3.25, -15.7, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    ["VKBO Army Bag"] = {
        siz = armor_siz *  Vector(1, 1, 1),
        pos = armor_pos +  Vector(-3, -12.15, 0),
        ang = armor_ang +  Angle(-90, 0, 90),
    },

    -- mask

    ["Ghost Balaclava"] = {
        siz = mask_siz * Vector(1, 0.95, 1),
        pos = mask_pos + Vector(1.38, -3.85, 0),
        ang = mask_ang + Angle(-80, 0, -90),
    },

    ["Balaclava"] = {
        siz = mask_siz * Vector(1, 0.95, 1),
        pos = mask_pos + Vector(1.41, -3.82, 0),
        ang = mask_ang + Angle(-80, 0, -90),
    },

    ["Lower Half-Mask"] = {
        siz = mask_siz * Vector(1, 1, 1),
        pos = mask_pos + Vector(1.41, -3.85, 0),
        ang = mask_ang + Angle(-80, 0, -90),
    },

    ["Shemagh (Green)"] = {
        siz = mask_siz * Vector(1, .96, .96),
        pos = mask_pos + Vector(1.5, -4.05, 0),
        ang = mask_ang +Angle(-80, 0, -90),
    },

    ["Shemagh (Tan)"] = {
        siz = mask_siz * Vector(1, .96, .98),
        pos = mask_pos + Vector(1.4, -3.9, 0),
        ang = mask_ang +Angle(-80, 0, -90),
        tgl = {
            slots = {
            acc_head = 1
            },
            pos = mask_pos + Vector(1.45, -3.8, -0.1),
            bdg = {
            [0] = 1
            },
        },
    },

    -- head

    ["6B47"] = {
        siz = Vector(1, 1, 1) * head_siz,
        pos = Vector(1.3, -3.5, 0) + head_pos,
        ang = Angle(-80, 0, -90) + head_ang,

    },
    ["ACHHC Black"] = {
        siz = head_siz * Vector(1.05, 1, 1.05),
        pos = head_pos + Vector(1.3, -2.6, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["ACHHC Olive"] = {
        siz = head_siz * Vector(1.05, 1, 1.05),
        pos = head_pos + Vector(1.3, -2.6, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["LShZ"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.35, -2.7, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },


    ["KiverM"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.5, -2.05, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["Kiver Shield"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.5, -2.05, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["6B47 Cover"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.6, -2.3, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },
    ["Untar-Helmet"] = {
        siz = head_siz * Vector(1, 1, 1.05),
        pos = head_pos + Vector(1, -2.85, 0),
        ang = head_ang + Angle(-85, 0, -90),
    },
    ["Shlem Maska 1SH"] = {
        siz = head_siz * Vector(1, 1, 1.05),
        pos = head_pos + Vector(1.8, -2.8, 0.2),
        ang = head_ang + Angle(-75, 0, -90),
    },

    ["Shmaska 1SH Shield"] = {
        siz = head_siz * Vector(1.05, 1, 1.05),
        pos = head_pos + Vector(1.7, -2.3, 0.2),
        ang = head_ang + Angle(-75, 0, -90),
        tgl = {
            pos = head_pos + Vector(6.2, 3, 0.2),
            ang = head_ang + Angle(180, 180, 90),
            mskmat = "",
            slots = {
                eyes = 0,
                mouthnose = 0
            }
        }
    },


    ["Shlem Maska 1SH (Killa)"] = {
        siz = head_siz * Vector(1, 1, 1.05),
        pos = head_pos + Vector(2.05, -2.85, 0),
        ang = head_ang + Angle(-75, 0, -90),
    },

    ["Shmaska 1SH Shield (Killa)"] = {
        siz = head_siz * Vector(1.05, 1, 1.05),
        pos = head_pos + Vector(1.7, -2.3, 0),
        ang = head_ang + Angle(-75, 0, -90),
        tgl = {
            pos = head_pos + Vector(6.2, 3, 0),
            ang = head_ang + Angle(180, 180, 90),
            mskmat = "",
            slots = {
                eyes = 0,
                mouthnose = 0
            }
        }
    },

    ["ZSH-1-2M"] = {
        siz = head_siz * Vector(1.02, 1, 1.05),
        pos = head_pos + Vector(1, -2.6, 0),
        ang = head_ang + Angle(-85, 0, -90),
    },

    ["ZSH-1-2M v2"] = {
        siz = head_siz * Vector(1.02, 1, 1.05),
        pos = head_pos + Vector(1, -2.6, 0),
        ang = head_ang + Angle(-85, 0, -90),
    },


    ["ZSH-1-2M Face Shield"] = {
        siz = head_siz * Vector(1.02, 1, 1.05),
        pos = head_pos + Vector(1, -2.6, 0),
        ang = head_ang + Angle(-85, 0, -90),
    },



    ["SHPM Firefighter Helmet"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.05, -6.65, 0),
        ang = head_ang + Angle(-85, 0, -90),
    },


    ["SHPM Faceshield"] = {
        siz = head_siz * Vector(0.9, 0.9, 0.9),
        pos = head_pos + Vector(1.15, -3.5, 0),
        ang = head_ang + Angle(-85, 0, -90),
        tgl = {
        pos = head_pos + Vector(5, -1.5, 0),
        ang = head_ang + Angle(-25, 0, -90),
            mskmat = "",
            slots = {
                eyes = 0,
                mouthnose = 0
            }
        }
    },
    ["ULACH B"] = {
        siz = head_siz * Vector(1.03, 1.03, 1.03),
        pos = head_pos + Vector(1.2, -2.75, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["ULACH C"] = {
        siz = head_siz * Vector(1.03, 1.03, 1.03),
        pos = head_pos + Vector(1.2, -2.75, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },
    ["Altyn"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1, -2.38, 0.1),
        ang = head_ang + Angle(-85, 0, -90),
    },


    ["Altyn Face Shield"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1, -2.38, 0.1),
        ang = head_ang + Angle(-85, 0, -90),
        tgl = {
        mskmat = "",
        pos = head_pos + Vector(5.4, -0.18, 0.1),
        ang = head_ang + Angle(-35, 0, -90),
            slots = {
                eyes = 0,
                mouthnose = 0
            }
        }
    },

    ["SSh-68"] = {
        siz = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.52, 0.15, 0.1),
        ang = head_ang + Angle(-90, 0, -90),
    },
    ["Crye AirFrame"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.25, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["Crye AirFrame Ears"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.25, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["Crye AirFrame Chops"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.25, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },
    ["TSh-4M-L"] = {
        siz = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.15, -2.4, 0.1),
        ang = head_ang + Angle(-90, 0, -90),
    },
    ["GP-5"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.15, -2.95, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["GP-7"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.23, -2.9, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["Fast MT Black"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.15, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["Fast MT Tan"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.15, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["Fast MT Black SLAAP"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.15, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

        ["Fast MT Tan SLAAP"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.15, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["Fast MT Shield"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.15, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),

    },

    ["FAST Visor"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.15, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),

    },

    ["Fast Mandible"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.15, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["Fast Side Armor Tan"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.15, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["Fast Side Armor Black"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.15, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["FAST RAC Headset"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.15, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },
    ["SFERA-S"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.6, -4.2, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["PSh-97 DJETA"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(2.2, -4.45, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },
    ["Bastion"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.31, -3.95, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["Bastion Shield"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.31, -3.95, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["MSA ACH TC-2001"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.4, -3.95, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["MSA ACH TC-2002"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.4, -3.95, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["DevTac Ronin"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.3, -3, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["TC 800"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.4, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["TW EXFIL B"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.2, -3.8, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["TW EXFIL Shield B"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.2, -3.8, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["TW EXFIL Ears B"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.2, -3.8, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["TW EXFIL C"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.2, -3.8, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["TW EXFIL Shield C"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.2, -3.8, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["TW EXFIL Ears C"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.2, -3.8, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },
    ["Rys-T"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1, -3.4, 0.1),
        ang = head_ang + Angle(-85, 0, -90),
    },

    ["Rys-T Face Shield"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1, -3.4, 0.1),
        ang = head_ang + Angle(-85, 0, -90),
    },

    ["HJELM"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(-0.1, 0.3, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["PNV-10T NVG"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.15, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["T-7 Thermal Goggles"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.15, -4, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },
    ["UBEY"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.4, -2.7, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["GORILLA"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.4, -2.7, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["Shattered"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0, -0.2, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Death Knight"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0, -0.5, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Hockey Brawler"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.3, -0.1, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Hockey Captain"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.3, -0.1, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Hockey Quiet"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.3, -0.1, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },


    ["Tac-Kek FAST MT"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.6, -3.6, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["Tac-Kek Heavy Trooper"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.6, -3.6, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["Kolpak-1S"] = {
        siz = head_siz * Vector(.95, .95, .95),
        pos = head_pos + Vector(1.5, -3.49, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },


    ["Kolpak-1S Visor"] = {
        siz = head_siz * Vector(.95, .95, .95),
        pos = head_pos + Vector(1.5, -3.49, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },
        ["Galvion Caiman"] = {
        siz = head_siz * Vector(.95, .95, .95),
        pos = head_pos + Vector(1.85, -3.6, 0),
        ang = head_ang + Angle(-75, 0, -90),
    },

    ["Galvion Caiman Applique"] = {
        siz = head_siz * Vector(.95, .95, .95),
        pos = head_pos + Vector(1.85, -3.6, 0),
        ang = head_ang + Angle(-75, 0, -90),
    },

    ["Caiman FA Visor"] = {
        siz = head_siz * Vector(.95, .95, .95),
        pos = head_pos + Vector(1.85, -3.6, 0),
        ang = head_ang + Angle(-75, 0, -90),
    },

    ["Caiman Mandible"] = {
        siz = head_siz * Vector(.95, .95, .95),
        pos = head_pos + Vector(1.85, -3.6, 0),
        ang = head_ang + Angle(-75, 0, -90),
    },

    ["Leather cap"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.45, -3.8, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
            },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(1.45, -3.8, 0),
            }
    },
    ["USEC cap black"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.2, -4.2, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
            },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(1.2, -4.2, 0),
            }
    },
    ["USEC cap tan"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.2, -4.2, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
            },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(1.2, -4.2, 0),
            }
    },
    ["BEAR cap black"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.2, -4.2, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
            },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(1.2, -4.2, 0),
            }
    },
    ["BEAR cap green"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.2, -4.2, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
            },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(1.2, -4.2, 0),
            }
    },

    ["Army Cap"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(-0.55, -0.3, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
            },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(-0.55, -0.3, 0),
        }
    },

    ["Army Cap Black"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(-0.5, 0.5, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
                    },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(-0.5, 0.5, 0),
        }
    },

    ["Army Cap Brown"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(-0.5, 0.5, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
                    },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(-0.5, 0.5, 0),
        }
    },

    ["Army Cap CADPAT"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(-0.5, 0.5, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
                    },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(-0.5, 0.5, 0),
        }
    },

    ["Army Cap Flora"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(-0.5, 0.5, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
                    },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(-0.5, 0.5, 0),
        }
    },

    ["Army Cap Sand"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(-0.5, 0.5, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
                    },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(-0.5, 0.5, 0),
        }
    },

    ["Army Cap UCP"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(-0.5, 0.5, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
                    },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(-0.5, 0.5, 0),
        }
    },


    ["Tagilla Cap"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.9, -3.75, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        siz = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.9, -3.75, 0),

        }
    },

    ["Bomber"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(-0.45, .3, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        siz = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(-0.45, .3, 0),

        }
    },

    ["Beret Olive"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.4, -5.6, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
            },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(1.4, -5.6, 0),
            }
    },
    ["Beret Green"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.4, -5.6, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
            },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(1.4, -5.6, 0),
            }
    },
    ["Beret Black"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.4, -5.6, 0),
        ang = head_ang + Angle(-80, 0, -90),
        tgl = {
            slots = {
                head = 1
            },
            siz = head_siz * Vector(1.05, 1.05, 1.05),
            pos = head_pos + Vector(1.4, -5.6, 0),
            }
    },
    ["Vulkan-5"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.8, -4.9, 0),
        ang = head_ang + Angle(-75, 0, -90),
    },

    ["Vulkan-5 Shield"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.8, -4.9, 0),
        ang = head_ang + Angle(-75, 0, -90),
    },

    ["LShZ-2DTM"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.5, -4.8, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["LShZ-2DTM Cover"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.5, -4.8, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["LShZ-2DTM Aventail"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.5, -4.8, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["LShZ-2DTM Shield"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.5, -4.8, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["GPNVG-18"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.1, -3.7, 0),
        ang = head_ang + Angle(-80, 0, -90),
    },

    ["PVS-14 NVM"] = {
        siz = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(1.4, -4, 0),
        ang = head_ang + Angle(-75, 0, -90),
    },


    ["Baseball cap"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.4, 0, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.4, 0, 0),

        }
    },

    ["Beanie"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.4, -0.4, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.4, -0.4, 0),

        }
    },

    ["Cowboy"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.15, 0.8, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.15, 0.8, 0),

        }
    },

    ["Door Kicker"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.2, 0.8, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.2, 0.8, 0),

        }
    },

    ["Skull Lock"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.3, -0.4, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.3, -0.4, 0),

        }
    },

    ["N-15 NVG"] = {

        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.1, -0.3, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Jason"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.3, -0.2, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Slender"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.1, 0.4, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Misha Mayorov"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.6, -0.3, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Ghoul"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.3, -0.1, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Faceless"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.4, 0.4, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Glorious"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.3, 0, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Pestily"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.1, 0, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Baddie"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0, -0.4, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Santa"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0, -0.4, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Mustache"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0, -0.4, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Pipe"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0, -0.4, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Deadly Skull"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.35, -0.1, 0),
        ang = head_ang + Angle(-70, 0, -90),
    },

    ["Ushanka"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0, 0, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0, 0, 0),

        }
    },

    ["Panama"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(-0.1, 0.5, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(-0.1, 0.4, 0),

        }
    },

    ["Chimera"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(-0.1, 0.5, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(-0.1, 0.4, 0),

        }
    },

    ["LLCS"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.4, 0.7, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(-0.1, 0.4, 0),

        }
    },

    ["Fleece"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0, 0.6, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0, 0.6, 0),

        }
    },

    ["Kotton"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0, 0.6, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0, 0.6, 0),

        }
    },

    ["EMERCOM"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.2, 0.6, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.2, 0.6, 0),

        }
    },

    ["UX PRO"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.1, 0.3, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.1, 0.3, 0),

        }
    },

    ["Pompon"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0, 0.4, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0, 0.4, 0),

        }
    },

    ["Police"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.1, 0.6, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.1, 0.6, 0),

        }
    },

    ["Ski Hat"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.2, 0.1, 0),
        ang = head_ang + Angle(-75, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.2, 0.1, 0),

        }
    },

    ["Bandana"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.1, 0.5, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.1, 0.5, 0),

        }
    },

    ["Big Pipe's Bandana"] = {
        pos = head_siz * Vector(1, 1, 1),
        pos = head_pos + Vector(0.1, 0.5, 0),
        ang = head_ang + Angle(-70, 0, -90),
        tgl = {
        slots = {
            head = 1
        },
        pos = head_siz * Vector(1.05, 1.05, 1.05),
        pos = head_pos + Vector(0.1, 0.5, 0),

        }
    },





    -- headphones 
    ["Sordin"] = {
        siz = ear_siz * Vector(1, 1, 1),
        pos = ear_pos + Vector(.75, 0, 0),
        ang = ear_ang + Angle(-80, 0, -90),
    },

    ["ComTac"] = {
        siz = ear_siz * Vector(1, 1, 1),
        pos = ear_pos + Vector(.75, 0, 0),
        ang = ear_ang + Angle(-80, 0, -90),
        tgl = {
        bon = "ValveBiped.Bip01_Head1",
            eff = {},
            slots = {
                acc_ears = 0
            },
        pos = ear_pos + Vector(.75, 0, 0),
        ang = ear_ang + Angle(-80, 0, -90),
        }
    },

    ["ComTac 4"] = {
        siz = ear_siz * Vector(1, 1, 1),
        pos = ear_pos + Vector(0.3, 0, 0),
        ang = ear_ang + Angle(-80, 0, -90),
    },

    ["M32"] = {
        siz = ear_siz * Vector(1, 1, 1),
        pos = ear_pos + Vector(-0.38, 0.13, 0),
        ang = ear_ang + Angle(-80, 0, -90),
        tgl = {
        bon = "ValveBiped.Bip01_Head1",
            eff = {},
            slots = {
                acc_ears = 0
            },
        pos = ear_pos + Vector(-0.38, 0.13, 0),
        ang = ear_ang + Angle(-80, 0, -90),
        }
    },

    ["GSSh-01"] = {
        siz = ear_siz * Vector(.95, .95, .95),
        pos = ear_pos + Vector(0.25, 0, 0),
        ang = ear_ang + Angle(-75, 0, -90),
    },

    ["Tactical Sport"] = {
        siz = ear_siz * Vector(1, 1, 1),
        pos = ear_pos + Vector(0.1, 0, 0),
        ang = ear_ang + Angle(-80, 0, -90),
    },


    ["Razor"] = {
        siz = ear_siz * Vector(1, 1, 1),
        pos = ear_pos + Vector(0, -0.05, 0),
        ang = ear_ang + Angle(-80, 0, -90),
    },

    ["XCEL"] = {
        siz = ear_siz * Vector(1, 1, 1),
        pos = ear_pos + Vector(-0.05, -0.05, 0),
        ang = ear_ang + Angle(-80, 0, -90),
    },


    -- glasses
    ["Condor Glasses"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(2.5, 1.8, 0),
        ang = eye_ang + Angle(-80, 0, -90),
    },
    ["Dundukk sunglasses"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.4, 0.1, 0),
        ang = eye_ang + Angle(-80, 0, -90),

    },
    ["Pyramex Proximity"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.4, 0.8, 0),
        ang = eye_ang + Angle(-80, 0, -90),

    },
    ["6B34"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.45, 0.8, 0),
        ang = eye_ang + Angle(-80, 0, -90),
    },
    ["AF Glasses"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.52, 0.8, 0),
        ang = eye_ang + Angle(-80, 0, -90),
    },

    ["Round Sunglasses"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.52, 0.8, 0),
        ang = eye_ang + Angle(-80, 0, -90),

    },
    ["Gas Welder Glasses"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.52, 0.8, 0),
        ang = eye_ang + Angle(-80, 0, -90),
    },

    ["Aviator Glasses"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.6, -0.3, 0),
        ang = eye_ang + Angle(-70, 0, -90),

    },
    ["Crossbow Glasses"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.6, -0.3, 0),
        ang = eye_ang + Angle(-70, 0, -90),
    },
    ["RayBench Glasses"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.6, -0.3, 0),
        ang = eye_ang + Angle(-70, 0, -90),
    },
    ["Gascan Glasses"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.6, -0.3, 0),
        ang = eye_ang + Angle(-70, 0, -90),
    },
    ["JohnB Glasses"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.6, -0.3, 0),
        ang = eye_ang + Angle(-70, 0, -90),
    },
    ["M Frame Glasses"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.6, -0.3, 0),
        ang = eye_ang + Angle(-70, 0, -90),
    },
    ["Batwolf Glasses"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.6, -0.3, 0),
        ang = eye_ang + Angle(-70, 0, -90),
    },
    ["Tactical Glasses"] = {
        siz = eye_siz * Vector(1, 1, 1),
        pos = eye_pos + Vector(0.6, -0.3, 0),
        ang = eye_ang + Angle(-70, 0, -90),
    },

    -- etc.

    ["NFM THOR IC Left Shoulder"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(2.3, -1, -4),
        ang = Angle(100, -80, 90),
    },

    ["NFM THOR IC Right Shoulder"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(2.3, -1, 4),
        ang = Angle(100, 80, 90),
    },

    ["IOTV Gen4 Left Shoulder"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(1.8, -2.5, -4.2),
        ang = Angle(100, -80, 90),
    },

    ["IOTV Gen4 RightShoulder"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(1.9, -2.5, 4.2),
        ang = Angle(100, 80, 90),
    },

    ["6B43 Left Shoulder"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(3, -1, -3.1),
        ang = Angle(100, -80, 90),
    },

    ["6B43 RightShoulder"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(3, -1, 3.5),
        ang = Angle(100, 80, 90),
    },




    ["CPC GE L.Brassard"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(0.3, 0.6, -1.5),
        ang = Angle(14, -88, 7),
    },

    ["CPC GE R.Brassard"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(0.3, 0.6, 1.5),
        ang = Angle(14, 88, 173),
    },

    ["MK4A L.SH.Guard"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3, -5.2, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["MK4A R.SH.Guard"] = {
        siz = armor_siz * Vector(1, 1, 1),
        pos = armor_pos + Vector(-3, -5.2, 0),
        ang = armor_ang + Angle(-90, 0, 90),
    },

    ["MK4A P L.Brassard"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(0, 0.6, -0.9),
        ang = Angle(14, -90, 7),
    },

    ["MK4A P R.Brassard"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(0, 0.6, 0.9),
        ang = Angle(14, 90, 173),
    },

    ["MK4A A L.Brassard"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(0, 0.6, -0.9),
        ang = Angle(14, -90, 7),
    },

    ["MK4A A R.Brassard"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(0, 0.6, 0.9),
        ang = Angle(14, 90, 173),
    },

    ["Redut-T5 L. Brassard"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(0, 2, -2),
        ang = Angle(0, -90, 0),
    },

    ["Redut-T5 R. Brassard"] = {
        siz = Vector(1, 1, 1),
        pos = Vector(0, 2, 2),
        ang = Angle(0, 90, 180),
    },
}


JMod.LuaConfig.ArmorOffsets["models/eft/pmcs/bear_extended_pm.mdl"] = armotable
JMod.LuaConfig.ArmorOffsets["models/eft/pmcs/usec_extended_pm.mdl"] = armotable
JMod.LuaConfig.ArmorOffsets["models/eft/scavs/scav_extended_pm.mdl"] = armotable
