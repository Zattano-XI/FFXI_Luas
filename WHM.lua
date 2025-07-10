
-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+R ]           Toggle Regen Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Afflatus Solace
--              [ ALT+` ]           Afflatus Misery
--              [ CTRL+[ ]          Divine Seal
--              [ CTRL+] ]          Divine Caress
--              [ CTRL+` ]          Composure
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+; ]           Penury/Parsimony
--
--  Spells:     [ ALT+O ]           Regen IV
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Black Halo
--              [ CTRL+Numpad8 ]    Hexa Strike
--              [ CTRL+Numpad9 ]    Realmrazer
--              [ CTRL+Numpad1 ]    Flash Nova
--              [ CTRL+Numpad0 ]    Mystic Boon
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
--              gs c scholar light          Light Arts/Addendum
--              gs c scholar dark                                       Dark Arts/Addendum
--              gs c scholar cost           Penury                      Parsimony
--              gs c scholar speed          Celerity                    Alacrity
--              gs c scholar aoe            Accession                   Manifestation
--              gs c scholar addendum       Addendum: White             Addendum: Black


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
res = require 'resources'

include('SendCommands.lua')

target_distance = 8

BarElements = S{"Barfira","Barblizzara","Baraera","Barstonra","Barthundra","Barwatera"}
BarStatus = S{"Barsleepra","Barpoisonra","Barparalyzra","Barblindra","Barsilencera","Barpetra","Barvira","Baramnesra"}
NaSpells = S{"Blindna","Erase","Paralyna","Poisona","Silena","Stona","Viruna"}
BoostSpells = S{"Boost-STR","Boost-DEX","Boost-VIT","Boost-AGI","Boost-INT","Boost-MND","Boost-CHR"}
EnfeeblingMND = S{"Paralyze","Slow","Distract","Frazzle","Addle",}
EnfeeblingINT = S{"Blind","Bind","Dispel","Sleep","Sleep II","Sleepga","Poison","Poison II","Poisonga"}

function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false

    state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}

    no_swap_gear = S{""}

 --lockstyle
	    state.AutoLockstyle = M(true, 'AutoLockstyle Mode')
	    send_command('@wait 3; input /lockstyleset 3')

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('DT','Normal', 'Resistant', 'SIRD')
    state.IdleMode:options('DT', 'Normal', 'MEva')
    state.BarElement = M{['description']='BarElement', 'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesra', 'Barvira', 'Barparalyzra', 'Barsilencera', 'Barpetra', 'Barpoisonra', 'Barblindra', 'Barsleepra'}
    state.BoostSpell = M{['description']='BoostSpell', 'Boost-STR', 'Boost-INT', 'Boost-AGI', 'Boost-VIT', 'Boost-DEX', 'Boost-MND', 'Boost-CHR'}
	state.Regen = M{['description']='Regen', 'Regen', 'Regen II', 'Regen III', 'Regen IV'}
	
	BarStatus = S{"Barsleepra","Barpoisonra","Barparalyzra","Barblindra","Barsilencera","Barpetra","Barvira","Baramnesra"}
    
	state.WeaponLock = M(false, 'Weapon Lock')
    -- state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
    --include('Global-Binds.lua') -- OK to remove this line
    --include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('bind ^` input /ja "Afflatus Solace" <me>')
    send_command('bind !` input /ja "Afflatus Misery" <me>')
    send_command('bind ^- gs c scholar light')
    send_command('bind ^= gs c scholar dark')
    send_command('bind !- gs c scholar addendum')
    send_command('bind != gs c scholar addendum')
    send_command('bind ^; gs c scholar speed')
    send_command('bind ![ gs c scholar aoe')
    send_command('bind !; gs c scholar cost')
    send_command('bind ^insert gs c cycleback BoostSpell')
    send_command('bind ^delete gs c cycle BoostSpell')
    send_command('bind ^home gs c cycleback BarElement')
    send_command('bind ^end gs c cycle BarElement')
    send_command('bind ^pageup gs c cycleback BarStatus')
    send_command('bind ^pagedown gs c cycle BarStatus')
    send_command('bind ^[ input /ja "Divine Seal" <me>')
    send_command('bind ^] input /ja "Divine Caress" <me>')
    send_command('bind !o input /ma "Regen IV" <stpc>')

	
    --send_command('bind !c gs c toggle CP')
    send_command('bind !r gs c cycle RegenMode')
    send_command('bind !w gs c toggle WeaponLock')

    send_command('bind ^numpad7 input /ws "Black Halo" <t>')
    send_command('bind ^numpad8 input /ws "Hexa Strike" <t>')
    send_command('bind ^numpad5 input /ws "Realmrazer" <t>')
    send_command('bind ^numpad1 input /ws "Flash Nova" <t>')
    send_command('bind ^numpad0 input /ws "Mystic Boon" <t>')

    select_default_macro_book()

    state.Auto_Kite = M(true, 'Auto_Kite')
    DW = false
    moving = false
    update_combat_form()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^;')
    send_command('unbind ![')
    send_command('unbind !;')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind !o')
    -- send_command('unbind @c')
    send_command('unbind !r')
    send_command('unbind !w')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad1')
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

    send_command('unbind 1')
    send_command('unbind 2')
    send_command('unbind 3')
    send_command('unbind 4')
    send_command('unbind 5')
    send_command('unbind 6')

