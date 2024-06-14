-- Original: Motenten / Modified: Arislan
-- https://github.com/ArislanShiva/luas/blob/master/Arislan-SCH.lua

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
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+H ]           Cycle Helix Mode
--              [ WIN+R ]           Cycle Regen Mode
--              [ WIN+S ]           Toggle Storm Surge
--
--  Abilities:  [ CTRL+` ]          Immanence
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+[ ]          Rapture/Ebullience
--              [ CTRL+] ]          Altruism/Focalization
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+] ]           Perpetuance
--              [ ALT+; ]           Penury/Parsimony
--
--  Weapons:    [ ALT+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad0 ]    Myrkr
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--              Addendum Commands:
--              Shorthand versions for each strategem type that uses the version appropriate for
--              the current Arts.
--                                          Light Arts                    Dark Arts
--                                          ----------                  ---------
--                gs c scholar light          Light Arts/Addendum
--              gs c scholar dark                                       Dark Arts/Addendum
--              gs c scholar cost           Penury                      Parsimony
--              gs c scholar speed          Celerity                    Alacrity
--              gs c scholar aoe            Accession                   Manifestation
--              gs c scholar power          Rapture                     Ebullience
--              gs c scholar duration       Perpetuance
--              gs c scholar accuracy       Altruism                    Focalization
--              gs c scholar enmity         Tranquility                 Equanimity
--              gs c scholar skillchain                                 Immanence
--              gs c scholar addendum       Addendum: White             Addendum: Black


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    state.HelixMode = M{['description']='Helix Mode', 'Potency', 'Duration'}
    state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}
    state.CP = M(false, "Capacity Points Mode")

    update_active_strategems()

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
    degrade_array = {
        ['Aspirs'] = {'Aspir','Aspir II'}
        }

    lockstyleset = 10

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Seidr', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'Vagary')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.StormSurge = M(false, 'Stormsurge')

    -- Additional local binds
    --include('Global-Binds.lua') -- OK to remove this line
    --include('Global-GEO-Binds.lua') -- OK to remove this line

    --send_command('bind ^` input /ja Immanence <me>')
    send_command('bind @m gs c toggle MagicBurst')
    send_command('bind ^- gs c scholar light')
    send_command('bind ^= gs c scholar dark')
    send_command('bind ^[ gs c scholar power')
    send_command('bind ^] gs c scholar accuracy')
    send_command('bind ^; gs c scholar speed')
    --send_command('bind !w input /ma "Aspir II" <t>')
    send_command('bind !o input /ma "Regen V" <stpc>')
    send_command('bind ![ gs c scholar aoe')
    send_command('bind !] gs c scholar duration')
    send_command('bind !; gs c scholar cost')
    --send_command('bind @c gs c toggle CP')
    send_command('bind @h gs c cycle HelixMode')
    send_command('bind @r gs c cycle RegenMode')
    send_command('bind @s gs c toggle StormSurge')
    send_command('bind !w gs c toggle WeaponLock')

    send_command('bind ^numpad0 input /Myrkr')
	send_command('lua l Skillchains')


    --include('Global-Binds.lua')

    --select_default_macro_book()
    --set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind ^;')
    send_command('unbind !w')
    send_command('unbind !o')
    send_command('unbind ![')
    send_command('unbind !]')
    send_command('unbind !;')
    send_command('unbind ^,')
    send_command('unbind !.')
    send_command('unbind @c')
    send_command('unbind @h')
    send_command('unbind @g')
    send_command('unbind @s')
    send_command('unbind @w')
    send_command('unbind ^numpad0')

    send_command('unbind #`')
    send_command('unbind #1')
    send_command('unbind #2')
    send_command('unbind #3')
    send_command('unbind #4')
    send_command('unbind #5')
    send_command('unbind #6')
    send_command('unbind #7')
    send_command('unbind #8')
    send_command('unbind #9')
    send_command('unbind #0')

    send_command('lua u gearinfo')
end



-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Tabula Rasa'] = {legs="Peda. Pants +3"}
    sets.precast.JA['Enlightenment'] = {body="Peda. Gown +3"}
    sets.precast.JA['Sublimation'] = {
		main="Musa",
        sub="Khonsu",
		head="Acad. Mortar. +3",
		body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
		hands="Regal Cuffs",
        legs="Acad. Pants +2",
		--feet="Chironic Slippers", --augments={'Pet: Accuracy+18 Pet: Rng. Acc.+18','CHR+5','"Refresh"+2','Accuracy+9 Attack+9',}},
		feet="Skaoi Boots",
		neck="Bathy choker +1",
        --neck="Unmoving Collar +1",
		waist="Embla Sash",
		--left_ear="Savant's Earring",
		right_ear="Etiolation Earring",
		left_ring="Gelatinous Ring +1",
		right_ring="Meridian ring",
        }

    -- Fast cast sets for spells
    sets.precast.FC = {
    --    /RDM --15			--79% w/o Musa
		--main="Musa",	--10
		--sub="Khonsu",
		ammo="Impatiens", --2QC
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}, --10
		body="Merlinic Jubbah", --13
        --hands="Acad. Bracers +3", --9
		hands="Acad. Bracers +2", --7
		legs="Volte brais", --8
		feet={ name="Peda. Loafers +3", augments={'Enhances "Stormsurge" effect',}},  --7
		neck="Baetyl Pendant", --4
		waist="Embla Sash", --5
		left_ear="Malignance Earring", --4
		right_ear="Loquac. Earring", --2
	    left_ring="Weather. Ring", --5/(QM3%)
		right_ring="Kishar ring", --4 
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}}, --10
        
        }

    sets.precast.FC.Grimoire = {head="Peda. M.Board +3", feet="Acad. loafers +2"}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
        ear1="Mendi. Earring", --5
        right_ring="Lebeche Ring", --(QM2%)
		back="Perimede cape", --QM4%
        waist="Witful Belt", --3/(QM3%)
        })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    --sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})
    --sets.precast.Storm = set_combine(sets.precast.FC, {ring2={name="Stikini Ring +1", bag="wardrobe4"},})


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        --back="Relucent Cape",
        waist="Fotia Belt",
        }

    sets.precast.WS['Omniscience'] = set_combine(sets.precast.WS, {
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body="Peda. Gown +3",
        legs="Peda. Pants +3",
        feet="Merlinic Crackows",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Archon Ring",
        back=gear.SCH_MAB_Cape,
        --waist="Sacro Cord",
        })


    sets.precast.WS['Myrkr'] = {
		ammo="Psilomene",
		head="Pixie Hairpin +1",
		body="Acad. Gown +3",
		hands="Kaykaus cuffs +1",
		legs="Kaykaus tights +1",
		feet="Kaykaus boots +1",
		neck="Sanctity Necklace",
		waist="Shinjutsu-no-Obi +1",
		left_ear="Gifted Earring",
		right_ear="Etiolation Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Mephitas's Ring +1",
		back={ name="Fi Follet Cape +1", augments={'Path: A',}},
        } -- Max MP


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = { --Cure Potency/Enmity
        main="Daybreak", --30
		sub="Sors Shield",
		ammo="Impatiens",
		head="Kaykaus Mitra +1", --11%
		body="Kaykaus Bliaut +1", --6%(4%)
		--hands="Peda. Bracers +3", --11%
		hands="Kaykaus Cuffs +1",
		legs="Kaykaus Tights +1", --11%/(-6)
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}, --11
		neck="Incanter's Torque",
		waist="Luminary Sash",
		left_ear="Mendi. Earring", --5
		right_ear="Magnetic Earring", 
		left_ring="Stikini Ring +1",
		right_ring="Lebeche Ring", --3/(--5)(--QM 2%)
		back="Solemnity Cape", --7

        }

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
        --main="Chatoyant Staff", --10
        --sub="Enki strap", 
        waist="Hachirin-no-Obi",
		back="Twilight Cape", --5
        })

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        waist="Luminary Sash",
        })

    sets.midcast.StatusRemoval = {
        hands="Peda. Bracers +3",
        legs="Acad. Pants +2",
        --feet="Vanya Clogs",
        neck="Incanter's Torque",
        --ear2="Meili Earring",
        --left_ring="Haoma's Ring",
        --right_ring="Menelaus's Ring",
        --waist="Bishop's Sash",
        }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        main="Gada",  			--18 skill
        sub="Ammurapi Shield",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}, --20 skill
        --head="Vanya Hood",	--20 skill
        --body="Vanya Robe",	--20 skill
		body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},			--19 skill
		hands={ name="Peda. Bracers +3", augments={'Enh. "Tranquility" and "Equanimity"',}},	--19 skill
        legs="Acad. Pants +2",  --22 skill
        feet="Peda. Loafers +3",--20 skill	
		--feet="Vanya Clogs",	--40 skill +5 cursna
        --feet="Gende. Galosh. +1",			--(+10 cursna)
        neck="Debilis Medallion",--15%
		ear1="Beatific Earring",
        --ear2="Meili Earring",
		left_ring="Haoma's Ring",		--15%
		right_ring="Menelaus's Ring", 	--20%
		--waist="Bishop's Sash",
		back="Oretan. Cape +1",
        })

    sets.midcast['Enhancing Magic'] = {
	    main="Musa",
		sub="Khonsu",
		ammo="Pemphredo tathlum",
		head="Telchine Cap", --augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
		hands="Telchine Gloves", --augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		legs="Telchine Braconi", --augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		feet="Telchine Pigaches", --augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear="Magnetic Earring",
		--right_ear="Andoaa Earring",
		left_ring="Weather. Ring",
		right_ring="Defending Ring",
		back="Fi Follet Cape +1",
        }

    sets.midcast.EnhancingDuration = {
        --main="Musa",
        main="Gada",
		sub="Ammurapi Shield",
		--sub="Khonsu",
		head="Telchine Cap", --augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		--body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
		Body="Telchine Chas.",
		--hands="Arbatel Gloves +3",
		hands="Telchine Gloves", --augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		legs="Telchine Braconi", --augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		feet="Telchine Pigaches", --augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
        waist="Embla Sash", --Argate Stole +2
		left_ear="Mimir Earring",		
        }

	--Telchine body having 10% (augment from dusk slot) plus Regen duration +12 is better than Relic Body +3
    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        --main="Musa",
        main="Gada",
		sub="Khonsu",	
        --head="Arbatel bonnet +3",
		head="Telchine Cap",
		body="Telchine Chas.", --augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		hands="Telchine Gloves", --augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		legs="Telchine Braconi", --augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		feet="Telchine Pigaches", --augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
        back="Bookworm's Cape",
        })

    sets.midcast.RegenDuration = set_combine(sets.midcast.EnhancingDuration, {
		head="Telchine Cap", --augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        })

    sets.midcast.Haste = sets.midcast.EnhancingDuration

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif",
        head="Amalric Coif +1",
		waist="Gishdubar Sash",
        --back="Grapevine Cape",
        })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
		legs="Shedir Seraweels",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
        sub="Ammurapi Shield",
        ammo="Staunch Tathlum +1",
        head="Amalric Coif",
		head="Amalric Coif +1",
		hands="Regal cuffs",
        ear1="Halasz Earring",
        ring2="Freke Ring",
        --waist="Emphatikos Rope",
		legs="Shedir Seraweels",
        })

    sets.midcast.Storm = sets.midcast.EnhancingDuration

    sets.midcast.Stormsurge = set_combine(sets.midcast.Storm, {feet="Peda. Loafers +3"})

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
    main={ name="Contemplator +1", augments={'Path: A',}},
        sub="Khonsu",
        ammo="Pemphredo Tathlum",
		head="Acad. Mortar. +3",
		--head=empty;
        --body="Cohort Cloak +1",
		body="Agwu's robe",
		hands="Kaykaus cuffs +1",
		--legs={ name="Chironic Hose", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Enmity-4','MND+9','Mag. Acc.+11',}},
		legs="Arbatel Pants +3",
		feet="Arbatel Loafers +3",
        neck="Argute Stole +2",
		--waist="Luminary sash",
		waist="Obstin. Sash",
        left_ear="Vor Earring",
		right_ear="Regal Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe2"},
		ring2={name="Stikini Ring +1", bag="wardrobe5"},
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
		--back={ name="Aurist's Cape +1", augments={'Path: A',}},
        }

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		body="Acad. Gown +3",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Enmity-4','MND+9','Mag. Acc.+11',}},
        --back=gear.SCH_MAB_Cape,
        --waist="Acuity Belt +1",
		waist="Obstin. Sash",
        })

    sets.midcast.ElementalEnfeeble = sets.midcast.Enfeebles
    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield"})

    sets.midcast['Dark Magic'] = {
		head="Musa",
		sub="Khonsu",
        ammo="Pemphredo Tathlum",
        head="Acad. Mortar. +3",
        body="Acad. Gown +3",
        --hands="Acad. Bracers +3",
		hands={ name="Agwu's Gages", augments={'Path: A',}},
        legs="Peda. Pants +3",
		feet="Acad. loafers +2",
		neck="Argute Stole +2",
        left_ear="Malignance Earring",
        right_ear="Regal earring",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		ring2={name="Stikini Ring +1", bag="wardrobe5"},
        waist="Acuity Belt +1",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        }

    sets.midcast.Kaustra = {
		main="Bunzi's rod",
		sub="Ammurapi shield",
		ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
		body="Agwu's Robe",
		hands={ name="Agwu's Gages", augments={'Path: A',}},
		legs="Agwu's Slops",
		feet={ name="Agwu's Pigaches", augments={'Path: A',}},
        neck="Argute Stole +2", --7
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Archon Ring",
		ring2="Freke Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        waist="Hachirin-no-Obi",
        }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main="Rubicundity",
        sub="Ammurapi Shield",
        head="Pixie Hairpin +1",
        neck="Erra pendant",
		feet={ name="Agwu's Pigaches", augments={'Path: A',}},
		--ear1="Hirudinea Earring",
        ring1="Archon Ring",
        ring2="Evanescence Ring",
        waist="Fucho-no-obi",
        })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        })

    -- Elemental Magic
    sets.midcast['Elemental Magic'] = {
		main="Bunzi's rod",
		sub="Ammurapi shield",
		ammo="Pemphredo Tathlum",
		head="Agwu's Cap",
		--body="Arbatel gown +3",
		body="Agwu's Robe",
		--hands="Arbatel Bracers +3",
		hands="Agwu's Gages",
		--legs="Arbatel pants +3",
		legs="agwu's Slops",
		--feet="Arbatel Loafers +3",
		feet="Agwu's Pigaches",
		neck="Argute Stole +2",
		waist="Refoccilation Stone",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Freke Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        }

    sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
        --body="Seidr Cotehardie",
        legs="Peda. Pants +3",
        neck="Erra Pendant",
        waist="Acuity Belt +1",
        })

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        })

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
		main="Bunzi's rod",
		sub="Ammurapi shield",
        --head=empty,
        --body="Twilight Cloak",
        ring1="Archon Ring",
        })

    sets.magic_burst = set_combine(sets.midcast['Elemental Magic'], { --10 from Akademos
        head="Agwu's Cap", --(4)
        hands={ name="Agwu's Gages", augments={'Path: A',}}, --8/5
        legs="Agwu's slops", --9
		feet={ name="Agwu's Pigaches", augments={'Path: A',}}, --6
        neck="Argute Stole +2", --10
        ring1="Mujin Band", --(5)
        })
		
    sets.midcast.Helix = {
		main="Bunzi's rod",
		sub="Ammurapi shield",
        ammo="Ghastly tathlum +1",
		--head="Arbatel bonnet +3",
		head="Agwu's Cap",
		--body="Arbatel gown +3",
		body="Agwu's Robe",
		hands={ name="Agwu's Gages", augments={'Path: A',}},
        --legs="Arbatel Pants +3",
		legs="Agwu's Slops",
		feet={ name="Agwu's Pigaches", augments={'Path: A',}},
        neck="Argute Stole +2",
		waist="Acuity belt +1",
        --waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Freke Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        }

    sets.midcast.DarkHelix = set_combine(sets.midcast.Helix, {
        head="Pixie Hairpin +1",
        ring1="Archon Ring",
        })

    sets.midcast.LightHelix = set_combine(sets.midcast.Helix, {
        main="Daybreak",
        sub="Ammurapi Shield",
        left_ring="Weather. Ring"
        })
		
	sets.burst_helix = set_combine(sets.midcast.Helix, { --10 from Akademos
        --head="Peda. M.Board +3", --(4)
		head="Agwu's cap",
		body="Agwu's robe",
        hands={ name="Agwu's Gages", augments={'Path: A',}}, --8/5
        feet={ name="Agwu's Pigaches", augments={'Path: A',}}, --6
        neck="Argute Stole +2", --10
        ring1="Mujin Band", --(5)
        })	


	sets.midcast.Dia = set_combine(sets.midcast.MndEnfeebles, {
		ammo="Per. Lucky Egg",
		hands={ name="Chironic Gloves", augments={'STR+4','INT+7','"Treasure Hunter"+2','Accuracy+3 Attack+3',}},
		waist="Chaac Belt",
})

	sets.midcast['Dia II'] = sets.midcast.Dia
	
    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
		--main="Bolelabunga",
		sub="Genmei Shield",
        ammo="Homiliary",
		--head="Acad. Mortar. +3",
		head="Nyame Helm",
		--body="Arbatel gown +3",
		body="Agwu's Robe",
		hands="Chironic Gloves",
		legs="Volte Brais",
		--feet={ name="Chironic Slippers", augments={'Pet: Accuracy+18 Pet: Rng. Acc.+18','CHR+5','"Refresh"+2','Accuracy+9 Attack+9',}},
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring",
		right_ear="Infused Earring",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back="Solemnity cape",
        }

    sets.idle.refresh = set_combine(sets.idle, {
        main="Daybreak",
        sub="Genmei Shield", --10/0
		head="Befouled crown",
		neck="Sibyl scarf",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		ring2={name="Stikini Ring +1", bag="wardrobe5"},
		feet="Herald's Gaiters"
        })

    sets.idle.DT = set_combine(sets.idle, {
        main="Daybreak",
        sub="Genmei Shield", --10/0
        ammo="Crepuscular pebble", --3/3
		head={ name="Nyame Helm", augments={'Path: B',}}, --7
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},  --7
        legs="Peda. Pants +3",
        --feet="Volte Gaiters",
        neck="Loricate Torque +1", --5/5
        --ear1="Sanare Earring",
        ring1="Gelatinous Ring +1", --6/(-2)
        ring2="Defending Ring", --10/10
        back="Solemnity cape", --4/4
        --waist="Carrier's Sash",
        })

    sets.idle.Vagary = sets.midcast['Elemental Magic']

    sets.idle.Town = set_combine(sets.idle, {
        main="Musa",
        sub="Khonsu",
        head="Peda. M.Board +3",
        --body="Amalric Doublet +1",
        legs="Peda. Pants +3",
        feet="Peda. Loafers +3",
        neck="Argute Stole +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        --back=gear.SCH_MAB_Cape,
        waist="Acuity Belt +1",
        })

    sets.resting = set_combine(sets.idle, {
        main="Chatoyant Staff",
        waist="Shinjutsu-no-Obi +1",
		--waist="Hierarch belt",
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT
    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sanctity Necklace",
		waist="Grunfeld Rope",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring={name="Chirich Ring +1", bag="wardrobe2"},
		right_ring="Cacoethic Ring +1",
		back="Solemnity Cape",
        }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff['Ebullience'] = {head="Arbatel bonnet +3",body="Agwu's robe",ring1="Mujin Band",}
    sets.buff['Rapture'] = {head="Arbatel bonnet +3"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +3"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +3", "Lugh's Cape"}
    --sets.buff['Penury'] = {legs="Arbatel Pants +3"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +3"}
    sets.buff['Celerity'] = {feet="Peda. Loafers +3"}
    sets.buff['Alacrity'] = {feet="Peda. Loafers +3"}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +3"}

    sets.buff.FullSublimation = {
	    main={ name="Musa", augments={'Path: C',}},
		sub="Khonsu",
		ammo="Psilomene",
		head="Acad. Mortar. +3", --5
		body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}}, --5
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Bathy Choker +1",
		waist="Embla Sash", --5
		left_ear="Etiolation Earring",
		--ear1="Savant's Earring", --1		
		right_ear="Tuisto Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Meridian Ring",
		back="Twilight Cape",
       }

    sets.buff.Doom = {
        --neck="Nicander's Necklace", --20
        --ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        --ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }
	sets.buff.Sleep = {main="Prime Staff",}

    sets.LightArts = {legs="Acad. Pants +2", feet="Acad. loafers +2"}
    sets.DarkArts = {body="Acad. Gown +3", feet="Acad. loafers +2"}

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.Bookworm = {back="Bookworm's Cape"}
    --sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Six Step //sixstep
