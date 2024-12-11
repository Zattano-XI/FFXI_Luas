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

include('SendCommands.lua')

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
    state.CastingMode:options('Normal', 'Mixed', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Field')

    brd_daggers = S{'Kali', 'Carnwenhan'}
    pick_tp_weapon()
    
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Terpander'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 1
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(true, 'Use Custom Timers')
    
    -- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind delete gs c set ExtraSongsMode Dummy; input /ma "Goblin Gavotte" <t>')
	send_command('bind end gs c set ExtraSongsMode Dummy; input /ma "Herb Pastoral" <t>')
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
    --head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}, --10 FC
    head="Bunzi's Hat",
	body="Inyanga Jubbah +2", --14 FC
    hands="Leyline Gloves", --8 FC
    legs="Volte Brais", --8 FC
    feet="Volte Gaiters", --6 FC
    neck="Baetyl Pendant", --4 FC
    waist="Witful Belt", --3 FC 3 QC
    left_ear="Loquac. Earring", --2 FC
    right_ear="Etiolation Earring", --1 FC
    left_ring="Kishar Ring", --4 FC
    --right_ring="Lebeche Ring", --2 QC
    --back="Perimede Cape", --4 QC
    --back="Intarabus's Cape", --10 FC
	back="Fi Follet Cape +1", --10 FC
	}

    sets.precast.FC.Cure = set_combine(sets.precast.FC)
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.BardSong = { --83~87
	range="Loughnashade",
    --head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}, --10 FC
    head="Fili Calot +3",
	body="Inyanga Jubbah +2", --14 FC
    hands="Leyline Gloves",
	--hands="Gende. Gages +1", --7 FC
    --legs="Lengo Pants",
	legs="Volte Brais", --8 FC
    feet="Volte Gaiters", --6 FC
    neck="Baetyl Pendant", --4 FC
	waist="Embla Sash", --5 FC
    left_ear="Loquac. Earring", --2 FC
    right_ear="Etiolation Earring", --1 FC
    left_ring="Kishar Ring", --4 FC
	--right_ring="Rahab Ring", --2 FC
    back="Fi Follet Cape +1",
	--back="Intarabus's Cape",---FC 10
	}

    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	
	sets.precast.FC["Honor March"] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
        
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
    sets.precast.JA.Troubadour = {body="Bihu Justaucorps +1"}
    sets.precast.JA['Soul Voice'] = {legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},}

    -- Waltz set (chr and vit)