end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells

    sets.precast.FC = {
    --  /SCH --3
        main="C. Palug Hammer", --7
        --sub="Chanter's Shield", --3
        ammo="Impatiens", --2
        head="Ebers Cap +3", --6 volte beret
        body="Inyanga Jubbah +2", --14
        --hands="Gende. Gages +1", --7
        legs="Ayanmo Cosciales +2", --8
        feet="Regal Pumps +1", --6 
        neck="Clr. Torque +2", --10
        ear1="Loquacious Earring", --2
        ear2="Malignance Earring", --2
        ring1="Lebeche Ring", --4
        ring2="Kishar Ring", --4
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10
        waist="Embla Sash", --5 Witful belt
        }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
        })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ammo="Impatiens", --(2)
        head="Piety Cap +3", --15
		legs="Vanya Slops", --7
        feet="Vanya Clogs", --7
		ear1="Mendi. earring",
		ear2="Malignance earring",
        ring1="Lebeche Ring", 
        ring2="Kishar Ring", --4
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --(4) Perimede
        waist="Shinjutsu-no-Obi +1",
        })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {body="Crepuscular Cloak", waist="Shinjutsu-no-Obi +1"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})

    -- Precast sets to enhance JAs
    --sets.precast.JA.Benediction = {}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        --ammo="Floestone",
        head="Piety Cap +3",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        body="Piety Bliaut +3",
        hands="Piety Mitts +3",
		ring1="Cornelia's Ring",
        ring2="Metamorph Ring +1",
        back={ name="Alaunus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        waist="Fotia Belt",
        legs="Piety Pantaln. +3",
        feet="Piety Duckbills +3",
        }

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
        neck="Rep. Plat. Medal",
        })

    sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {
        head="Blistering Sallet +1",
        ring2="Begrudging Ring",
        })
		
	sets.precast.WS['Mystic Boon'] = set_combine(sets.precast.WS,{
		head="Nyame Helm",
		neck="Clr. Torque +2",
		ear2="Regal Earring",
		body="Nyame Mail",
		Hands="Nyame Gauntlets",
		waist="Grunfeld Rope",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	
    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS, {
        ammo="Pemphredo Tathlum",
        body="Cohort Cloak +1",
        --legs="Kaykaus Tights +1",
        })

    -- Midcast Sets

    sets.midcast.FC = sets.precast.FC

    sets.midcast.ConserveMP = {
        main="Septoptic +1",
        --sub="Thuellaic Ecu +1",
        head="Vanya Hood",
        body="Vedic Coat",
        --hands="Shrieker's Cuffs",
        legs="Vanya Slops",
        feet="Kaykaus Boots",
        ear1="Mendi. Earring",
        back="Solemnity Cape",
        waist="Shinjutsu-no-Obi +1",
        }

    -- Cure sets

    sets.midcast.CureSolace = {
        main="Raetic Rod +1", --23(+10)
        sub="Sors Shield", --3/(-5)
        ammo="Pemphredo Tathlum",
        head="Kaykaus Mitra +1", --11(+2)/(-6)
        body="Ebers Bliaut +3",
        hands="Theophany Mitts +3", --(+4)/(-7)
        legs="Ebers Pant. +3",
        feet="Kaykaus Boots +1", -- 11(+2)/(-12)
        neck="Clr. Torque +2", --10/(-25)
        ear1="Glorious Earring",
        ear2="Ebers Earring +1",
        ring1="Lebeche Ring", --3/(-5)
        ring2="Defending Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --10
        waist="Shinjutsu-no-Obi +1",
      }

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.CureSolace, { 
		head="Bunzi's Hat",
		feet="Bunzi's Sabots",
		})

	sets.midcast.CureSolace.SIRD = set_combine(sets.midcast.CureSolace.DT, { 
		ammo="Staunch Tathlum", --10
		hands={ name="Chironic Gloves", augments={'Spell interruption rate down -10%','INT+7','"Mag.Atk.Bns."+8',}}, --30
		feet="Theo. Duckbills +3", --29
		waist="Rumination Sash", --10
		--left_ear="Nourishing Earring +1", --5
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}}, --10
		})
	--94+10 SIRD from merits
	
	
    sets.midcast.CureSolaceWeather = set_combine(sets.midcast.CureSolace, {
        --ear1="Nourish. Earring +1", --7
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
        })

    sets.midcast.CureNormal = set_combine(sets.midcast.CureSolace, {
        body="Theo. Bliaut +3", --0(+6)/(-6)
        })
		
	sets.midcast.CureNormal.SIRD = set_combine(sets.midcast.CureSolace, {
		ammo="Staunch Tathlum", --10
		hands={ name="Chironic Gloves", augments={'Spell interruption rate down -10%','INT+7','"Mag.Atk.Bns."+8',}}, --30
		feet="Theo. Duckbills +3", --29
		waist="Rumination Sash", --10
		left_ear="Nourishing Earring +1", --5
		left_ring="Defending Ring",
		right_ring="Lebeche Ring", 
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}}, --10
		})
	--94+10 SIRD from merits
	
    sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
        hands="Kaykaus Cuffs +1", --11/(-6)
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
        })

