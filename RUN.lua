-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ CTR+F10 ]         Toggle defence modes normal, hp , parry
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+H ]           Toggle Charm Defense Mods
--              [ WIN+D ]           Toggle Death Defense Mods
--              [ WIN+K ]           Toggle Knockback Defense Mods
--              [ WIN+A ]           AttackMode: Capped/Uncapped WS Modifier
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Use current Rune
--              [ CTRL+- ]          Rune element cycle forward.
--              [ CTRL+= ]          Rune element cycle backward.
--              [ CTRL+` ]          Use current Rune
--
--              [ CTRL+Numpad/ ]    Berserk/Meditate/Weapon Bash       
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki/Arcane Circle   
--              [ CTRL+Numpad- ]    Aggressor/Third Eye/Souleater	
--
--  Spells:     [ CTRL+Numpad/`]           Utsusemi: Ichi
--              [ CTRL+Numpad* ]           Utsusemi: Ni (not numpad)
--
--  Weapons:    [ CTRL+G ]          Cycles between available greatswords
--              [ CTRL+W ]          Toggle Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Resolution
--              [ CTRL+Numpad8 ]    Upheaval
--              [ CTRL+Numpad9 ]    Dimidiation
--				[ CTRL+NUMPAD4 ]    Savage Blade
--              [ CTRL+Numpad5 ]    Ground Strike
--              [ CTRL+Numpad6 ]    Full Break
--              [ CTRL+Numpad1 ]    Herculean Slash
--              [ CTRL+Numpad2 ]    Shockwave
--              [ CTRL+Numpad3 ]    Armor Break
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------


--  gs c rune                       Uses current rune
--  gs c cycle Runes                Cycles forward through rune elements
--  gs c cycleback Runes            Cycles backward through rune elements


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end

-- Setup vars that are user-independent.
function job_setup()

	rune_enchantments = S{'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda',
        'Lux','Tenebrae'}

    -- /BLU Spell Maps
    blue_magic_maps = {}

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura',
        'Poison Breath', 'Blitzstrahl', 'Chaotic Eye'}
    blue_magic_maps.Cure = S{'Wild Carrot'}
    blue_magic_maps.Buffs = S{'Sheep Song', 'Soporific'}
	blue_magic_maps.Buff = S{'Sheep Song', 'Soporific'}

    rayke_duration = 35
    gambit_duration = 96

    --lockstyleset = 1
	lockstyleset = 22

--******adding treasure hunter include myself********--
    include('Mote-TreasureHunter')
    --state.TreasureMode:set('Tag')
	state.TreasureMode:set('None')

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'Refresh')
    state.PhysicalDefenseMode:options('PDT', 'Parry', 'HP')
    state.MagicalDefenseMode:options('MDT')

    state.Knockback = M(false, 'Knockback')

    state.WeaponSet = M{['description']='Weapon Set', 'Epeolatry', 'Lionheart', 'Aettir', 'GreatAxe'}
    state.AttackMode = M{['description']='Attack', 'Uncapped', 'Capped'}
    state.CP = M(false, "Capacity Points Mode")
    state.WeaponLock = M(false, 'Weapon Lock')

    state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line
    --include('Global-GEO-Binds.lua') -- OK to remove this line

    --send_command('lua l gearinfo')

    send_command('bind ^` input //gs c rune')
    send_command('bind !` input /ma "Temper" <me>')
	send_command('bind !- gs c cycleback runes')
    send_command('bind != gs c cycle runes')
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind @a gs c cycle AttackMode')
    --send_command('bind @c gs c toggle CP')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @k gs c toggle Knockback')
    send_command('bind !q input /ma "Temper" <me>')