--[[    sets.precast.Waltz = {range="Gjallarhorn",
        head="Nahtirah Hat",
        body="Gendewitha Bliaut",hands="Buremte Gloves",
        back="Kumbira Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
]]--    
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
	range={ name="Linos", augments={'Attack+15','Weapon skill damage +3%','STR+8',}},
    head="Nyame Helm",
    --body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
	body="Nyame Mail",
	hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Fotia Gorget",
	waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Brutal Earring",
    left_ring="Cornelia's Ring",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", {'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
	neck="Baetyl Pendant",
    waist="Eschan Stone",
	--waist="Hachirin-no-Obi",
    left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    right_ear="Friomisi Earring",
	--back="Izdubar Mantle",
	left_ring="Metamor. Ring +1",
	right_ring="Ilabrat Ring",
	})
    
	sets.precast.WS['Cyclone'] = set_combine(sets.precast.WS['Aeolian Edge'], {
	--40% DEX / 40% INT
	})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    head={ name="Blistering Sallet +1", augments={'Path: A',}},
	body="Ayanmo Corazza +2",
    hands="Bunzi's Gloves",
	left_ring="Hetairoi Ring",
	})
	
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS)
	
    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
	neck="Mnbw. Whistle +1",
	})
	
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
	left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
	neck={ name="Bard's Charm +2", augments={'Path: A',}},
	waist="Kentarch Belt",
	})
    
	sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {
	neck="Rep. Plat. Medal",
	left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
	left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
	waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	right_ring={name="Stikini Ring", bag="wardrobe4"},
	right_ear="Ishvara Earring",
	})
    
    -- Midcast Sets

    -- General set for recast times.    
	sets.midcast.FastRecast = {}
        
    -- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
    sets.midcast.Ballad = {legs="Fili Rhingrave +3",}--range="Blurred Harp +1",
	sets.midcast.Mambo = {feet="Mousai Crackows +1"}
    sets.midcast.Lullaby = {hands="Brioso Cuffs +2",}--range="Blurred Harp +1",
    sets.midcast.Madrigal = {head="Fili Calot +3",back="Intarabus's Cape",}
	sets.midcast.Prelude = {back="Intarabus's Cape",}
    sets.midcast.March = {hands="Fili Manchettes +3"}
    sets.midcast.Minuet = {body="Fili Hongreline +3"}
    sets.midcast.Minne = {legs="Mousai Seraweels +1"}
    sets.midcast.Paeon = {head="Brioso Roundlet +2"}
	sets.midcast.Etude = {Head="Mousai Turban +1"}
	sets.midcast.Carol = {hands="Mousai Gages +1"}
	sets.midcast.Threnody = {body="Mou. Manteel +1"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +3"}
    sets.midcast['Magic Finale'] = {}
	sets.midcast['Magic Finale'].Mixed = set_combine(sets.midcast['Magic Finale'], {})
	sets.midcast['Magic Finale'].Resistant = set_combine(sets.midcast['Magic Finale'], {})	
    sets.midcast.Mazurka = {range=info.ExtraSongInstrument}
	sets.midcast["Honor March"] = {range="Marsyas"}
    

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {
	main="Carnwenhan",
    sub="Kali",
    range="Loughnashade",
	--range="Gjallarhorn",
    head="Fili Calot +3",
    body="Fili Hongreline +3",
    hands="Fili Manchettes +3",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +2",
    neck="Mnbw. Whistle +1",
    waist="Flume Belt",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Fili Earring +1",
    left_ring="Defending Ring",
    right_ring="Moonlight Ring",
    back="Intarabus's Cape",
	}

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {
	--main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}, bag="wardrobe1"},
    --sub={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}, bag="wardrobe2"},
	--sub="Ammurapi Shield",
	range="Loughnashade",
	--range="Gjallarhorn",
    --head="Brioso Roundlet +3",
	head="Fili Calot +3",
    body="Fili Hongreline +3",
    hands="Inyan. Dastanas +2",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    --waist={ name="Acuity Belt +1", augments={'Path: A',}},
    left_ear="Regal Earring",
    right_ear="Fili Earring +1",
	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	ring2={name="Stikini Ring +1", bag="wardrobe5"}, 
	back="Intarabus's Cape",
	}

    -- For song defbuffs (Mix of accuracy/duration)
    sets.midcast.MixedSongDebuff = set_combine(sets.midcast.SongDebuff, {head="Brioso Roundlet +3"})
	
	-- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.ResistantSongDebuff = set_combine(sets.midcast.MixedSongDebuff, {
    body="Brioso Justau. +2",
    legs="Brioso Cannions +2",
	})

    -- Song-specific recast reduction
    sets.midcast.SongRecast = {ear1="Loquacious Earring",ring1="Kishar Ring",ring1="Lebeche Ring",legs="Fili Rhingrave +3"}

    --sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

    -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	sets.midcast['Herb Pastoral'] = {range="Terpander",}
	sets.midcast['Warding Round'] = {range="Terpander",}
	
    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = {
	main={ name="Kali", bag="wardrobe1"}, --7 FC
    sub={ name="Kali",  bag="wardrobe8"}, --7 FC
	--sub="Ammurapi Shield",
	--range="Terpander",
    head="Fili Calot +3", 
    body="Inyanga Jubbah +2", --14 FC
    hands="Leyline Gloves", --7 FC
    --legs="Volte Brais", --6 FC
    --feet="Volte Gaiters", --6 FC
    neck="Baetyl Pendant", --4 FC
	waist="Embla Sash", --5 FC
    --left_ear="Loquac. Earring", --2 FC
    right_ear="Etiolation Earring", --1 FC
    left_ring="Kishar Ring", --4 FC
	--right_ring="Rahab Ring", --2 FC
	back="Fi Follet Cape +1", --FC 10
	}

    -- Other general spells and classes.
    sets.midcast.Cure = { --53CP 9CP2 57ConMP
	--main="Daybreak",
    --sub="Ammurapi Shield",
	ammo="Pemphredo Tathlum", --4 ConMP
    head="Kaykaus Mitra +1",-- augments={'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',}}, --11 CP 2 CP2
    --body={ name="Kaykaus Bliaut +1", augments={'MP+80','"Cure" potency +6%','"Conserve MP"+7',}},
    body="Bunzi's Robe", --15cp
	hands="Kaykaus Cuffs +1",-- augments={'MP+80','MND+12','Mag. Acc.+20',}}, --11 CP 2 CP2
    --legs={ name="Kaykaus Tights +1", augments={'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',}}, --11 CP 2 CP2
    legs="Bunzi's Slops",
	feet="Kaykaus Boots +1", --augments={'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',}}, --11 CP 2 CP2 7 ConMP
    neck="Baetyl Pendant",
    --neck="Reti Pendant", --4 ConMP
    waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}}, --15 ConMP
    --left_ear="Gifted Earring", --3 ConMP
    --right_ear="Calamitous Earring", --4 ConMP
    right_ear="Mendi. Earring",
	--left_ring="Naji's Loop", --1 CP 1 CP2
    ring1={name="Stikini Ring +1", bag="wardrobe2"},
	right_ring={ name="Mephitas's Ring +1", augments={'Path: A',}}, --15 ConMP
    back={ name="Fi Follet Cape +1", augments={'Path: A',}}, --5 ConMP
	}
        
    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
	
	sets.midcast['Enhancing Magic'] = {
	main="Pukulatmuj +1",
    sub="Ammurapi Shield",
	head="Telchine Cap",
	body="Telchine Chas.",
	hands="Telchine Gloves",
	legs="Telchine Braconi",
	feet="Telchine Pigaches",
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Andoaa Earring",
	left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	}
	sets.midcast['Enfeebling Magic'] = {
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}, bag="wardrobe7"}, --7 FC
		--sub={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}, bag="wardrobe8"}, --7 FC
		sub="Ammurapi Shield",
		--head="Brioso Roundlet +3",
		
		neck="Mnbw. Whistle +1",
		left_ear="Regal Earring",
		--right_ear="Vor Earring",
		body="Brioso Justau. +1",
		hands="Brioso Cuffs +1",
		left_ring={name="Stikini Ring", bag="wardrobe3"}, --1
		right_ring={name="Stikini Ring", bag="wardrobe4"}, --1
		back="Intarabus's Cape",
		waist="Obstin. Sash",
		legs={ name="Chironic Hose", augments={'"Conserve MP"+5','Mag. Acc.+30','Accuracy+4 Attack+4',}},
		feet="Brioso slippers +3"
		}
    sets.midcast.Stoneskin = set_combine (sets.midcast['Enhancing Magic'], {
	neck="Nodens Gorget",
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
    feet="Gendewitha galoshes +1",
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
    ammo="Mana Ampulla",
    head="Orvail Corona +1",
    body="Oracle's Robe",
    hands="Nares Cuffs",
    legs="Menhit Slacks",
    feet="Chelona Boots",
    neck="Eidolon Pendant +1",
    waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}},
    left_ear="Relaxing Earring",
    right_ear="Magnifying Earring",
    left_ring="Angha Ring",
    right_ring="Star Ring",
    back="Felicitas Cape +1",
	}
    
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = { --44 DT 7 PDT 4 MDT 18% Movement Reraise
	--main="Daybreak",
    --sub="Genmei Shield",
	--ammo="Staunch Tathlum +1", --3 DT
    head="Fili Calot +3", --7 DT
    body="Adamantite Armor", --Reraise
    --hands={ name="Chironic Gloves", augments={'Weapon skill damage +2%','INT+7','"Refresh"+2','Accuracy+11 Attack+11','Mag. Acc.+13 "Mag.Atk.Bns."+13',}}, --1 Refresh
	hands="Fili Manchettes +3", --7 DT
    --legs={ name="Assid. Pants +1", augments={'Path: A',}}, --1~2 Refresh
    legs="Nyame Flanchard", --8 DT
    --feet="Volte Gaiters", --1 Refresh
	--feet={ name="Nyame Sollerets", augments={'Path: B',}}, --7 DT
	feet="Fili Cothurnes +3", --18% Movement
    neck="Loricate Torque +1", --6 DT
	--neck={ name="Bard's Charm", augments={'Path: A',}},
    waist="Carrier's Sash", 
	--waist="Flume Belt +1", --4 PDT
    right_ear="Etiolation Earring", --3 MDT
	left_ear={ name="Odnowa Earring +1", augments={'Path: A',}}, --3 DT 2 MDT
	left_ring={name="Stikini Ring +1", bag="wardrobe2"}, --1 Refresh
    right_ring={name="Stikini Ring +1", bag="wardrobe5"}, --1 Refresh
    back="Intarabus's Cape", --5 DT
		}

    sets.idle.PDT = {
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Loricate Torque +1",
    waist="Carrier's Sash",
    left_ear="Eabani Earring",
    right_ear="Infused Earring",
    left_ring="Vengeful Ring",
    right_ring="Warden's Ring",
    back="Intarabus's Cape",
	 }
			
    sets.idle.Town = {
    feet="Fili Cothurnes +3",
	}
    
    sets.idle.Weak = set_combine(sets.idle.PDT, {})
    
    
    -- Defense sets

    sets.defense.PDT = {
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Loricate Torque +1",
    waist="Carrier's Sash",
    left_ear="Eabani Earring",
    right_ear="Infused Earring",
    left_ring="Vengeful Ring",
    right_ring="Warden's Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	}

    sets.defense.MDT = {
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Loricate Torque +1",
    waist="Carrier's Sash",
    left_ear="Eabani Earring",
    right_ear="Infused Earring",
    left_ring="Vengeful Ring",
    right_ring="Warden's Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},}

    sets.Kiting = {feet="Fili Cothurnes +3"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
	--range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
    --head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
	--body="Ashera Harness",
    hands="Bunzi's Gloves",
	--hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
	neck="Bard's Charm +2",
    waist="Reiki Yotai",
	--waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Telos Earring",
	right_ear="Crep. Earring",
    --right_ear="Brutal Earring",
    left_ring={name="Moonlight Ring", bag="wardrobe5"},
    right_ring={name="Moonlight Ring", bag="wardrobe5"},
    --back={ name="Aurist's Cape +1", augments={'Path: A',}},
	back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},
	head="Fili Calot +3",
    back="Moonbeam Cape",	
	}
	
	    sets.engaged.Auto = {
	--range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
    --head="Aya. Zucchetto +2",
    --body="Ayanmo Corazza +2",
	--body="Ashera Harness",
    --hands="Bunzi's Gloves",
	--hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
    --legs={ name="Zoar Subligar +1", augments={'Path: A',}},
    --feet={ name="Nyame Sollerets", augments={'Path: B',}},
	--neck={ name="Bard's Charm", augments={'Path: A',}},
    --waist="Reiki Yotai",
	--waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    --left_ear="Telos Earring",
	--right_ear="Crep. Earring",
    --right_ear="Brutal Earring",
    --left_ring={name="Moonlight Ring", bag="wardrobe8"},
    --right_ring={name="Moonlight Ring", bag="wardrobe7"},
    --back={ name="Aurist's Cape +1", augments={'Path: A',}},
	--back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},
	main="Naegling",
	head="Fili Calot +3",
    body="Ayanmo Corazza +2",
    hands="Fili Manchettes +3",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Sanctity Necklace",
    waist="Kentarch Belt",
    left_ear="Telos Earring",
    right_ear="Lempo Earring",
    left_ring="Moonbeam Ring",
    right_ring="Ayanmo Ring",
    back="Moonbeam Cape",
	
	}


	sets.dmg = {}
	sets.sub = {}

	sets.dmg.index = {'Naegling','Tauret','Aeneas'}
	dmg_ind = 1 --Naegling is the Default

	sets.dmg['Naegling'] = {main="Naegling"}
	sets.dmg['Tauret'] = {main="Tauret"}
	sets.dmg['Aeneas'] = {main="Aeneas"}

	sets.sub.index = {'TP Bonus','Gleti','Ternion','Malevolence'}
	sub_ind = 1 --TP Bonus is the Default

	sets.sub['TP Bonus'] = {sub={ name="Fusetto +3", augments={'TP Bonus +1000',}}}
	sets.sub['Gleti'] = {sub="Gleti's Knife",}
	sets.sub['Ternion'] = {sub={ name="Ternion Dagger +1", augments={'Path: A',}}}
	sets.sub['Malevolence'] = {sub={name="Malevolence", augments={'INT+9','Mag. Acc.+10','"Mag.Atk.Bns."+9','"Fast Cast"+4',}}}

    --[[ Sets with weapons defined.
    sets.engaged.Dagger = {
	}

    -- Set if dual-wielding
    sets.engaged.DW = {
		}
	]]--	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    --if spell.type == 'BardSong' then
        -- Auto-Pianissimo
        --if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            --not state.Buff['Pianissimo'] then
            
            --local spell_recasts = windower.ffxi.get_spell_recasts()
            --if spell_recasts[spell.recast_id] < 2 then
                --send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                --eventArgs.cancel = true
                --return
            --end
        --end
    --end
	
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
    
    if player.equipment.main == "Carnwenhan" then mult = mult + 0.3 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.body == "Fili Hongreline +3" then mult = mult + 0.13 end
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