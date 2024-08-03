-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
	

end


-- Setup vars that are user-independent.
function job_setup()
	get_combat_form()
    include('Mote-TreasureHunter')
    --state.TreasureMode:set('Tag')
	state.TreasureMode:set('None')
    CT = "Cammlan's Torment"
    state.CapacityMode = M(false, 'Capacity Point Mantle')
	
    -- list of weaponskills that make better use of Gavialis helm
    wsList = S{'Stardiver'}--no longer true for stardiver

	send_command('bind ^numpad7 input /ws "Stardiver" <t>')				----Stardiver CTRL + NUMPAD 7
	send_command('bind ^numpad9 input /ws "Camlann\'s Torment" <t>')    ----Camlann's Torment CTRL + NUMPAD 9
	send_command('bind ^numpad4 input /ws "Sonic Thrust" <t>')          ----Sonic Thrust CTRL + NUMPAD 4
	send_command('bind ^numpad6 input /ws "Drakesbane" <t>')            ----Drakesbane CTRL + NUMPAD 6
	send_command('bind !numpad7 input /ws "Leg Sweep" <t>')             ----Leg Sweep ALT + NUMPAD 7
	send_command('bind ^numpad8 input /ws "Diarmuid" <t>')            	----Diarmuid CTRL + NUMPAD 8
	send_command('bind !numpad4 input /ws "Geirskogul" <t>')            ----Geirskogul ALT + NUMPAD 4
	send_command('bind !numpad9 input /ws "Impulse Drive" <t>')         ----Impulse Drive ALT + NUMPAD 9
	send_command('bind @numpad4 input /ws "Savage Blade" <t>')          ----Savage Blade WIN + NUMPAD 4
	send_command('bind !numpad4 input /ws "Judgment" <t>')          	----Judgment ALT + NUMPAD 4
	send_command('bind ^numpad1 input /ws "Cataclysm" <t>')          	----Cataclysm ALT + NUMPAD 6
	






	state.Buff = {}
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}
	
	angon_duration = 90 --with 5/5 merits
	
	breath_delay = 1.2
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	--state.OffenseMode:options('Normal', 'LowHaste', 'Mid', 'Acc','MaxBuff')
	state.OffenseMode:options('Normal', 'Mid', 'Acc','MaxBuff')
	--state.IdleMode:options('Normal', 'Sphere','Regain')
	
	--may add a dedicated wyvern regen idle set at a later date. Normal set currently has +17 wyvern regen, 51pdt, 39 MDT, 23 Wyvern PDT, 20 Wyvern MDT. Relic feet would add an additional 10 wyvern regen. Relic Legs would add an additional 10 Wyvern pdt.
	--Native Wyvern -40% DT
	--May need to set wyvern mode to keep some dt in areas such as dyna when below 90% (when regen equipment kicks in)
	state.IdleMode:options('Regain','Normal')
	
	
	--state.HybridMode:options('Normal', 'PDT', 'Wyvern')
	--state.HybridMode:options('Normal', 'PDT')
	state.HybridMode:options('PDT', 'Normal')
	state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT')
	
	state.SB = M{['description'] = 'Subtle Blow', 'None', 'SB'}--toggle for subtle blow
	state.SC = M{['description'] = 'Skill Chain', 'None', 'SC'}--toggle for skillchain gear
	state.killer = M{['description'] = 'killer', 'Off', 'On'}--toggle for skillchain gear
    state.AttackMode = M{['description'] = 'Attack Mode', 'Normal', 'Capped'}--toggle for attack cap
	
    war_sj = player.sub_job == 'WAR' or false

	select_default_macro_book(9, 16)
    send_command('bind != gs c toggle CapacityMode')
	send_command('bind ^= gs c cycle treasuremode')
	
	send_command('bind ^` gs c cycle SB')--ctrl+` to cycle subtle blow
	send_command('bind !` gs c cycle SC')--alt+` to cycle Skill chain gear
	send_command('bind ^k gs c cycle killer')--ctrl+k to cycle founder's breastplate
	send_command('bind @` gs c cycle AttackMode')--win +` to cycle attack capped or uncapped
	
	
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
	
	
	
	--[[-----------------------------------------------------------
---------------Temporary Binds until XIVHotbar works-------
-----------------------------------------------------------
	send_command('bind ^4 input /ja "Spirit Jump" <t>')	
	send_command('bind ^5 input /ja "Soul Jump" <t>')
	send_command('bind 4 input /ja "Jump" <t>')
	send_command('bind 5 input /ja "High Jump" <t>')
	send_command('bind 6 input /ja "Steady Wing" <me>')
	send_command('bind 7 input /ja "Angon" <t>')
	send_command('bind ^7 input /ja "Restoring Breath" <me>')
	send_command('bind !7 input /ja "Spirit Link" <me>')
	send_command('bind 8 input /ja "Ancient Circle" <me>')
	send_command('bind 9 input /ja "Spirit Bond" <me>')
	send_command('bind ^0 input /ja "Super Jump" <t>')
	send_command('bind ^8 input /ja "Smiting Breath" <t>')

	
	if player.sub_job == 'SAM' then
        send_command('bind !q input /ja "Hasso" <me>')
		send_command('bind !2 input /ja "Sekkanoki" <me>')
		send_command('bind !3 input /ja "Seigan" <me>')
		send_command('bind !5 input /ja "Meditate" <me>')
		send_command('bind !0 input /ja "Third Eye" <me>')
	elseif player.sub_job == 'WAR' then
		send_command('bind !q input /ja "Provoke" <stnpc>')
		send_command('bind !2 input /ja "Aggressor" <me>')
		send_command('bind !3 input /ja "Berserk" <me>')
		send_command('bind !4 input /ja "Defender" <me>')
		send_command('bind !5 input /ja "Warcry" <me>')
	end
	

---------------------------------------------------------------
--------------------------------------------------------------]]




	state.Auto_Kite = M(false, 'Auto_Kite')


end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind ^[')
	send_command('unbind ![')
	send_command('unbind ^=')
	send_command('unbind !=')
	
	send_command('unbind ^numpad7')
	send_command('unbind ^numpad9')
	send_command('unbind ^numpad4')
	send_command('unbind ^numpad6')
	send_command('unbind !numpad7')
	send_command('unbind ^numpad1')
	send_command('unbind !numpad9')
	send_command('unbind @numpad4')
	send_command('unbind !numpad6')
	send_command('unbind ^k')
	
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind @`')
	
	
	--[[send_command('unbind ^4')	
	send_command('unbind ^5')
	send_command('unbind 4')
	send_command('unbind 5')
	send_command('unbind 6')
	send_command('unbind 7')
	send_command('unbind 8')
	send_command('unbind 9')
	send_command('unbind ^0')
	send_command('unbind ^8')
	
	
	send_command('unbind !q')
	send_command('unbind !2')
	send_command('unbind !3')
	send_command('unbind !4')
	send_command('unbind !5')
	send_command('unbind !0')]]
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
    Brigantia = {}
    --Brigantia.TP = { name="Brigantia's Mantle", augments={'STR+30','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}--stopped working when being called for some reason? line below works
	Brigantia.TP = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    Brigantia.WS = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	Brigantia.GS = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	Brigantia.WSD = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	Brigantia.STP = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    -- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands="Pteroslaver Finger Gauntlets +3", ear1="Dragoon's Earring",
	
		--adding enmity gear for arebati
		head="Halitus Helm",
		body="Emet Harness +1",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Warwolf Belt",
		right_ear="Friomisi Earring",
		left_ring="Eihwaz Ring",
		right_ring="Supershear Ring",
		back="Reiki Cloak",
	
	
	}
    sets.CapacityMantle = {back="Mecistopins Mantle"}
    --sets.Berserker = {neck="Berserker's Torque"}
    --sets.WSDayBonus     = {head="Gavialis Helm"}--note that petro +3 wins in uncapped situations. Gavialis no longer wins in any situation

    sets.Organizer = {
    }

	sets.precast.JA.Jump = {
    ammo="Coiste Bodhar",
    head="Flamma Zucchetto +2",
    --body="Vishap Mail +3",
	body="Pteroslaver Mail +3",
    hands="Vis. Fng. Gaunt. +3",
    --legs={ name="Valorous Hose", augments={'Accuracy+24 Attack+24','"Dbl.Atk."+5',}},
	--legs="Pteroslaver Brais +3",
	legs="Ptero. Brais +3",
    feet="Ostro Greaves",
    --neck="Dragoon's Collar +2",
	neck="Vim Torque +1",
    waist="Ioskeha Belt",
    left_ear="Sherida Earring",
	--right_ear="Brutal Earring",
	right_ear = "Telos Earring",
   --[[ left_ring="Petrov Ring",
    right_ring="Niqmaddu Ring",]]
	left_ring="Moonlight Ring",
	right_ring="Defending Ring",
    back=Brigantia.TP
    }

	sets.precast.JA['Ancient Circle'] = { 
		legs="Vishap Brais +3",
		
		
		
		--adding enmity for arebati fight
		ammo="Staunch Tathlum +1",
		head="Halitus Helm",
		body="Emet Harness +1",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Warwolf Belt",
		left_ear="Cryptic Earring",
		right_ear="Friomisi Earring",
		left_ring="Eihwaz Ring",
		right_ring="Supershear Ring",
		back="Reiki Cloak",
		
		}
    sets.TreasureHunter = { 
        --head="White rarab cap +1", 
		legs="Volte Hose",--1
		body={ name="Valorous Mail", augments={'"Conserve MP"+6','"Resist Silence"+4','"Treasure Hunter"+2','Accuracy+11 Attack+11','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},--2
        --waist="Chaac Belt",
		ammo="Perfect Lucky Egg", --1
     }

	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {
        --legs="Vishap Brais +3",
		legs="Pteroslaver Brais +3",
    }) 
	sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {
        --legs="Peltast's Cuissots +3",
		body="Vishap Mail +3",--higher tp return
		hands="Nyame Gauntlets",
		back=Brigantia.STP,
    })
	sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {
        legs="Peltast's Cuissots +3",
        feet="Peltast's Schynbalds +3"
    })
	sets.precast.JA['Super Jump'] = sets.precast.JA.Jump

	sets.precast.JA['Spirit Link'] = set_combine(sets.defense.pdt,{
		head="Vishap armet +3",
		hands="Pel. Vambraces +3",
		feet="Pteroslaver Greaves +3",
    })
	sets.precast.JA['Call Wyvern'] = {body="Pteroslaver Mail +3"}
	sets.precast.JA['Deep Breathing'] = {--head="Wyrm Armet +1" or Petroslaver Armet +1
    }
    sets.precast.JA['Spirit Surge'] = { --body="Wyrm Mail +2"
        body="Pteroslaver Mail +3"
    }
	
	sets.precast.JA['Provoke']={
		ammo="Staunch Tathlum +1",
		head="Halitus Helm",
		body="Emet Harness +1",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Warwolf Belt",
		left_ear="Cryptic Earring",
		right_ear="Friomisi Earring",
		left_ring="Eihwaz Ring",
		right_ring="Supershear Ring",
		back="Reiki Cloak",
	}
	
	
	-- Healing Breath sets
	sets.HB = {
        ammo="Staunch Tathlum +1",
		head="Pteroslaver Armet +3",
		body="Acro Surcoat",
		--hands="Despair Finger Gauntlets",
		hands={ name="Acro Gauntlets", augments={'Pet: Mag. Acc.+25','Pet: Breath+8',}},
		legs="Vishap Brais +3",
		feet="Pteroslaver Greaves +3",
		--neck="Dragoon's Collar +2",
		neck="Loricate Torque +1",
		--waist="Glassblower's Blet",
		waist="Flume Belt",
		left_ear="Anastasi Earring",
		right_ear="Genmei Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back="Updraft Mantle",
    }--some DT options added to this set as it already heals to full HP from critical
	
	--Elemental Breath Set
	sets.EB = {
	
        ammo="Voluspa Tathlum",
		head="Pteroslaver Armet +3",
		--feet="Acro Leggings",
		neck="Adad Amulet",--maybe switch to JSE neck for wyvern DT?
		waist="Incarnation Sash",
		right_ear="Odnowa Earring +1",
		--right_ear="Genmei Earring",
		left_ear="Handler's Earring +1",
		left_ring="Moonlight Ring",
		--left_ring="Cath Palug Ring",--Need to farm
		right_ring="Defending Ring",
		back="Updraft Mantle",
	
		--body="Acro Surcoat",
		--hands={ name="Acro Gauntlets", augments={'Pet: Mag. Acc.+25','Pet: Breath+8',}},
		--legs="Acro Breeches",	
		
		--Swaps for MACC and defense. Lose breath augments, but much more dt
		--body="Gleti's Cuirass",
		body="Peltast's Plackart +3",--food effects, more def/master meva
		--body="Nyame Mail",
		hands="Gleti's Gauntlets",
		--hands="Peltast's Vambraces +3",
		legs="Peltast's Cuissots +3",
		feet="Peltast's Schynbalds +3",
		
    }
	
	--Subtle Blow set to be combined with melee sets and ws sets
	sets.SB = {
		--SB I
		legs="Gleti's Breeches", -- I - 13 at R25
		ring1="Chirich Ring +1", -- I - 10
		ear2="Dignitary's Earring", -- I - 5
		neck="Bathy Choker +1", --I - 11
		--feet="Volte Spats", --I - 6 (too glassy)
		--39 SB I
		
		------------------- SB II -------------------------
		--ring2="Niqmaddu Ring", -- II - 5
		ear1="Sherida Earring", -- II - 5
		body="Dagon Breastplate", -- II - 10		
		--20 SB II
		
		--may need to use defending ring instead of niq for survival purposes
		ring2="Defending Ring",
	}--Total SB = 59
	
	sets.SB_Auspice = {
		------------------ SB I -------------------------
		--Auspice = 29 SB I
		legs="Gleti's Breeches", -- I - 13 at R25
		ring1="Chirich Ring +1", -- I - 10
		
		------------------- SB II -------------------------
		--ring2="Niqmaddu Ring", -- II - 5
		ear1="Sherida Earring", -- II - 5
		body="Dagon Breastplate", -- II - 10
		
		--may need to use defending ring instead of niq for survival purposes
		ring2="Defending Ring",
		
	}--Total SB = 70
	
	
	sets.SC = {
	
		--Nyame pieces allow for48% total bonus, but are a major hit to ws damage. Likely best to get +20 from only sacrificing neck and ring slots
		
		--head="Nyame Helm", --5
		--body="Nyame Mail",--Path B --7
		--hands="Nyame Gauntlets", --5
		--legs={ name="Nyame Flanchard", augments={'Path: A',}}, --6
		--feet="Nyame Sollerets", --5
		neck="Warder's Charm +1", -- 15 
		right_ring="Mujin Band", -- 5
	}
	

    sets.MadrigalBonus = {hands="Composer's Mitts"}
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
		ammo="Sapience Orb",
		head="Carmine Mask",
		--body="Sulevia's Plate. +2",
		body="Nyame Mail",
		hands="Leyline Gloves",
		legs="Limbo Trousers",
		feet="Carmine Greaves",
		neck="Orunmila's Torque",
		waist="Flume Belt",
		left_ear="Ethereal Earring",
		right_ear="Etiolation Earring",
		--left_ring="Lebeche Ring",
		left_ring="Prolix Ring",
		right_ring="Rahab Ring",
		back=Brigantia.TP,
    }
    
	-- Midcast Sets
	sets.midcast.FastRecast = {
    }	
		
	sets.midcast.Breath = set_combine(sets.midcast.FastRecast, { head="Vishap armet +3" })
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
        ammo="Knobkierrie",
		head="Peltast's Mezail +3",
		--head={ name="Valorous Mask", augments={'MND+10','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Weapon skill damage +9%','Accuracy+13 Attack+13','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		--body={ name="Valorous Mail", augments={'Pet: Attack+3 Pet: Rng.Atk.+3','Weapon skill damage +10%','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
		body="Nyame Mail",--Path B
        neck="Dragoon's Collar +2",
        ear2="Moonshade Earring",
        ear1="Thrud Earring",
		--body="Sulevia's Platemail +2",
		hands="Pteroslaver Finger Gauntlets +3",
        ring2="Niqmaddu Ring",
        ring1="Regal Ring",
		back=Brigantia.WS,
        waist="Sailfi Belt +1",
        --legs="Vishap Brais +3",
		legs="Nyame Flanchard",--Path B
        --feet="Sulevia's Leggings +2",
		feet="Nyame Sollerets",--Path B
    }
	sets.precast.WS.Mid = set_combine(sets.precast.WS,{
	
	})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		--neck="Shulmanu Collar",
		waist="Ioskeha Belt"
    })
	

	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
		ear1="Sherida Earring",
        waist="Fotia Belt",
		ammo="Coiste Bodhar",
		head="Peltast's Mezail +3",--high on attack, polearm skill, and wsd. No multi attack unlike ptero head
		neck="fotia gorget",
		hands="Pel. Vambraces +3",
		body="Gleti's Cuirass",--Nyame technically better when underbuffed, but this allows for situations when just over attack cap 
		ring1="Sroda Ring",
		legs="Nyame Flanchard",--Path B
		feet="Nyame Sollerets",--Path B
	})

	
	sets.precast.WS['Stardiver'].Mid = set_combine(sets.precast.WS['Stardiver'], {
		ammo="Voluspa Tathlum",
    })
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'].Mid, {
		legs="Vishap Brais +3",
		--feet="Vishap Greaves +3",
		--body="Vishap Mail +3", --offensive stats aren't great. Replace once I have regal ring
	})

	
	sets.StardiverCapped = set_combine(sets.precast.WS, {
        head="Flamma Zucchetto +2",--multiattack from flamma beats PDL (Python program has Peltast winning)
		--hands={ name="Valorous Mitts", augments={'Pet: STR+6','Attack+2','Quadruple Attack +3','Accuracy+16 Attack+16',}},
		hands="Gleti's Gauntlets",
		--body="Sulevia's Platemail +2",
		--body="Hjarrandi Breastplate",
		body="Gleti's Cuirass",
		neck="Dragoon's Collar +2",
		ear1="Sherida Earring",--to be replaced with sortie earring
		--feet="Gleti's Boots",--Assuming that double attack can only proc on the first 2 hits of stardiver, this is better than flamma. Flamma pulls ahead if DA can proc on all hits 
		feet="Flamma Gambieras +2",
		--hands="Sulevia's Gauntlets +2",
		--legs="Sulevia's Cuisses +2",
		--legs={ name="Valorous Hose", augments={'Attack+25','"Dbl.Atk."+2','STR+14',}},
		legs="Gleti's Breeches",
		--legs={ name="Valorous Hose", augments={'Accuracy+24	 Attack+24','"Dbl.Atk."+5',}},
        waist="Fotia Belt",
		--ammo="Coiste Bodhar",
		ammo="Crepuscular Pebble",
    })



	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
		--[[--	head="Stinger Helm +1",
		body={ name="Valorous Mail", augments={'Pet: Attack+3 Pet: Rng.Atk.+3','Weapon skill damage +10%','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
		--considering an uncapped set for gleti's with crit rate
		--body="Hjarrandi Breastplate",
		back=Brigantia.WSD,]]
		
		
		--Updating set after re-running the numbers. When uncapped, str has a much larger impact than wsd
		
		head="Peltast's Mezail +3",
		neck="Dragoon's Collar +2",
		--ear1="Sherida Earring",--consider swapping to thrud?
		ear1="Thrud Earring",
		--ear1="Thrud Earring",--guide lists sherida? Spreadsheet has sherida coming ahead
		ear2="Moonshade Earring",
		--body="Gleti's Cuirass",--this assumes some level of buffs such as chaos roll and minuets. Nyame pulls ahead otherwise
		body="Nyame Mail",--Path B
		--hands="Pteroslaver Finger Gauntlets +3",
		hands="Nyame Gauntlets",
		--legs="Vishap Brais +3",
		legs="Peltast's Cuissots +3",
		feet="Nyame Sollerets",
        ring2="Niqmaddu Ring",
        ring1="Regal Ring",
		back=Brigantia.WSD,
		waist="Sailfi Belt +1",
		
		
    })
	sets.precast.WS['Impulse Drive'].Mid = set_combine(sets.precast.WS['Impulse Drive'], {
		head="Peltast's Mezail +3",
		feet="Pteroslaver Greaves +3",
		ammo="Voluspa Tathlum",
    })
	sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'].Mid, {
		legs="Vishap Brais +3",
		feet="Vishap Greaves +3",
		--body="Vishap Mail +3", --offensive stats aren't great. Replace once I have regal ring
	})

	sets.ImpulseCapped = set_combine(sets.precast.WS['Impulse Drive'], {
		--head="Gleti's Mask",
		--hands="Gleti's Gauntlets",--removing some pdl gear for reaching pdif cap more realistically without geo
		--legs="Gleti's Breeches",
		hands="Gleti's Gauntlets",
		--feet="Gleti's Boots",
		legs="Gleti's Breeches",
		
		
		right_ring="Defending Ring",--for xevi
		
	})

	sets.Impulse_No_Crit = set_combine(sets.precast.WS,{
	
	})


	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, {
		--ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		--body={ name="Valorous Mail", augments={'Pet: Attack+3 Pet: Rng.Atk.+3','Weapon skill damage +10%','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
		--hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		--legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		--feet={ name="Founder's Greaves", augments={'VIT+10','Accuracy+15','"Mag.Atk.Bns."+15','Mag. Evasion+15',}},
		--neck="Deviant Necklace",
		neck="Fotia Gorget",
		--waist="Eschan Stone",
		--waist="Anrin Obi",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		--left_ring="Arvina Ringlet +1",
		left_ring="Epaminondas's Ring",
		right_ring="Archon Ring",
		back=Brigantia.WSD,
		
		
		

		--head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		
		
		
		
		
		
    })
	sets.precast.WS['Cataclysm'].Mid = set_combine(sets.precast.WS['Cataclysm'], {
    })
	sets.precast.WS['Cataclysm'].Acc = set_combine(sets.precast.WS.Acc['Cataclysm'],{})





	sets.precast.WS["Leg Sweep"] = set_combine(sets.precast.WS, {
        ammo="Pemphredo Tathlum",
		--[[head="Flamma Zucchetto +2",
		body="Flamma Korazin +2",
		legs="Pteroslaver Brais +3",
		feet="Flamma Gambieras +2",]]
        ear1="Crepuscular Earring",
		ear2="Dignitary's Earring",
		back=Brigantia.GS,
		ring1="Flamma Ring",
		ring2="Crepuscular Ring",
        waist="fotia belt",
		
		
		head="Nyame Helm",
		--body="Nyame Mail",
		body="Peltast's Plackart +3",
		legs="Pelt. Cuissots +3",
		feet="Nyame Sollerets",
		hands="Nyame Gauntlets",
    })
	sets.precast.WS["Leg Sweep"].Mid = set_combine(sets.precast.WS["Leg Sweep"], {
    })
	sets.precast.WS["Leg Sweep"].Acc = set_combine(sets.precast.WS["Leg Sweep"].Mid, {})

	

	sets.precast.WS["Shell Crusher"] = set_combine(sets.precast.WS["Leg Sweep"], {})
	sets.precast.WS["Shell Crusher"].Mid = set_combine(sets.precast.WS["Leg Sweep"], {})
	sets.precast.WS["Shell Crusher"].Acc = set_combine(sets.precast.WS["Leg Sweep"].Mid, {})



	sets.precast.WS["Geirskogul"] = set_combine(sets.precast.WS, {
        --ammo="Voluspa Tathlum",
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		back=Brigantia.GS,
        waist="Fotia Belt",
    })
	sets.precast.WS["Geirskogul"].Mid = set_combine(sets.precast.WS["Geirskogul"], {
    })
	sets.precast.WS["Geirskogul"].Acc = set_combine(sets.precast.WS["Geirskogul"].Mid, {})



    sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
		ear1="Ishvara Earring",--maybe this should be Thrud and ear2 moonshade?
		ear2="Thrud Earring",
        waist="Fotia Belt",
		back=Brigantia.WSD,
    })
	sets.precast.WS["Camlann's Torment"].Mid = set_combine(sets.precast.WS["Camlann's Torment"], {
    })
	sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"].Mid, {})

	sets.CamlannsCapped = set_combine(sets.precast.WS["Camlann's Torment"],{
		neck="Dragoon's Collar +2",
		ring1="Epaminondas's Ring",
		
		ear1="Moonshade Earring",
		--will need to test gleti's over wsd options
		--head="Gleti's Mask",
		legs="Gleti's Breeches",
		body="Gleti's Cuirass",
		
	})
	
	sets.Camlanns3k = set_combine(sets.CamlannsCapped,{
		ear1="Ishvara Earring",
	})


	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
        --head="Stinger Helm +1",
		ammo="Coiste Bodhar",
		--head="Blistering Sallet +1",
		head="Gleti's Mask",
		--body="Pteroslaver Mail +3",
		--body="Hjarrandi Breastplate",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		ring1="Regal Ring",
		ring2="Niqmaddu Ring",
		ear2="Sherida Earring",
		ear1="Sroda Earring",--assuming that wyvern is alive. May add logic for this later... may not be worth it over empy earring and thrud
        legs="Peltast's Cuissots +3",
		--legs="Gleti's Breeches",
		--feet={ name="Valorous Greaves", augments={'Attack+18','Crit. hit damage +3%','STR+12','Accuracy+9',}},
		--feet={ name="Valorous Greaves", augments={'STR+9','"Dbl.Atk."+3','Crit.hit rate+2','Accuracy+18 Attack+18',}},
		feet="Gleti's Boots",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}},
    })
	sets.precast.WS['Drakesbane'].Mid = set_combine(sets.precast.WS['Drakesbane'], {
		--back=Brigantia.WS,
    })
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'].Mid, {
		--waist="Anguinus Belt"
	})

	
	
	sets.DrakesbaneCapped = set_combine(sets.precast.WS, {
        --head="Stinger Helm +1",
		--head="Blistering Sallet +1",
		head="Gleti's Mask",
		--body="Pteroslaver Mail +3",
		--body="Hjarrandi Breastplate",
		--hands="Flamma Manopolas +2",
		ring1="Regal Ring",
		ring2="Niqmaddu Ring",
		ear2="Sherida Earring",
        legs="Peltast's Cuissots +3",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		--legs="Gleti's Breeches",
		feet="Gleti's Boots",
		ammo="Crepuscular Pebble",
		--feet={ name="Valorous Greaves", augments={'Attack+18','Crit. hit damage +3%','STR+12','Accuracy+9',}},
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}},
    })
	
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {	
		--head={ name="Valorous Mask", augments={'MND+10','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Weapon skill damage +9%','Accuracy+13 Attack+13','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		back=Brigantia.WSD,
		--body="Founder's Breastplate",--add in for bumba
		ring1="Cornelia's Ring",
		ring2="Epaminondas's Ring",
	})
	sets.precast.WS['Savage Blade'].Mid = set_combine(sets.precast.WS['Savage Blade'], {
    })
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'].Mid, {
    })
	sets.SavageCapped = set_combine(sets.precast.WS['Savage Blade'],{
		body="Gleti's Cuirass",
		--head={ name="Valorous Mask", augments={'MND+10','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Weapon skill damage +9%','Accuracy+13 Attack+13','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		neck="Dragoon's Collar +2",
		--head="Gleti's Mask",
		feet="Gleti's Boots",--unsure on this. Just eyeballing vs trading relic gloves for more pdl
		ring2="Sroda Ring",
	})
	
	sets.precast.WS['Judgment'] = set_combine(sets.precast.WS['Savage Blade'], {
    })
	sets.precast.WS['Judgment'].Mid = set_combine(sets.precast.WS['Savage Blade'].Mid, {
    })
	sets.precast.WS['Judgment'].Acc = set_combine(sets.precast.WS['Savage Blade'].Acc, {
    })
	
	--[[sets.precast.WS['Diarmuid'] = set_combine(sets.precast.WS['Stardiver'], {
		ring1="Cornelia's Ring",
		neck="Dgn. Collar +2",
		waist="Sailfi Belt +1",
		hands="Nyame Gauntlets",
    })]]
	
	--Additional set for testing pure wsd set vs multi attack set
	sets.precast.WS['Diarmuid'] = set_combine(sets.precast.WS['Savage Blade'], {
		ring2="Sroda Ring",
    })
	
	sets.precast.WS['Diarmuid'].Mid = set_combine(sets.precast.WS['Savage Blade'].Mid, {
    })
	sets.precast.WS['Diarmuid'].Acc = set_combine(sets.precast.WS['Savage Blade'].Acc, {
    })
	sets.DiarmuidCapped = set_combine(sets.SavageCapped,{

	})
	
	
	sets.killer = {
		body = "Founder's Breastplate",
	}

	
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = set_combine(sets.idle,{
    })
	

	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum +1",
		--head="Hjarrandi Helm",
		head="Gleti's Mask",
		body="Vishap Mail +3",
		--hands="Sulev. Gauntlets +2",
		hands="Gleti's Gauntlets",
		--legs="Carmine Cuisses +1",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Dgn. Collar +2",
		waist="Flume Belt",
		left_ear="Anastasi Earring",
		--right_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		--left_ring="Moonlight Ring",
		ring1="Shneddick Ring +1",
		right_ring="Defending Ring",
		back=Brigantia.TP,
    }

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = set_combine(sets.idle, {--[[body="Councilor's Garb"]]})
		
	sets.idle.Field = set_combine(sets.idle, {

    })
    sets.idle.Sphere = set_combine(sets.idle, {})

    sets.idle.Regen = set_combine(sets.idle.Field, {
		neck="Bathy Choker +1",
		ear1="infused earring",
		--ear2="infused earring",
    })

	sets.idle.Weak = set_combine(sets.idle.Field, {
    })
	
	--sets.idle.Regain=set_combine(sets.idle, {
	sets.idle.Regain=set_combine(sets.idle,{
		--ring1="Epaminondas's Ring",
		head={ name="Valorous Mask", augments={'MND+10','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Weapon skill damage +9%','Accuracy+13 Attack+13','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		feet="Gleti's Boots",
		legs="Gleti's Breeches",
		--legs="Carmine Cuisses +1",
		--body="Hjarrandi Breastplate",--Extra DT to replace Odin Head
	})
	
	-- Defense sets
	sets.defense.PDT = {
		--[[ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		--body="Sulevia's Plate. +2",
		body="Hjarrandi Breastplate",
		hands="Nyame Gauntlets",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Flam. Gambieras +2",
		neck="Dgn. Collar +2",
		waist="Sailfi Belt +1",--Should probably get tempest fugit for this set
		right_ear="Sherida Earring",
		left_ear="Brutal Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},]]
		
		
		--Oh shit
		    ammo="Staunch Tathlum +1",
			head={ name="Nyame Helm", augments={'Path: A',}},
			body="Adamantite Armor",
			hands={ name="Nyame Gauntlets", augments={'Path: B',}},
			legs={ name="Nyame Flanchard", augments={'Path: B',}},
			feet={ name="Nyame Sollerets", augments={'Path: B',}},
			neck={ name="Warder's Charm +1", augments={'Path: A',}},
			waist="Plat. Mog. Belt",
			left_ear="Eabani Earring",
			right_ear="Tuisto Earring",
			left_ring="Shadow Ring",
			right_ring="Archon Ring",
			back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		
    }

	sets.defense.Reraise = set_combine(sets.defense.PDT, {
	--sets.defense.Reraise = {
		body="Crepuscular Mail",
		head="Twilight Helm",
    })

	sets.defense.MDT = set_combine(sets.defense.PDT, {
		--body="Tartarus Platemail",
		--body="Gleti's Cuirass",
		--legs="Volte Hose",
		--head="Gleti's Mask",
		--legs="Gleti's Breeches",
		--hands="Nyame Gauntlets",
		--feet="Volte Spats",
		waist="Sailfi Belt +1",
		ammo="Staunch Tathlum +1",
		
		head="Nyame Helm", --5
		body="Nyame Mail",--Path B --7
		hands="Nyame Gauntlets", --5
		legs="Ptero. Brais +3",
		feet="Nyame Sollerets", --5
    })

	sets.Kiting = {
		legs="Carmine Cuisses +1",
		right_ring="Defending Ring",
    }

	sets.PhalanxReceived={
			head={ name="Taeon Chapeau", augments={'Accuracy+17 Attack+17','"Triple Atk."+2','Phalanx +3',}},
			body={ name="Taeon Tabard", augments={'Spell interruption rate down -10%','Phalanx +3',}},
			hands={ name="Taeon Gloves", augments={'Accuracy+13','Spell interruption rate down -8%','Phalanx +3',}},
			--legs={ name="Taeon Tights", augments={'Accuracy+21','Spell interruption rate down -7%','Phalanx +3',}},
			legs={ name="Valorous Hose", augments={'STR+4','Pet: "Store TP"+7','Phalanx +4','Accuracy+20 Attack+20','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
			feet={ name="Taeon Boots", augments={'Accuracy+25','Spell interruption rate down -10%','Phalanx +3',}},
	}
	
	
--temp placeholder for mixed pdt set 
	sets.Reraise = {
	
	}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions arelegs={ name="Valorous Hose", augments={'Accuracy+24 Attack+24','"Dbl.Atk."+5',}},n't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
		---------------------------------Gungnir--------------------------------
		--[[ammo="Coiste Bodhar",
		neck="Vim Torque +1",
		--head="Flamma Zucchetto +2",    --Required when magic haste is not capped (i.e. only haste II)
		head="Hjarrandi Helm",         --Can use when magic haste is capped
		--body="Pelt. Plackart +3",
		body="Flamma Korazin +2",
		hands="Sulev. Gauntlets +2",
		legs={ name="Valorous Hose", augments={'Accuracy+24 Attack+24','"Dbl.Atk."+5',}},
		feet="Flam. Gambieras +2",
		--neck="Ganesha's Mala",
		--waist="Ioskeha Belt",
		waist="Sailfi Belt +1",
		right_ear="Sherida Earring",
		left_ear="Brutal Earring",
		left_ring="Petrov Ring",
		right_ring="Flamma Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
		]]--
		
		------------------------------Trishula--------------------------------
		--weapon="Trishula",
		--Sub="Utu Grip",
		ammo="Coiste Bodhar",
		--head="Hjarrandi Helm",
		head="Flamma Zucchetto +2",
		--body="Hjarrandi Breastplate",
		body="Gleti's Cuirass",--beats hjarrandi at 25
		hands="Nyame Gauntlets",
		--legs={ name="Valorous Hose", augments={'Accuracy+24 Attack+24','"Dbl.Atk."+5',}},
		--legs={ name="Valorous Hose", augments={'"Mag.Atk.Bns."+8','"Store TP"+5','Quadruple Attack +2','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		--legs="Pteroslaver Brais +3",--decent stats and wyvern survivability
		--legs="Ptero. Brais +3",
		legs="Gleti's Breeches",
		feet="Flam. Gambieras +2",
		neck="Vim Torque +1",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		ear2="Dedition Earring",--swap to sroda if wyvern alive
		ear1="Sherida Earring",
		ring2="Niqmaddu Ring",
		ring1="Petrov Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		
		
    }
	
	sets.engaged.LowHaste = set_combine(sets.engaged, {
		--head="Flamma Zucchetto +2",
		--body={ name="Valorous Mail", augments={'MND+4','Pet: "Dbl. Atk."+1','"Store TP"+8','Accuracy+19 Attack+19',}},
		--waist="Ioskeha Belt",
    })
	

	sets.engaged.Mid = set_combine(sets.engaged, {
		legs="Pteroslaver Brais +3",
		--head="Flamma Zucchetto +2",
		--legs={ name="Valorous Hose", augments={'Accuracy+24 Attack+24','"Dbl.Atk."+5',}},
		waist="Ioskeha Belt",
		--ring1="Flamma Ring",
		--hands="Flamma Manopolas +2",
		--neck="Shulmanu Collar",
		ring1="Chirich Ring +1",
		ear2="Cessance Earring",
		body="Nyame Mail",
		legs="Ptero. Brais +3",
    })

	sets.engaged.Acc = set_combine(sets.engaged.Mid, {
		ammo="Voluspa Tathlum",
		body="Vishap Mail +3",
        legs="Vishap Brais +3",
		--hands="Vishap Finger Gauntlets +3",
		hands="Nyame Gauntlets",
		--hands="Flamma Manopolas +2",
		--head="Vishap armet +3",
		ear2="Telos Earring",
		head="Flamma Zucchetto +2",
		--feet="Vishap Greaves +3",
		feet="Nyame Sollerets",
		ring1="Chirich Ring +1",
		ring2="Regal Ring",
		neck="Shulmanu Collar",
		--waist="Olseni Belt",
    })
	
	
	sets.engaged.MaxBuff = set_combine(sets.engaged, {
		--neck="Dragoon's Collar +2",
		ammo="Coiste Bodhar",
		--ear1="Sherida Earring",
		--body={ name="Valorous Mail", augments={'MND+4','Pet: "Dbl. Atk."+1','"Store TP"+8','Accuracy+19 Attack+19',}},
		body="Gleti's Cuirass",
		--hands="Sulevia's Gauntlets +2",
		--legs="Nyame Flanchard",
		--legs="Gleti's Breeches",--solid option at rank 30

	})

    sets.engaged.PDT = set_combine(sets.engaged, {
		--ammo="Coiste Bodhar",
		--head="Hjarrandi Helm",
		--waist="Sailfi Belt +1",
		--left_ear="Sherida Earring",
		--right_ear="Brutal Earring",
		
		--right_ring="Defending Ring",
		--back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		
		
		
		--left_ring="Moonlight Ring",--commenting out for xevi only
		right_ring="Defending Ring",
		head="Nyame Helm",
		legs="Ptero. Brais +3",--maintaining pet dt
		hands="Gleti's Gauntlets",
		--feet="Nyame Sollerets",
		--feet="Flam. Gambieras +2",
		body="Gleti's Cuirass",
		neck="Dgn. Collar +2",--maintaining pet dt
		
		
		--changes for xevi only
		left_ring="Shadow Ring",
		right_ear="Odnowa Earring +1",
		feet="Nyame Sollerets",
		
		
		
		
		
		
		
		
		
		
    })
	
	--not really required anymore
	sets.engaged.Wyvern = set_combine(sets.engaged.PDT, {
		legs="Pteroslaver Brais +3",
		--hands = "Ptero. Fin. G. +3",
		hands="Gleti's Gauntlets",
		--ring2="Defending Ring",
	})
	
	
	
	
	sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
		--ammo="Coiste Bodhar",
		--head="Hjarrandi Helm",
		head="Nyame Helm",
		--body="Sulevia's Plate. +2",
		--body="Hjarrandi Breastplate",
		--hands="Sulev. Gauntlets +2",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		--feet="Flam. Gambieras +2",
		neck="Dgn. Collar +2",
		--waist="Sailfi Belt +1",
		--left_ear="Sherida Earring",
		--right_ear="Brutal Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		--back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    })
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
		--ammo="Coiste Bodhar",
		--head="Hjarrandi Helm",
		head="Nyame Helm",
		--body="Sulevia's Plate. +2",
		--body="Hjarrandi Breastplate",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		geet="Nyame Sollerets",
		--feet="Flam. Gambieras +2",
		neck="Dgn. Collar +2",
		--waist="Sailfi Belt +1",
		--left_ear="Sherida Earring",
		--right_ear="Brutal Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		--back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    })

    sets.engaged.War = set_combine(sets.engaged, {
    })
    sets.engaged.War.Mid = set_combine(sets.engaged.Mid, {
    })


--Aftermath-----
----------------------------------------------------------------------------------
--                      Rhongomiant                                             --
----------------------------------------------------------------------------------
sets.engaged.Aftermath_Rhongo = {
		ammo="Coiste Bodhar",
		--head="Hjarrandi Helm",--Flamma Head for /war
		--head="Flamma Zucchetto +2",
		head="Nyame Helm",
		--body="Hjarrandi Breastplate",
		--hands="Sulevia's Gauntlets +2",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		--hands={ name="Valorous Mitts", augments={'Pet: STR+6','Attack+2','Quadruple Attack +3','Accuracy+16 Attack+16',}},
		--legs="Gleti's Breeches",
		--legs={ name="Valorous Hose", augments={'Accuracy+24 Attack+24','"Dbl.Atk."+5',}},
		--legs={ name="Valorous Hose", augments={'"Mag.Atk.Bns."+8','"Store TP"+5','Quadruple Attack +2','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		legs="Gleti's Breeches",
		feet="Flam. Gambieras +2",
		--neck="Vim Torque +1",
		neck="Vim Torque +1",
		--neck="Ganesha's Mala",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		ear2="Brutal Earring",
		ear1="Sherida Earring",
		ring2="Niqmaddu Ring",
		ring1="Petrov Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}


sets.engaged.Aftermath_Rhongo_capped = {
		ammo="Coiste Bodhar",
		--head="Hjarrandi Helm",--Flamma Head for /war
		head="Flamma Zucchetto +2",
		--body="Hjarrandi Breastplate",
		--hands="Sulevia's Gauntlets +2",
		body="Gleti's Cuirass",
		--hands="Gleti's Gauntlets",
		hands={ name="Valorous Mitts", augments={'Pet: STR+6','Attack+2','Quadruple Attack +3','Accuracy+16 Attack+16',}},
		--legs="Gleti's Breeches",
		--legs={ name="Valorous Hose", augments={'Accuracy+24 Attack+24','"Dbl.Atk."+5',}},
		--legs={ name="Valorous Hose", augments={'"Mag.Atk.Bns."+8','"Store TP"+5','Quadruple Attack +2','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		legs="Gleti's Breeches",
		feet="Flam. Gambieras +2",
		--neck="Vim Torque +1",
		neck="Dragoon's Collar +2",
		--neck="Ganesha's Mala",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		ear2="Brutal Earring",
		ear1="Sherida Earring",
		ring2="Niqmaddu Ring",
		ring1="Petrov Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

sets.engaged.Aftermath_Rhongo.LowHaste = set_combine(sets.engaged.Aftermath_Rhongo,{
		head="Flamma Zucchetto +2",
		--[[ammo="Coiste Bodhar",
		--head="Hjarrandi Helm",
		--head="Flamma Zucchetto +2",
		head="Blistering Sallet +1",
		body="Gleti's Cuirass",
		hands="Sulevia's Gauntlets +2",
		--legs={ name="Valorous Hose", augments={'Accuracy+24 Attack+24','"Dbl.Atk."+5',}},
		legs={ name="Valorous Hose", augments={'"Mag.Atk.Bns."+8','"Store TP"+5','Quadruple Attack +2','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		feet="Flam. Gambieras +2",
		neck="Dragoon's Collar +2",
		--waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		waist="Ioskeha Belt",
		ear2="Brutal Earring",
		ear1="Sherida Earring",
		ring2="Niqmaddu Ring",
		ring1="Petrov Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},]]
})

sets.engaged.Aftermath_Rhongo.Mid = {
		ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		body="Gleti's Cuirass",
		--hands="Sulevia's Gauntlets +2",
		hands="Gleti's Gauntlets",
		--legs={ name="Valorous Hose", augments={'Accuracy+24 Attack+24','"Dbl.Atk."+5',}},
		legs="Pteroslaver Brais +3",
		feet="Flam. Gambieras +2",
		--neck="Vim Torque +1",
		neck="Dragoon's Collar +2",
		--waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		waist="Ioskeha Belt",
		ear2="Telos Earring",
		ear1="Sherida Earring",
		ring2="Niqmaddu Ring",
		ring1="Petrov Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

sets.engaged.Aftermath_Rhongo.Acc = set_combine(sets.engaged.Acc, {
		head="Blistering Sallet +1", --adds some crit rate. need to see how much acc this costs (if any) due to set bonuses
		body="Hjarrandi Breastplate",
		waist="Ioskeha Belt",
		--need to make a DA/acc cape

})

sets.engaged.Aftermath_Rhongo.MaxBuff = set_combine(sets.engaged.Aftermath_Rhongo, {
		neck="Dragoon's Collar +2",
		--head="Blistering Sallet +1",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",--not sure why these beat quad attack gloves according to spreadsheet
		legs="Gleti's Breeches",
		
})

sets.engaged.Aftermath_Rhongo.DT = set_combine(sets.engaged.Aftermath_Rhongo, {
		--[[legs="Gleti's Breeches",
		hands="Gleti's Gauntlets",
		ring1="Moonlight Ring",]]
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		neck="Dragoon's Collar +2",
		--legs="Pteroslaver Brais +3",--should add a wyvern toggle
		feet="Gleti's Boots",
		
		ring1="Moonlight Ring",
		--ring2="Defending Ring",
		--ring1="Shadow Ring",
		legs="Gleti's Breeches",--relic +3 instead for wyvern?
})


----------------------------------------------------------------------------------
--                      Ryunohige                                               --
----------------------------------------------------------------------------------

sets.engaged.Aftermath_Ryu = {
    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    --head="Flam. Zucchetto +2",
	head="Nyame Helm",
    --body="Hjarrandi Breast.",
	--body="Gleti's Cuirass",
	--body="Nyame Mail",
	body="Peltast's Plackart +3",
    --hands="Flam. Manopolas +2",
	--hands="Nyame Gauntlets",
	hands="Gleti's Gauntlets",
    --legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
	legs="Ptero. Brais +3",
    --feet={ name="Valorous Greaves", augments={'Accuracy+12 Attack+12','"Store TP"+3','STR+5','Accuracy+13','Attack+14',}},
	--feet="Flamma Gambieras +2",--to be replaced once I get new valorous augments
	feet="Nyame Sollerets",
    neck={ name="Vim Torque +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    right_ear="Sherida Earring",
    left_ear="Dedition Earring",
    left_ring="Hetairoi Ring",
    right_ring="Niqmaddu Ring",
    back= Brigantia.STP,--spreadsheet says double attack may be better. To confirm later
}

sets.engaged.Aftermath_Ryu.LowHaste = set_combine(sets.engaged.Aftermath_Ryu,{


})

sets.engaged.Aftermath_Ryu.Mid = set_combine(sets.engaged.Aftermath_Ryu,{
		--[[ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		body="Hjarrandi Breastplate",
		hands="Nyame Gauntlets",
		legs={ name="Valorous Hose", augments={'Accuracy+24 Attack+24','"Dbl.Atk."+5',}},
		--feet={ name="Valorous Greaves", augments={'Accuracy+12 Attack+12','"Store TP"+3','STR+5','Accuracy+13','Attack+14',}},
		--neck="Vim Torque +1",
		neck="Dragoon's Collar +2",
		--waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		waist="Ioskeha Belt",
		ear2="Telos Earring",
		ear1="Sherida Earring",
		ring2="Niqmaddu Ring",
		ring1="Petrov Ring",
		back=Brigantia.STP,]]
		ear2="Telos Earring",
		--body="Nyame Mail",
		ring1="Chirich Ring +1",
})

sets.engaged.Aftermath_Ryu.Acc = set_combine(sets.engaged.Acc, {
		--body="Hjarrandi Breastplate",
		waist="Ioskeha Belt",
		back=Brigantia.STP,
})

sets.engaged.Aftermath_Ryu.MaxBuff = set_combine(sets.engaged.Aftermath_Ryu, {
		neck="Dragoon's Collar +2",
		--ear1="Sroda Earring",--assuming wyvern is alive
})

sets.engaged.Aftermath_Ryu.DT = set_combine(sets.engaged.Aftermath_Ryu, {
		head="Nyame Helm",
		legs="Ptero. Brais +3",
		neck="Dragoon's Collar +2",
		--hands="Nyame Gauntlets",
		left_ring="Defending Ring",
		hands="Gleti's Gauntlets",
		ring2="Moonlight Ring",
		ring1="Defending Ring",
		--feet="Nyame Sollerets",
		left_ring="Chirich Ring +1",
		boey="Gleti's Cuirass",--consider Hjarrandi here.Big hit to Meva
		--body="Nyame Mail",
})


--------Misc---------------------
    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        --ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        --ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
		ring1={name="Saida Ring", bag="wardrobe3"}, --15
        ring2={name="Saida Ring", bag="wardrobe4"}, --15
        }
		
--set for regain while sleeping with DT		
	sets.Sleeping = set_combine(sets.idle.Regain,{
		neck="Vim Torque +1",
		legs = "Gleti's Breeches",
	})

end



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

--[[ Set eventArgs.handled to true if we don't want any automatic target handling to be done.
No longer valid now that jump timers aren't shared
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.english == "Spirit Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command('Jump')
        end
    elseif spell.english == "Soul Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command("High Jump")
        end
    end
end
]]--

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if player.hpp < 51 then
		classes.CustomClass = "Breath" 
	end
    if spell.type == 'WeaponSkill' then
		--No Longer Using Capacity Mantle (mastered)
        --[[if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end]]
		--element head is now outclassed
        --[[if is_sc_element_today(spell) then
            if wsList:contains(spell.english) then
				--if State.WeaponskillMode.Value ~= "Uncapped" then
                --equip(sets.WSDayBonus)
				--end
            end
        end]]
		
		--capped vs uncapped sets for stardiver/drakesbane/impulse
		if state.AttackMode.value == "Capped" then
			if spell.english == 'Stardiver' then
				equip (sets.StardiverCapped)
			elseif spell.english == 'Drakesbane' then
				equip (sets.DrakesbaneCapped)
			elseif spell.english == 'Impulse Drive' then
				equip (sets.ImpulseCapped)
			elseif spell.english == 'Savage Blade' then
				equip (sets.SavageCapped)
			elseif spell.english == 'Diarmuid' then	
				equip(sets.DiarmuidCapped)
			end
		end
		
	


		if spell.english == "Camlann's Torment" then
			if player.tp > 2750 then
				equip (sets.Camlanns3k)
			elseif player.tp >= 2000 and player.tp < 2750 or state.AttackMode.value == "Capped" then
				equip (sets.CamlannsCapped)
			end
		elseif spell.english == "Impulse Drive" and player.equipment.main ~= "Shining One" then
			equip (sets.Impulse_No_Crit)
		end
		
		
		--skill chain toggle
		if state.SC.value == 'SC' and spell.english ~= 'Leg Sweep' and spell.english ~= 'Shell Crusher' then
			equip (sets.SC)
		end
		
		if state.killer.value == 'On' and spell.english ~= 'Leg Sweep' and spell.english ~= 'Shell Crusher' then
			equip (sets.killer)
		end
		
		--subtle blow toggle
		if state.SB.value == 'SB' and spell.english ~= 'Leg Sweep' and spell.english ~= 'Shell Crusher' then
			if buffactive['Auspice'] then
				--equip (sets.SB_Auspice)
				equip({
					--Auspice SB 29
					neck="Bathy Choker +1",--11
					ear1="Sherida earring",--5 (II)
					ring1="Chirich Ring +1",--10
					ring2="Niqmaddu Ring",--5(II)
					--60 SB
					
				})
			else
				--equip (sets.SB)
				equip({
					neck="Bathy Choker +1",--11
					ear1="Sherida earring",--5 (II)
					ring1="Chirich Ring +1",--10
					ring2="Niqmaddu Ring",--5(II)
					legs="Gleti's Breeches"--11
					
					
				})
			end
		end
		
		if state.TreasureMode.value == 'Tag' and spell.english == 'Cataclysm' then
            equip(sets.TreasureHunter)
		end
		
    end
	
			--add dt to jumps. Comment out if not required for now
		if spell.english:endswith('Jump') and state.HybridMode.value == "PDT" then
	--if spell.english == 'Jump' --[[and state.HybridMode.value == "PDT"]] then
		--add_to_chat(8, '-------------Jump Called--------------')
			equip({
				ring1="Defending Ring",
				ring2="Moonlight Ring",
				head="Nyame Helm",
				body="Gleti's Cuirass",
			})
	end
	
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
	    equip(sets.midcast.FastRecast)
	    if player.hpp < 51 then
		    classes.CustomClass = "Breath" 
	    end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end

function job_pet_precast(spell, action, spellMap, eventArgs)

	
end
-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' or spell.english == 'Steady Wing' then
		equip(sets.HB)
	--elseif spell.english == 'Smiting Breath' then
	
	--Moving this section to aftercast with delay
	elseif spell.english == 'Frost Breath' or spell.english == 'Flame Breath' or spell.english == 'Sand Breath' or spell.english == 'Gust Breath' or spell.english == 'Hydro Breath' or spell.english == 'Lightning Breath' then
		--keeping off for now until I figure the command for waiting 1.2s to equip after breath starts
		--equip(sets.EB)--Turn off for Dyna (not sure about this, but it seems to have some impact on dps)
		
		
		--windower.send_command('wait 1;input /console equip sets.EB')
		
		--send_command('wait '..breath_delay..';input /echo [Gambit just wore off!];')
		--send_command('wait '..breath_delay..';input /console gs equip sets.EB;')
		--send_command('wait '..breath_delay..';'..equip(sets.EB))

		
	end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
	
end



-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	--[[if state.HybridMode.value == 'SB' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'SB') then
		equip(sets.SB)
	end]]
	
	 if spell.name == 'Angon' and not spell.interrupted then
        send_command('@timers c "Angon ['..spell.target.name..']" '..angon_duration..' down spells/00136.png')
		send_command('wait '..angon_duration..';input /echo [***********************************************************];')
        send_command('wait '..angon_duration..';input /echo [*******************Angon just wore off!**********************];')
		send_command('wait '..angon_duration..';input /echo [***********************************************************];')
	end
	
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
--[[function job_handle_equipping_gear(status, eventArgs)

end]]

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
	end
	
	if state.IdleMode.value == 'Regain' then
		idleSet = set_combine(idleSet, sets.idle.Regain)
	end
	
	--will figure this out later
	--[[if state.Auto_Kite.value == true then
	--if state.IdleMode.value == 'Regain' then
       idleSet = set_combine(idleSet, sets.Kiting)
    end]]
	
	if state.PhysicalDefenseMode.value == 'Reraise' then
		idleSet=set_combine(idleSet,sets.defense.Reraise)
	end
	
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if S{'madrigal'}:contains(buff:lower()) then
        if buffactive.madrigal and state.OffenseMode.value == 'Acc' then
            equip(sets.MadrigalBonus)
        end
    end
    if string.lower(buff) == "sleep" and gain and player.hp > 200 then
        equip(sets.Sleeping)--regain/DT set while asleep
    else
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
	if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed')
             disable('ring1','ring2','waist','neck')
        else
            enable('ring1','ring2','waist','neck')
            handle_equipping_gear(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end
end

function job_update(cmdParams, eventArgs)
    war_sj = player.sub_job == 'WAR' or false
	classes.CustomMeleeGroups:clear()
	th_update(cmdParams, eventArgs)
	get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

function get_combat_form()
	--if areas.Adoulin:contains(world.area) and buffactive.ionis then
	--	state.CombatForm:set('Adoulin')
	--end

    if war_sj then
        state.CombatForm:set("War")
    else
        state.CombatForm:reset()
    end
end


-- Job-specific toggles.
function job_toggle(field)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

local r_color = ''

local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local am_msg = '(' ..string.sub(state.OffenseMode.value,1,1).. ')'

    local ws_msg = state.WeaponskillMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

	local msg = ''

    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end
	
	
	local a_msg='Normal'
	if state.AttackMode.value ~= 'Normal' then
		a_msg = ' '..state.AttackMode.value..' '
	else
		a_msg = ' Uncapped '
	end
	
	local sb_msg = 'Off'
	if state.SB.value ~= 'None' then
		sb_msg = ' '..state.SB.value..' '
	end
	
	local sc_msg = 'Off'
	if state.SC.value ~= 'None' then
		sc_msg = ' '..state.SC.value..' '
	end

    add_to_chat(string.char(31,210).. ' Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002).. ' |'
        ..string.char(31,207).. ' WS' ..am_msg.. ': ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060)
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002).. ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002).. ' |'
		..string.char(31,006).. ' Attack: ' ..string.char(31,001)..a_msg.. string.char(31,002).. ' |'
		..string.char(31,010).. ' SB: ' ..string.char(31,001)..sb_msg.. string.char(31,002).. ' |'
		..string.char(31,010).. ' SC: ' ..string.char(31,001)..sc_msg.. string.char(31,002).. ' |'
        ..string.char(31,002)..msg)

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
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(9, 1)
    elseif player.sub_job == 'BLU' then
    	set_macro_page(9, 1)
    else
    	set_macro_page(9, 1)
    end
end


-- Detects if your lockable gear is equipped and locks said slot. Then determines if it's an enchanted item and if that item has a charge ready or not to re-enable said slot.
--added code to the end of motes-include for this to work
function job_handle_equipping_gear(playerStatus, eventArgs)
    local lockables = T{'Mecisto. Mantle', 'Shobuhouou Kabuto', 'Aptitude Mantle', 'Nexus Cape', 'Aptitude Mantle +1', 'Warp Ring', 'Vocation Ring', 'Reraise Earring', 'Capacity Ring', 'Trizek Ring', 'Echad Ring', 'Facility Ring', 'Dim. Ring (Holla)', 'Dim. Ring (Dem)', 'Dim. Ring (Mea)'}
    local watch_slots = T{'ear1','ear2','ring1','ring2','back','head'}
 
    for _,v in pairs(watch_slots) do
        if lockables:contains(player.equipment[v]) then
            disable(v)
            --[[if has_charges(player.equipment[v]) and (not is_enchant_ready(player.equipment[v])) then
                enable(v)
            end]]
        else
            enable(v)
        end
    end
	
	check_moving()
end


--------------------------------------------------------------------------------------------------------------------------------
----------------------adding function for rhongoimant aftermath (and in the future ryunohige)-----------------------------------
--------------------------------------------------------------------------------------------------------------------------------



--[[function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end


    --if buff == "terror" then
    --    if gain then
    --        --equip(sets.defense.PDT)
	--		equip(sets.defense)  --May have to switch back to .pdt
    --    end
    --end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed')
             disable('ring1','ring2','waist','neck')
        else
            enable('ring1','ring2','waist','neck')
            handle_equipping_gear(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end

 --to do: add set for amnesia

end]]



function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)


	if player.sub_job ~= 'SAM' or player.equipment.main == "Naegling" then --Changing body to hit gear haste cap to make up for loss of hasso
		--meleeSet = set_combine(meleeSet, {body = "Nyame Mail",})--Gleti's also hits haste cap
	end
	
	

	if state.DefenseMode.value == 'Physical' then
		meleeSet = set_combine(meleeSet, sets.defense.PDT)
					if pet.isvalid then
						meleeSet = set_combine(meleeSet, {ear2="Sroda Earring"})
					end
	elseif state.DefenseMode.value == 'Magical' then
		meleeSet = set_combine(meleeSet, sets.defense.MDT)
					if pet.isvalid then
						meleeSet = set_combine(meleeSet, {ear2="Sroda Earring"})
					end
	else
		if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Rhongomiant" and state.DefenseMode.value == 'None' then
			if state.HybridMode.value == "PDT" then
				meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Rhongo.DT)
				 --add_to_chat(8, '-------------Rhongo_DT--------------')
			--[[elseif state.HybridMode.value =="SB" then
				meleeSet = set_combine(meleeSet, sets.engaged.SB)]]
			else
				if state.OffenseMode.value == "Normal" then
					if state.AttackMode.value == "Normal" then
						meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Rhongo)
					else
						meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Rhongo_capped)
					end
					--check for wyvern for Sroda
					if pet.isvalid then
						meleeSet = set_combine(meleeSet, {ear2="Sroda Earring"})
					end
				elseif state.OffenseMode.value == "LowHaste" then
					meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Rhongo.LowHaste)
					--add_to_chat(8, '-------------Rhongo_LowHaste--------------')
				elseif state.OffenseMode.value == "Mid" then
					meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Rhongo.Mid)
					--add_to_chat(8, '-------------Rhongo_Mid--------------')
				elseif state.OffenseMode.value == "Acc" then
					meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Rhongo.Acc)
					--add_to_chat(8, '-------------Rhongo_Acc--------------')
				elseif state.OffenseMode.value == "MaxBuff" then
					meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Rhongo.MaxBuff)
					if pet.isvalid then
						meleeSet = set_combine(meleeSet, {ear2="Sroda Earring"})
					end
					--add_to_chat(8, '-------------Rhongo_MaxBuff--------------')
				else
					meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Rhongo)
					--add_to_chat(8, '-------------Rhongo_Normal--------------')
				end
			end

		elseif buffactive['Aftermath: Lv.3'] and player.equipment.main == "Ryunohige" and state.DefenseMode.value == 'None' then
			if state.HybridMode.value == "PDT" then
				meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Ryu.DT)
			elseif state.HybridMode.value == "Wyvern" then
				meleeSet = set_combine(meleeSet, sets.engaged.Wyvern)
				 --add_to_chat(8, '-------------Rhongo_DT--------------')
			--[[elseif state.HybridMode.value =="SB" then
				meleeSet = set_combine(meleeSet, sets.engaged.SB)]]
			else
				if state.OffenseMode.value == "Normal" then
					meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Ryu)
				elseif state.OffenseMode.value == "LowHaste" then
					meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Ryu.LowHaste)
					--add_to_chat(8, '-------------Rhongo_LowHaste--------------')
				elseif state.OffenseMode.value == "Mid" then
					meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Ryu.Mid)
					--add_to_chat(8, '-------------Rhongo_Mid--------------')
				elseif state.OffenseMode.value == "Acc" then
					meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Ryu.Acc)
					--add_to_chat(8, '-------------Rhongo_Acc--------------')
				elseif state.OffenseMode.value == "MaxBuff" then
					meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Ryu.MaxBuff)
					--add_to_chat(8, '-------------Rhongo_MaxBuff--------------')
				else
					meleeSet = set_combine(meleeSet, sets.engaged.Aftermath_Ryu)
					--add_to_chat(8, '-------------Rhongo_Normal--------------')
				end
			end
		
		
		
	--Manually adding a check in the file for accuracy modes as it did not seem to be detecting the additional values
	--Seemed less responsive at first, but I think it's fine
		else
			 if state.HybridMode.value == "PDT" then
				meleeSet = set_combine(meleeSet, sets.engaged.PDT)
				 --add_to_chat(8, '-------------Rhongo_DT--------------')
			--[[elseif state.SB.value =="SB" then
					if buffactive['Auspice'] then
						meleeSet = set_combine(meleeSet, sets.SB_Auspice)
					else
						meleeSet = set_combine(meleeSet, sets.SB)
					end
			
				--meleeSet = set_combine(meleeSet, sets.engaged.SB)]]
			elseif state.HybridMode.value == "Wyvern" then
				meleeSet = set_combine(meleeSet, sets.engaged.Wyvern)
			else
				if state.OffenseMode.value == "Normal" then
					meleeset = set_combine(meleeSet, sets.engaged)
					if pet.isvalid then
						meleeSet = set_combine(meleeSet, {ear2="Sroda Earring"})
					end
				elseif state.OffenseMode.value == "LowHaste" then
					meleeSet = set_combine(meleeSet, sets.engaged.LowHaste)
					--add_to_chat(8, '-------------Rhongo_LowHaste--------------')
				elseif state.OffenseMode.value == "Mid" then
					meleeSet = set_combine(meleeSet, sets.engaged.Mid)
					if pet.isvalid then
						meleeSet = set_combine(meleeSet, {ear2="Sroda Earring"})
					end
					--add_to_chat(8, '-------------Rhongo_Mid--------------')
				elseif state.OffenseMode.value == "Acc" then
					meleeSet = set_combine(meleeSet, sets.engaged.Acc)
					--add_to_chat(8, '-------------Rhongo_Acc--------------')
				elseif state.OffenseMode.value == "MaxBuff" then
					meleeSet = set_combine(meleeSet, sets.engaged.MaxBuff)
						if pet.isvalid then
							meleeSet = set_combine(meleeSet, {ear2="Sroda Earring"})
						end
					--add_to_chat(8, '-------------Rhongo_MaxBuff--------------')
				else
					meleeSet = set_combine(meleeSet, sets.engaged)
					--add_to_chat(8, '-------------Rhongo_Normal--------------')
				end
			end
		end
	end
	
	
	--[[if state.killer.value == 'On' then
		meleeSet = set_combine(meleeset, sets.killer) -- currently not combining with above sets, but rather with the normal engaged set
	end
	]]
	
	--[[if pet.isvalid then
		meleeSet = set_combine(meleeSet, {ear1="Sroda Earring",})
	end]]
	
	--Combine meleeset with subtle blow if toggled
	if state.SB.value == 'SB' and state.DefenseMode.value == 'None' then
					if buffactive['Auspice'] then
						meleeSet = set_combine(meleeSet, sets.SB_Auspice)
					else
						meleeSet = set_combine(meleeSet, sets.SB)
					end
	end
	
    --[[if state.Knockback.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Knockback)
    end]]

    return meleeSet
end