--custom binds by me	
	--send_command('bind @= gs c cycle treasuremode')


    --if player.sub_job == 'BLU' then
        --send_command('bind !w input /ma "Cocoon" <me>')
    --elseif player.sub_job == 'WAR' then
        --send_command('bind !w input /ja "Defender" <me>')
    --elseif player.sub_job == 'DRK' then
        --send_command('bind !w input /ja "Last Resort" <me>')
    --elseif player.sub_job == 'SAM' then
        --send_command('bind !w input /ja "Hasso" <me>')
    --end

   -- send_command('bind !o input /ma "Regen IV" <stpc>')
  --  send_command('bind !p input /ma "Ice Spikes" <me>')

    --send_command('bind @w gs c toggle WeaponLock')
    --send_command('bind @c gs c toggle CP')

    --if player.sub_job == 'WAR' then
        --send_command('bind ^numpad/ input /ja "Berserk" <me>')
        --send_command('bind ^numpad* input /ja "Warcry" <me>')
        --send_command('bind ^numpad- input /ja "Aggressor" <me>')
    --elseif player.sub_job == 'DRK' then
        --send_command('bind ^numpad- input /ja "Souleater" <me>')
        --send_command('bind ^numpad* input /ja "Arcane Circle" <me>')
		--send_command('bind ^numpad* input /ma "Stun" <stnpc>')
        --send_command('bind ^numpad/ input /ja "Weapon Bash" <t>')
    --elseif player.sub_job == 'SAM' then
        --send_command('bind ^numpad/ input /ja "Meditate" <me>')
        --send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
        --send_command('bind ^numpad- input /ja "Third Eye" <me>')
	--elseif player.sub_job == 'NIN' then
		--send_command('bind ^numpad/ input /ma "Utsusemi: Ichi" <me>')
        --send_command('bind ^numpad* input /ma "Utsusemi: Ni" <me>')
    --end

    --send_command('bind ^numpad7 input /ws "Resolution" <t>')
    --send_command('bind ^numpad8 input /ws "Upheaval" <t>')
    --send_command('bind ^numpad9 input /ws "Dimidiation" <t>')
    --send_command('bind ^numpad5 input /ws "Ground Strike" <t>;input /p Ground Strike')
	--send_command('bind ^numpad5 input /ws "Ground Strike" <t>')
    --send_command('bind ^numpad6 input /ws "Full Break" <t>')
    --send_command('bind ^numpad1 input /ws "Herculean Slash" <t>')
    --send_command('bind ^numpad2 input /ws "Shockwave" <t>')
    --send_command('bind ^numpad3 input /ws "Armor Break" <t>')
	
	--send_command('bind ^numpad/ input /ma "Utsusemi: Ichi" <me>')
	--send_command('bind ^numpad* input /ma "Utsusemi: Ni" <me>')
	--send_command('bind ^numpad4 input /ws "Savage Blade" <t>')
	

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^f11')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind @a')
    send_command('unbind @c')
    send_command('unbind @d')
    send_command('unbind !q')
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind !o')
    send_command('unbind !p')
    send_command('unbind ^,')
    send_command('unbind @w')
    --send_command('unbind ^numpad/')
    --send_command('unbind ^numpad*')
    --send_command('unbind ^numpad-')
    --send_command('unbind ^numpad7')
    --send_command('unbind ^numpad9')
	--send_command('unbind ^numpad4')
    --send_command('unbind ^numpad5')
    --send_command('unbind ^numpad1')
    --send_command('unbind @numpad*')

	send_command('unbind ^/')
	send_command('unbind ^*')


    --send_command('unbind #`')
    --send_command('unbind #1')
    --send_command('unbind #2')
    --send_command('unbind #3')
    --send_command('unbind #4')
    --send_command('unbind #5')
    --send_command('unbind #6')
    --send_command('unbind #7')
    --send_command('unbind #8')
    --send_command('unbind #9')
    --send_command('unbind #0')
	


    --send_command('lua u gearinfo')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enmity sets
    sets.Enmity = {
	--79 enimity-89 with sword, 2976 HP
	
	
	head="Halitus Helm",
    body="Emet Harness",
    hands="Turms mittens +1",
    legs="Meg. Chausses +2",
    feet="Turms leggings +1",
    neck="Moonlight Necklace",
    waist="Flume Belt +1",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    ring2="Defending Ring",
    ring1="Moonlight ring",
    back={ name="Ogma's Cape", augments={'Accuracy+10 Attack+10','Enmity+10',}},
	
      --ammo="", --2
      --head="Halitus Helm", --8
      --body="Emet Harness +1", --9
      ----hands="Kurys Gloves", --9
		--hands="Futhark Mitons",--3
      --legs="Eri. Leg Guards +1", --11
      --feet="Ahosi Leggings",--7
      --neck="Unmoving Collar +1", --9
      --left_ear="Cryptic Earring", --4
      ----right_ear="Trux Earring", --5
		--right_ear="Friomisi Earring",--2
		----right_ear="Odnowa Earring +1",--Sacrificing 2 enmity for 100 HP
      ----ring1="Supershear Ring", --5
		--ring1="Petrov Ring",--4
      ----ring2="Eihwaz Ring", --5
		--ring2="Provocare Ring",--5
		--back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},--10
      ----waist="Kasiri Belt", --3
		--waist="Warwolf Belt", --3
		--
		--************************-----94 total Enmity with epeo -- 104 with merits-----***********************
        }

    sets.Enmity.HP = {
    --   head="Halitus Helm", --8
    --   --body="Emet Harness +1 +1", --10
    --   --hands="Kurys Gloves", --9
    --   legs="Eri. Leg Guards +1", --11
    --   --feet="Ahosi Leggings",--7
    --   --neck={name="Unmoving Collar +1 +1", priority=1}, --10
    --   right_ear={name="Tuisto Earring", priority=4},
    --   left_ear={name="Odnowa Earring +1", priority=3},
    --   --ring1={name={name="Moonbeam Ring", bag="wardrobe4"}, priority=2},
    --   --ring2="Eihwaz Ring", --5
    --   --waist="Kasiri Belt", --3
	--	
	--	
	--	ammo="Aqreqaq Bomblet", --2
	--	body="Emet Harness +1",--9
	--	hands="Futhark Mitons",--3
	--	feet="Erilaz Greaves +1",--6
    --   neck={name="Unmoving Collar +1", priority=1}, --9
	--	ring1="Petrov Ring",--4
	--	ring2="Provocare Ring",--5
	--	back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	--	waist="Warwolf Belt", --3
	    --ammo="Aqreqaq Bomblet",
    --head="Nyame Helm",
    --body="Runeist's Coat +3",
    --hands="Regal Gauntlets",
    --legs="Eri. Leg Guards +1",
    --feet="Turms Leggings +1",
    --neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    --waist="Silver Mog. Belt",
    --left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    --right_ear="Tuisto Earring",
    --left_ring={name="Moonbeam Ring", bag="wardrobe4"},
    --right_ring={name="Moonbeam Ring", bag="wardrobe4"},
    --back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
        }

    sets.precast.JA['Vallation'] = {body="Runeist's Coat +1", 
									back="Ogma's cape"}
									--legs="Futhark Trousers"} 
									
    --sets.precast.JA['Pflug'] = {feet="Runeist's Boots +1"}
    --sets.precast.JA['Battuta'] = {head="Fu. Bandeau +3"}
    --sets.precast.JA['Liement'] = {body="Futhark Coat +3"}

    sets.precast.JA['Lunge'] = {
        --back="Argocham. Mantle",
	ammo="Seething Bomblet +1",
	--head="Nyame helm",
    body="Cohort cloak +1",
    hands="Agwu's Gages",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Hermetic Earring",
    right_ear="Friomisi Earring",
    ring2="Defending Ring",
    ring1="Moonlight Ring",
    back={ name="Ogma's Cape", augments={'Accuracy+10 Attack+10','Enmity+10',}},
	}

    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    --sets.precast.JA['Gambit'] = {hands="Runeist's Mitons +2"}
    --sets.precast.JA['Rayke'] = {feet="Futhark Boots"}
    --sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat +3"}
    --sets.precast.JA['Swordplay'] = {hands="Futhark Mitons"}
    sets.precast.JA['Vivacious Pulse'] = { 											  
											--head="Erilaz Galea +1",
											left_ear="Beatific Earring",
											--right_ear="Divine Earring",
											left_ring="Stikini Ring +1",
											right_ring="Stikini Ring +1",
											--back="Altruistic Cape",
											--neck="Incanter's Torque",
											}

    -- Fast cast sets for spells
    sets.precast.FC = {--3030hp
        ammo="Sapience Orb", --2  (Farm this in zi'tah)
		--body=gear.Taeon_FC_body, --8
		head="Carmine Mask +1",
		body="Samnuha Coat",
		hands="Leyline Gloves",
		legs="Aya. Cosciales +2",
		feet="Carmine Greaves +1",
		neck="Moonlight Necklace",
		waist="Carrier's sash",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Kishar Ring",
		right_ring="Rahab Ring",
		back={name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}}
			
		-----------    Total FC=40   ----------------------------
        }

    sets.precast.FC.HP = set_combine(sets.precast.FC, {
       -- ammo="Aqreqaq Bomblet",
        --head={name="Rune. Bandeau +1", priority=6},
        --body={name="Runeist's Coat +3", priority=2},
        --neck={name="Unmoving Collar +1 +1", priority=1}, --10
        --right_ear={name="Tuisto Earring", priority=5},
        --left_ear={name="Odnowa Earring +1", priority=4},
        --ring1={name={name="Moonbeam Ring", bag="wardrobe4"}, priority=3},
        --waist="Oneiros Belt",
        })

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
       -- legs="Futhark Trousers",
        })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {--[[ammo="Impatiens",]] --[[right_ear="Mendi. Earring"]]})

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        --ammo="Impatiens",
       -- body="Passion Jacket",
        ring1="Lebeche Ring",
        --waist="Rumination Sash",
        })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        --[[ammo="Knobkierrie",
        head="Lilitu Headpiece",
        body=gear.Herc_WS_body,
        hands="Meg. Gloves +2",
        legs=gear.Herc_WS_legs,
        feet=gear.Herc_TA_feet,
        neck="Fotia Gorget",
        left_ear="Sherida Earring",
        right_ear="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Niqmaddu Ring",
        back=gear.RUN_WS1_Cape,
        waist="Fotia Belt",]]--
		
	--	ammo="Knobkierrie",
	--	head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
	--	body="Meg. Cuirie +2",
	--	hands="Meg. Gloves +2",
	--	legs="Meg. Chausses +2",
	--	--feet="Lustratio Leggings",
	--	feet={ name="Herculean Boots", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','Accuracy+8','Attack+7',}},
	--	neck="Lacono Necklace +1",
	--	waist="Sailfi Belt +1",
	--	right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	--	left_ear="Sherida Earring",
	--	left_ring="Niqmaddu Ring",
	--	right_ring="Regal Ring",
	--	back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
      
			--ammo="Aurgelmir Orb",
	ammo="Knobkierrie",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Ishvara Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Regal Ring",
    back={ name="Ogma's Cape", augments={'Accuracy+10 Attack+10','Enmity+10',}},
	  
	  
	  
	  
	  }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        --[[ammo="Seeth. Bomblet +1",
        body=gear.Adhemar_B_body,
        legs="Meg. Chausses +2",
        right_ear="Telos Earring",]]
        })

    sets.precast.WS.Uncapped = set_combine(sets.precast.WS, {
        --ammo="Seeth. Bomblet +1",
        })

    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
        --head="Lustratio Cap +1",
        --body="Lustr. Harness +1",
        --hands=gear.Adhemar_B_hands,
        --legs="Samnuha Tights",
        --feet="Lustra. Leggings +1",
        --ring1="Epona's Ring",
        --back=gear.RUN_WS1_Cape,
		--head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		--body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		--feet="Lustratio Leggings",
		--legs="Samnuha Tights",
		--back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		--waist="fotia belt",
		--neck="fotia gorget",
		
		
			--ammo="Aurgelmir Orb",
			ammo="Knobkierrie",
			--head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
			--body="Ayanmo Corazza +2",
			--body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
			--hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
			--legs="Meghanada chausses +2",
			--legs={ name="Herculean Trousers", augments={'Accuracy+23','"Triple Atk."+4','STR+3',}},
			--feet={ name="Herculean Boots", augments={'Accuracy+24','"Triple Atk."+3','STR+1','Attack+5',}},
			neck="Rep. Plat. Medal",
			waist="Sailfi Belt +1",
			left_ear="Sherida Earring",
			right_ear="Moonshade Earring",
			left_ring="Regal Ring",
			right_ring="Niqmaddu Ring",
			--back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Parrying rate+5%',}},
		
		
		
        })

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {
        
        hands="Adhemar wrist. +1",
        legs="Nyame Flanchard",
        --feet=gear.Herc_STP_feet,
        right_ear="Telos Earring",
		left_ear="Sherida earring",
        })

    sets.precast.WS['Resolution'].Uncapped = set_combine(sets.precast.WS['Resolution'], {
        --[[ammo="Seeth. Bomblet +1",
        head=gear.Adhemar_B_head,
        body=gear.Adhemar_B_body,
        legs="Meg. Chausses +2",
        feet=gear.Herc_TA_feet,
        ring1="Regal Ring",]]--
        })

    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
	
       ammo="Knobkierrie",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		--back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
		
        })

    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], {
        --[[body=gear.Adhemar_B_body,
        legs="Samnuha Tights",
        feet=gear.Herc_STP_feet,
        right_ear="Mache Earring +1",]]--
        })

    sets.precast.WS['Dimidiation'].Uncapped = set_combine(sets.precast.WS['Dimidiation'], {
        --[[neck="Caro Necklace",
        waist="Grunfeld Rope",
        waist="Sailfi Belt +1",]]--
        })

    sets.precast.WS['Herculean Slash'] = sets.precast.JA['Lunge']

    sets.precast.WS['Shockwave'] = {
	
        ammo="Knobkierrie",
       -- head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
		hands="Carmine Fin. Ga. +1",
        legs="Aya. Cosciales +2",
		feet="Meghanada Jambeaux +2",
		feet="Herculean Boots", --augments={'Mag. Acc.+27','Weapon Skill Acc.+2','"Treasure Hunter"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		neck="Erra Pendant",
       -- neck="Fotia Gorget",
		left_ear="Digni. Earring",
       -- --right_ear="Moonshade Earring",
		--right_ear="Cessance Earring",
		--left_ear="Sherida Earring",
       -- ring1="Niqmaddu Ring",
		ring2="Epaminondas's Ring",
       -- back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
        waist="Eschan Stone",
		
		--*******************Lunge set below. Need to test shockwave sets at some point--****************************************
		--[[
		ammo="Seething Bomblet +1",
		head={ name="Herculean Helm", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','STR+14','"Mag.Atk.Bns."+10',}},
		body={ name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +2%','"Mag.Atk.Bns."+11',}},
		feet={ name="Herculean Boots", augments={'"Mag.Atk.Bns."+25','Pet: Accuracy+5 Pet: Rng. Acc.+5','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		neck="Deviant Necklace",
		waist="Eschan Stone",
		left_ear="Novio Earring",
		right_ear="Friomisi Earring",
		left_ring="Fenrir Ring",
		right_ring="Acumen Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+2','Damage taken-4%',}},
		]]--
        }

    sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {

        })

    sets.precast.WS['Upheaval'] = sets.precast.WS['Resolution']
    sets.precast.WS['Full Break'] = sets.precast.WS['Shockwave']

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
		head="Taeon Chapeau", --9/10
		body="Taeon Tabard", -- 9/10
        --hands="Regal Gauntlets", --20
        hands="Rawhide Gloves", --15
		legs="Carmine Cuisses +1", --20
        neck="Moonlight necklace", --15
        --left_ear="Halasz Earring", --5
        ring2="Evanescence Ring", --5
        --waist="Rumination Sash", --10
		waist="Audumbla Sash", --10
		--head="Futhark Bandeau +2",
		--body="Futhark Coat +3",--might consider the runeist's coat instead for extra hp
		right_ear="Etiolation Earring",
		--right_ear="Ethereal Earring",
		left_ear="Odnowa Earring +1",
		ring2="Defending Ring",
		back={name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}}
		--94/96 Total SIRD + 10/merits

		----sacrificing quite a bit of dt for SIRD
		--body={ name="Taeon Tabard", augments={'Spell interruption rate down -10%','Phalanx +3',}}, --10
		--feet={ name="Taeon Boots", augments={'Accuracy+25','Spell interruption rate down -10%','Phalanx +3',}},--10
		
	--ammo={name="Staunch Tathlum +1",priority=4},
    
    --body={name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',priority=14}},
    --hands={name="Rawhide Gloves", augments={'HP+50','Accuracy+15','Evasion+20',priority=15}},
	--hands="Regal Gauntlets",
    --legs={name="Carmine Cuisses +1", augments={'Accuracy+12','DEX+12','MND+20',priority=8}},
    --feet={name="Taeon Boots", augments={'DEF+17','Spell interruption rate down -10%','HP+48',priority=11}},
    --neck={name="Moonlight necklace",priority=3},
    --waist={name="Audumbla Sash",priority=2},
    --right_ear={name="Tuisto Earring",priority=15},
    --left_ear={name="Odnowa Earring +1", priority=15},--2MDT
    --left_ring={name="Defending Ring",priority=1},
    --right_ring={name={name="Moonbeam Ring", bag="wardrobe4"},priority=15},
   -- back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
		
		
		
        } -- +10% from merit points

    sets.midcast.Cure = {
        ammo="Staunch Tathlum +1",
        --head="Fu. Bandeau +3",
        body="Vrikodara Jupon", -- 13
        --hands="Buremte Gloves", --(13)
        --legs="Aya. Cosciales +2",
		--legs="Augury Cuisses +1",
        feet="Skaoi Boots", --7
		--feet="Erilaz Greaves +1",
        --neck="Phalaina Locket", -- 4(4)
		--neck="Veisa Collar",
        --left_ear="Roundel Earring", -- 5
		right_ear="Beatific Earring",
        right_ear="Mendi. Earring", -- 5
        ring1="Lebeche Ring", -- 3
        --ring2="Kunaji Ring",
        back="Solemnity Cape", -- 7
		--back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
        waist="Gishdubar Sash", --(10)
		waist="Flume Belt +1",
        }

    sets.midcast['Enhancing Magic'] = {
        --main="Pukulatmuj +1",
        --sub="Pukulatmuj",
        head="Carmine Mask +1",
        --body="Manasa Chasuble",
        --hands="Runeist's Mitons +2",
        legs="Carmine Cuisses +1",
		feet="Turms Leggings +1",
        neck="Melic Torque",
		--neck="Incanter's Torque",
        left_ear="Odnowa Earring +1",		
		--left_ear="Mimir Earring",
        --right_ear="Andoaa Earring",
		--waist="Olympus Sash",
		--back="Merciful Cape",
		ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        --waist="Olympus Sash",
        }

    sets.midcast.EnhancingDuration = {
        --head="Erilaz Galea +1",
        hands="Regal Gauntlets",
        --legs="Futhark Trousers +1",
        }

    sets.midcast['Phalanx'] = set_combine(sets.midcast.SpellInterrupt, {
        --main="Deacon Sword", --4
        --sub="Pukulatmuj +1",
       -- ammo="Staunch Tathlum +1", --(11)
        --head="Fu. Bandeau +2", --7
		--body="Taeon Tabard"
		--hands={ name="Taeon Gloves", augments={'Accuracy+13','Spell interruption rate down -8%','Phalanx +3',}},--3
		--legs={ name="Taeon Tights", augments={'Accuracy+21','Spell interruption rate down -7%','Phalanx +3',}},--3
		--feet={ name="Taeon Boots", augments={'Accuracy+25','Spell interruption rate down -10%','Phalanx +3',}},--3
		--left_ear="Andoaa Earring",
       -- right_ear="Mimir Earring",
		--waist="Olympus Sash",
        --ring1={name="Moonbeam Ring", bag="wardrobe4"},
		--left_ring={name={name="Moonbeam Ring", bag="wardrobe4"}, bag="wardrobe2"},
		--right_ring={name="Chirich Ring +1", bag="wardrobe1"},
       -- back="Merciful Cape",
	   
			ammo="Staunch Tathlum +1",
			--head={ name="Fu. Bandeau +3", 
			head="Taeon Chapeau",
			body="Taeon Tabard", --augments={'"Fast Cast"+5','Phalanx +3',}},
			hands="Taeon Gloves", --augments={'Spell interruption rate down -9%','Phalanx +3',}},
			legs="Taeon Tights", --augments={'Spell interruption rate down -8%','Phalanx +3',}},
			feet="Taeon Boots", --augments={'Spell interruption rate down -9%','Phalanx +3',}},
			neck="Incanter's Torque",
			waist="Olympus Sash",
			left_ear="Mimir Earring",
			right_ear="Andoaa Earring",
			left_ring="Stikini Ring +1",
			right_ring="Stikini Ring +1",
			back="Merciful Cape",
	   
	   
        })
	sets.phalanx2 = set_combine(sets.midcast.SpellInterrupt, {
        --main="Deacon Sword", --4
        --sub="Pukulatmuj +1",
       -- ammo="Staunch Tathlum +1", --(11)
        --head="Fu. Bandeau +2", --7
		--body="Taeon Tabard"
		--hands={ name="Taeon Gloves", augments={'Accuracy+13','Spell interruption rate down -8%','Phalanx +3',}},--3
		--legs={ name="Taeon Tights", augments={'Accuracy+21','Spell interruption rate down -7%','Phalanx +3',}},--3
		--feet={ name="Taeon Boots", augments={'Accuracy+25','Spell interruption rate down -10%','Phalanx +3',}},--3
		--left_ear="Andoaa Earring",
       -- right_ear="Mimir Earring",
		--waist="Olympus Sash",
        --ring1={name="Moonbeam Ring", bag="wardrobe4"},
		--left_ring={name={name="Moonbeam Ring", bag="wardrobe4"}, bag="wardrobe2"},
		--right_ring={name="Chirich Ring +1", bag="wardrobe1"},
       -- back="Merciful Cape",
	   
			ammo="Staunch Tathlum +1",
			--head={ name="Fu. Bandeau +3", 
			head="Taeon Chapeau",
			body="Taeon Tabard", --augments={'"Fast Cast"+5','Phalanx +3',}},
			hands="Taeon Gloves", --augments={'Spell interruption rate down -9%','Phalanx +3',}},
			legs="Taeon Tights", --augments={'Spell interruption rate down -8%','Phalanx +3',}},
			feet="Taeon Boots", --augments={'Spell interruption rate down -9%','Phalanx +3',}},
			neck="Incanter's Torque",
			waist="Olympus Sash",
			left_ear="Mimir Earring",
			right_ear="Andoaa Earring",
			left_ring="Stikini Ring +1",
			right_ring="Stikini Ring +1",
			back="Merciful Cape",	   
        })


    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.SpellInterrupt, {
        --main="Nibiru Faussar", --1
        --sub="Refined Grip +1",
        })

    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {neck="Sacro gorget"})
    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {waist="Gishdubar sash"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {legs="Doyen pants"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'])
    sets.midcast.Shell = sets.midcast.Protect

    sets.midcast['Divine Magic'] = {
        ammo="Yamarang",
        --legs="Rune. Trousers +1",--15
        --neck="Incanter's Torque",
		--left_ear="Divine Earring",--3
		ring1="Stikini Ring +1",--5
        ring2="Stikini Ring +1",--5
		left_ear="Beatific Earring",--4
        waist="Bishop's Sash",
		---------   Total Divine = 34   ---------- 
        }

    sets.midcast.Flash = sets.Enmity
    sets.midcast.Foil = sets.Enmity
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast['Blue Magic'] = {}
    sets.midcast['Blue Magic'].Enmity = sets.Enmity
    sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
    sets.midcast['Blue Magic'].Buff = sets.midcast['Blue Magic'].Buffs
		--ammo={name="Staunch Tathlum +1",priority=4},
		--head={ name="Taeon Chapeau", augments={'Spell interruption rate down -10%',priority=10}},
		--body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',priority=15}},
		--hands="Rawhide Gloves",
		--hands={name="Regal Gauntlets",priority=14},
		--legs="Carmine Cuisses +1",
		--feet={ name="Taeon Boots", augments={'DEF+12','Spell interruption rate down -10%','HP+48',priority=10}},
		--neck={name="Moonlight necklace",priority=4},
		--waist={name="Audumbla Sash",priority=4},
		--right_ear={name="Odnowa Earring",priority=13},
		--left_ear={name="Odnowa Earring +1",priority=13},
		--left_ring={name="Defending Ring",priority=4},
		--right_ring="Moonlight Ring",
		--back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	
	--}
	
	--cocoon/refueling are not affected by enhancing modifiers
	sets.midcast['Blue Magic'].Buffs = { --sets.midcast.SpellInterrupt
	
		ammo={name="Staunch Tathlum +1",priority=4}, --11%
		head="Taeon Chapeau", --9
		--body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',priority=15}},
		hands="Rawhide Gloves", --15%
		--hands={name="Regal Gauntlets",priority=14},
		legs="Carmine Cuisses +1", --20%
		feet="Taeon Boots", --9%
		neck={name="Moonlight necklace",priority=4}, --15%
		waist={name="Audumbla Sash",priority=4}, --10%
		right_ear={name="Odnowa Earring",priority=13},
		left_ear={name="Odnowa Earring +1",priority=13},
		ring2={name="Defending Ring",priority=4},
		--right_ring="Moonlight Ring",
		ring1="Evanescence Ring", --5%
		--back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}},

	
		--head={ name="Fu. Bandeau +2", augments={'Enhances "Battuta" effect',}},
	--	--body="Runeist's Coat +3",
		--hands="Turms Mittens",
		----legs="Eri. Leg Guards +1",
		--feet="Turms Leggings +1",
		--neck={ name="Futhark Torque +1", augments={'Path: A',}},
		--waist="Flume Belt +1",
		--left_ear="Etiolation Earring",
		--right_ear="Eabani Earring",
		----left_ring={name="Moonbeam Ring", bag="wardrobe4"},
		--right_ring="Defending Ring",
		----back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},	
	}


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
       -- --sub="Mensch Strap +1",
       -- --ammo="Homiliary",
		----ammo="Vanir Battery",
		--ammo="Staunch Tathlum +1",
		----head="Rawhide Mask",
		--head="Nyame Helm",
       -- --body="Futhark Coat +3",
		--body="Runeist's Coat +3",
       -- hands="Turms Mittens +1",
       -- --legs="Turms Subligar +1",
		--legs="Carmine Cuisses +1",
       -- feet="Turms Leggings +1",
       -- neck="Bathy Choker +1",
       -- right_ear="Infused Earring",
       -- left_ear="Odnowa Earring +1",
       -- --ring1={name="Chirich Ring +1", bag="wardrobe3"},
       -- --ring2={name="Chirich Ring +1", bag="wardrobe4"},
		--ring1="Defending Ring",
		--ring2={name="Moonbeam Ring", bag="wardrobe4"},
       -- back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
       -- waist="Flume Belt +1",
		
    ammo="Staunch Tathlum +1",
    head="Nyame helm",
    body="Nyame mail",
    hands="Nyame gauntlets",
    legs="Nyame flanchard",
    --feet={ name="Herculean Boots", augments={'Sklchn.dmg.+1%','Attack+7','"Refresh"+2','Accuracy+9 Attack+9','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
    --neck={ name="Futhark Torque +1", augments={'Path: A',}},
	feet="Nyame sollerets",
    waist="Flume Belt +1",
    left_ear="Odnowa Earring +1",
    right_ear="Odnowa Earring",
    ring2="Defending Ring",
    ring1="Moonlight Ring",
    back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},

		
		
        }

    sets.idle.DT = {--31dt, 21(50)ptd, 33mdt(caps with shellV), 3027 HP
		
        ammo="Staunch Tathlum +1",--2DT
		head="Nyame Helm",
        body="Nyame Mail", --8/8
        --hands="Nyame Gauntlets", --4/4
        legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		hands={name="Turms Mittens +1",priority=15},
		--legs={name="Eri. Leg Guards +1",priority=15},--7PDT
		feet="Turms Leggings +1",
		--neck={ name="Futhark Torque +1", augments={'Path: A',}},--6DT
		waist="Flume Belt +1",--4PDT
		--[[left_ear="Etiolation Earring",
		right_ear="Eabani Earring",]]--
		left_ear={name="Odnowa Earring +1", priority=15},--2MDT
		right_ear="tuisto Earring",
		ring1="Moonlight Ring",--4DT
		ring2="Defending Ring",--10DT
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},--10PDT
	
      --  --sub="Mensch Strap +1", --5/0
      --  ammo="Staunch Tathlum +1", --3/3
      --  head="Fu. Bandeau +2", --6/0
      --  body="Runeist's Coat +3",
      --  --hands="Turms Mittens +1",
		--hands="Turms Mittens +1",
      --  --legs="Turms Subligar +1",
		--legs="Erilaz Leg Guards +1",
      --  --feet="Turms Leggings +1",
		--feet="Turms Leggings +1",
      --  --neck="Futhark Torque +1", --6/6
		--neck="Wiglen Gorget",
      --  left_ear="Etiolation Earring",
      --  right_ear="Infused Earring", --0/2
      --  --ring1={name="Moonbeam Ring", bag="wardrobe4"}, --5/5
		--ring1={name="Moonbeam Ring", bag="wardrobe4"},
      --  ring2="Defending Ring", --10/10
      --  back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
      --  waist="Flume Belt +1", --4/0
		
		--	ammo="Staunch Tathlum +1",
		--	head={ name="Fu. Bandeau +2", augments={'Enhances "Battuta" effect',}},
		--	body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
		--	hands="Turms Mittens +1",
		--	legs="Carmine Cuisses +1",
		--	feet="Turms Leggings +1",
		--	neck={ name="Futhark Torque +1", augments={'Path: A',}},
		--	waist="Flume Belt +1",
		--	left_ear="Odnowa Earring +1",
		--	right_ear="Tuisto Earring",
		--	left_ring="Defending Ring",
		--	right_ring={name="Moonbeam Ring", bag="wardrobe4"},
		--	back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
		
		
        }

    sets.idle.Refresh = set_combine(sets.idle, {
        --ammo="Homiliary",
        --head=gear.Herc_Idle_head,
		head="Rawhide Mask",
        --body="Runeist's Coat +3",
        hands="Regal Gauntlets",
        legs="Rawhide Trousers",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        })

    sets.idle.Town = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1",
        --body="Councilor's Garb",
        neck="Futhark Torque +1",
		legs="Carmine Cuisses +1"
        })

    sets.Kiting = {legs="Carmine Cuisses +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.Knockback = {back="Repulse Mantle"}


--PDT set is balanced and allows for switching to dd gear with same grip
    sets.defense.PDT = {--31dt, 21(50)ptd, 33mdt(caps with shellV), 3027 HP
	
        ammo="Staunch Tathlum +1",--2DT
		--head={ name="Fu. Bandeau +2", augments={'Enhances "Battuta" effect',}},
		head="Nyame Helm",
        body="Nyame Mail", --8/8
        hands="Nyame Gauntlets", --4/4
        legs="Nyame Flanchard",
		feet="Nyame Sollerets",--
		--neck={ name="Futhark Torque +1", augments={'Path: A',}},--6DT
		waist="Flume Belt +1",--4PDT
		--left_ear="Tuisto Earring",
		--[[left_ear="Etiolation Earring",
		]]--
		right_ear="Odnowa Earring",
		left_ear="Odnowa Earring +1",--2MDT
		--right_ear="tuisto Earring",
		ring1="Moonlight Ring",--4DT
		ring2="Defending Ring",--10DT
		--back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},--10PDT
		back="Moonbeam cape",
        }

