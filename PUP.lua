-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

include('SendCommands.lua')

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- List of pet weaponskills to check for
    petWeaponskills = S{"Slapstick", "Knockout", "Magic Mortar",
        "Chimera Ripper", "String Clipper",  "Cannibal Blade", "Bone Crusher", "String Shredder",
        "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}
    
    -- Map automaton heads to combat roles
    petModes = {
        ['Harlequin Head'] = 'Melee',
        ['Sharpshot Head'] = 'Ranged',
        ['Valoredge Head'] = 'Tank',
        ['Stormwaker Head'] = 'Magic',
        ['Soulsoother Head'] = 'Heal',
        ['Spiritreaver Head'] = 'Nuke'
        }

    -- Subset of modes that use magic
    magicPetModes = S{'Nuke','Heal','Magic'}
    
    -- Var to track the current pet mode.
    state.PetMode = M{['description']='Pet Mode', 'None', 'Melee', 'Ranged', 'Tank', 'Magic', 'Heal', 'Nuke'}
	
	--lockstyle
	    state.AutoLockstyle = M(true, 'AutoLockstyle Mode')
	    send_command('@wait 3; input /lockstyleset 18')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options( 'DT','Hybrid', 'Acc','Normal', 'Capacity', 'Fodder', 'Ngai')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
    defaultManeuvers = {
        ['Melee'] = {'Fire Maneuver', 'Thunder Maneuver', 'Wind Maneuver', 'Light Maneuver'},
        ['Ranged'] = {'Wind Maneuver', 'Fire Maneuver', 'Thunder Maneuver', 'Light Maneuver'},
        ['Tank'] = {'Earth Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Wind Maneuver'},
        ['Magic'] = {'Ice Maneuver', 'Light Maneuver', 'Dark Maneuver', 'Earth Maneuver'},
        ['Heal'] = {'Light Maneuver', 'Dark Maneuver', 'Water Maneuver', 'Earth Maneuver'},
        ['Nuke'] = {'Ice Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Earth Maneuver'}
    }

    update_pet_mode()
    select_default_macro_book()
	send_command('lua u Gearinfo')
end


-- Define sets used by this job file.
function init_gear_sets()
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
	head="Haruspex Hat",
	ear2="Loquacious Earring",
	hands="Thaumas Gloves"
	}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    
    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +2"}
    
    sets.precast.JA['Repair'] = {feet="Foire Babouches"}

    sets.precast.JA.Maneuver = {neck="Buffoon's Collar",body="Cirque Farsetto +2",hands="Foire Dastanas",back="Dispersal Mantle"}

	sets.precast.JA['Activate'] = {ear2="Karagoz Earring +1", back="Visucius's Mantle", feet="Mpaca's Boots",}

	sets.precast.JA['Deus Ex Automata'] = {ear2="Karagoz Earring +1", back="Visucius's Mantle", feet="Mpaca's Boots",}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Whirlpool Mask",ear1="Roundel Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",legs="Nahtirah Trousers",feet="Thurandaut Boots +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Mpaca's Cap",
		body="Mpaca's Doublet", 
		hands="Mpaca's Gloves", 
		legs="Mpaca's Hose", 
		feet="Mpaca's Boots", 
		neck="Rep. Plat. Medal",
		waist="Moonbow Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Moonshade Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back="Shadow Mantle",
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {
		neck="Rancor Collar",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
        ring1="Spiral Ring",
		waist="Fotia Belt"
		})
		
    sets.precast.WS['Stringing Pummel'].Mod = set_combine(sets.precast.WS['Stringing Pummel'], {
		legs="Nahtirah Trousers"
		})

    sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {
		neck="Rancor Collar",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
        waist="Fotia Belt"
		})

    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		waist="Fotia Belt"
		})

    
    -- Midcast Sets

    sets.midcast.FastRecast = {
        head="Haruspex Hat",
		ear2="Loquacious Earring",
        body="Otronif Harness +1",
		hands="Regimen Mittens",
        legs="Manibozho Brais",
		feet="Otronif Boots +1"
		}
        

    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {legs="Foire Churidars"}

    sets.midcast.Pet['Elemental Magic'] = {feet="Pitre Babouches"}

    sets.midcast.Pet.WeaponSkill = {head="Cirque Cappello +2", hands="Cirque Guanti +2", legs="Cirque Pantaloni +2"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
		head="Pitre Taj",
		neck="Loricate Torque +1",
        ring1="Sheltered Ring",
		ring2="Paguroidea Ring"
	}
    

    -- Idle sets

    sets.idle = {	--Divinator
        head="Nyame Helm", --Pitre
		neck="Loricate Torque +1",
		ear1="Enmerkar Earring",
		ear2="Odnowa Earring +1",
        body="Nyame Mail", --Foire
		hands="Nyame Gauntlets", --Regimen
		ring1="Sheltered Ring",
		ring2="Paguroidea Ring",
        back="Shadow Mantle",
		waist="Incarnation Sash",
		legs="Nyame Flanchard", --foire
		feet="Nyame Sollerets" --Hermes
	}

    sets.idle.Town = set_combine(sets.idle, {main="Tinhaspa"})

    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = sets.idle

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {
        --head="Foire Taj",
		head="Mpaca's Cap",
		neck="Shulmanu Collar",
		ear1="Enmerkar Earring",
		ear2="Karagoz Earring +1",
        --body="Foire Tobe",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		ring1="C. Palug Ring",
		right_ring={name="Varar ring +1", bag="wardrobe5"},
        back="Visucius's Mantle",
		waist="Incarnation Sash",
		--legs="Kara. Pantaloni +3",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
	}

    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {
		--head="Pitre Taj +3",
		ear2="Crep. Earring",
		left_ring={name="Varar ring +1", bag="wardrobe2"},
		--waist="Klouskap Sash +1",
		}) 
	
	sets.idle.Pet.Engaged.Tank = set_combine(sets.idle.Pet.Engaged, {
		waist="Isa Belt",
	})
		
    sets.idle.Pet.Engaged.Nuke = set_combine(sets.idle.Pet.Engaged, {
		ring2="Tali'ah Ring",
		waist="Ukko's Sash",
		--legs="Pitre Churidars +3",
		--feet="Pitre Babouches +3"
		})

    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {
		waist="Ukko's Sash",
		--legs="Fiore Churidars +3",
		--feet="Naga Kyahan"
		})


    -- Defense sets

    sets.defense.Evasion = {
        head="Whirlpool Mask",neck="Twilight Torque",
        body="Otronif Harness +1",hands="Otronif Gloves",ring2="Defending Ring",
        back="Ik Cape",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Otronif Boots +1"}

    sets.defense.PDT = {
        head="Whirlpool Mask",neck="Twilight Torque",
        body="Otronif Harness +1",hands="Otronif Gloves",ring2="Defending Ring",
        back="Shadow Mantle",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Otronif Boots +1"}

    sets.defense.MDT = {
        head="Whirlpool Mask",neck="Twilight Torque",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Tuilha Cape",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Otronif Boots +1"}

    sets.Kiting = {feet="Hermes' Sandals"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Karagoz Earring +1",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Haste+10',}},
	}
	
    sets.engaged.Capacity = set_combine(sets.engaged, {
		back="Mecistopins Mantle"
		})
	
    sets.engaged.Acc = {
        head="Whirlpool Mask",
		neck="Ej Necklace",
		ear1="Telos Earring",
		ear2="Crepuscular Earring",
        body="Qaaxo Harness",
		hands="Otronif Gloves",
		ring1="Chirich Ring +1",
		ring2="Epona's Ring",
        back="Null Shawl",
		waist="Hurch'lan Sash",
		legs="Manibozho Brais",
		feet="Otronif Boots +1"
		}
    
	sets.engaged.Hybrid = {
        head="Mpaca's Cap",
		neck="Shulmanu Collar",
		ear1="Schere Earring",
		ear2="Cessance Earring",
        body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
        back="Visucius's Mantle",
		waist="Windbuffet Belt",
		legs="Samnuha Tights",
		feet="Malignance Boots"
		}
    
	
	sets.engaged.DT = {
        head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Schere Earring",
		ear2="Odnowa Earring +1",
        body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
        back="Visucius's Mantle",
		waist="Windbuffet Belt",
		legs="Malignance Tights",
		feet="Malignance Boots"
		}
    
	sets.engaged.Ngai  = set_combine(sets.engaged.DT, {
		head="Nyame Helm",
		neck="Warder's Charm",
		ear2="Mache Earring +1",
		body="Mpaca's Doublet",
		hands="Nyame Gauntlets",
		--waist="Moonlight Belt",
		legs="Mpaca's Hose",
		feet="Nyame Sollerets",
	})
	
	sets.phalanx = {
		ammo="Staunch Tathlum +1",
		head="Herculean Helm",
		body="Herculean Vest",
		hands="Herculean Gloves",
		legs="Herculean Trousers",
		feet="Herculean Boots",
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

-- Called when pet is about to perform an action
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if petWeaponskills:contains(spell.english) then
        classes.CustomClass = "Weaponskill"
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == 'Wind Maneuver' then
        handle_equipping_gear(player.status)
    end
end

-- Called when a player gains or loses a pet.
-- pet == pet gained or lost
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(pet, gain)
    update_pet_mode()
end

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
    if newStatus == 'Engaged' then
        display_pet_status()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_pet_mode()
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_pet_status()
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'maneuver' then
        if pet.isvalid then
            local man = defaultManeuvers[state.PetMode.value]
            if man and tonumber(cmdParams[2]) then
                man = man[tonumber(cmdParams[2])]
            end

            if man then
                send_command('input /pet "'..man..'" <me>')
            end
        else
            add_to_chat(123,'No valid pet.')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Get the pet mode value based on the equipped head of the automaton.
-- Returns nil if pet is not valid.
function get_pet_mode()
    if pet.isvalid then
        return petModes[pet.head] or 'None'
    else
        return 'None'
    end
end

-- Update state.PetMode, as well as functions that use it for set determination.
function update_pet_mode()
    state.PetMode:set(get_pet_mode())
    update_custom_groups()
end

-- Update custom groups based on the current pet.
function update_custom_groups()
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        classes.CustomIdleGroups:append(state.PetMode.value)
    end
end

-- Display current pet status.
function display_pet_status()
    if pet.isvalid then
        local petInfoString = pet.name..' ['..pet.head..']: '..tostring(pet.status)..'  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)
        
        if magicPetModes:contains(state.PetMode.value) then
            petInfoString = petInfoString..'  MP%='..tostring(pet.mpp)
        end
        
        add_to_chat(122,petInfoString)
    end
end

function file_unload()
	send_command('lua l Gearinfo')
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 18)
	elseif player.sub_job == 'DNC' then
        set_macro_page(2, 18)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 18)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 18)

	else
        set_macro_page(1, 18)
    end
end

function set_lockstyle()
    send_command('wait 3; input /lockstyleset 18 ' .. lockstyleset)
end