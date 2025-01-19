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

include('SendCommands.lua')

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

    rayke_duration = 45
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
    state.OffenseMode:options('DT', 'Nyame', 'ResistDeath', 'Hybrid') --,'Normal','STP',
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('DT', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'Refresh')
    state.PhysicalDefenseMode:options('PDT', 'Parry', 'HP')
    state.MagicalDefenseMode:options('MDT')

    state.Knockback = M(false, 'Knockback')
    state.WeaponSet = M{['description']='Weapon Set', 'Epeolatry', 'Axe' , 'Reikiko', 'GreatAxe'} -- 'Lionheart' 'Agwu'
    state.AttackMode = M{['description']='Attack','Capped','Uncapped',}
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
	--send_command('bind @k gs c toggle Knockback')
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
	
	--gear.enmity_jse_back = {name="Ogma's cape",augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}}
	--gear.stp_jse_back = {name="Ogma's cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	--gear.da_jse_back = {name="Ogma's cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
	send_command('unbind !-')
	send_command('unbind !=')
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
		 ammo="Sapience Orb", --2
	     head="Nyame Helm",
		 --neck="Futhark Torque +2",
		 neck="Unmoving Collar +1", --10
		 ear1="Odnowa Earring +1", 
		 ear2="Cryptic Earring", --4
	     body="Adamantite Armor", --10
		 hands="Futhark Mitons +3", --6 Kurys Gloves?
		 ring1="Eihwaz Ring", --4
		 ring2="Begrudging Ring", --5
		 back="Reiki Cloak", --6
		 waist="Plat. Mog. Belt", --
		 legs="Eri. Leg Guards +3", --13
		 feet="Erilaz Greaves +3" --7
	}
		--Enmity +67
	
    sets.Enmity.HP = {
		ammo="Staunch Tathlum +1",
        head="Nyame Helm",
		--neck="Futhark Torque +2",
		neck="Unmoving Collar +1",
		ear1="Odnowa Earring +1",
		ear2="Cryptic Earring",
        body="Runeist Coat +3",
		hands="Futhark Mitons +3",
		ring1="Moonlight Ring",
		ring2="Moonlight Ring",
        back="Moonbeam Cape",
		waist="Plat. Mog. Belt",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3"
	}	

    sets.precast.JA['Vallation'] = set_combine(sets.Enmity,{body="Runeist Coat +3",legs="Futhark Trousers +3"})
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = set_combine(sets.Enmity,{feet="Runeist Bottes +2"})
    sets.precast.JA['Battuta'] = set_combine(sets.Enmity,{head="Futhark Bandeau +3"})
    sets.precast.JA['Liement'] = set_combine(sets.Enmity,{body="Futhark Coat +3"})
    sets.precast.JA['Gambit'] = set_combine(sets.Enmity,{hands="Runeist Mitons +3"})
    sets.precast.JA['Rayke'] = set_combine(sets.Enmity,{feet="Futhark Boots +3"})
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity,{body="Futhark Coat +3"})
    sets.precast.JA['Swordplay'] = set_combine(sets.Enmity,{hands="Futhark Mitons +3"})
    sets.precast.JA['Embolden'] = set_combine(sets.Enmity,{})
    sets.precast.JA['One For All'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Last Resort'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    sets.precast.JA['Vallation'].DT = set_combine(sets.Enmity.HP,{body="Runeist Coat +3", legs="Futhark Trousers +3"})
    sets.precast.JA['Valiance'].DT = sets.precast.JA['Vallation'].DT
    sets.precast.JA['Pflug'].DT = set_combine(sets.Enmity.HP,{feet="Runeist Bottes +2"})
    sets.precast.JA['Battuta'].DT = set_combine(sets.Enmity.HP,{head="Futhark Bandeau +3"})
    sets.precast.JA['Liement'].DT = set_combine(sets.Enmity.HP,{body="Futhark Coat +3"})
    sets.precast.JA['Gambit'].DT = set_combine(sets.Enmity.HP,{hands="Runeist Mitons +3"})
    sets.precast.JA['Rayke'].DT = set_combine(sets.Enmity.HP,{feet="Futhark Boots +3"})
    sets.precast.JA['Elemental Sforzo'].DT = set_combine(sets.Enmity.HP,{body="Futhark Coat +3"})
    sets.precast.JA['Swordplay'].DT = set_combine(sets.Enmity.HP,{hands="Futhark Mitons +3"})
    sets.precast.JA['Embolden'].DT = set_combine(sets.Enmity.HP,{})
    sets.precast.JA['One For All'].DT = set_combine(sets.Enmity.HP,{})
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.HP, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.HP, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.HP, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.HP, {})
	sets.precast.JA['Last Resort'].DT = set_combine(sets.Enmity.HP, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.HP, {})
	sets.precast.JA['Animated Flourish'].DT = set_combine(sets.Enmity.HP, {})

    sets.precast.JA['Lunge'] = {
	ammo="Seething Bomblet +1",
	head="Agwu's Cap",
    body="Agwu's Robe",
    hands="Agwu's Gages",
    legs="Agwu's Slops",
    feet="Agwu's Pigaches",
    neck="Baetyl Pendant",
    waist="Orpheus's Sash",
    left_ear="Hermetic Earring",
    right_ear="Friomisi Earring",
    ring1="Shiva Ring +1",
    ring2="Mujin Band",
	--back="Argocham. Mantle",
    back="Evasionist's Cape",
	}

    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    
	sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea +3",neck="Incanter's Torque",ring1={name="Stikini Ring +1", bag="wardrobe2"},ring2={name="Stikini Ring +1", bag="wardrobe5"},legs="Rune. Trousers +2"}
    sets.precast.JA['Vivacious Pulse']['Ignis'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Gelus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Flabra'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tellus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Sulpor'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Unda'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Lux'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tenebrae'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	
	sets.precast.Waltz = {ammo="Yamarang",
        head="Carmine Mask +1",
		neck="Unmoving Collar +1",
		--ear1="Enchntr. Earring +1",
		--ear2="Handler's Earring +1",
		ring2="Defending Ring",
        back="Moonbeam Cape",
		waist="Chaac Belt",
		--legs="Dashing Subligar",
	}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
    sets.precast.Step = {}
		
	sets.precast.JA['Violent Flourish'] = {}
	

    -- Fast cast sets for spells
    sets.precast.FC = {--3101hp
        ammo="Sapience Orb", --2  
		head="Rune. Bandeau +3",
		body="Erilaz Surcoat +3",
		hands="Leyline Gloves",
		legs="Agwu's Slops",
		feet="Carmine Greaves +1",
		neck="Moonlight Necklace", --orunmila's torque
		waist="Carrier's sash",
		Right_ear="Etiolation Earring",
		Left_ear="Odnowa Earring +1", --enchanter?
		left_ring="Kishar Ring",
		right_ring="Defending Ring", --rahab?
		back={name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}}
			
		-----------   Total FC=54   ----------------------------
        }

    sets.precast.FC.HP = set_combine(sets.precast.FC, {
		ammo="Staunch Tathlum +1",
        head="Rune. Bandeau +3",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
        body="	 +3",
		ring1="Moonlight Ring",
		ring2="Moonlight Ring",
        --back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
		back={name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},
		waist="Plat. Mog. Belt",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3"
		})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash",
		legs="Futhark Trousers +3"
	})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {--[[ammo="Impatiens",]] --[[right_ear="Mendi. Earring"]]})

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		neck="Magoraga Beads",
		ring1="Lebeche Ring",
        })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Erilaz Earring +2",
		left_ring="Regal Ring",
		right_ring="Cornelia's Ring",
		--back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, 
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}, --replace if inventory allows
	}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        --ammo="Seeth. Bomblet +1",
        --body=gear.Adhemar_B_body,
		ear1="Telos Earring",
        hands="Gazu Bracelets +1",
		ring1="Moonlight Ring",
        ring2={name="Chirich Ring +1", bag="wardrobe5"},
		--legs="Meg. Chausses +2",
        --right_ear="Telos Earring",]]
        })

    sets.precast.WS.Uncapped = set_combine(sets.precast.WS, {
        --ammo="Seeth. Bomblet +1",
        })

    sets.precast.WS.Uncapped.Acc = set_combine(sets.precast.WS.Acc, {
        --ammo="Seeth. Bomblet +1",
        })


    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		head="Adhemar Bonnet +1",
		right_ear="Sherida Earring",
		body="Adhemar Jacket +1",
		hands="Adhemar Wrist. +1",
		right_ring="Niqmaddu Ring",
		--back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}, --replace if inventory allows
		legs="Meg. Chausses +2",
		feet="Nyame Sollerets",
	})

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {
        legs="Nyame Flanchard",
        left_ear="Telos Earring",
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
		waist="Grunfeld Rope",
		right_ear="Sherida Earring",
		--right_ring="Ilabrat Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
		
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

    sets.precast.WS['Shockwave'] = set_combine(sets.precast.WS, {
        ammo="Perfect Lucky Egg",
		head="Volte Cap",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Volte Boots",
		--neck={ name="Futhark Torque +2", augments={'Path: A',}},
		neck="Fotia Gorget",
		waist="Chaac Belt",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		--back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}, --Replace if inventory allows
		})	

    sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {

        })

    sets.precast.WS['Upheaval'] = sets.precast.WS['Resolution']
    sets.precast.WS['Full Break'] = sets.precast.WS['Shockwave']

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11%
		head="Erilaz Galea +3", --20%
		--neck="Futhark Torque +2", 
		neck="Moonlight Necklace", --15%
		ear1="Odnowa Earring +1",
		ear2="Cryptic Earring",
		body="Adamantite Armor",
		hands="Regal Gauntlets", --10%
		ring1="Moonlight Ring",
		ring2="Defending Ring",
		back={name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},
		waist="Audumbla Sash", --10%
		legs="Carmine Cuisses +1", --20%
		feet="Erilaz Greaves +3" 
    } -- 96+10% from merit points

    sets.midcast.Cure = {
		ammo="Staunch Tathlum +1",
		neck="Sacro Gorget",
		ear1="Mendi. Earring",
		ear2="Odnowa Earring +1",
        body="Vrikodara Jupon",
		ring1="Lebeche Ring",
        back="Solemnity Cape",
		waist="Sroda Belt",
		legs="Carmine Cuisses +1",
		feet="Skaoi Boots"
		}
		

  sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,{
		ammo="Staunch Tathlum +1",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
		hands="Regal Gauntlets",
		legs="Futhark Trousers +3",
		feet="Turms Leggings +1",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Andoaa Earring",
		right_ear="Mimir Earring",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		ring2={name="Stikini Ring +1", bag="wardrobe5"},
		back={name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},
		})

    sets.midcast.EnhancingDuration = { 
        head="Erilaz Galea +3",
        hands="Regal Gauntlets",
        legs="Futhark Trousers +3",	
        }

    sets.midcast['Phalanx'] = set_combine(sets.midcast.SpellInterrupt, {
			head="Fu. Bandeau +3", 
			body="Herculean Vest",
			hands="Herculean Gloves",
			legs="Taeon Tights", --augments={'Spell interruption rate down -8%','Phalanx +3',}},
			feet="Taeon Boots", --augments={'Spell interruption rate down -9%','Phalanx +3',}},
		})
		
	sets.phalanx2 = set_combine(sets.midcast.SpellInterrupt, {
			head="Fu. Bandeau +3", 
			body="Herculean Vest",
			hands="herculean Gloves",
			legs="Herculean Trousers", --augments={'Spell interruption rate down -8%','Phalanx +3',}},
			feet="Herculean Boots", --augments={'Spell interruption rate down -9%','Phalanx +3',}},	   
        })

	sets.phalanx = sets.phalanx2

    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.SpellInterrupt, {
        --main="Nibiru Faussar", --1
        --sub="Refined Grip +1",
        })

    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'],{head="Rune. Bandeau +3",ear2="Erilaz Earring +2", hands="Regal Gauntlets", waist="Sroda Belt",}) 
    	
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'],{head="Erilaz Galea +3",hands="Regal Gauntlets", waist="Gishdubar Sash",}) 

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
    
	sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration)
    
	sets.midcast.Shell = sets.midcast.Protect

    sets.midcast['Divine Magic'] = {
        ammo="Yamarang",
        --legs="Rune. Trousers +2",--15
        --neck="Incanter's Torque",
		--left_ear="Divine Earring",--3
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		ring2={name="Stikini Ring +1", bag="wardrobe5"},
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
	sets.midcast['Blue Magic'].Buffs = sets.midcast.SpellInterrupt
	
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Nyame helm",
		neck="Unmoving Collar +1",
		--neck={ name="Futhark Torque +2", augments={'Path: A',}},
		body="Erilaz Surcoat +3",
		hands="Nyame gauntlets",
		legs="Carmine Cuisses +1",
		feet="Nyame sollerets",
		waist="Plat. Mog. Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Erilaz Earring +2",
		ring1="Moonlight Ring",
		ring2="Defending Ring",
		--back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
		back="Reiki Cloak",
	}

    sets.idle.DT = {--31dt, 21(50)ptd, 33mdt(caps with shellV), 3027 HP
		
        ammo="Staunch Tathlum +1",--2DT
		head="Nyame Helm",
        --neck={ name="Futhark Torque +2", augments={'Path: A',}},--6DT
		neck="Unmoving Collar +1",
		left_ear={name="Odnowa Earring +1", priority=15},--2MDT
		right_ear="Erilaz Earring +2",
		body="Nyame Mail", --8/8
        --body="Futhark Coat +3",
		hands="Regal Gauntlets",
		ring1="Moonlight Ring",--4DT
		ring2="Defending Ring",--10DT
		--back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},--10PDT
		back="Reiki Cloak",
		waist="Plat. Mog. Belt",
		legs={name="Eri. Leg Guards +3",priority=15},--7PDT
		feet="Erilaz Greaves +3",
		}

    sets.idle.Refresh = set_combine(sets.idle, {
        ammo="Homiliary",
		head="Rawhide Mask",
        body="Runeist Coat +3",
        hands="Regal Gauntlets",
        --legs="Rawhide Trousers",
		ring1={name="Stikini Ring +1", bag="wardrobe2"},
		ring2={name="Stikini Ring +1", bag="wardrobe5"},
		waist="Fucho-no-obi",
        })

    sets.idle.Town = set_combine(sets.idle, {
		legs="Carmine Cuisses +1"
        })

    sets.Kiting = {legs="Carmine Cuisses +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    --sets.defense.Knockback = {back="Repulse Mantle"}


--PDT set is balanced and allows for switching to dd gear with same grip
    sets.defense.PDT = {--31dt, 21(50)ptd, 33mdt(caps with shellV), 3027 HP
	
        ammo="Staunch Tathlum +1",--2DT
		--head={ name="Fu. Bandeau +2", augments={'Enhances "Battuta" effect',}},
		head="Nyame Helm",
        body="Nyame Mail", --8/8
        hands="Nyame Gauntlets", --4/4
        legs="Eri. Leg Guards +3",
		feet="Nyame Sollerets",--
		--neck={ name="Futhark Torque +2", augments={'Path: A',}},--6DT
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
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
		--legs="Rawhide Trousers",--7PDT
		feet="Turms Leggings +1",
		--neck={ name="Futhark Torque +2", augments={'Path: A',}},--6DT
		waist="Plat. Mog. Belt",
		--right_ear="Tuisto Earring",
		--right_ear="Eabani Earring",
		left_ear="Odnowa Earring +1",--2MDT
		right_ear="Odnowa Earring",
		ring1="Moonlight Ring",--4DT
		ring2="Defending Ring",--10DT
		--back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}},	--need
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
        }