--Parry Set
    sets.defense.Parry = {--22DT, 16(38)PDT, 2MDT(43), HP3078
	
	
		--sub="Refined Grip +1",
        ammo="Staunch Tathlum +1",--2DT
		--head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},--5PDT
		head="Nyame Helm",
		--body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},--9DT
		body="Nyame Mail",
		hands="Turms Mittens +1",
		legs="Rawhide Trousers",--7PDT
		feet="Turms Leggings +1",
		--neck={ name="Futhark Torque +1", augments={'Path: A',}},--6DT
		waist="Flume Belt +1",--4PDT
		--right_ear="Tuisto Earring",
		--right_ear="Eabani Earring",
		left_ear="Odnowa Earring +1",--2MDT
		right_ear="Odnowa Earring +1",
		ring1="Moonlight Ring",--4DT
		ring2="Defending Ring",--10DT
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}},		
        }






--MDT set is more focused on MEVA (Need to figure a way to work Turms Head in without losing pdt cap)
    sets.defense.MDT = {--22DT, 21PDT(43), 5MDT(27+ShellV=46), HP3027
		
		ammo="Staunch Tathlum +1",--2DT
		head="Nyame Helm",
		body="Nyame mail",
		hands="Turms Mittens +1",
		--legs="Rune. Trousers +2",
		--legs="Eri. Leg Guards +1",--7PDT
		feet="Turms Leggings +1",
		--neck="Futhark Torque +1",--6DT
		waist="Carrier's sash", --4PDT
		--right_ear="Tuisto Earring",
		--left_ear="Etiolation Earring",
		--right_ear="Genmei Earring",
		--right_ear="Eabani Earring",
		left_ear="Odnowa Earring +1",--2MDT
		--right_ear="Tuisto Earring",
		right_ear="Odnowa Earring",
		ring1="Moonlight Ring",--4DT
		ring2="Defending Ring",--10DT
		back="Reiki cloak",
		--back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},--10PDT


        }

    sets.defense.HP = {
        ammo="Staunch Tathlum +1",
		head="Nyame Helm",
        body="Nyame Mail", --8/8
        --hands="Nyame Gauntlets", --4/4
        legs="Nyame Flanchard",
		--feet="Nyame Sollerets",
		hands="Turms Mittens +1",
		--legs="Eri. Leg Guards +1",
		feet="Turms Leggings +1",
		--neck={ name="Futhark Torque +1", augments={'Path: A',}},
		waist="CArrier's sash",
		Right_ear="Odnowa Earring",
		left_ear="Odnowa Earring +1",
		ring1="Moonlight Ring",
		ring2="Defending Ring",
		back="Moonbeam cape",
		--back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},	
        }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
        --sub="Alber Strap",
		sub="Utu Grip", -- Leaving Utu grip in engaged set. May use different grips in MDT/PDT sets
		--ammo="Coiste Bodhar",
		--head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		--body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		--hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		----legs="Meg. Chausses +2",
		--legs="Samnuha Tights",
		----feet={ name="Herculean Boots", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','Accuracy+8','Attack+7',}},
		--feet={ name="Herculean Boots", augments={'Pet: Phys. dmg. taken -1%','"Mag.Atk.Bns."+6','"Store TP"+9','Accuracy+1 Attack+1',}},
		----neck="Asperity Necklace",
		--neck="Anu Torque",
		----waist="Ioskeha Belt",
		--waist="Sailfi Belt +1",
		--left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		--left_ring="Niqmaddu Ring",
		--right_ring="Epona's Ring",
		--back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
		
			ammo="Coiste Bodhar",
			head="Nyame helm",
			--body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
			body="Ayanmo Corazza +2",
			hands="Adhemar Wrist. +1",
			--legs={ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}},
			legs="Nyame flanchard",
			--feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','STR+2',}},
			feet="Herculean Boots",
			neck="Anu Torque",
		    waist="Ioskeha Belt +1",
			left_ear="Sherida Earring",
			--right_ear="Telos Earring",
			right_ring="Niqmaddu Ring",
			left_ring="Epona's Ring",
			back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Magic dmg. taken-10%',}},
		
		
        }

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        head="Nyame helm",
			--body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
			body="Ayanmo Corazza +2",
			hands="Adhemar Wrist. +1",
			--legs={ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}},
			legs="Nyame flanchard",
			--feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','STR+2',}},
			feet="Herculean Boots",
			--neck="Anu Torque",
		    waist="Ioskeha Belt +1",
			left_ear="Sherida Earring",
			right_ear="Telos Earring",
			right_ring="Niqmaddu Ring",
			--left_ring="Epona's Ring",
			back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Magic dmg. taken-10%',}},
        })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
        head="Nyame helm",
			--body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
			body="Ayanmo Corazza +2",
			hands="Adhemar Wrist. +1",
			--legs={ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}},
			legs="Nyame flanchard",
			--feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','STR+2',}},
			feet="Herculean Boots",
			--neck="Anu Torque",
		    waist="Ioskeha Belt +1",
			left_ear="Sherida Earring",
			right_ear="Telos Earring",
			right_ring="Niqmaddu Ring",
			--left_ring="Epona's Ring",
			back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Magic dmg. taken-10%',}},
        })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        head="Nyame helm",
			--body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
			body="Ayanmo Corazza +2",
			hands="Adhemar Wrist. +1",
			--legs={ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}},
			legs="Nyame flanchard",
			--feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','STR+2',}},
			feet="Herculean Boots",
			--neck="Anu Torque",
		    waist="Ioskeha Belt +1",
			left_ear="Sherida Earring",
			right_ear="Telos Earring",
			right_ring="Niqmaddu Ring",
			left_ring="Epona's Ring",
			back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Magic dmg. taken-10%',}},
        })

    sets.engaged.STP = set_combine(sets.engaged, {
        --[[head="Aya. Zucchetto +2",
        body="Ashera Harness",
        feet="Carmine Greaves +1",
        right_ear="Dedition Earring",
        ring1={name="Chirich Ring +1", bag="wardrobe3"},
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
        waist="Kentarch Belt +1",]]--
        })

    sets.engaged.Aftermath = set_combine(sets.engaged,{
	--	head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		--body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		--legs="Samnuha Tights",
        --body="Ashera Harness",
        neck="Anu Torque",
        left_ear="Sherida Earring",
        --right_ear="Dedition Earring",
		ring2="Ilabrat Ring",
        --ring1={name="Chirich Ring +1", bag="wardrobe3"},
        --ring2={name="Chirich Ring +1", bag="wardrobe4"},
        --waist="Kentarch Belt +1",
		--waist="Windbuffet Belt",
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

--PDT based Hybrid Tanking Set 
    sets.Hybrid = {
	
	head="Nyame helm",
			--body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
			body="Ayanmo Corazza +2",
			hands="Turms Mittens +1",
			--hands="Adhemar Wrist. +1",
			--legs={ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}},
			legs="Nyame flanchard",
			--feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','STR+2',}},
			feet="Herculean Boots",
			--neck="Anu Torque",
		    waist="Ioskeha Belt +1",
			left_ear="Sherida Earring",
			right_ear="Telos Earring",
			right_ring="Niqmaddu Ring",
			left_ring="Epona's Ring",
			back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Magic dmg. taken-10%',}},

	
	
    --    --head=gear.Adhemar_D_head,
	--	head="Ayanmo Zucchetto +2", --3
    --    --body="Futhark Coat +3", --9
	--	body="Ayanmo Corazza +2", --6
	 -- 0
    --    neck="Futhark Torque +1", --6/6
	--	legs="Meghanada Chausses +2",--6
    --    ring1={name="Moonbeam Ring", bag="wardrobe4"}, --7
    --    ring2="Defending Ring", --10
	--	--possible changes
	--	ammo="Staunch Tathlum +1", --2
	--	neck="Anu Torque", 
	--	feet="Meghanada Jambeaux +2", --3
	--	--right_ear="Odnowa Earring +1", -- not much of a point if weaponskilling
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.Hybrid)
	sets.engaged.PDT = set_combine(sets.defense.PDT)
--[[
    sets.engaged.Aftermath.DT = {
        head="Aya. Zucchetto +2",
        feet="Carmine Greaves +1",
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        ring1={name="Moonbeam Ring", bag="wardrobe4"},
        ring2="Defending Ring",
        waist="Kentarch Belt +1",
        }
]]

    sets.engaged.Aftermath.DT = set_combine(sets.engaged.DT,{
        --head="Aya. Zucchetto +2",
        --body="Ashera Harness",
        --hands=gear.Adhemar_A_hands,
        --legs="Meg. Chausses +2",
        --feet=gear.Herc_STP_feet,
		feet="Herculean Boots",-- augments={'Pet: Phys. dmg. taken -1%','"Mag.Atk.Bns."+6','"Store TP"+9','Accuracy+1 Attack+1',}},
        --neck="Futhark Torque +1",
        left_ear="Sherida Earring",
        right_ear="Dedition Earring",
        --ring1={name="Moonbeam Ring", bag="wardrobe4"},
        --ring2="Defending Ring",
        back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
        --waist="Sailfi Belt +1",]]--
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Purity Ring", --20
        --ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        --waist="Gishdubar Sash", --10
        }

    sets.Embolden = set_combine(sets.midcast.EnhancingDuration, {back="Evasionist's Cape"})
    sets.Obi = {}--not sure what this is for****
    sets.CP = {back="Mecistopins Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

    sets.Epeolatry = {main="Epeolatry"}
    sets.Lionheart = {main="Lionheart"}
    sets.Aettir = {main="Aettir"}
    sets.GreatAxe = {main="Hepatizon Axe"}
	
	
	sets.TreasureHunter = { 
        --head="White rarab cap +1", 
		--legs="Volte Hose",
        --waist="Chaac Belt",
		--body={ name="Herculean Vest", augments={'STR+2','Attack+1','"Treasure Hunter"+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
     }
	

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
        add_to_chat(167, 'Stopped due to status.')
        eventArgs.cancel = true
        return
    end
	if rune_enchantments:contains(spell.english) then
        eventArgs.handled = true
    end
    if state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.current == 'HP' then
        currentSpell = spell.english
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            equip(sets.precast.FC.HP)
        elseif spell.action_type == 'Ability' then
            equip(sets.Enmity.HP)
            equip(sets.precast.JA[currentSpell])
        end
    else
        if spell.action_type == 'Ability' then
            equip(sets.Enmity)
            equip(sets.precast.JA[spell])
        end
    end
    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
--            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end
    if spell.english == 'Valiance' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Vallation" <me>')
            eventArgs.cancel = true
            return
        elseif spell.english == 'Valiance' and buffactive['vallation'] then
            cast_delay(0.2)
            send_command('cancel Vallation') -- command requires 'cancel' add-on to work
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.current == 'HP' and spell.english ~= "Phalanx" then
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            if spell.english == 'Flash' or spell.english == 'Foil' or spell.english == 'Stun'
                or blue_magic_maps.Enmity:contains(spell.english) then
                equip(sets.Enmity.HP)
            elseif spell.skill == 'Enhancing Magic' then
                equip(sets.midcast.EnhancingDuration)
            end
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if state.DefenseMode.value == 'None' then
        if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
        if spell.english == 'Phalanx' and buffactive['Embolden'] then
            equip(sets.midcast.EnhancingDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if spell.name == 'Rayke' and not spell.interrupted then
        send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
        send_command('wait '..rayke_duration..';input /echo [Rayke just wore off!];')
    elseif spell.name == 'Gambit' and not spell.interrupted then
        send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
        send_command('wait '..gambit_duration..';input /echo [Gambit just wore off!];')
    end
end

---------------------------------------------------------------------------------------------------------------------
----------Added TreasureHunter myself
--------------------------------------------------------------------------------------------------------------------
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

--[[-- Check for various actions that we've specified in user code as being used with TH gear.
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
--]]

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.Charm.current)
    classes.CustomDefenseGroups:append(state.Knockback.current)
    classes.CustomDefenseGroups:append(state.Death.current)

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.Charm.current)
    classes.CustomMeleeGroups:append(state.Knockback.current)
    classes.CustomMeleeGroups:append(state.Death.current)
end

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "terror" then
        if gain then
            --equip(sets.defense.PDT)
			equip(sets.defense)  --May have to switch back to .pdt
        end
    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Embolden' then
        if gain then
            equip(sets.Embolden)
            disable('head','legs','back')
        else
            enable('head','legs','back')
            status_change(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end

    if buff == 'Battuta' and not gain then
        status_change(player.status)
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub','ranged','ammo')
    else
        enable('main','sub','ranged','ammo')
    end

    equip(sets[state.WeaponSet.current])

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
	--check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
    handle_equipping_gear(player.status)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Knockback.value == true then
        idleSet = set_combine(idleSet, sets.defense.Knockback)
    end
    --if state.CP.current == 'on' then
    --    equip(sets.CP)
    --    disable('back')
    --else
    --    enable('back')
    --end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Epeolatry"
        and state.DefenseMode.value == 'None' then
        if state.HybridMode.value == "DT" then
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.DT)
        else
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
        end
    end
    if state.Knockback.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Knockback)
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Battuta'] then
        --defenseSet = set_combine(defenseSet, sets.defense.Parry)
		defenseSet = set_combine(defenseSet,{
			hands="Turms Mittens +1",
			legs="Erilaz Leg Guards +1",
			back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}}, --'Mag. Evasion+10',--
		})
    end
    if state.Knockback.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Knockback)
    end

    return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local r_msg = state.Runes.current
    local r_color = ''
    if state.Runes.current == 'Ignis' then r_color = 167
    elseif state.Runes.current == 'Gelus' then r_color = 210
    elseif state.Runes.current == 'Flabra' then r_color = 204
    elseif state.Runes.current == 'Tellus' then r_color = 050
    elseif state.Runes.current == 'Sulpor' then r_color = 215
    elseif state.Runes.current == 'Unda' then r_color = 207
    elseif state.Runes.current == 'Lux' then r_color = 001
    elseif state.Runes.current == 'Tenebrae' then r_color = 160 end

    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local am_msg = '(' ..string.sub(state.AttackMode.value,1,1).. ')'

    local ws_msg = state.WeaponskillMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Knockback.value == true then
        msg = msg .. ' Knockback Resist |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(r_color, string.char(129,121).. '  ' ..string.upper(r_msg).. '  ' ..string.char(129,122)
        ..string.char(31,210).. ' Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002).. ' |'
        ..string.char(31,207).. ' WS' ..am_msg.. ': ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060)
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002).. ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002).. ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, action, spellMap)
    if spell.type == 'WeaponSkill' and state.AttackMode.value == 'Uncapped' then
        return "Uncapped"
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
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

--function check_gear()
 --   if no_swap_gear:contains(player.equipment.left_ring) then
   --     disable("ring1")
    --else
--        enable("ring1")
  --  end
    --if no_swap_gear:contains(player.equipment.right_ring) then
--        disable("ring2")
  --  else
    --    enable("ring2")
--    end
--end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book: (set, book)
    if player.sub_job == 'BLU' then
        set_macro_page(1, 22)
    elseif player.sub_job == 'DRK' then
        set_macro_page(1, 22)
    elseif player.sub_job == 'WHM' then
        set_macro_page(1, 22)
    else
        set_macro_page(1, 22)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end