sets.midcast.CureWeather.SIRD = set_combine(sets.midcast.CureWeather, {
        ammo="Staunch Tathlum", --10
		hands={ name="Chironic Gloves", augments={'Spell interruption rate down -10%','INT+7','"Mag.Atk.Bns."+8',}}, --30
		feet="Theo. Duckbills +3", --29
		waist="Rumination Sash", --10
		left_ear="Nourishing Earring +1", --5
		left_ring="Defending Ring",
		right_ring="Lebeche Ring", 
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}}, --10
		})
	--94+10 SIRD from merits

    sets.midcast.CuragaNormal = set_combine(sets.midcast.CureNormal, {
        body="Theo. Bliaut +3", --0(+6)/(-6)
        ring1={name="Stikini Ring +1", bag="wardrobe2"},
        ring2={name="Stikini Ring +1", bag="wardrobe5"},
        waist="Luminary Sash",
        })

	sets.midcast.CuragaNormal.SIRD = set_combine(sets.midcast.CuragaNormal, {
        ammo="Staunch Tathlum", --10
		hands={ name="Chironic Gloves", augments={'Spell interruption rate down -10%','INT+7','"Mag.Atk.Bns."+8',}}, --30
		feet="Theo. Duckbills +3", --29
		waist="Rumination Sash", --10
		left_ear="Nourishing Earring +1", --5
		left_ring="Defending Ring",
		right_ring="Lebeche Ring", 
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}}, --10
		})
	--94+10 SIRD from merits
	
    sets.midcast.CuragaWeather = {
        head="Ebers Cap +3",
		neck="Clr. Torque +2",
        ear1="Glorious Earring",
        ear2="Ebers Earring +1",
		body="Theo. Bliaut +3", --0(+6)/(-6)
        hands="Theophany Mitts +3", --11/(-6)
        ring1={name="Stikini Ring +1", bag="wardrobe2"}, --Janniston
        ring2="Metamor. Ring +1", --Mephitas
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
		legs="Ebers Pantaloons +3",
		feet="Piety Duckbills +3" --Kaykuas +1
        }

	sets.midcast.CuragaWeather.SIRD = set_combine(sets.midcast.CuragaWeather,  { 
		ammo="Staunch Tathlum", --10
		hands={ name="Chironic Gloves", augments={'Spell interruption rate down -10%','INT+7','"Mag.Atk.Bns."+8',}}, --30
		feet="Theo. Duckbills +3", --29
		waist="Rumination Sash", --10
		left_ear="Nourishing Earring +1", --5
		left_ring="Defending Ring",
		right_ring="Lebeche Ring", 
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}}, --10
		})
	--94+10 SIRD from merits

	
    --sets.midcast.CureMelee = sets.midcast.CureSolace

    sets.midcast.StatusRemoval = {
        main="Yagrush",
        sub="Chanter's Shield",
        head="Vanya Hood",
        body="Inyanga Jubbah +2",
        hands="Fanatic Gloves",
        legs="Aya. Cosciales +2",
        feet="Medium's Sabots",
        neck="Orunmila's Torque",
		ear1="Etiolation Earring",
        ear2="Ebers Earring +1",
        ring1="Kishar Ring",
        ring2={name="Stikini Ring +1", bag="wardrobe5"},
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
        waist="Embla Sash",
        }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        main="Yagrush",
        sub="Chanter's Shield",
        body="Ebers Bliaut +3",
        hands="Fanatic Gloves", --15
        legs="Th. Pant. +3", --21
        feet="Vanya Clogs", --5
        --feet="Gende. Galosh. +1", --10
        neck="Debilis Medallion", --15
        ear1="Meili Earring",
        ear2="Ebers Earring +1",
        ring1="Haoma's Ring", --15
        ring2="Menelaus's Ring", --20
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}, --25
        waist="Bishop's Sash",
        })

    sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Clr. Torque +2"})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {
        main="Gada",
        sub="Ammurapi Shield",
        head="Befouled Crown",
        body="Telchine Chasuble",
        hands="Dynasty Mitts",
        legs="Telchine Braconi",
        feet="Theo. Duckbills +3",
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe2"},
        ring2={name="Stikini Ring +1", bag="wardrobe5"},
        back="Fi Follet Cape +1",
        waist="Olympus Sash",
        }

    sets.midcast.EnhancingDuration = {
        main="Gada",
        sub="Ammurapi Shield",
        head="Telchine Cap",
		neck="Incanter's Torque",
		ear1="Mimir Earring",
		ear2="Andoaa Earring",
        body="Telchine Chasuble",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Theo. Duckbills +3",
        waist="Embla Sash",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        head="Inyanga Tiara +2",
        body="Piety Bliaut +3",
		hands="Ebers Mitts +3",
        })

    sets.midcast.RegenDuration = set_combine(sets.midcast.EnhancingDuration, {
        hands="Ebers Mitts +3",
        legs="Th. Pant. +3", --
        feet="Theo. Duckbills +3",
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        waist="Gishdubar Sash",
        back="Grapevine Cape",
        })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        --main="Vadose Rod",
        sub="Ammurapi Shield",
        ammo="Staunch Tathlum",
        hands="Regal Cuffs",
        ear1="Halasz Earring",
        ear2="Magnetic Earring",
        ring1="Freke Ring",
        ring2="Evanescence Ring",
        waist="Emphatikos Rope",
        })

    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {
        feet="Ebers Duckbills +3",
        })

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
        main="Gada", --beneficus
        sub="Ammurapi Shield",
        head="Ebers Cap +3",
        body="Ebers Bliaut +3",
        hands="Ebers Mitts +3",
        legs="Piety Pantaln. +3",
        feet="Ebers Duckbills +3",
        })
	
	sets.midcast.BarStatus = set_combine(sets.midcast['Enhancing Magic'], {
		main="Gada", --beneficus
        sub="Ammurapi Shield",
        head="Telchine Cap",
        neck="Sroda Necklace",
		body="Telchine Chas.",
        hands="Telchine Gloves",
		waist="Embla Sash",
        legs="Telchine Braconi",
        feet="Theo. Duckbills +3",
		})

    sets.midcast.BoostStat = set_combine(sets.midcast['Enhancing Magic'], {
        feet="Ebers Duckbills +3"
        })

    sets.midcast.Protect = set_combine(sets.midcast.ConserveMP, sets.midcast.EnhancingDuration, {
        ring1="Sheltered Ring",
        })

    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast['Divine Magic'] = {
        main="Yagrush",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Theophany Cap +3",
        body="Theo. Bliaut +3",
        hands="Piety Mitts +3",
        legs="Chironic Hose",
        feet="Theo. Duckbills +3",
        neck="Erra Pendant",
        ear1="Digni. Earring",
        ear2="Regal Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe2"},
        ring2={name="Stikini Ring +1", bag="wardrobe5"},
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
        }

    sets.midcast.Banish = set_combine(sets.midcast['Divine Magic'], {
        main="Daybreak",
        sub="Ammurapi Shield",
        head="Cath Palug Crown",
		neck="Baetyl Pendant",
        ear1="Malignance Earring",
		ear2="Regal Earring",
        body="Bunzi's Robe", --Cohort +1
        hands="Fanatic Gloves",
		ring1="Freke Ring", 
        ring2="Metamorph Ring +1",
        waist="Refoccilation Stone", 
        legs="Bunzi's Pants", --Kaykaus Tights +1
        feet="Bunzi's Sabots",
        })

    sets.midcast.Holy = sets.midcast.Banish

	sets.midcast.Dia = set_combine(sets.midcast.MndEnfeebles, {
		ammo="Per. Lucky Egg",
		body="Volte Jupon",
		waist="Chaac Belt",
})

	sets.midcast['Dia II'] = sets.midcast.Dia
	
    sets.midcast['Dark Magic'] = {
        main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body="Theo. Bliaut +3",
        hands="Theophany Mitts +3",
        legs="Chironic Hose",
        feet="Theo. Duckbills +3",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Mani Earring",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        back="Aurist's Cape +1",
        waist="Fucho-no-Obi",
        }

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
        main="Yagrush",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        body="Cohort Cloak +1",
        hands="Regal Cuffs",
        legs="Chironic Hose",
        feet="Theo. Duckbills +3",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Vor Earring",
        ring1="Kishar Ring",
        ring2={name="Stikini Ring +1", bag="wardrobe5"},
        back="Aurist's Cape +1",
        waist="Luminary Sash",
        }

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        waist="Acuity Belt +1",
        })

    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield"})

    sets.midcast.Impact = {
        main="Yagrush",
        sub="Ammurapi Shield",
        body="Crepuscular Cloak",
        hands="Raetic Bangles +1",
        legs="Th. Pant. +3",
        feet="Theo. Duckbills +3",
        ring1="Freke Ring",
        ring2="Archon Ring",
        }

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {
        main="Chatoyant Staff",
        waist="Shinjutsu-no-Obi +1",
        }

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
        main="Daybreak",
        sub="Genmei Shield", --10pdt
        ammo="Homiliary",
        head="Inyanga Tiara +2",
		neck="Sibyl Scarf",
        ear1="Etiolation Earring",
        ear2="Ebers Earring +1", --4
        body="Ebers Bliaut +3",
        hands="Ebers Mitts +3", --11 raetic bangles +1 
        ring1={name="Stikini Ring +1", bag="wardrobe2"},
        ring2={name="Stikini Ring +1", bag="wardrobe5"},
        back="Solemnity Cape", --4
        waist="Carrier's Sash",
        legs="Ebers Pant. +3", --13
        feet="Inyan. Crackows +2",
        } --DT 32+10PDT
		
    sets.idle.DT = set_combine(sets.idle, {
        --ammo="Staunch Tathlum", --3/3
        head="Bunzi's Hat", --7/7
        --neck="Loricate Torque +1", --6/6
        --ear1="Odnowa Earring +1", --3/5		
		feet="Ebers Duckbills +3", --11/11
        --ring1="Gelatinous Ring +1", --7/(-1)
        --ring2="Defending Ring", --10/10
        --back="Moonlight Cape", --6/6
        waist="Carrier's Sash",
        }) 
		--total 62+
		
    sets.idle.MEva = set_combine(sets.idle.DT, {
        main="Daybreak",
        sub="Genmei Shield",
        ammo="Staunch Tathlum",
        head="Bunzi's Hat",
        --hands="Raetic Bangles +1",
        feet="Inyan. Crackows +2",
        neck="Warder's Charm +1",
        ear1="Etiolation Earring",
        ear2="Sanare Earring",
        ring1="Purity Ring",
        ring2={name="Stikini Ring +1", bag="wardrobe5"},
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
        waist="Carrier's Sash",
        })

    sets.idle.Town = set_combine(sets.idle, {
        main="Yagrush",
        })

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
	
    sets.defense.MDT = set_combine(sets.idle.DT, {
		head="Bunzi's Hat",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		legs="Ebers Pant. +3",
		feet="Bunzi's Sabots",
		})

    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {ammo="Amar Cluster",
        main="Yagrush",
        sub="Genmei Shield",
        head="Bunzi's Hat",
        body="Ayanmo Corazza +2",
        hands="Bunzi's Gloves",
        legs="Aya. Cosciales +2",
        feet="Nyame Sollerets",
        neck="Combatant's Torque", --combatant's torque
        ear1="Cessance Earring",
        ear2="Telos	Earring",
        left_ring={name="Chirich Ring +1", bag="wardrobe2"},
        right_ring={name="Chirich Ring +1", bag="wardrobe5"},
        back={ name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        waist="Windbuffet Belt +1",
        }

    sets.engaged.Acc = set_combine(sets.engaged, {
        neck="Combatant's Torque",
		ear1="Mache Earring +1",
		ear2="Telos Earring",
		hands="Gazu Bracelet +1",
		ring1="Cacoethic Ring +1",
		right_ring={name="Chirich Ring +1", bag="wardrobe5"},
        waist="Grunfeld Rope",
        })

    sets.engaged.DW = set_combine(sets.engaged, {ammo="Amar Cluster",
        main="Yagrush",
        sub="C. Palug Hammer",
        ear1="Eabani Earring",
        ear2="Suppanomimi", --5
        })

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
        --sub="Sindri",
        hands="Gazu Bracelet +1",
        })

    sets.engaged.Aftermath = set_combine(sets.engaged, {
        right_ring={name="Chirich Ring +1", bag="wardrobe5"},
        --back={ name="Alaunus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        })

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +3", back="Mending Cape"}
    sets.buff['Devotion'] = {head="Piety Cap +3"}
    sets.buff.Sublimation = {waist="Embla Sash"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }
	
	sets.buff.Sleep = {main="Lorg Mor",}

    sets.Obi = {waist="Hachirin-no-Obi"}
    -- sets.CP = {back="Mecisto. Mantle"}
	
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
	
	sets.smithing = {
		neck="Smithy's Torque",
		body="Blacksmith's Apron",
		hands="Smithy's Mitts",
		ring1="Orvail Ring +1",
		ring2="Confectioner's Ring",
		waist="Blacksmith's Belt",
		}
		
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
    if spellMap == 'Banish' or spellMap == "Holy" then
        if (world.weather_element == 'Light' or world.day_element == 'Light') then
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
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Repose" then
            send_command('@timers c "Repose ['..spell.target.name..']" 90 down spells/00098.png')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
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

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    update_sublimation()
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
--      if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
--          return "CureMelee"
        if default_spell_map == 'Cure' then
            if buffactive['Afflatus Solace'] then
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureSolaceWeather"
                else
                    return "CureSolace"
              end
            else
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureWeather"
                else
                    return "CureNormal"
              end
            end
        elseif default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return "CuragaWeather"
            else
                return "CuragaNormal"
            end
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Yagrush" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end

    return meleeSet
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.Kiting, sets.buff.Sublimation)
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.Kiting, sets.latent_refresh)
    end
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local c_msg = state.CastingMode.value

    local r_msg = state.RegenMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Regen: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'boostspell' then
        send_command('@input /ma '..state.BoostSpell.value..' <me>')
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

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

function status_change(new,old)
	if new == 'Resting' then
		equip(sets.misc.rest)
	elseif new == 'Engaged' and player.target.distance > target_distance or new == 'Idle' then
		enable('main','sub','ammo')
		equip(sets.idle[sets.idle.index[idle_ind]])
	elseif new == 'Engaged' then
		disable('main','sub','ammo')
		equip(sets.TP[sets.TP.index[TP_ind]])
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
			equip({main="Lorg Mor",})
		else
			equip({main="Yagrush"})
		end
	end
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
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
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
            equip(idleSet, sets.Kiting)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(idleSet, sets.Kiting)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 3)
end

	