-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    gs c cycle treasuremode (set on Win+= by default): Cycles through the available treasure hunter modes.
--              [ WIN+C ]           Toggle Capacity Points Mode
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
	state.CP = M(false, "Capacity Points Mode")
    state.AutoLockstyle = M(true, 'AutoLockstyle Mode')
	    send_command('@wait 3; input /lockstyleset 6')

	
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options( 'Hybrid', 'DT', 'Nyame') -- 'Normal', 'Acc' 
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'AtkCapped')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')
	state.CP = M(false, "Capacity Points Mode")

    gear.default.weaponskill_neck = "Assassin's Gorget +2"
    gear.default.weaponskill_waist = "Caudata Belt"

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind @t gs c cycle treasuremode')
	send_command('bind @c gs c toggle CP')
    send_command('bind !- gs c cycle targetmode')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end



-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    sets.TreasureHunter = {hands="Plunderer's Armlets +3", feet="Skulker's Poulaines +3"}
    sets.ExtraRegen = {}
    sets.Kiting = {feet="Jute Boots +1"}

    sets.buff['Sneak Attack'] = {ammo="Cath Palug Stone",
        head="Pillager's Bonnet +3",
		neck="Assassin's Gorget +2",
		ear2="Odr Earring",
		ear1="Sherida Earring",
        body="Pillager's Vest +3",
		hands="Skulker's Armlets +2",
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
		waist="Kentarch Belt +1",
		legs="Pillager's Culottes +3",
		feet="Plunderer's Poulaines +3"
	}

    sets.buff['Trick Attack'] = {ammo="Cath Palug Stone",
        head="Pillager's Bonnet +3",
		neck="Assassin's Gorget +2",
		ear2="Infused Earring",
		ear1="Sherida Earring",
        body="Pillager's Vest +3",
		hands="Pillager's Armlets +1",
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
		waist="Sveltesse Gouriz +1",
		legs="Pillager's Culottes +3",
		feet="Plunderer's Poulaines +3"
	}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +3"}
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +3"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +3"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +3"}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest +3"}
    sets.precast.JA['Steal'] = {ammo="Barathrum", head="Plunderer's Bonnet +3", hands="Pillager's Armlets +1", legs="Pillager's Culottes +3", feet="Pillager's Poulaines +3"}
    sets.precast.JA['Despoil'] = {ammo="Barathrum", legs="Skulker's Culottes +2", feet="Skulker's Poulaines +3"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +3"}
    sets.precast.JA['Feint'] =  {legs="Plunderer's Culottes +3"}
	sets.precast.JA["Assassin's Charge"] = {feet="Plunderer's Poulaines +3"}
    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",
        head="Mummu Bonnet +2",
        body="Gleti's Cuirass",
		hands="Pillager's Armlets +1",
		ring1="Asklepian Ring",
        legs="Pillager's Culottes +3", 
		feet="Rawhide Boots"
	}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {
	ammo="Sapience Orb",
	head="Haruspex Hat",
	ear1="Etiolation Earring",
	ear2="Loquacious Earring",
	hands="Leyline Gloves",
	ring1="Prolix Ring",
	legs="Enif Cosciales"
	}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    -- Ranged snapshot gear
    sets.precast.RA = {head="Malignance Chapeau",hands="Malignance Gloves",legs="Malignance Tights",feet="Malignance Boots"}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Seething Bomblet +1",
        head="Nyame Helm",
		neck="Assassin's Gorget +2", 
		ear2="Moonshade Earring",
		ear1="Sherida Earring",
        body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Regal Ring",
		ring2="Cornelia's Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
		waist="Kentarch Belt +1",
		legs="Plunderer's Culottes +3",
		feet="Nyame Sollerets"
		}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

		--RUDRA'S STORM Sets
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
		head="Skulker's Bonnet +3", --plunderer's?
		ear2="Dominance Earring +1", --test
		body="Skulker's Vest +3", 
		hands="Gleti's Gauntlets", --test
		ring1="Epaminondas's Ring",
		legs="Gleti's Breeches", --test
	})
	
	--[[    main  Twashtar R25
			sub  Crepuscular Knife
			ranged  Empty
			ammo  Crepuscular Pebble
			head  Skulker's Bonnet +3
			body  Skulker's Vest +3
			hands  Gleti's Gauntlets R25
			legs  Gleti's Breeches R25
			feet  Nyame Sollerets R25B
			neck  Assassin's Gorget +2 R25
			waist  Kentarch Belt +1 R15
			ear1  Moonshade Earring
			ear2  Dominance Earring +1 R15
			ring1  Epaminondas's Ring
			ring2  Cornelia's ring
			back  Toutatis's Cape DEX Weaponskill Damage
	  ]]
	  
    sets.precast.WS["Rudra's Storm"].AtkCapped = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Crepuscular Pebble",
		head="Skulker's Bonnet +3",
		ear2="Odr Earring",
		body="Gleti's Cuirass",
		ring2="Cornelia's Ring",
	})
   
    --[[    main  Twashtar R25
			sub  Gleti's Knife R25
			ranged  Empty
			ammo  Coiste Bodhar R25
			head  Nyame Helm R25B
			body  Skulker's Vest +3
			hands  Nyame Gauntlets R25B
			legs  Nyame Flanchard R25B
			feet  Nyame Sollerets R25B
			neck  Assassin's Gorget +2 R25
			waist  Kentarch Belt +1 R15
			ear1  Moonshade Earring
			ear2  Dominance Earring +1 R15
			ring1  Regal Ring
			ring2  Cornelia's ring
			back  Toutatis's Cape DEX Weaponskill Damage
   ]]
   
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila +1",
		head="Pillager's Bonnet +3",
		ear2="Odr Earring",
	}) 
	
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila +1",
		head="Pillager's Bonnet +3",
		ear2="Odr Earring",
	}) 
	
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila +1",
		head="Pillager's Bonnet +3",    
		ear2="Odr Earring",
	})  

		--Evisceration Sets
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Yetshila +1",
        head="Adhemar Bonnet", --+1 B path
		neck="Fotia Gorget",
		ear2="Odr Earring",
		body="Plunderer's Vest +3",
		hands="Adhemar Wristbands +1",
		waist="Fotia Belt",
		legs="Pillager's Culottes +3", 
		--feet="Adhemar Gamashes +1 Path B
	})

    sets.precast.WS['Evisceration'].AtkCapped = set_combine(sets.precast.WS['Evisceration'], {
		head="Skulker's Bonnet +3",
		body="Gleti's Cuirass",
	})
	
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'], {})
	
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'], {})
	
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'], {})

		--Exenterator Sets
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {ammo="Cath Palug Stone",
		head="Skulker's Bonnet +3",
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Telos Earring", --Balder +1 is better...
		body="Plunderer's Vest +3",
		waist="Fotia Belt",
		legs="Meghanada Chausses +2",
		feet="Plunderer's Poulaines +3",
	
	})
		
    sets.precast.WS['Exenterator'].AtkCapped = set_combine(sets.precast.WS['Exenterator'], {ammo="Crepuscular Pebble",
		head="Skulker's Bonnet +3",
		Body="Gleti's Cuirass",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		
	})
	
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'], {})

		--Dancing Edge Sets
    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {
	})
	
    sets.precast.WS['Dancing Edge'].AtkCapped = set_combine(sets.precast.WS['Dancing Edge'])
	
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Yetshila +1"
	})
	
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Yetshila +1"
	})
	
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Yetshila +1"
	})

		--Shark Bite Sets *Nom*
    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
		head="Nyame Helm",
		body="Plunderer's Vest +3",--skulkers 
		hands="Meghanada Gloves +2",
		waist="Grunfeld Rope",
		
	})
    sets.precast.WS['Shark Bite'].AtkCapped = set_combine(sets.precast.WS['Shark Bite'], {ammo="Crepuscular Pebble",
		head="Pillager's Bonnet +3",
		body="Gleti's Cuirass",
		hands="Nyame Gauntlets",
		ring2="Cornelia's Ring",
		legs="Gleti's Breeches",
	})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'], {ammo="Yetshila +1",
        body="Pillager's Vest +3",
		legs="Plunderer's Culottes +3"
	})	
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'], {ammo="Yetshila +1",
        body="Pillager's Vest +3",
		legs="Plunderer's Culottes +3"
	})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'], {ammo="Yetshila +1",
        body="Pillager's Vest +3",
		legs="Plunderer's Culottes +3"
	})
	
		--Mandalic Stab Sets
    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS["Rudra's Storm"], {
	})
	
    sets.precast.WS['Mandalic Stab'].AtkCapped = sets.precast.WS["Rudra's Storm"].AtkCapped

    sets.precast.WS['Mandalic Stab'].SA = sets.precast.WS["Rudra's Storm"].SA

    sets.precast.WS['Mandalic Stab'].TA = sets.precast.WS["Rudra's Storm"].TA

    sets.precast.WS['Mandalic Stab'].SATA = sets.precast.WS["Rudra's Storm"].SATA

		--Aeolian Edge Sets
    sets.precast.WS['Aeolian Edge'] = {
		ammo="Seething Bomblet +1",
        head="Nyame Helm",
		neck="Baetyl Pendant",
		ear2="Moonshade Earring",
		ear1="Friomisi Earring",
        body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring2="Cornelia's Ring",
		ring1="Dingir Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
		waist="Orpheus's Sash", 
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"
	}

	sets.precast.WS['Aeolian Edge'].AtkCapped = sets.precast.WS['Aeolian Edge']
	
    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

    sets.precast.WS['Savage Blade'] = {
		ammo="Seething Bomblet +1",
        --head="Gleti's Mask",
		head="Nyame Helm",
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
        body="Nyame Mail",
		--body="Gleti's Cuirass",
		hands="Nyame Gauntlets",
		ring1="Regal Ring",
		ring2="Cornelia's Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
		waist="Fotia Belt",
		legs="Nyame Flanchard",
		--legs="Plunderer's Culottes +3",
		feet="Nyame Sollerets",
	}
	sets.precast.WS['Savage Blade'].AtkCapped = set_combine(sets.precast.WS['Savage Blade'], {
		head="Gleti's Mask",
		body="Gleti's Cuirass",
	})

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Herculean Helm",
		ear1="Etiolation earring",
		ear2="Loquacious Earring",
        body="Malignance Tabard",
		hands="Leyline Gloves",
        back="Canny Cape",
		legs="Enif Cosciales",
		feet="Malignance Boots"
		}

    -- Specific spells
    sets.midcast.Utsusemi = {
        head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Loquacious Earring",
        body="Malignance Tabard",
		hands="Leyline Gloves",
        back="Canny Cape",
		legs="Malignance Tights",
		feet="Malignance Boots"}

    -- Ranged gear
    sets.midcast.RA = {
        head="Malignance Chapeau",
		neck="Iskur Gorget",
		ear1="Telos Earring",
		ear2="Crepuscular Earring",
        body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Cacoethic Ring +1",
		ring2="Dingir Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
		waist="Yemaya Belt",
		legs="Malignance Tights",
		feet="Malignance Boots"
		}

    sets.midcast.RA.Acc = {
        head="Pillager's Bonnet +3",
		neck="Iskur Gorget",
		ear1="Telos Earring",
		ear2="Crepuscular Earring",
        body="Malignance Tabard",
		hands="Buremte Gloves",
		ring1="Cacoethic Ring +1",
		ring2="Dingir Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
		waist="Yemaya Belt",
		legs="Malignance Tights",
		feet="Pillager's Poulaines +3"
		}


    --------------------------------------
    -- Idle/resting/defense setsn
    --------------------------------------

    -- Resting sets
    sets.resting = {
		neck="Loricate Torque +1",
        ring1="Sheltered Ring",
		ring2="Paguroidea Ring"
	}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {ammo="Staunch Tathlum +1",
        head="Nyame Helm",
		neck="Warder's Charm +1",
		ear1="Sherida Earring",
		ear2="Odnowa Earring +1",
        body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Moonlight Ring",
		ring2="Defending Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}, 
		waist="Plat. Mog. Belt",
		legs="Nyame Flanchard",
		feet="Jute Boots +1"
		}

    sets.idle.Weak ={ammo="Yamarang",
        head="Nyame Helm",
		neck="Unmoving Collar +1",
		ear1="Odnowa Earring",
		ear2="Odnowa Earring +1",
        body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Gelatinous Ring +1",
		ring2="Defending Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}, 
		waist="Plat. Mog. Belt",
		legs="Nyame Flanchard",
		feet="Jute Boots +1"
		}

    -- Defense sets

    sets.defense.Evasion = {ammo="Yamarang",
        head="Pillager's Bonnet +3",
		neck="Assassin's Gorget +2",
        body="Malignance Tabard",
		hands="Pillager's Armlets +1",
		ring1="Moonlight Ring", 
		ring2="Defending Ring",
        back="Canny Cape",
		waist="Plat. Mog. Belt",
		legs="Malignance Tights",
		feet="Malignance Boots"
	}

    sets.defense.PDT = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
		neck="Loricate Torque +1",
        body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Hetairoi Ring",
		ring2="Defending Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
		waist="Plat. Mog. Belt",
		legs="Malignance Tights",
		feet="Nyame Sollerets"
	}

    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Pillager's Bonnet +3",
		neck="Loricate Torque +1",
        body="Pillager's Vest +3",
		hands="Pillager's Armlets +1",
		ring1="Moonlight Ring",
		ring2="Defending Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
		waist="Flume Belt +1",
		legs="Pillager's Culottes +3",
		feet="Malignance Boots"
	}


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {ammo="Coiste Bodhar",
        head="Skulker's Bonnet +3",
		neck="Assassin's Gorget +2",
		ear1="Eabani Earring",
		ear2="Suppanomimi",
        body="Pillager's Vest +3", 
		hands="Adhemar Wristbands +1",
		ring1="Gere Ring",
		ring2="Hetairoi Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}, 
		waist="Reiki Yotai",
		legs="Samnuha Tights",
		feet="Plunderer's Poulaines +3",
}
	
	sets.engaged.Hybrid = {ammo="Coiste Bodhar",
        head="Malignance Chapeau",
		neck="Assassin's Gorget +2",
		ear1="Sherida Earring",
		ear2="Skulk. Earring +1",
        body="Pillager's Vest +3",
		hands="Malignance Gloves",
		ring1="Gere Ring",
		ring2="Moonlight Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
		waist="Reiki Yotai",
		legs="Pillager's Culottes +3",
		feet="Plunderer's Poulaines +3"
		}
		
	sets.engaged.DT = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
		neck="Assassin's Gorget +2",
		ear1="Sherida Earring",
		ear2="Odnowa earring +1", --ear2="Telos Earring",
        body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Moonlight Ring",
		ring2="Defending Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}, 
		waist="Reiki Yotai",
		legs="Malignance Tights",
		feet="Plunderer's Poulaines +3"
		}

	sets.engaged.Nyame = {ammo="Coiste Bodhar",
        head="Nyame Helm",
		neck="Assassin's Gorget +2",
		ear1="Sherida Earring",
		ear2="Skulk. Earring +1",
        body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Gere Ring",
		ring2="Moonlight Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
		waist="Reiki Yotai",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"
		}
		
    sets.engaged.Acc = {ammo="Cath Palug Stone",
        head="Pillager's Bonnet +3",
		neck="Assassin's Gorget +2",
		ear1="Crepuscular Earring",
		ear2="Telos Earring",
        body="Pillager's Vest +3",
		hands="Adhemar Wristbands +1",
		ring1="Gere Ring",
		ring2="Regal Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
		waist="Reiki Yotai",
		legs="Pillager's Culottes +3",
		feet="Plunderer's Poulaines +3"
		} --+228 acc+DPS

    sets.engaged.Evasion = {ammo="Yamarang",
        head="Malignance Chapeau",
		neck="Assassin's Gorget +2",
		ear1="Dudgeon Earring",
		ear2="Heartseeker Earring",
        body="Malignance Tabard",
		hands="Pillager's Armlets +1",
		ring1="Moonlight Ring",
		ring2="Epona's Ring",
        back="Canny Cape",
		waist="Windbuffet Belt +1",
		legs="Malignance Tights",
		feet="Malignance Boots"}

    sets.engaged.Acc.Evasion = {}
    sets.engaged.PDT = {}
    sets.engaged.Acc.PDT = {}
		
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Eshmun's Ring", --20
        waist="Gishdubar Sash", --10
        }
		
    sets.CP = {back="Mecisto. Mantle"}
	
	sets.phalanx = {
		head="Herculean Helm",
		body="Herculean Vest",
		hands="Herculean Gloves",
		legs="Herculean Trousers",
		feet="Herculean Boots",
	}
	
	sets.alchemy = {
	main="Caduceus",
	sub="Br. Escutcheon",
	head="Protective Specs.",
	neck="Alchemist's Torque",
	body="Alchemist's Smock",
	ring1="Orvail Ring +1",
	ring2="Confectioner's Ring",
	waist="Alchemist's Belt",
	}
	
		
	sets.bonecraft = {
	--main="Caduceus",
	--sub="Br. Escutcheon",
	head="Protective Specs.",
	neck="boneworker's Torque",
	body="Boneworker's Smock",
	ring1="Orvail Ring +1",
	ring2="Patissiere's Ring",
	--ring2="Confectioner's Ring",
	waist="Boneworker's Belt",
	}
	
	sets.blacksmith = {
	main="Caduceus",
	--sub="Smythe's Escutcheon",
	--head="Protective Specs.",
	neck="Smithy's Torque",
	body="blackmith's Apron",
	ring1="Orvail Ring +1",
	ring2="Confectioner's Ring",
	waist="Blacksmith Belt",
	}

	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
	end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(3, 6)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 6)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 6)
	elseif player.sub_job == 'DRG' then
        set_macro_page(4, 6)
    else
        set_macro_page(1,6)
    end
end

	--Lockstyle

