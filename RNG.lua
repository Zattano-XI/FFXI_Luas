-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+NumLock ]    Double Shot
--              [ CTRL+Numpad/ ]    Berserk/Meditate
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki
--              [ CTRL+Numpad- ]    Aggressor/Third Eye
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ WIN+E/R ]         Cycles between available Weapon Sets
--
--  WS:         [ CTRL+Numpad7 ]    Trueflight
--              [ CTRL+Numpad8 ]    Last Stand
--              [ CTRL+Numpad4 ]    Wildfire
--
--  RA:         [ Numpad0 ]         Ranged Attack
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
    state.Buff.Barrage = buffactive.Barrage or false
    state.Buff.Camouflage = buffactive.Camouflage or false
    state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
    state.Buff['Velocity Shot'] = buffactive['Velocity Shot'] or false
    state.Buff['Double Shot'] = buffactive['Double Shot'] or false
	

    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    elemental_ws = S{'Aeolian Edge', 'Trueflight', 'Wildfire'}
    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring",
              "Era. Bul. Pouch", "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Quelling B. Quiver",
              "Yoichi's Quiver", "Artemis's Quiver", "Chrono Quiver"}

    lockstyleset = 11
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('DT', 'STP', 'Normal') --, 'LowAcc', 'MidAcc', 'HighAcc'
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('STP', 'Normal', 'Acc', 'HighAcc', 'Critical')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('DT','Normal')
	state.WeaponLock = M(false, 'Weapon Lock')

    state.WeaponSet = M{['description']='Weapon Set', 
	
		
		--KC sets
	--'NaeglingKC', 
	--'GastraphetesKC',
	--'TauretKC', 
	--'ArmageddonKC',
	--'FomalhautKC',
	--'PinakaKC',
	
		--RAsets
	--'GastraphetesRA', 
	--'AnnihilatorRA', 
	--'FomalhautRAP',
	--'FomalhautRAM',	
	--'ArmageddonRAP',
	--'ArmageddonRAM',
	--'FailNot',
	
		--non kc sets
	'Naegling', 
	'Pinaka',
	--'Gastraphetes', 
	--'Annihilator', 
	'Fomalhaut', 
	--'tauret', 
	'Armageddon',
	
	
	}
    state.CP = M(false, "Capacity Points Mode")

   DefaultAmmo = {['Sparrowhawk +2'] = "Chrono Arrow",
                  ['Fail-Not'] = "Chrono Arrow",
				  ['Pinaka'] = "Chrono Arrow",
                  ['Annihilator'] = "Chrono Bullet",
                ['Armageddon'] = "Chrono Bullet",
                  ['Gastraphetes'] = "Quelling Bolt",
                  ['Fomalhaut'] = "Chrono Bullet",
                  ['Ataktos'] = "Chrono Bullet",
				  }

 AccAmmo = {    ['Yoichinoyumi'] = "Yoichi's Arrow",
				['Pinaka'] = "Chrono Arrow",
				['Sparrowhawk +2'] = "Chrono Arrow",
   --           ['Gandiva'] = "Yoichi's Arrow",
                ['Fail-Not'] = "Yoichi's Arrow",
              ['Annihilator'] = "Eradicating Bullet",
                  ['Armageddon'] = "Eradicating Bullet",
                ['Gastraphetes'] = "Quelling Bolt",
                   ['Fomalhaut'] = "Devastating Bullet",
                  }

   WSAmmo = {    ['Yoichinoyumi'] = "Chrono Arrow",
				 ['Pinaka'] = "Bayeux Arrow",
   			     ['Sparrowhawk +2'] = "Chrono Arrow",
  --                 ['Gandiva'] = "Chrono Arrow",
                 ['Fail-Not'] = "Chrono Arrow",
                 ['Annihilator'] = "Chrono Bullet",
                   ['Armageddon'] = "Chrono Bullet",
                 ['Gastraphetes'] = "Quelling Bolt",
                 ['Fomalhaut'] = "Chrono Bullet",
				 ['Ataktos'] = "Chrono Bullet",
				 
                  }

   MagicAmmo = {  --['Yoichinoyumi'] = "stone arrow",
				  ['Sparrowhawk +2'] = "Chrono Arrow",
  --               ['Gandiva'] = "Chrono Arrow",
                  ['Fail-Not'] = "Chrono Arrow",
                  ['Annihilator'] = "Devastating Bullet",
                  ['Armageddon'] = "Devastating Bullet",
                  ['Gastraphetes'] = "Quelling Bolt",
                  ['Fomalhaut'] = "Devastating Bullet",
				  ['Ataktos'] = "Devastating Bullet",
                  }

    -- Additional local binds
  --  include('Global-Binds.lua') -- OK to remove this line
  --  include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('lua l gearinfo')

    send_command('bind ^` input /ja "Velocity Shot" <me>')
    send_command ('bind @` input /ja "Scavenge" <me>')
	send_command('bind @w gs c toggle WeaponLock')

    if player.sub_job == 'DNC' then
        send_command('bind ^, input /ja "Spectral Jig" <me>')
        send_command('unbind ^.')
    else
        send_command('bind ^, input /item "Silent Oil" <me>')
        send_command('bind ^. input /item "Prism Powder" <me>')
    end

    send_command('bind @c gs c toggle CP')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')

    send_command('bind ^numlock input /ja "Double Shot" <me>')

    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
    elseif player.sub_job == 'SAM' then
        send_command('bind ^numpad/ input /ja "Meditate" <me>')
        send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
        send_command('bind ^numpad- input /ja "Third Eye" <me>')
    end

    send_command('bind ^numpad7 input /ws "Trueflight" <t>')
    send_command('bind ^numpad8 input /ws "Last Stand" <t>')
    send_command('bind ^numpad4 input /ws "Wildfire" <t>')
    send_command('bind ^numpad6 input /ws "Coronach" <t>')
    send_command('bind ^numpad2 input /ws "Sniper Shot" <t>')
    send_command('bind ^numpad3 input /ws "Numbing Shot" <t>')

    send_command('bind numpad0 input /ra <t>')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind f9')
    send_command('unbind ^f9')
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind ^,')
    send_command('unbind @f')
    send_command('unbind @c')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind ^numlock')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
    send_command('unbind numpad0')

    send_command('unbind #`')
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

   -- send_command('lua u gearinfo')
