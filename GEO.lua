-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Magic Burst Mode Toggle
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Full Circle
--              [ CTRL+B ]          Blaze of Glory
--              [ CTRL+A ]          Ecliptic Attrition
--              [ CTRL+D ]          Dematerialize
--              [ CTRL+L ]          Life Cycle
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad0 ]    Myrkr
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.

include('SendCommands.lua')

function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    geo_timer = ''
    indi_timer = ''
    indi_duration = 308
    entrust_timer = ''
    entrust_duration = 344
    entrust = 0
    newLuopan = 0

    state.Buff['Blaze of Glory'] = buffactive['Blaze of Glory'] or false

    -- state.CP = M(false, "Capacity Points Mode")

    state.Auto = M(true, 'Auto Nuke')
    state.Element = M{['description']='Element','Fire','Blizzard','Aero','Stone','Thunder','Water'}

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    degrade_array = {
        ['Fire'] = {'Fire','Fire II','Fire III','Fire IV','Fire V'},
        ['Ice'] = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V'},
        ['Wind'] = {'Aero','Aero II','Aero III','Aero IV','Aero V'},
        ['Earth'] = {'Stone','Stone II','Stone III','Stone IV','Stone V'},
        ['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V'},
        ['Water'] = {'Water', 'Water II','Water III', 'Water IV','Water V'},
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'},
        }

	--lockstyle
	    state.AutoLockstyle = M(true, 'AutoLockstyle Mode')
	    send_command('@wait 3; input /lockstyleset 21')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'DT', 'Acc')
    state.CastingMode:options('Normal', 'Seidr', 'Resistant')
    state.IdleMode:options('DT','Normal' )

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')

    -- Additional local binds

    send_command('bind ^` input /ja "Full Circle" <me>')
    send_command('bind ^b input /ja "Blaze of Glory" <me>')
    send_command('bind ^a input /ja "Ecliptic Attrition" <me>')
    send_command('bind ^d input /ja "Dematerialize" <me>')
    send_command('bind ^c input /ja "Life Cycle" <me>')
    send_command('bind !m gs c toggle MagicBurst')
    send_command('bind ^insert gs c cycleback Element')
    send_command('bind ^delete gs c cycle Element')
    send_command('bind !w input /ma "Aspir III" <t>')
    send_command('bind !p input /ja "Entrust" <me>')
    send_command('bind ^, input /ma Sneak <stpc>')
    send_command('bind ^. input /ma Invisible <stpc>')
    -- send_command('bind !c gs c toggle CP')
    send_command('bind !w gs c toggle WeaponLock')

    send_command('bind ^numpad7 input /ws "Black Halo" <t>')
    send_command('bind ^numpad8 input /ws "Hexa Strike" <t>')
    send_command('bind ^numpad9 input /ws "Realmrazer" <t>')
    send_command('bind ^numpad6 input /ws "Exudation" <t>')
    send_command('bind ^numpad1 input /ws "Flash Nova" <t>')

	include('SendCommands.lua')

    select_default_macro_book()

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind ^b')
    send_command('unbind ^a')
    send_command('unbind ^d')
    send_command('unbind ^c')
    send_command('unbind !`')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind !w')
    send_command('unbind !p')
    send_command('unbind ^,')
    send_command('unbind !.')
    -- send_command('unbind @c')
    send_command('unbind !w')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad1')
    send_command('unbind !numpad7')
    send_command('unbind !numpad8')
    send_command('unbind !numpad9')
    send_command('unbind !numpad4')
    send_command('unbind !numpad5')
    send_command('unbind !numpad6')
    send_command('unbind !numpad1')
    send_command('unbind !numpad+')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Precast Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +3"}
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood +3"}
    sets.precast.JA['Life Cycle'] = {head="Bagua Galero +3", body="Geomancy Tunic +3", back="Nantosuelta's Cape",}


    sets.TreasureHunter = {ammo="Perfect Lucky Egg", head="White Rarab Cap +1", waist="Chaac Belt",}

    -- Fast cast sets for spells

    sets.precast.FC = {
    --  /RDM --15
        ranged="Dunna", --3
        --main="Sucellus", --5 excluded
        --sub="Chanter's Shield", --3 excluded
        head="Merlinic Hood", --14
        --body="Merlinic Jubbah", --12 excluded
        body="Agwu's Robe", --8
		hands="Agwu's Gages", --6
		--legs="Geomancy Pants +2", --15 excluded
        legs="Agwu's Slops", --7
		feet="Regal Pumps +1", --5 Volte Gaiters
        neck="Orunmila's Torque", --4
        ear1="Malignance Earring", --4
        ear2="Etiolation Earring", --1 
        ring1="Kishar Ring", --4
        ring2="Prolix Ring", --2
        back="Fi Follet Cape +1", --10
        waist="Shinjutsu-no-Obi +1",
        } -- 76%

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        back="Perimede Cape",
        waist="Siegel Sash",
        })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Bagua Mitaines +3"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ear1="Mendi. Earring", --5
        ring2="Lebeche Ring", 
        back="Perimede Cape", --(4) 
        legs="Vanya Slops",
		feet="Vanya Clogs",
		})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty, 
		body="Crepuscular Cloak",
	    ranged="Dunna", --3
        --main="Sucellus", --5 excluded
        --sub="Chanter's Shield", --3 excluded
		hands="Agwu's Gages", --6
		--legs="Geomancy Pants +2", --15 excluded
        legs="Agwu's Slops", --7
		feet="Regal Pumps +1", --5 Volte Gaiters
        neck="Orunmila's Torque", --4
        ear1="Malignance Earring", --4
        ear2="Etiolation Earring", --1 
        ring1="Kishar Ring", --4
        ring2="Prolix Ring", --2
        back="Fi Follet Cape +1", --10
        waist="Shinjutsu-no-Obi +1",
	})
    
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nyame Helm",
		neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Azimuth Earring +2",
		body="Nyame Mail",
        hands="Nyame Gauntlets",
        ring1="Epaminondas's Ring",
        ring2="Cornelia's Ring",
		back="Aurist's Cape +1",
		waist="Fotia Belt",
		legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        }

    sets.precast.WS['Hexastrike'] = set_combine(sets.precast.WS, {
        neck="Rep. Plat. Medal",
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Exudation'] = sets.precast.WS['Hexastrike']

	sets.precast.WS['Realmrazer'] = sets.precast.WS['Hexastrike']
	
    sets.precast.WS['Flash Nova'] = {
        neck="Saevus Pendant +1",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Metamor. Ring +1",
        --back=gear.GEO_MAB_Cape,
        back="Nantosuelta's Cape",
		waist="Refoccilation Stone",
        }

    ------------------------------------------------------------------------
    ----------------------------- Midcast Sets -----------------------------
    ------------------------------------------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = {
        main="Sucellus",
        sub="Chanter's Shield",
        head="Amalric Coif +1",
        hands=gear.Merl_FC_hands,
        legs="Geomancy Pants +3",
        ear1="Malignance Earring",
        ear2="Etiolation Earring",
        ring1="Kishar Ring",
        ring2="Lebeche Ring",
        back="Fi Follet Cape +1",
        waist="Shinjutsu-no-Obi +1",
        } -- Haste

   sets.midcast.Geomancy = {
        main="Idris",
		sub="Chanter's Shield",
        head="Bagua Galero +3",
        body="Vedic Coat",
        hands="Telchine Gloves",
        legs="Vanya Slops",
        feet="Amalric Nails +1",
        --ear1="Calamitous Earring",
        ear1="Mendi. earring",
		ear2="Azimuth Earring +2",
        neck="Incanter's Torque",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		ring2={name="Stikini Ring +1", bag="wardrobe5"},
        back="Fi Follet Cape +1",
        waist="Shinjutsu-no-Obi +1",
        }

    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
        head="Vanya Hood",
        legs="Bagua Pants +3",
        feet="Azimuth Gaiters +3",
        back="Lifestream Cape",
        })

    sets.midcast.Cure = { --50
        main="Daybreak", --30CP
        sub="Genmei Shield", --3/(-5) ***
        head="Vanya Hood", --10CP
        body="Agwu's Robe", --7/(-6)?
        hands="Telchine Gloves", --10CP
        legs="Vanya Slops", --12CMP
        feet="Vanya Clogs", --5CP
        neck="Incanter's Torque",
        ear1="Beatific Earring",
        ear2="Meili Earring",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		ring2={name="Stikini Ring +1", bag="wardrobe5"},
        back="Solemnity Cape", --0/(-10)
        waist="Bishop's Sash",
        }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Nuna Gorget +1",
        ring2="Metamor. Ring +1",
        waist="Luminary Sash",
        })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        neck="Malison Medallion",
        ring1={name="Haoma's Ring", bag="wardrobe3"},
        ring2={name="Haoma's Ring", bag="wardrobe4"},
        back="Oretan. Cape +1",
        })

    sets.midcast['Enhancing Magic'] = {
        main=gear.Gada_ENH,
        sub="Ammurapi Shield",
        head="Befouled Crown",
        body="Telchine Chas.",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Telchine Pigaches",
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		ring2={name="Stikini Ring +1", bag="wardrobe5"},
        back="Fi Follet Cape +1",
        waist="Olympus Sash",
        }

    sets.midcast.EnhancingDuration = {
        main=gear.Gada_ENH,
        sub="Ammurapi Shield",
        head="Telchine Cap",
        body="Telchine Chas.",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Telchine Pigaches",
        waist="Embla Sash",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1",
        })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
        sub="Ammurapi Shield",
        head="Amalric Coif +1",
        ear2="Magnetic Earring",
        })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect


    sets.midcast.MndEnfeebles = {
        main="Idris",
        sub="Ammurapi Shield",
        head="Azimuth Hood +3",
        body="Azimuth Coat +3",
        hands="Geo. Mitaines +2",
        legs="Geomancy Pants +3",
        feet="Bagua Sandals +3",
        neck="Bagua Charm +2",
        ear1="Vor Earring",
        ear2="Regal Earring",
        ring1="Kishar Ring",
        ring2="Stikini Ring +1",
        back="Aurist's Cape +1",
        waist="Luminary Sash",
        } -- MND/Magic accuracy

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        ring1="Freke Ring",
        ring2="Metamorph Ring +1",
        waist="Acuity Belt +1",
        }) -- INT/Magic accuracy

    sets.midcast.LockedEnfeebles = {body="Geomancy Tunic +3"}

    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield"})

	sets.midcast.Dia = set_combine(sets.midcast.MndEnfeebles, {
		ammo="Per. Lucky Egg",
		body="Volte Jupon",
		waist="Chaac Belt",
		feet="Merlinic Crackows",
		})

	sets.midcast['Dia II'] = sets.midcast.Dia
	

    sets.midcast['Dark Magic'] = {
        main="Rubicundity",
        sub="Ammurapi Shield",
        head="Azimuth Hood +3",
        --body="Geomancy Tunic +3",
        body="Azimuth Coat +3",
		hands="Agwu's Gages",
        legs="Azimuth Tights +3",
        feet="Azimuth Gaiters +3",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Stikini Ring +1",
        ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
        }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Bagua Galero +3",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        ear1="Hirudinea Earring",
        ear2="Mani Earring",
        waist="Fucho-no-Obi",
        })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        })

    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
        head="Azimuth Hood +3",
        body="Azimuth Coat +3",
        hands="Agwu's Gages",
        legs="Azimuth Tights +3",
        feet="Azimuth Gaiters +3",
        neck="Saevus Pendant +1",
        ear1="Regal Earring",
        ear2="Azimuth Earring +2",
        ring1="Freke Ring",
        ring2="Metamorph ring +1",
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
        }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        main="Idris",
        sub="Ammurapi Shield",
        --hands="Bagua Mitaines +3",
        --legs=gear.Merl_MAB_legs,
        --feet=gear.Merl_MAB_feet,
        neck="Null Loop",
        ear2="Digni. Earring",
        waist="Acuity Belt +1",
        })

    sets.midcast.GeoElem = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'].Resistant, {
        body="Seidr Cotehardie",
        })

    sets.midcast.GeoElem.Seidr = set_combine(sets.midcast['Elemental Magic'].Seidr, {})

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        ammo="Seraphic Ampulla",
		head=empty,
        neck="Combatant's Torque", --4 STP
		left_ear="Crep. Earring", --6 STP
		right_ear="Telos Earring", --5 STP
		body="Crepuscular Cloak",
		left_ring="Crepuscular Ring", --6 STP
		right_ring="Chirich Ring +1", --5 STP    
		waist="Oneiros Rope", --20 Occult 2 STP
		legs="Perdition Slops", --30 Occult
        }) --Occult build

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    ------------------------------------------------------------------------------------------------
    ------------------------------------------ Idle Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        main="Bolelabunga",
        sub="Genmei Shield",
        head="Volte Beret",
        body="Azimuth Coat +3", 
        --hands="Bagua Mitaines +3",
        hands="Agwu's Gages",
		legs="Volte Brais",
        feet="Geomancy Sandals +3",
        neck="Bathy Choker +1",--windy?
        ear1="Lugalbanda Earring",
        ear2="Etiolation Earring",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		ring2={name="Stikini Ring +1", bag="wardrobe5"},
        back="Nantosuelta's Cape",
        waist="Slipor Sash",
        }

    sets.resting = set_combine(sets.idle, {
        waist="Shinjutsu-no-Obi +1",
        })

    sets.idle.DT = set_combine(sets.idle, {
        sub="Genmei Shield", --10/0
 		head="Nyame Helm",
		body="Adamantite Armor",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
        neck="Loricate Torque +1", --6/6
        ear1="Genmei Earring", --2/0
        ear2="Azimuth Earring +2", --3/3
		--ear2="Azimuth Earring +1", --3/3
        ring1="Gelatinous Ring +1", --7/(-1)
        ring2="Defending Ring", --10/10
        back="Nantosuelta's Cape", --5/5
        waist="Slipor Sash", --0/3
        })

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = set_combine(sets.idle, {
        -- PDT / MDT / Pet: -DT (37.5% to cap) / Pet: Regen
        main="Idris", --0/0/25/0
        sub="Genmei Shield", --10/0/0/0
        head="Azimuth Hood +3", --12/12/0/5
        body="Adamantite Armor", --20/20/0/0
        hands="Geo. Mitaines +2", --3/0/13/0
        legs="Telchine Braconi", --0/0/0/3
        feet="Bagua Sandals +3", --0/0/0/5
        neck="Bagua Charm +2",
        ear1="Odnowa Earring +1", 
        ear2="Azimuth Earring +2", priority=14, --6/6/0/0
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		ring2={name="Stikini Ring +1", bag="wardrobe5"},
        back="Nantosuelta's Cape", --0/0/0/15
        waist="Isa Belt" --0/0/3/1
        }) --58/48/28/29

    sets.idle.DT.Pet = set_combine(sets.idle.Pet, {
		legs="Nyame Flanchard",
		})

    sets.PetHP = {head="Bagua Galero +3"}

    -- .Indi sets are for when an Indi-spell is active.
    --sets.idle.Indi = set_combine(sets.idle, {})
    --sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    --sets.idle.DT.Indi = set_combine(sets.idle.DT, {})
    --sets.idle.DT.Pet.Indi = set_combine(sets.idle.DT.Pet, {})

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Geo. Sandals +3"}

    sets.latent_refresh = {waist="Fucho-no-Obi"}

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        main="Idris",
        sub="Genmei Shield",
        head="Azimuth Hood +3",
		neck="Combatant's Torque",
		ear1="Telos Earring",
        ear2="Crepuscular Earring",
        body="Nyame Mail",
		hands="Gazu Bracelets +1",
        left_ring={name="Chirich Ring +1", bag="wardrobe2"},
        right_ring={name="Chirich Ring +1", bag="wardrobe5"},
        back="Null Shawl",
		waist="Grunfeld Rope", --cetl belt
		legs="Nyame Flanchard",
        feet="Azimuth Gaiters +3",
        }

	sets.engaged.DT = {
        main="Idris",
        sub="Genmei Shield",
        head="Nyame Helm",
		neck="Loricate Torque +1",
		ear1="Cessance Earring",
        ear2="Brutal Earring",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        ring1="Chirich Ring +1",
        ring2="Defending Ring",
        back="Null Shawl",
		waist="Cetl Belt",
		legs="Nyame Flanchard",
        feet="Nyame Sollerets"
        }

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.magic_burst = set_combine(sets.midcast['Elemental Magic'], {
        head="Azimuth Hood +3", --7/(7)
        body="Azimuth Coat +3", --9/(9)
        hands="Agwu's Gages", --6/(6)
        legs="Azimuth Tights +3", --8/(8)
        feet="Azimuth Gaiters +3",
        neck="Mizu. Kubikazari", --10
        ring2="Mujin Band", --(5)
        })

    sets.buff.Doom = {ring1={name="Saida Ring", bag="wardrobe3"}, ring2={name="Saida Ring", bag="wardrobe4"},}
    sets.Obi = {waist="Hachirin-no-Obi"}
    -- sets.CP = {back="Mecisto. Mantle"}
	
	sets.vagary = {    
	main="Idris",
    sub="Genmei Shield",
    ammo="Pemphredo Tathlum",
    head="Volte Beret",
	ear1=empty,
	ear2=empty,
    body="Adamantite Armor",
    hands="Regal Cuffs",
    neck={ name="Bagua Charm +2", augments={'Path: A',}},
    left_ring="Defending Ring",
    right_ring="Shadow Ring",
	back=empty,
	waist=empty,
	legs="Volte Brais",
	feet="Medium's Sabots",
}

	sets.phalanx = {
	ammo="Staunch Tathlum +1",
	main="Sakpata's Sword",
	head="Chironic Hat",
	body="Chironic Doublet",
	hands="Chironic Gloves", --augments={'Phys. dmg. taken -2%','Pet: "Store TP"+7','Phalanx +5','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
	legs="Chironic Hose",
	feet="Chironic Slippers",
	neck="Null Loop",
	ear1="Odnowa earring +1",
	ring1="Shadow Ring",
	ring2="Defending Ring",
	back="Moonbeam Cape",
	waist="Null Belt",
	}	


end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell, spellMap, eventArgs)
    if spell.type == 'Geomancy' then
        if spell.name:startswith('Indi') and buffactive.Entrust and spell.target.type == 'SELF' then
            add_to_chat(002, 'Entrust active - Select a party member!')
            cancel_spell()
        end
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    elseif state.Auto.value == true then
        if spell.skill == 'Elemental Magic' and spell.english ~= 'Impact' and spellMap ~= 'GeoNuke' then
            refine_various_spells(spell, action, spellMap, eventArgs)
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    elseif spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    elseif spell.skill == 'Enfeebling Magic' and newLuopan == 1 then
        -- prevent Cohort Cloak from unequipping head when relic head is locked
        equip(sets.midcast.LockedEnfeebles)
    elseif spell.skill == 'Geomancy' then
        if buffactive.Entrust and spell.english:startswith('Indi-') then
            equip({main=gear.Gada_GEO})
                entrust = 1
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        --[[if spell.english:startswith('Geo') then
            geo_timer = spell.english
            send_command('@timers c "'..geo_timer..'" 600 down spells/00136.png')
        elseif spell.english:startswith('Indi') then
            if entrust == 1 then
                entrust_timer = spell.english
                send_command('@timers c "'..entrust_timer..' ['..spell.target.name..']" '..entrust_duration..' down spells/00136.png')
                entrust = 0
            else
                send_command('@timers d "'..indi_timer..'"')
                indi_timer = spell.english
                send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
            end
        end ]]
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english:startswith('Geo-') or spell.english == "Life Cycle" then
            newLuopan = 1
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    if gain == false then
        send_command('@timers d "'..geo_timer..'"')
        enable('head')
        newLuopan = 0
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        elseif spell.skill == 'Elemental Magic' then
            if spellMap == 'GeoElem' then
                return 'GeoElem'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if pet.isvalid then
        if pet.hpp > 73 then
            if newLuopan == 1 then
                equip(sets.PetHP)
                disable('head')
            end
        elseif pet.hpp <= 73 then
            enable('head')
            newLuopan = 0
        end
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Auto.value then
        msg = ' Auto: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function refine_various_spells(spell, action, spellMap, eventArgs)

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if spell.skill == 'Elemental Magic' and spellMap ~= 'GeoElem' then
            spell_index = table.find(degrade_array[spell.element],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array[spell.element][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        elseif spell.name:startswith('Aspir') then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end



-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'nuke' and not midaction() then
        send_command('@input /ma "' .. state.Element.current .. ' V" <t>')
    end
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 21)
end