-------------------------------------------------------------------------------------------------------------------
send_command('alias sixstep input /p Beginning Six-Step Skillchain;input /ja "Immanence" <me>;wait 1;input /ma "Stone" <t>;wait 5;input /ja "Immanence" <me>;wait 1;input /ma "Aero" <t>;wait 5;input /ja "Immanence" <me>;wait 1;input /ma "Stone" <t>;wait 5;input /ja "Immanence" <me>;wait 1;input /ma "Aero" <t>;wait 5;input /ja "Immanence" <me>;wait 1;input /ma "Stone" <t>;wait 5;input /ja "Immanence" <me>;wait 1;input /ma "Aero" <t>;wait 5;input /ja "Immanence" <me>;wait 1;input /ma "Stone" <t>;wait 1;input /p Six-Step Skillchain Complete!')

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"])) or
        (spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"])) then
        equip(sets.precast.FC.Grimoire)
    elseif spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if spellMap == "Helix" then
            equip(sets.midcast['Elemental Magic'])
            if spell.english:startswith('Lumino') then
                equip(sets.midcast.LightHelix)
            elseif spell.english:startswith('Nocto') then
                equip(sets.midcast.DarkHelix)
            else
                equip(sets.midcast.Helix)
            end
            if state.HelixMode.value == 'Duration' then
                equip(sets.Bookworm)
            end
        end
        if buffactive['Klimaform'] and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
		
		if spell.element == 'Earth' and spellMap ~= "Helix" then
			equip(sets.buff['Klimaform'])
		end
    end
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
    if spell.skill == 'Enfeebling Magic' then
        if spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"]) then
            --equip(sets.LightArts)
        elseif spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"]) then
            --equip(sets.DarkArts)
        end
    end
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
		if spellMap == "Helix" then
			equip(sets.burst_helix)
		else
			equip(sets.magic_burst)
			
			if state.CastingMode.value == 'Seidr' then
				equip({body="Seidr Cotehardie"})
			end
		end
		--apply grimoire buffs for klimaform and ebullience in existing functions
		apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
		
		if spell.english == "Impact" then
            equip(sets.midcast.Impact)
        end
    end
    if spell.skill == 'Elemental Magic' or spell.english == "Kaustra" then
        if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
            equip(sets.Obi)
        -- Target distance under 1.7 yalms.
        elseif spell.target.distance < (1.7 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Matching day and weather.
        elseif spell.element == world.day_element and spell.element == world.weather_element then
            equip(sets.Obi)
        -- Target distance under 8 yalms.
        elseif spell.target.distance < (8 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Match day or weather.
        elseif spell.element == world.day_element or spell.element == world.weather_element then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
        if spellMap == "Regen" and state.RegenMode.value == 'Duration' then
            equip(sets.midcast.RegenDuration)
        end
        if state.Buff.Perpetuance then
            equip(sets.buff['Perpetuance'])
        end
        if spellMap == "Storm" and state.StormSurge.value then
            equip (sets.midcast.Stormsurge)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" then
            send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
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
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
	elseif buff == "sleep" then
		if gain then
			if buffactive["Stoneskin"] then
				send_command('cancel Stoneskin')
			end
			equip(sets.buff.Sleep)
            --send_command('@input /p Slept.')
             disable('main')
        else
            enable('main')
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

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_rings()
    check_moving()
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    update_active_strategems()
    update_sublimation()
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.buff.FullSublimation)
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)

    local c_msg = state.CastingMode.value

    local h_msg = state.HelixMode.value

    local r_msg = state.RegenMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Helix: ' ..string.char(31,001)..h_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Regen: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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

function buff_change(n, gain, buff_table)
	local name
	name = string.lower(n)
	if S{"silence"}:contains(name) then
		if gain then
			--send_command('@input /item "Echo Drops" <me>')
			send_command('@input /item "Remedy" <me>')
		end
	elseif S{"reraise"}:contains(name) then
		if gain then
		else
			if player.hp ~= 0 then
				add_to_chat(123, 'Reraise: [lost]')
			end
		end
	elseif S{"sublimation: activated"}:contains(name) then
		if gain then
			equip({waist="Embla Sash"})
		else
			if player.mpp <= 45 then
				equip({waist="Fucho-no-Obi"})
			else
				equip({waist="Shinjutsu-no-obi +1"})
			end
		end
	elseif S{"afflatus solace"}:contains(name) then
		if gain then
		else
			if player.hp ~= 0 then
				add_to_chat(123, 'Afflatus Solace: [lost]')
			end
		end
	elseif S{"afflatus misery"}:contains(name) then
		if gain then
		else
			if player.hp ~= 0 then
				add_to_chat(123, 'Afflatus Misery: [lost]')
			end
		end
	elseif S{"sleep"}:contains(name) then
		if gain then
			if buffactive["Stoneskin"] then
				send_command('cancel Stoneskin')
			end
			equip({main="Prime Staff",})
		else
			equip({main="Daybreak"})
		end
	end
end

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end

function refine_various_spells(spell, action, spellMap, eventArgs)
    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if spell.name:startswith('Aspir') then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
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

function check_rings()
    rings = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    if rings:contains(player.equipment.left_ring) then
        disable("left_ring")
    else
        enable("left_ring")
    end

    if rings:contains(player.equipment.right_ring) then
        disable("right_ring")
    else
        enable("right_ring")
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
        if no_swap_gear:contains(player.equipment.waist) then
            enable("waist")
            equip(sets.idle)
        end
    end
)

------------------------------------------
-- Macro and Style Change on Job Change
------------------------------------------
function set_macros(sheet,book)
    if book then
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end
 
function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
    add_to_chat (55, 'You are on '..('Scholar '):color(5)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
end
 
--Page, Book--
set_macros(1,20)
--Use the Lockstyle Number--
set_style(20)  