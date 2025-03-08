-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    ExtraSongsMode may take one of three values: None, Dummy, FullLength
    
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle ExtraSongsMode
    gs c set ExtraSongsMode Dummy
    
    The Dummy state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    
    
    Simple macro to cast a dummy Daurdabla song:
    /console gs c set ExtraSongsMode Dummy
    /ma "Shining Fantasia" <me>
    
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end


BarElements = S{"Barfira","Barblizzara","Baraera","Barstonra","Barthundra","Barwatera"}
BarAilments = S{"Barsleepra","Barpoisonra","Barparalyzra","Barblindra","Barsilencera","Barpetra","Barvira","Baramnesra"}

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.ExtraSongsMode = M{['description']='Extra Songs', 'None', 'Dummy', 'FullLength'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    -- For tracking current recast timers via the Timers plugin.
    custom_timers = {}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Auto','Normal','None')
    state.CastingMode:options('Normal', 'Resistant', 'Enmity', 'AOE')
    state.IdleMode:options('Normal', 'PDT', 'Field')

    brd_daggers = S{'Kali', 'Carnwenhan'}
    pick_tp_weapon()
    
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(true, 'Use Custom Timers')
    
    -- Additional local binds
    --send_command('bind ^` gs c cycle ExtraSongsMode')
	--send_command('bind delete gs c set ExtraSongsMode Dummy; input /ma "Goblin Gavotte" <t>')
	--send_command('bind end gs c set ExtraSongsMode Dummy; input /ma "Herb Pastoral" <t>')
	send_command('bind home input /ma "Chocobo Mazurka" <me>')
	send_command('bind ^delete input /ws "Mordant Rime" <t>')
	send_command('bind !a gs c toggle dmg set') -- Hit alt+a, toggles the sets
	send_command('bind ^a gs c toggle sub set') -- Hit ctrl+a, toggles the sets

    select_default_macro_book()
	set_lockstyle()
	
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind `')
    send_command('unbind ^`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !`')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind @`')
    send_command('unbind @-')
    send_command('unbind @=')
	send_command('unbind delete')
	send_command('unbind end')
	send_command('unbind home')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = { --69 FC 7 QC
    head={ name="Bunzi's Hat", augments={'Path: A',}}, --10 FC
    body="Inyanga Jubbah +2", --14 FC
    hands="Volte Gloves", --6 FC
    legs="Volte Brais", --8 FC
    feet="Volte Gaiters", --6 FC
    neck="Orunmila's Torque", --5 FC
    --waist="Witful Belt", --3 FC 3 QC
	waist="Embla Sash",
    left_ear="Loquac. Earring", --2 FC
    right_ear="Etiolation Earring", --1 FC
    right_ring="Kishar Ring", --4 FC
    --right_ring="Lebeche Ring", --2 QC
	left_ring="Rahab Ring",
    --back="Perimede Cape", --4 QC
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10 FC
	}

    sets.precast.FC.Cure = set_combine(sets.precast.FC)
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
	waist="Siegel Sash",
	})

    sets.precast.FC.BardSong = { --83~87
    head="Fili Calot +3",
    body="Inyanga Jubbah +2",
    hands="Volte Gloves",
    legs="Volte Brais",
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck="Orunmila's Torque",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','Damage taken-5%',}},
    left_ring="Rahab Ring",
    right_ring="Kishar Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}

    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	
	sets.precast.FC["Honor March"] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC["Aria of PAssion"] = set_combine(sets.precast.FC.BardSong,{range="Loughnashade"})
        
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"}
    sets.precast.JA.Troubadour = {body="Bihu Justaucorps +3"}
    sets.precast.JA['Soul Voice'] = {legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},}

    -- Waltz set (chr and vit)
	sets.precast.Waltz = {
	legs="Dashing Subligar",
	left_ring="Valseur's Ring",
	} 
     
	sets.precast.Step = {
	range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
    head="Fili Calot +3",
    body="Fili Hongreline +3",
    hands="Fili Manchettes +3",
    legs="Fili Rhingrave +3",
    feet="Fili Cothurnes +3",
    neck={ name="Bard's Charm +2", augments={'Path: A',}},
    waist={ name="Kentarch Belt +1", augments={'Path: A',}},
    left_ear="Crep. Earring",
    right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','Damage taken-5%',}},
    left_ring={name="Chirich Ring +1", bag="wardrobe8"},
    right_ring={name="Chirich Ring +1", bag="wardrobe7"},
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	} 
	 
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
	range={ name="Linos", augments={'Attack+15','Accuracy+15','Weapon skill damage +3%','STR+6','DEX+6',}},
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
	hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Bard's Charm +2", augments={'Path: A',}},
	waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
	right_ear="Digni. Earring",
	right_ring={name="Chirich Ring +1", bag="wardrobe7"},
    --right_ear={ name="Domin. Earring +1", augments={'Path: A',}},
	left_ring="Epaminondas's Ring",
    --right_ring="Ilabrat Ring",	
    back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum",
	neck="Sibyl Scarf",
    waist="Orpheus's Sash",
    left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    right_ear="Friomisi Earring",
	right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
	})
    
	sets.precast.WS['Cyclone'] = set_combine(sets.precast.WS['Aeolian Edge'], {
	--40% DEX / 40% INT
	})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
	range={ name="Linos", augments={'Attack+15','Crit.hit rate+3','DEX+8',}},
	head={ name="Blistering Sallet +1", augments={'Path: A',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
    feet={ name="Lustra. Leggings +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    right_ear={ name="Domin. Earring +1", augments={'Path: A',}},
    left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Ilabrat Ring",
    right_ring={ name="Cacoethic Ring +1", augments={'Path: A',}},
    --back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	})
	
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
	body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
	})
	
    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
	range="Loughnashade",
	neck={ name="Bard's Charm +2", augments={'Path: A',}},
	right_ear="Regal Earring",
	right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
	back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
	body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
	left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
	neck={ name="Bard's Charm +2", augments={'Path: A',}},
	waist={ name="Kentarch Belt +1", augments={'Path: A',}},
	})
    
	sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {
	neck="Rep. Plat. Medal",
	left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
	right_ear="Digni. Earring",
	right_ring={name="Chirich Ring +1", bag="wardrobe7"},
	--left_ring={name="Chirich Ring +1", bag="wardrobe8 "},
	--right_ring="Sroda Ring",
	waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	right_ear="Ishvara Earring",
	})
    
	sets.precast.WS["Shell Crusher"] = set_combine(sets.precast.WS, {

	})
	
    -- Midcast Sets

    -- General set for recast times.    
	sets.midcast.FastRecast = {}
        
    -- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
	--sets.midcast.Ballad = {legs="Fili Rhingrave +3"}
	sets.midcast.Mambo = {feet="Mousai Crackows +1"}
    sets.midcast["Horde Lullaby"] = {hands="Brioso Cuffs +3",range="Blurred Harp +1",}--range="Daurdabla",
	sets.midcast["Horde Lullaby II"] = {hands="Brioso Cuffs +3",range="Blurred Harp +1",}--range="Daurdabla",
	sets.midcast["Foe Lullaby"] = {hands="Brioso Cuffs +3",range="Marsyas"}
	sets.midcast["Foe Lullaby II"] = {hands="Brioso Cuffs +3",range="Marsyas"}
    sets.midcast.Madrigal = {head="Fili Calot +3",back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},}
	sets.midcast.Prelude = {back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},}
    sets.midcast.March = {hands="Fili Manchettes +3"}
    sets.midcast.Minuet = {body="Fili Hongreline +3"}
    sets.midcast.Minne = {legs="Mousai Seraweels +1"}
    sets.midcast.Paeon = {head="Brioso Roundlet +3"}
	sets.midcast.Etude = {Head="Mousai Turban +1"}
	sets.midcast.Carol = {hands="Mousai Gages +1"}
	sets.midcast.Threnody = {body="Mou. Manteel +1"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +3"}
    sets.midcast['Magic Finale'] = {}
	sets.midcast['Magic Finale'].Mixed = set_combine(sets.midcast['Magic Finale'], {})
	sets.midcast['Magic Finale'].Resistant = set_combine(sets.midcast['Magic Finale'], {})	
    sets.midcast.Mazurka = {range=info.ExtraSongInstrument}
	sets.midcast["Honor March"] = {range="Marsyas"}
	sets.midcast["Aria of Passion"] = {range="Loughnashade"}

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {
	main="Carnwenhan",
    sub={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
    range="Loughnashade",
    head="Fili Calot +3",
    body="Fili Hongreline +3",
    hands="Fili Manchettes +3",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    waist="Plat. Mog. Belt",
    right_ear="Fili Earring +1",
    left_ear="Darkside Earring",
    left_ring="Defending Ring",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {
	--main="Carnwenhan",
    --sub={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}, bag="wardrobe2"},
	--sub={ name="Gleti's Knife", augments={'Path: A',}},
	--sub="Ammurapi Shield",
	range="Gjallarhorn",
	--range="Loughnashade",
    head="Brioso Roundlet +3",
    body="Fili Hongreline +3",
    hands="Fili Manchettes +3",
	legs="Fili Rhingrave +3",
    --legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    waist="Null Belt",
    left_ear="Regal Earring",
    right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','Damage taken-5%',}},
	left_ring={name="Stikini Ring +1", bag="wardrobe8"}, --1
    right_ring={name="Stikini Ring +1", bag="wardrobe7"}, --1
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}

    -- For song defbuffs (Mix of accuracy/duration)
    sets.midcast.MixedSongDebuff = set_combine(sets.midcast.SongDebuff, {
	legs="Fili Rhingrave +3"
	})
	
	-- For song defbuffs (Enmity and DT)
    sets.midcast.Enmity = { 
	--main="Mafic Cudgel", --
	--sub="Genmei Shield",
	range="Daurdabla",
    head="Halitus Helm",
    body="Emet Harness +1",
    hands="Fili Manchettes +3",
    legs={ name="Zoar Subligar +1", augments={'Path: A',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Kasiri Belt",
    left_ear="Cryptic Earring",
    right_ear="Pluto's Pearl",
    left_ring="Eihwaz Ring",
    right_ring="Supershear Ring",
    back="Reiki Cloak",
	}

	sets.midcast.AOE = {
	--main={ name="Carnwenhan", augments={'Path: A',}},
	--sub={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}, bag="wardrobe2"},
	--sub="Ammurapi Shield",
    --range="Daurdabla",
    range="Blurred Harp +1",
	head="Brioso Roundlet +3",
    body="Brioso Justau. +3",
    hands="Fili Manchettes +3",
    legs="Inyanga Shalwar +2",
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck="Mnbw. Whistle +1",
    waist="Harfner's Sash",
    left_ear="Darkside Earring",
    right_ear="Gersemi Earring",
 	left_ring={name="Stikini Ring +1", bag="wardrobe8"}, --1 Refresh
    right_ring={name="Stikini Ring +1", bag="wardrobe7"}, 
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}

    -- Song-specific recast reduction
    sets.midcast.SongRecast = {ear1="Loquacious Earring",ring1="Kishar Ring",ring1="Lebeche Ring",legs="Fili Rhingrave +3"}

    sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

    -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = {}

    -- Other general spells and classes.
    sets.midcast.Cure = { --51 CP 9 CP2 57 ConMP
	ammo="Pemphredo Tathlum", --4 ConMP
    head={ name="Kaykaus Mitra +1", augments={'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',}}, --11 CP 2 CP2
    body={ name="Kaykaus Bliaut +1", augments={'MP+80','"Cure" potency +6%','"Conserve MP"+7',}},
    hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}}, --11 CP 2 CP2
    legs={ name="Kaykaus Tights +1", augments={'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',}}, --11 CP 2 CP2
    feet={ name="Kaykaus Boots +1", augments={'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',}}, --11 CP 2 CP2 7 ConMP
    neck="Reti Pendant", --4 ConMP
    waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}}, --15 ConMP
    left_ear="Gifted Earring", --3 ConMP
    right_ear="Calamitous Earring", --4 ConMP
    left_ring="Naji's Loop", --1 CP 1 CP2
    right_ring={ name="Mephitas's Ring +1", augments={'Path: A',}}, --15 ConMP
    back={ name="Fi Follet Cape +1", augments={'Path: A',}}, --5 ConMP
	}
        
    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
	
	sets.midcast['Enhancing Magic'] = {
	--main="Pukulatmuj +1",
    --sub="Ammurapi Shield",
	head={ name="Telchine Cap", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	body={ name="Telchine Chas.", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	hands={ name="Telchine Gloves", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	legs={ name="Telchine Braconi", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	feet={ name="Telchine Pigaches", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Andoaa Earring",
	left_ring={name="Stikini Ring +1", bag="wardrobe8"},
    right_ring={name="Stikini Ring +1", bag="wardrobe7"},
    back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	}
	
	sets.midcast['Enfeebling Magic'] = {
		--main="Carnwenhan",
		--sub={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}, bag="wardrobe8"}, --7 FC
		--sub="Ammurapi Shield",
		head="Brioso Roundlet +3",
		neck="Null Loop",
		left_ear="Regal Earring",
		right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','Damage taken-5%',}},
		body="Brioso Justau. +3",
		hands="Brioso Cuffs +3",
		left_ring="Medada's Ring", --1
		right_ring={name="Stikini Ring +1", bag="wardrobe7"}, --1
		--right_ring="Kishar Ring",
		back="Null Shawl",
		waist="Obstin. Sash",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-2','Mag. Acc.+12',}},
		feet="Brioso slippers +3"
		--feet="Uk'uxkaj Boots",
		}
		
	sets.midcast.Absorb = set_combine (sets.midcast['Enfeebling Magic'], {
	--ammo="Pemphredo Tathlum",
	hands="Inyan. Dastanas +2",
    legs="Brioso Cannions +3",
	waist={ name="Acuity Belt +1", augments={'Path: A',}},
	}) 
	
    sets.midcast.Stoneskin = set_combine (sets.midcast['Enhancing Magic'], {
	neck="Stone Gorget",
	left_ear="Earthcry earring",
	waist="Siegel Sash",
	legs="Shedir Seraweels",
	hands="Inyan. Dastanas +2",
	feet={ name="Kaykaus Boots +1", augments={'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',}},
	}) 
	
	sets.midcast.Aquaveil = set_combine (sets.midcast['Enhancing Magic'], {
	head="Chironic Hat",
	waist="Emphatikos Rope",
	legs="Shedir Seraweels",
	hands="Inyan. Dastanas +2",
	feet={ name="Kaykaus Boots +1", augments={'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',}},
	}) 
	
	sets.midcast.Phalanx = set_combine (sets.midcast['Enhancing Magic'], {
	legs="Shedir Seraweels",
	waist="Olympus Sash",
	hands="Inyan. Dastanas +2",
	feet={ name="Kaykaus Boots +1", augments={'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',}},
	}) 
		
	sets.midcast.bar_element = set_combine(sets.midcast['Enhancing Magic'], {
	legs="Shedir Seraweels",
	waist="Olympus Sash",
	hands="Inyan. Dastanas +2",
	feet={ name="Kaykaus Boots +1", augments={'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',}},
	})

	sets.midcast.Haste = set_combine (sets.midcast['Enhancing Magic'], {}) 
	
    sets.midcast.Cursna = {
	head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
	hands="Inyan. Dastanas +2",
    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    right_ring="Haoma's Ring",
	left_ring="Menelaus's Ring",
	neck="Debilis Medallion",
	left_ear="Meili Earring",
	right_ear="Beatific Earring",
	waist="Bishop's Sash",
	back="Oretan. Cape +1",
	}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
	--main="Boonwell Staff",
    --sub="Ariesian Grip",
    --ammo="Mana Ampulla",
    head="Orvail Corona +1",
    body="Oracle's Robe",
    hands="Nares Cuffs",
    legs="Menhit Slacks",
    feet="Chelona Boots",
    neck="Eidolon Pendant +1",
    waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}},
    left_ear="Relaxing Earring",
    right_ear="Magnifying Earring",
    back="Felicitas Cape +1",
	}
    
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = { --48 DT 18% Movement
	--main="Daybreak",
    --sub="Genmei Shield",
	head="Fili Calot +3", --11 DT
    body="Annoint. Kalasiris", --Reraise
	--body="Adamantite Armor", --20 DT
    hands="Fili Manchettes +3",
	--hands="Regal Gloves", -- +20 DT
	--hands={ name="Chironic Gloves", augments={'Weapon skill damage +2%','INT+7','"Refresh"+2','Accuracy+11 Attack+11','Mag. Acc.+13 "Mag.Atk.Bns."+13',}}, --1 Refresh
    legs="Fili Rhingrave +3", --13 DT
	--legs={ name="Assid. Pants +1", augments={'Path: A',}}, --1~2 Refresh
    feet="Fili Cothurnes +3", --18% Movement
	--neck={ name="Warder's Charm +1", augments={'Path: A',}},
    neck="Rep. Plat. Medal",
    waist="Null Belt",
    left_ear="Infused Earring",
    right_ear={ name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','Damage taken-5%',}}, --5 DT
    --left_ring={name="Moonlight Ring", bag="wardrobe8"}, -- 5 DT
	--left_ring={name="Stikini Ring +1", bag="wardrobe7"}, --1 Refresh
	--right_ring={name="Moonlight Ring", bag="wardrobe7"}, --5 DT
	--right_ring={name="Stikini Ring +1", bag="wardrobe8"}, --1 Refresh
	left_ring={name="Chirich Ring +1", bag="wardrobe8"},
    right_ring={name="Chirich Ring +1", bag="wardrobe7"},
    --back="Moonlight Cape", --6 DT
		}

    sets.idle.PDT = {
    head={ name="Nyame Helm", augments={'Path: B',}},
	body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Fili Manchettes +3",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet="Fili Cothurnes +3",
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Carrier's Sash",
    left_ear="Eabani Earring",
    right_ear="Infused Earring",
    left_ring={name="Moonlight Ring", bag="wardrobe8"},
	--left_ring={name="Stikini Ring +1", bag="wardrobe7"}, --1 Refresh
	right_ring={name="Moonlight Ring", bag="wardrobe7"}, --5 DT
	--right_ring={name="Stikini Ring +1", bag="wardrobe8"}, --1 Refresh
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
			
    sets.idle.Town = {
	body="Councilor's Garb",
    feet="Fili Cothurnes +3",
	}
    
    sets.idle.Weak = set_combine(sets.idle.PDT, {})
    
    
    -- Defense sets

    sets.defense.PDT = {
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    --neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Carrier's Sash",
    left_ear="Eabani Earring",
    right_ear="Infused Earring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}

    sets.defense.MDT = {
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    --neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Carrier's Sash",
    left_ear="Eabani Earring",
    right_ear="Infused Earring",
    back="Reiki Cloak",
	}

    sets.Kiting = {feet="Fili Cothurnes +3"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
	--main="Tauret",
	--main={ name="Aeneas", augments={'Path: A',}},
	main="Naegling",
	--main="Carnwenhan",
    --sub="Mercurial Kris",
    --sub="Centovente",
	sub={ name="Gleti's Knife", augments={'Path: A',}},
	--sub="Carnwenhan",
	--sub="Genmei Shield",
    range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
    head={ name="Bunzi's Hat", augments={'Path: A',}},
    body="Ashera Harness",
    hands={ name="Bunzi's Gloves", augments={'Path: A',}},
	legs={ name="Nyame Flanchard", augments={'Path: B',}},
    --legs={ name="Zoar Subligar +1", augments={'Path: A',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
	--feet="Volte Spats",
    --neck={ name="Warder's Charm +1", augments={'Path: A',}},
	neck={ name="Bard's Charm +2", augments={'Path: A',}},
    --waist="Reiki Yotai",
	waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	--left_ear="Digni. Earring",
	--left_ear="Crep. Earring",
	left_ear="Dedition Earring",
	--left_ear="Suppanomimi",
    --right_ear="Eabani Earring",
	right_ear="Telos Earring",
	--right_ear="Brutal Earring",
    left_ring={name="Chirich Ring +1", bag="wardrobe2"},
    right_ring={name="Chirich Ring +1", bag="wardrobe5"},
	--left_ring={name="Moonlight Ring", bag="wardrobe8"},
    --right_ring={name="Moonlight Ring", bag="wardrobe7"},
	--right_ring="Shadow Ring",
    --back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.engaged.Auto = set_combine(sets.midcast.Cure, {
	range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
	main="Naegling",
	sub="Gleti's Knife",
	head="Fili Calot +3",
    body="Ayanmo Corazza +2",
    hands="Fili Manchettes +3",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Null Loop",
    waist="Kentarch Belt +1",
    left_ear="Telos Earring",
    right_ear="Lempo Earring",
    left_ring="Moonbeam Ring",
    right_ring="Ayanmo Ring",
    --back="Moonbeam Cape",
	})

	sets.dmg = {}
	sets.sub = {}

	--sets.dmg.index = {'Naegling','Tauret','Aeneas'}
	--dmg_ind = 1 --Naegling is the Default

	--sets.dmg['Naegling'] = {main="Naegling"}
	--sets.dmg['Tauret'] = {main="Tauret"}
	--sets.dmg['Aeneas'] = {main="Aeneas"}

	--sets.sub.index = {'TP Bonus','Gleti','Ternion','Malevolence'}
	--sub_ind = 1 --TP Bonus is the Default

	--sets.sub['TP Bonus'] = {sub={ name="Centovente", augments={'TP Bonus +1000',}}}
	--sets.sub['Gleti'] = {sub={ name="Gleti's Knife", augments={'Path: A',}}}
	--sets.sub['Ternion'] = {sub={ name="Ternion Dagger +1", augments={'Path: A',}}}
	--sets.sub['Malevolence'] = {sub={name="Malevolence", augments={'INT+9','Mag. Acc.+10','"Mag.Atk.Bns."+9','"Fast Cast"+4',}}}

    --[[ Sets with weapons defined.
    sets.engaged.Dagger = {
	}
	]]

	--Set if dual-wielding
    --sets.engaged.DW = {
	--back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	--}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            not state.Buff['Pianissimo'] then
            
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end
    end
	
	if (spell.type:endswith('Magic') or spell.type == "Ninjutsu" or spell.type == 'BardSong') then
	   if buffactive.Silence then
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
       end
    end
end

function self_command(command)
    if command == 'dmg set' then
        dmg_ind = dmg_ind +1
        if dmg_ind > #sets.dmg.index then dmg_ind = 1 end
        windower.add_to_chat(1,'<----- main Set changed to '..sets.dmg.index[dmg_indi]..' ----->')
        enable('main','sub','range')
        equip(sets.dmg[sets.dmg.index[dmg_ind]])
    end
    if command == 'sub set' then
        if sets.idle[sets.idle.index[idle_ind]] == sets.idle['DW'] then
            sub_ind = sub_ind +1
            if sub_ind > #sets.sub.index then sub_ind = 1 end
            windower.add_to_chat(1,'<----- sub Set changed to '..sets.sub.index[sub_ind]..' ----->')
            enable('main','sub','range')
            equip(sets.sub[sets.sub.index[sub_ind]])
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' then
		if BarElements:contains(spell.name) then
			equip(sets.midcast.bar_element)
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.type == 'BardSong' then
            -- layer general gear on first, then let default handler add song-specific gear.
            local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
                equip(sets.midcast[generalClass])
            end
        end
    end
			
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.ExtraSongsMode.value == 'FullLength' then
            equip(sets.midcast.Daurdabla)
        end

        state.ExtraSongsMode:reset()
    end
end

-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' and not spell.interrupted then
        if spell.target and spell.target.type == 'SELF' then
            adjust_timers(spell, spellMap)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','ammo')
        else
            enable('main','sub','ammo')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    pick_tp_weapon()
end


-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
	
	if world.area:contains('Adoulin') then
        idleSet = set_combine(sets.idle.Town, {body="Councilor's Garb"})
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'ResistantSongDebuff'
		elseif state.CastingMode.value == 'Mixed' then
			return 'MixedSongDebuff'
        else
            return 'SongDebuff'
        end
    elseif state.ExtraSongsMode.value == 'Dummy' then
        return 'DaurdablaDummy'
    else
        return 'SongEffect'
    end
end

-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
function adjust_timers(spell, spellMap)
    if state.UseCustomTimers.value == false then
        return
    end
    
    local current_time = os.time()
    
    -- custom_timers contains a table of song names, with the os time when they
    -- will expire.
    
    -- Eliminate songs that have already expired from our local list.
    local temp_timer_list = {}
    for song_name,expires in pairs(custom_timers) do
        if expires < current_time then
            temp_timer_list[song_name] = true
        end
    end
    for song_name,expires in pairs(temp_timer_list) do
        custom_timers[song_name] = nil
    end
    
    local dur = calculate_duration(spell.name, spellMap)
    if custom_timers[spell.name] then
        -- Songs always overwrite themselves now, unless the new song has
        -- less duration than the old one (ie: old one was NT version, new
        -- one has less duration than what's remaining).
        
        -- If new song will outlast the one in our list, replace it.
        if custom_timers[spell.name] < (current_time + dur) then
            send_command('timers delete "'..spell.name..'"')
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        end
    else
        -- Figure out how many songs we can maintain.
        local maxsongs = 2
        if player.equipment.range == info.ExtraSongInstrument then
            maxsongs = maxsongs + info.ExtraSongs
        end
        if buffactive['Clarion Call'] then
            maxsongs = maxsongs + 1
        end
        -- If we have more songs active than is currently apparent, we can still overwrite
        -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
        if maxsongs < table.length(custom_timers) then
            maxsongs = table.length(custom_timers)
        end
        
        -- Create or update new song timers.
        --[[if table.length(custom_timers) < maxsongs then
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        else
            local rep,repsong
            for song_name,expires in pairs(custom_timers) do
                if current_time + dur > expires then
                    if not rep or rep > expires then
                        rep = expires
                        repsong = song_name
                    end
                end
            end
            if repsong then
                custom_timers[repsong] = nil
                send_command('timers delete "'..repsong..'"')
                custom_timers[spell.name] = current_time + dur
                send_command('timers create "'..spell.name..'" '..dur..' down')
            end
        end--]]
    end
end

-- Function to calculate the duration of a song based on the equipment used to cast it.
-- Called from adjust_timers(), which is only called on aftercast().
function calculate_duration(spellName, spellMap)
    local mult = 1
    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    
    if player.equipment.main == "Carnwenhan" then mult = mult + 0.1 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.body == "Fili Hongreline +3" then mult = mult + 0.14 end
    if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
    if player.equipment.feet == "Brioso slippers +3" then mult = mult + 0.15 end
    
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +3" then mult = mult + 0.2 end
	if spellMap == 'Etude' and player.equipment.head == "Mousai Turban +1" then mult = mult + 0.2 end
    if spellMap == 'Madrigal' and player.equipment.head == "Fili Calot +3" and player.equipment.back == "Intarabus's Cape" then mult = mult + 0.2 end
    if spellMap == 'Minuet' and player.equipment.body == "Fili Hongreline +3" then mult = mult + 0.1 end
    if spellMap == 'March' and player.equipment.hands == 'Fili Manchettes +3' then mult = mult + 0.1 end
    if spellMap == 'Ballad' and player.equipment.legs == "Fili Rhingrave +3" then mult = mult + 0.1 end
    if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Fili Cothurnes +3" then mult = mult + 0.1 end
    if spellMap == 'Prelude' and player.equipment.back == "Intarabus's Cape" then mult = mult + 0.1 end
    if spellMap == 'Lullaby' and player.equipment.hands == "Brioso Cuffs +3" then mult = mult + 0.2 end
    
    if buffactive.Troubadour then
        mult = mult*2
    end
    if spellName == "Sentinel's Scherzo" then
        if buffactive['Soul Voice'] then
            mult = mult*2
        elseif buffactive['Marcato'] then
            mult = mult*1.5
        end
    end
    
    local totalDuration = math.floor(mult*120)

    return totalDuration
end


-- Examine equipment to determine what our current TP weapon is.
function pick_tp_weapon()
    if brd_daggers:contains(player.equipment.main) then
        state.CombatWeapon:set('Dagger')
        
        if S{'NIN','DNC'}:contains(player.sub_job) and brd_daggers:contains(player.equipment.sub) then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    else
        state.CombatWeapon:reset()
        state.CombatForm:reset()
    end
end

-- Function to reset timers.
function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 10)
end

function set_lockstyle()
	send_command('wait 6;input /lockstyleset 10')
end


windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)