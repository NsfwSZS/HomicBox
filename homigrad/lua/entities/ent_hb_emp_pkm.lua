AddCSLuaFile()

ENT.Base = "ent_hb_emp_base"

ENT.PrintName = "PKM"
ENT.Category = "Homice-Box | EMP"

ENT.Spawnable = true
ENT.BaseModel = "models/hunter/blocks/cube025x025x025.mdl" 

ENT.GunModel = "models/pwb2/weapons/w_pkm.mdl"
ENT.NextShoot = 0

ENT.Damage = 55
ENT.Force = 30

ENT.MaxClip = 150
ENT.Clip = 150
ENT.Delay = 0.05

ENT.ReloadSounds = {
    [0.1] = {"pwb/weapons/pkm/coverup.wav"},
    [0.9] = {"pwb/weapons/pkm/boxout.wav"},
    [1.6] = {"pwb/weapons/pkm/draw.wav"},
    [2.3] = {"pwb/weapons/pkm/boxin.wav"},
    [3] = {"pwb/weapons/pkm/chain.wav"},
    [3.4] = {"pwb/weapons/pkm/coverdown.wav"},
    [4] = {"pwb/weapons/pkm/coversmack.wav"},
    [5] = {"pwb/weapons/pkm/bolt.wav"}
}

ENT.ShootSound = "pwb/weapons/pkm/shoot.wav"
ENT.ShootSoundFar = "snd_jack_hmcd_snp_far.wav"