--MDT set is more focused on MEVA (Need to figure a way to work Turms Head in without losing pdt cap)
    sets.defense.MDT = {--22DT, 21PDT(43), 5MDT(27+ShellV=46), HP3027
		
		ammo="Staunch Tathlum +1",--2DT
		head="Nyame Helm",
		body="Nyame mail",
		hands="Turms Mittens +1",
		--legs="Rune. Trousers +2",
		legs="Eri. Leg Guards +3",--7PDT
		feet="Turms Leggings +1",
		--neck="Futhark Torque +2",--6DT
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
        --legs="Nyame Flanchard",
		--feet="Nyame Sollerets",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +3",
		feet="Turms Leggings +1",
		--neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="CArrier's sash",
		Right_ear="Odnowa Earring",
		left_ear="Odnowa Earring +1",
		ring1="Moonlight Ring",
		ring2="Defending Ring",
		back="Moonbeam cape",
		--back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},--10PDT
        }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
		ammo="Coiste Bodhar",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Samnuha Tights",
		feet="Nyame Sollerets",
		neck="Combatant's Torque",
		waist="Ioskeha Belt +1",
		left_ear="Brutal Earring",
		right_ear="Sherida Earring",
		left_ring="Epona's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.engaged.Hybrid = {
		ammo="Coiste Bodhar",
		head="Nyame Helm",
		neck="Anu Torque",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		body="Ashera Harness",
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		left_ring="Moonlight Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		waist="Ioskeha Belt +1",
		legs="Meg. Chausses +2",
		feet="Nyame Sollerets",
	}
			
    sets.engaged.DT = set_combine(sets.engaged, {
		ammo="Staunch Tathlum +1",
		--head="Turms Cap +1",
		head="Nyame helm",
		neck="Loricate Torque +1",
		--neck="Futhark Torque +2", is this necessary?
		left_ear="Odnowa Earring +1",
		right_ear="Erilaz Earring +2",
		--body="Runeist Coat +3", No
		--body="Nyame Mail",
		body="Erilaz Surcoat +3",
		--body="Futhark Coat +3",
		hands="Turms Mittens +1",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		--back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},--10PDT
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		waist="Plat. Mog. Belt",
		legs="Eri. Leg Guards +3",
		feet="Turms Leggings +1",
	})
    
	sets.engaged.Nyame = set_combine(sets.engaged.DT, {
		Body="Nyame Mail",
		Legs="Nyame Flanchard",
	})
	
	sets.engaged.ResistDeath = set_combine(sets.engaged.DT, { 
		body="Samnuha Coat",
		ring1="Eihwaz Ring",
		ring2="Shadow Ring",
	})
	
    sets.engaged.STP = set_combine(sets.engaged, {
        --head="Aya. Zucchetto +2",
        body="Ashera Harness",
        --feet="Carmine Greaves +1",
        right_ear="Telos Earring",
        ring1={name="Chirich Ring +1", bag="wardrobe2"},
        ring2={name="Chirich Ring +1", bag="wardrobe5"},
        waist="Kentarch Belt +1",
        })

    sets.engaged.Aftermath = set_combine(sets.engaged,{
		--head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		--body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Erilaz Leg Guards +3",
        body="Ashera Harness",
        left_ear="Sherida Earring",
        right_ear="Erilaz Earring +2",
        ring1={name="Chirich Ring +1", bag="wardrobe2"},
        ring2={name="Moonlight Ring", bag="wardrobe5"},
        --waist="Kentarch Belt +1",
		--waist="Windbuffet Belt",
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

--PDT based Hybrid Tanking Set 
    sets.Hybrid = {
		head="Nyame Helm",
		--body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ayanmo Corazza +2",
		hands="Turms Mittens +1",
		--hands="Adhemar Wrist. +1",
		--legs={ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}},
		legs="Nyame flanchard",
		--feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+4','STR+2',}},
		feet="Nyame Sollerets",
		--neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		right_ring="Niqmaddu Ring",
		left_ring="Epona's Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.Hybrid)
	sets.engaged.PDT = set_combine(sets.defense.PDT)

    sets.engaged.Aftermath.DT = set_combine(sets.engaged.DT,{
        --head="Aya. Zucchetto +2",
        --body="Ashera Harness",
        --hands=gear.Adhemar_A_hands,
        --legs="Meg. Chausses +2",
        --feet=gear.Herc_STP_feet,
		--feet="Herculean Boots",-- augments={'Pet: Phys. dmg. taken -1%','"Mag.Atk.Bns."+6','"Store TP"+9','Accuracy+1 Attack+1',}},
        --neck="Futhark Torque +2",
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        ring1={name="Moonlight Ring", bag="wardrobe5"},
        ring2="Defending Ring",
        back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
        --waist="Sailfi Belt +1",--
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
    sets.CP = {}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

    sets.Epeolatry = {main="Epeolatry",sub="Utu Grip"}
    sets.Lionheart = {main="Lionheart",sub="Utu Grip"}
    sets.Aettir = {main="Aettir",sub="Utu Grip"}
    sets.GreatAxe = {main="Lycurgos",sub="Utu Grip"}
	sets.Axe = {main="Dolichenus",sub="Chanter's Shield",}
	sets.Agwu = {main="Agwu's Claymore",sub="Utu Grip"}
	sets.Reikiko = {main="Reikiko", sub="Chanter's Shield"}
	
	sets.TreasureHunter = { 
        ammo="Per. Lucky Egg", 
		body="Volte Jupon",
        waist="Chaac Belt",
		--legs="Volte Hose",
		}
	
	sets.death = {
		body="Samnuha Coat",
		ring1="Eihwaz Ring",
		ring2="Shadow Ring",
		}
	
	--Craft
	sets.alchemy = {
	main="Caduceus",
	sub="Br. Escutcheon",
	head="Protective Specs.",
	neck="Alchemist's Torque",
	body="Alchemist's Smock",
	ring1="Orvail ring +1", --+1
	ring2="Confectioner's Ring",
	waist="Alchemist's Belt",
	}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if buffactive['terror'] or buffactive['petrification'] or buffactive['sleep'] then --or buffactive['stun']
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
	if state.Auto_Kite.value == false then
		meleeSet = (meleeSet)
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Battuta'] then
        --defenseSet = set_combine(defenseSet, sets.defense.Parry)
		defenseSet = set_combine(defenseSet,{
			hands="Turms Mittens +1",
			legs="Eri Leg Guards +3",
			--back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}}, --'Mag. Evasion+10',--need
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
		if player.status == 'Engaged' then
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