end


-- Set up all gear sets.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

  --  Precast sets to enhance JAs
   sets.precast.JA['Eagle Eye Shot'] ={} 
    sets.precast.JA['Bounty Shot'] = {}
   sets.precast.JA['Camouflage'] = {}
   sets.precast.JA['Scavenge'] = {}
    sets.precast.JA['Shadowbind'] = {}
   sets.precast.JA['Sharpshot'] = {"Arcadian jerkin +3"}


    -- Fast cast sets for spells

    sets.precast.Waltz = {
      
        }

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
        
        }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        
        })


    -- (10% Snapshot, 5% Rapid from Merits)
    sets.precast.RA = {
	head="Amini Gapette +2",--9
	neck="Scout's Gorget +2",--3
	body="Amini Caban +2",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},--8
	right_ring="Crepuscular Ring",
	back={ name="Belenus's Cape", augments={'"Snapshot"+10',}},--10
	waist="Yamaya Belt",
	--waist="Impulse Belt", --3/0
	--legs="Orion Braccae +2",--12
	legs="Ikenga's Trousers",
	feet="Meg. Jam. +2",--10
    } --61/26

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
    head="Orion Beret +3",
    body="Amini Caban +2",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
    feet="Meg. Jam. +2",
    neck="Scout's Gorget +2",
    waist="Impulse Belt",
    back={ name="Belenus's Cape", augments={'"Snapshot"+10',}},
    }) --43/39

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
    head="Orion Beret +3",
    body="Amini Caban +2",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
    feet="Arcadian Socks +3",
    neck="Scout's Gorget +2",
    waist="Yemaya Belt",
    back={ name="Belenus's Cape", augments={'"Snapshot"+10',}},
    }) --30/54

    sets.precast.RA.Gastra = {
	head="Orion Beret +3",
	body="Amini Caban +2",
	waist="Impulse Belt", --3/0
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},--8
	feet="Meg. Jam. +2",--10
	legs="Orion Braccae +2",--12
	neck="Scout's Gorget +2",--3
	right_ring="Crepuscular Ring",
	back={ name="Belenus's Cape", augments={'"Snapshot"+10',}},--10
	}
	
    sets.precast.RA.Gastra.Flurry1 = set_combine(sets.precast.RA.Gastra, {
	feet="Pursuer's Gaiters",
	})
	
    sets.precast.RA.Gastra.Flurry2 = set_combine(sets.precast.RA.Gastra.Flurry1, {
	feet="Arcadian Socks +3",
	waist="Yemaya Belt",
	legs="Pursuer's Pants",
	})


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {	
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Nyame Gauntlets",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Moonshade Earring",
    right_ear="Amini Earring +2",
    left_ring="Regal Ring",
    right_ring="Cornelia's Ring",
    back={ name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
		

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
    left_ring="Regal Ring",
    })

    sets.precast.WS["Apex Arrow"] = sets.precast.WS

    sets.precast.WS["Apex Arrow"].Acc = set_combine(sets.precast.WS["Apex Arrow"], {
       
    })

    sets.precast.WS["Jishnu\'s Radiance"] = set_combine(sets.precast.WS, {
        
    })

    sets.precast.WS["Jishnu\'s Radiance"].Acc = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
        
    })

    sets.precast.WS["Sarv"] = sets.precast.WS["Last Stand"]--STR65%/AGL65%
	


    sets.precast.WS["Last Stand"] = set_combine(sets.precast.WS, {
	--head="Orion Beret +3",
	--body="Ikenga's Vest",
    --body="Nyame Mail",
	hands="Nyame Gauntlets",
    --legs="Arcadian braccae +3",
	feet="Amini Bottillons +3",
    --feet="Nyame Sollerets",
    neck="Scout's Gorget +2",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Amini Earring +2",
    left_ring="Regal Ring",
    right_ring="Cornelia's Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},  	   
    })

    sets.precast.WS["Last Stand"].Acc = set_combine(sets.precast.WS["Last Stand"], {
       
    })

    sets.precast.WS["Coronach"] = set_combine(sets.precast.WS["Last Stand"], {
    head="Orion Beret +3",
	body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Arcadian braccae +3",
    feet="Nyame Sollerets",
    neck="Scout's Gorget +2",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear="Ishvara Earring",
    left_ring="Regal Ring",
    right_ring="Cornelia's Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Atk.+10','Weapon skill damage +10%',}},
    })

    sets.precast.WS["Coronach"].Acc = set_combine(sets.precast.WS['Coronach'], {

    })

    sets.precast.WS["Trueflight"] = { 
    head="Nyame Helm",
	body="Nyame Mail",
	--body={ name="Cohort Cloak +1", augments={'Path: A',}},
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist="Orpheus's Sash",
    left_ear="Moonshade Earring",
    right_ear="Amini Earring +2",
    left_ring="Dingir Ring",
    right_ring="Cornelia's Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},  
    }


	
	    sets.precast.WS["Wildfire"] = set_combine(sets.precast.WS["Trueflight"], {
	--right_ear="Novio Earring",
	})
	sets.precast.WS["Empyreal Arrow"] = set_combine(sets.precast.WS["Last Stand"], {
	
	})
	
    sets.precast.WS["Aeolian Edge"] = set_combine(sets.precast.WS["Trueflight"], {
	ammo="Hauksbok arrow",
	})



	sets.precast.WS["Hot Shot"] = set_combine(sets.precast.WS["Trueflight"], {
	ammo="Devastating Bullet",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
	hands="Nyame Gauntlets",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    left_ear="Moonshade Earring",
    right_ear="Amini Earring +2",
    left_ring="Dingir Ring",
    back={ name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},			
    })
	
    sets.precast.WS['Evisceration'] = {
	ammo="Hauksbok arrow",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands="Mummu Wrists +2",
    legs={ name="Herculean Trousers", augments={'Accuracy+23','"Triple Atk."+4','STR+3',}},
    --feet={ name="Herculean Boots", augments={'Accuracy+29','Crit. hit damage +3%','DEX+15','Attack+1',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Odr Earring",
    right_ear="Amini Earring +2",
    left_ring="Regal Ring",
    right_ring="Chirich Ring +1",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10',}},
    }
	
	sets.precast.WS['Savage Blade'] = {
    ammo="Hauksbok arrow",
	head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Nyame Gauntlets",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Moonshade Earring",
	right_ear="Amini Earring +2",
    left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    right_ring="Cornelia's Ring",
    back={ name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }

    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {

    })

    sets.precast.WS['Rampage'] = set_combine(sets.precast.WS['Evisceration'], {feet=gear.Herc_TA_feet})
    sets.precast.WS['Rampage'].Acc = sets.precast.WS['Evisceration'].Acc


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast recast for spells

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {

        }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    -- Ranged sets

    sets.midcast.RA = {	
    head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
    body="Nisroch Jerkin",
    hands="Amini Glove. +3",
    legs={ name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
    feet="Malignance Boots",
    neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist="Kwahu Kachina Belt +1",
    left_ear="Telos Earring",
    right_ear="Amini Earring +2",
    left_ring="Regal Ring",
    right_ring="Ilabrat Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}},
	}

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
       	body="Malignance Tabard",
		--right_ear="Telos Earring",
        })

    sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.Acc, {
       
        })

    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
    head={ name="Blistering Sallet +1", augments={'Path: A',}},
    body="Nisroch Jerkin",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
    feet={ name="Arcadian Socks +3", augments={'Enhances "Stealth Shot" effect',}},
    neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist="K. Kachina Belt +1",
    left_ear="Telos Earring",
    right_ear="Odr Earring",
    left_ring="Mummu Ring",
    right_ring="Begrudging Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10',}},
        })

    sets.midcast.RA.STP = set_combine(sets.midcast.RA, {
       
        })

    sets.DoubleShot = {    
	head="Arcadian Beret +3",
    body="Arc. Jerkin +3",
    hands="Oshosi Gloves +1",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}},
    legs="Oshosi Trousers +1",
    feet="Oshosi Leggings +1",
        } --25

    sets.DoubleShot.Critical = {
    head="Arcadian Beret +3",
    body="Arc. Jerkin +3",
    hands="Oshosi Gloves +1",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10',}},
    legs="Oshosi Trousers +1",
    feet="Oshosi Leggings +1",
    waist="K. Kachina Belt +1",
    left_ear="Telos Earring",
    right_ear="Odr Earring",
    left_ring="Begrudging Ring",
    right_ring="Ilabrat Ring",
	neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		}


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    -- Idle sets
    sets.idle = {
    head="Nyame Helm",
    body="Adamantite Armor",
    hands="Amini Glove. +3",
    Legs="Carmine Cuisses +1",
    feet="Nyame Sollerets",
    neck="Iskur Gorget",
    waist="Windbuffet Belt +1",
    left_ear="Telos Earring",
	right_ear="Amini Earring +2",
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
        }

    sets.idle.DT = set_combine(sets.idle, {
    head="Nyame Helm",
    body="Adamantite Armor",
    hands="Amini Glove. +3",
    legs="Amini Bragues +3",
    feet="Nyame Sollerets",
    neck="Iskur Gorget",
    waist="Windbuffet Belt +1",
    left_ear="Telos Earring",
    --right_ear="Crepuscular Earring",
	right_ear="Amini Earring +2",
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
        })

    sets.idle.Town = set_combine(sets.idle, {
       body="Nisroch Jerkin",
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {Legs="Carmine Cuisses +1",}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
    --KC set
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Amini Glove. +3",
    legs="Amini Bragues +3",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    waist="Windbuffet Belt +1",
    left_ear="Telos Earring",
	right_ear="Crepuscular Earring",	
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},  
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	
	--no kc

	--  ammo="stone arrow",
	--head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	--body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    --hands={ name="Tatena. Gote +1", augments={'Path: A',}},
    --legs="Malignance Tights",
    --feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
    --neck="Iskur Gorget",
    --waist="Windbuffet Belt +1",
    --left_ear="Suppanomimi",
    --right_ear="Sherida Earring",
    --left_ring="Petrov Ring",
    --right_ring="Epona's Ring",
	--back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	
        }

    sets.engaged.LowAcc = set_combine(sets.engaged, {
    neck="Combatant's Torque",
    left_ear="Amini Earring +2",

			
       })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
	hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
    left_ear="Odr Earring",

        })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
	body={ name="Tatena. Harama. +1", augments={'Path: A',}},
    hands={ name="Tatena. Gote +1", augments={'Path: A',}},
    feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},    
        })

    sets.engaged.STP = set_combine(sets.engaged, {
       
        })

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
	
	--KC set
	head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Amini Glove. +3",
    legs="Carmine Cuisses +1",
	--legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    waist="Windbuffet Belt +1",
    left_ear="Telos Earring",
    right_ear="Amani Earring +2",
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},  
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	
	--nokc extra pieces
	--head="Malignance Chapeau",
	--right_ear="Crep. Earring",
	--neck="Combatant's Torque",
	--left_ring={name="Chirich Ring +1", bag="wardrobe2"},
	--right_ring={name="Chirich Ring +1", bag="wardrobe5"},
    --head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	--body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    --hands={ name="Tatena. Gote +1", augments={'Path: A',}},
    --legs="Malignance Tights",
    --feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
    --neck="Iskur Gorget",
    --waist="Windbuffet Belt +1",
	--waist="Olseni Belt",
    --left_ear="Suppanomimi",
    --right_ear="Sherida Earring",
    --left_ring="Petrov Ring",
    --right_ring="Epona's Ring",
	--back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
        } -- 52%

    sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
    neck="Combatant's Torque",
    left_ear="Crep. Earring",
        })

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
	hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
    left_ear="Odr Earring",
        })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
	body={ name="Tatena. Harama. +1", augments={'Path: A',}},
    hands={ name="Tatena. Gote +1", augments={'Path: A',}},
    feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},     
        })

    sets.engaged.DW.STP = set_combine(sets.engaged.DW, {
     
        })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = {
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Amini Glove. +3",
    legs="Carmine Cuisses +1",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    waist="Windbuffet Belt +1",
    left_ear="Suppanomimi",
	right_ear="Eabani Earring",	
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},  
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
        } -- 42%

    sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    neck="Combatant's Torque",
    left_ear="Crep. Earring",
        })

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
    hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
    left_ear="Odr Earring",       
        })

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
	body={ name="Tatena. Harama. +1", augments={'Path: A',}},
    hands={ name="Tatena. Gote +1", augments={'Path: A',}},
    feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},    
        })

    sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
       
        })

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = {
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Amini Glove. +3",
    legs="Amini Bragues +3",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    waist="Windbuffet Belt +1",
    left_ear="Telos Earring",
	right_ear="Eabani Earring",	
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},  
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
      } -- 31%

    sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    neck="Combatant's Torque",
    left_ear="Eabani Earring",
        })

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
    hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
    left_ear="Eabani Earring",       
        })

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
	body={ name="Tatena. Harama. +1", augments={'Path: A',}},
    hands={ name="Tatena. Gote +1", augments={'Path: A',}},
    feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},    
        })

    sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
      
        })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = {
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Amini Glove. +3",
    legs="Amini Bragues +3",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    waist="Windbuffet Belt +1",
    left_ear="Eabani Earring",
    right_ear="Telos Earring",
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},  
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
      } -- 27%

    sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    neck="Combatant's Torque",
    left_ear="Crep. Earring", 
        })

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
    hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
    left_ear="Odr Earring",       
        })

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
	body={ name="Tatena. Harama. +1", augments={'Path: A',}},
    hands={ name="Tatena. Gote +1", augments={'Path: A',}},
    feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},  
        })

    sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
       
        })

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
      head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Amini Glove. +3",
    legs="Amini Bragues +3",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    waist="Windbuffet Belt +1",
    left_ear="Telos Earring",
	right_ear="Crepuscular Earring",	
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},  
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
        } -- 11%

    sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
	neck="Combatant's Torque",
        })

    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
    hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
        })

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
	body={ name="Tatena. Harama. +1", augments={'Path: A',}},
    hands={ name="Tatena. Gote +1", augments={'Path: A',}},
    feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},  
        })

    sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
       
        })

    --sets.engaged.DW.MaxHastePlus = set_combine(sets.engaged.DW.MaxHaste, {back=gear.RNG_DW_Cape})
    --sets.engaged.DW.LowAcc.MaxHastePlus = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {back=gear.RNG_DW_Cape})
    --sets.engaged.DW.MidAcc.MaxHastePlus = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {back=gear.RNG_DW_Cape})
    --sets.engaged.DW.HighAcc.MaxHastePlus = set_combine(sets.engaged.DW.HighAcc.MaxHaste, {back=gear.RNG_DW_Cape})
    --sets.engaged.DW.STP.MaxHastePlus = set_combine(sets.engaged.DW.STP.MaxHaste, {back=gear.RNG_DW_Cape})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
    head="Nyame Helm",
    body="Malignance Tabard",
    hands="Amini Glove. +3",
    legs="Amini Bragues +3",
    feet="Nyame Sollerets",
    neck="Combatant's Torque",
    waist="Windbuffet Belt +1",
    left_ear="Telos Earring",
	right_ear="Crepuscular Earring",	
    left_ring="Defending Ring",
    right_ring={name="Chirich Ring +1", bag="wardrobe5"},
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT = set_combine(sets.engaged.DW.LowAcc, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT = set_combine(sets.engaged.DW.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.LowHaste = set_combine(sets.engaged.DW.STP.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MidHaste = set_combine(sets.engaged.DW.STP.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MaxHaste = set_combine(sets.engaged.DW.STP.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHastePlus = set_combine(sets.engaged.DW.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.LowAcc.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.MidAcc.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.HighAcc.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MaxHastePlus = set_combine(sets.engaged.DW.STP.MaxHastePlus, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Barrage = {
    head="Orion Beret +3",
    body={ name="Ikenga's Vest", augments={'Path: A',}},
    hands="Orion Bracers +3",
    legs={ name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
    feet="Malignance Boots",
    neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist="Kwahu Kachina Belt +1",
    left_ear="Telos Earring",
	right_ear="Amini Earring +2",	
    left_ring="Regal Ring",
    right_ring="Crepuscular Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}},

	}
    sets.buff['Velocity Shot'] = set_combine(sets.midcast.RA, {body="Amini Caban +2",})
    sets.buff.Camouflage = {body="Orion Jerkin +1"}

    sets.buff.Doom = {
        }

	sets.phalanx = {
		head="Herculean Helm",
		body="Herculean Vest",
		hands="Herculean Gloves",
		legs="Herculean Trousers",
		feet="Herculean Boots",
	}

   -- sets.FullTP = {ear1="Crematio Earring"}
    --sets.Obi = {waist="Hachirin-no-Obi"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}
    sets.CP = {back="Mecisto. Mantle"}

	------KC weapon sets
	sets.NaeglingKC = { 
	main="Naegling",
	--sub="Kraken Club",
    range="Ataktos",
	Ammo="Chrono Bullet",
	}
   sets.TauretKC = {
	--main="Tauret",
    --sub="Kraken Club",
	range={ name="Sparrowhawk +2", augments={'TP Bonus +1000',}},
	ammo="Hauksbok Arrow",
	}
	sets.ArmageddonKC = {
	--main="Tauret",
    --sub="Kraken Club",
	ranged="Armageddon",
	ammo="Chrono Bullet",
	}
    sets.GastraphetesKC = {
	ranged="Gastraphetes",
	--main="Tauret",
	--sub="Kraken Club",
	ammo="Quelling Bolt"
	}
	sets.FomalhautKC = {
	--main={ name="Ternion Dagger +1", augments={'Path: A',}},
	--sub="kraken club",
	ranged="Fomalhaut",
	ammo="Chrono Bullet",
	}
	sets.PinakaKC = {
	--main={ name="Ternion Dagger +1", augments={'Path: A',}},
	--sub="kraken club",
	ranged="Pinaka",
	ammo="Chrono Arrow",
	}

	
	--------weapon sets
	sets.Tauret = {
	main="Tauret",
    sub="Malevolence",
	range="Sparrowhawk +2",
	ammo="Hauksbok Arrow",
	}
	sets.Fomalhaut = {
	--main={ name="Ternion Dagger +1", augments={'Path: A',}},
	--sub="kraken club",
	ranged="Fomalhaut",
	ammo="Chrono Bullet",
	}
	sets.Armageddon = {
	--main="Tauret",
    --sub="Kraken Club",
	ranged="Armageddon",
	ammo="Chrono Bullet",
	}
	sets.Naegling = { 
	main="Naegling",
    sub={ name="Ternion Dagger +1", augments={'Path: A',}},
    range="Ataktos",
	Ammo="Chrono Bullet",
	}
	sets.Gastraphetes = {
	ranged="Gastraphetes",
	main={ name="Malevolence",bag="wardrobe7"},
    sub={ name="Malevolence",bag="wardrobe8"},
	ammo="Quelling Bolt"
	}
	sets.Pinaka = {
	ranged="Pinaka",
	ammo="Chrono Arrow",
	}

	
	-----------ranged sets
    sets.AnnihilatorRA = {
	main="Perun +1",
	sub={ name="Ternion Dagger +1", augments={'Path: A',}},
	ranged="Annihilator",
	}
	
	sets.FomalhautRAP = {
	main="Perun +1",
    sub="Nusku Shield",
	ranged="Fomalhaut",
	}	
	sets.FomalhautRAM = {
	main={ name="Malevolence",bag="wardrobe2"},
    sub={ name="Malevolence",bag="wardrobe3"},
	ranged="Fomalhaut",
	}
	
   	sets.ArmageddonRAP = {--ranged="Armageddon"
    main={ name="Gleti's Knife", augments={'Path: A',}},
    sub="Nusku Shield",
	ranged="Armageddon",
	}
	sets.ArmageddonRAM = {--ranged="Armageddon"
	main={ name="Malevolence",bag="wardrobe2"},
    sub={ name="Malevolence",bag="wardrobe3"},
	ranged="Armageddon",
	}
	
    sets.GastraphetesRA = {
	ranged="Gastraphetes",
	main={ name="Malevolence",bag="wardrobe2"},
	sub="Nusku Shield",
	ammo="Quelling Bolt"
	}
	
	sets.FailNot = {
	main="Perun +1",
    --sub="Nusku Shield",
	sub={ name="Ternion Dagger +1", augments={'Path: A',}},
	ranged="Fail-Not",
	ammo="Chrono Arrow",
	}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        state.CombatWeapon:set(player.equipment.range)
    end
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
        check_ammo(spell, action, spellMap, eventArgs)
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

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if spell.action_type == 'Ranged Attack' then
            if player.equipment.ranged == "Gastraphetes" then
                if flurry == 2 then
                    equip(sets.precast.RA.Gastra.Flurry2)
                elseif flurry == 1 then
                    equip(sets.precast.RA.Gastra.Flurry1)
                else
                    equip(sets.precast.RA.Gastra)
                end
            else
                if flurry == 2 then
                    equip(sets.precast.RA.Flurry2)
                elseif flurry == 1 then
                    equip(sets.precast.RA.Flurry1)
                else
                    equip(sets.precast.RA)
                end
            end
            if player.equipment.main == "Perun +1" then
                equip({waist="Yemaya Belt"})
            end
        end
      elseif spell.type == 'WeaponSkill' then
        -- Replace TP-bonus gear if not needed.
        if spell.english == 'Trueflight' or spell.english == 'Aeolian Edge' and player.tp > 2900 then
            equip(sets.FullTP)
        end
        -- Equip obi if weather/day matches for WS.
        if elemental_ws:contains(spell.name) then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
				elseif spell.element == 'Light' then
					equip({waist="Korin Obi"})
				elseif spell.element == 'Wind' then
					equip({waist="Furin Obi"})
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
               -- equip({waist="Korin Obi"
				elseif spell.element == 'Light' then
					equip({waist="Korin Obi"})
				elseif spell.element == 'Wind' then
					equip({waist="Furin Obi"})
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                --equip({waist="Korin Obi"})
				elseif spell.element == 'Light' then
					equip({waist="Korin Obi"})
				elseif spell.element == 'Wind' then
					equip({waist="Furin Obi"})			
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if buffactive['Double Shot'] then
            equip(sets.DoubleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.DoubleShotCritical)
                if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                    equip(sets.TrueShot)
                end
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
            equip(sets.midcast.RA.Critical)
            if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                equip(sets.TrueShot)
            end
        end
        if state.Buff.Barrage then
            equip(sets.buff.Barrage)
        end
--        if state.Buff['Velocity Shot'] and state.RangedMode.value == 'STP' then
--            equip(sets.buff['Velocity Shot'])
--        end
    end
end


function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english == "Shadowbind" then
        send_command('@timers c "Shadowbind ['..spell.target.name..']" 42 down abilities/00122.png')
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
    if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            add_to_chat(122, "Flurry status cleared.")
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    if buff == "Camouflage" then
        if gain then
            equip(sets.buff.Camouflage)
            disable('body')
        else
            enable('body')
        end
    end

--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

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

function job_state_change(stateField, newValue, oldValue)
    --if state.WeaponLock.value == true then
    --    disable('ranged')
    --else
    --    enable('ranged')
   -- end

    check_weaponset()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Carnwenhan" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end

    check_weaponset()

    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
        if state.RangedMode.value == 'Acc' or state.RangedMode.value == 'HighAcc' then
            wsmode = 'Acc'
            add_to_chat(1, 'WS Mode Auto Acc')
        end
    elseif (spell.skill ~= 'Marksmanship' and spell.skill ~= 'Archery') then
        if state.OffenseMode.value == 'Acc' or state.OffenseMode.value == 'HighAcc' then
            wsmode = 'Acc'
        end
    end

    return wsmode
end

function customize_idle_set(idleSet)
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

function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

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

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action',
    function(act)
        --check if you are a target of spell
        local actionTargets = act.targets
        playerId = windower.ffxi.get_player().id
        isTarget = false
        for _, target in ipairs(actionTargets) do
            if playerId == target.id then
                isTarget = true
            end
        end
        if isTarget == true then
            if act.category == 4 then
                local param = act.param
                if param == 845 and flurry ~= 2 then
                    --add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    --add_to_chat(122, 'Flurry Status: Flurry II')
                    flurry = 2
              end
            end
        end
    end)

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 11 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 11 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MaxHastePlus')
        elseif DW_needed > 21 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
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

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
     if spell.action_type == 'Ranged Attack' then
        if player.equipment.ammo == "Hauksbok Arrow" then
             add_to_chat(104, 'WSD Arrow equipped -- cancel shot')
             eventArgs.cancel = true
             return
        end

        elseif player.equipment.ammo == 'empty' or player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
            if DefaultAmmo[player.equipment.range] then
                if player.inventory[DefaultAmmo[player.equipment.range]] then
                    --add_to_chat(3,"Using Default Ammo")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"Default ammo unavailable.  Leaving empty.")
                end
            else
                add_to_chat(3,"Unable to determine default ammo for current weapon.  Leaving empty.")
            end
        

    elseif spell.type == 'WeaponSkill' then
        -- magical weaponskills
        if elemental_ws:contains(spell.english) then
            if player.inventory[MagicAmmo[player.equipment.range]] then
                equip({ammo=MagicAmmo[player.equipment.range]})
            else
                add_to_chat(3,"Magic ammo unavailable.  Using default ammo.")
                equip({ammo=DefaultAmmo[player.equipment.range]})
            end
        --physical weaponskills
        else
            if state.RangedMode.value == 'Acc' then
                if player.inventory[AccAmmo[player.equipment.range]] then
                    equip({ammo=AccAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"Acc ammo unavailable.  Using default ammo.")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                end
            else
                if player.inventory[WSAmmo[player.equipment.range]] then
                    equip({ammo=WSAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"WS ammo unavailable.  Using default ammo.")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                end
            end
        end
    end
    if player.equipment.ammo ~= 'empty' and player.inventory[player.equipment.ammo].count < 15 then
        add_to_chat(39,"*** Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low! *** ("..player.inventory[player.equipment.ammo].count..")")
    end
end

function update_offense_mode()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        state.CombatForm:set('DW')
    else
        state.CombatForm:reset()
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
    if no_swap_gear:contains(player.equipment.waist) then
        disable("waist")
    else
        enable("waist")
    end
end

function check_weaponset()
    if state.OffenseMode.value == 'LowAcc' or state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        equip(sets[state.WeaponSet.current].Acc)
    else
        equip(sets[state.WeaponSet.current])
    end
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 11)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
