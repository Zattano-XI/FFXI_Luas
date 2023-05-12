-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(true, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)
	    state.AutoLockstyle = M(true, 'AutoLockstyle Mode')
	    send_command('@wait 3; input /lockstyleset 16')

    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('DT','Hybrid','Ranged') -- 'Acc','Capacity',
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')

    gear.RAbullet = "Eminent bullet" --chrono
    gear.WSbullet = "Eminent bullet" --chrono
    gear.MAbullet = "Eminent bullet" --living
    gear.QDbullet = "Eminent bullet" --living
    options.ammo_warning_limit = 15

    -- Additional local binds
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()


    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Precast sets to enhance JAs
    
    sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +3"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}

    
    sets.precast.CorsairRoll = {main="Rostam", range="Compensator",
	head="Lanun Tricorne +3", 
	neck="Regal Necklace",
	hands="Chasseur's Gants +3",
	Legs="Desultor Tassets", 
	back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	Ring1="Luzaf's Ring"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes +3"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +3"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne +3"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +3"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +3"})
    
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}
    
    sets.precast.CorsairShot = {}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
		hands="Malignance Tabard",
        legs="Malignance Tights",
		feet="Malignance Tabard"
		}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
	head="Carmine Mask +1",
	ear1="Etiolation Earring",
	ear2="Loquacious Earring",
	hands="Leyline Gloves",
	ring1="Prolix Ring",
	ring2="Kishar Ring",
	}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    sets.precast.RA = {ammo=gear.RAbullet,
        head="Chasseur's Tricorne +3",
		head="Ikenga's Hat",
		neck="Commodore Charm +2",
        body="Laksamana's Frac +2",
		hands="Lanun Gants +3",
		ring1="Crepuscular Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}},
		waist="Yemaya Belt",
		legs="Adhemar Kecks +1",
		feet="Meghanada Jambeaux +2"
		}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Meghanada Visor +2",
		neck="Commodore Charm +2",
		ear1="Cessance Earring",
		ear2="Ishvara Earring",
        body="Meghanada Cuirie +2",
		hands="Meghanada Gloves +2",
		ring1="Regal Ring",
		ring2="Ilabrat Ring",
        back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
		legs="Meghanada Chausses +2",
		feet="Meghanada Jambeaux +2"
	}


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Savage Blade'] = {main="Naegling",
		head="Nyame Helm",
		neck="Rep. Plat. Medal",
    	ear1="Ishvara Earring",
		ear2="Moonshade Earring",
        body="Nyame Mail",
		hands="Meghanada Gloves +2",
		ring1="Regal Ring",
		ring2="Ilabrat Ring",
        waist="Sailfi Belt +1",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
		legs="Nyame Flanchard",
		feet="Lanun Bottes +3"
	}
	
	sets.precast.WS['Evisceration'] = {main="Tauret",
		head="Adhemar Bonnet",
		body="Mummu Jacket +2",
		neck="Fotia Gorget",
		ear1="Mache Earring +1",
		ear2="Moonshade Earring",
		hands="Mummu Wrists +2", 
		legs="Samnuha Tights",
		feet="Mummu Gamashes +2",
		ring1="Regal ring",
		ring2="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Fotia Belt"
	}
		
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		waist="Fotia Belt",
})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		waist="Fotia Belt",
	})

    sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,
        head="Lanun Tricorne +3",
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
        body="Lanun Frac +3",
		hands="Chasseur's Gants +3",
		ring1="Dingir Ring",
		ring2="Ilabrat Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%'}},
		waist="Fotia Belt",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +3"
	}

    sets.precast.WS['Last Stand'].Acc = {ammo=gear.WSbullet,
        head="Lanun Tricorne +3",
		neck="Commodore Charm +2",
		ear1="Crepuscular Earring",
		ear2="Moonshade Earring",
        body="Laksamana's Frac +2",
		hands="Chasseur's Gants +3",
		ring1="Crepuscular Ring",
		ring2="Cacoethic Ring +1",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
		waist="Fotia Belt",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +3"
	}

    sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
        head="Nyame Helm",
		neck="Commodore Charm +2",
		ear1="Friomisi Earring",
		ear2="Hecate's Earring",
        body="Lanun Frac +3",
		hands="Nyame Gauntlets",
		ring1="Ilabrat Ring", 
		ring2="Dingir Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
		waist="Eschan Stone",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +3",
	}
    
    sets.precast.WS['Leaden Salute'] = {ammo=gear.MAbullet,
        head="Pixie Hairpin +1",
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Moonshade Earring",
        body="Lanun Frac +3", --+3 
		hands="Nyame Gauntlets",
		ring1="Archon Ring",
		ring2="Dingir Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
		waist="Orpheus's Sash",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +3",
	}    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Malignance Chapeau",
        body="Malignance Tabard",hands="Malignance Tabard",
        legs="Malignance Tights",feet="Malignance Tabard"
	}
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {ammo=gear.QDbullet,
        head="Herculean Helm",
		neck="Baetyl pendant",
		Ear1="Friomisi Earring",
		Ear2="Moonshade Earring",
		body="Lanun Frac +3",
		hands="Carmine Finger Gauntlets +1",
		--ring1="Fenrir Ring +1",
		ring1="Stikini Ring +1",
		ring2="Dingir Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
		waist="Eschan Stone", --Skrymir cord +1
		legs="Nyame Flanchard",
		feet="Chasseur's Bottes +3"
	}

    sets.midcast.CorsairShot.Acc = {ammo=gear.QDbullet,
        head="Laksamana's Hat",
		neck="Commodore Charm +2",
		ear1="Dignitary's Earring",
		ear2="Gwati Earring",
        body="Malignance Tabard",
		hands="Laksamana's Gants +3",
		ring1="Stikini Ring +1",
		ring2="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
		waist="Eschan Stone",
		legs="Malignance Tights",
		feet="Laksamana's Bottes +3"
	}

    sets.midcast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
        head="Laksamana's Hat",
		neck="Commodore Charm +2",
		ear1="Dignitary's Earring",
		ear2="Gwati Earring",
        body="Malignance Tabard",
		hands="Laksamana's Gants +3",
		ring1="Stikini Ring +1",
		ring2="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
		waist="Eschan Stone",
		legs="Malignance Tights",
		feet="Laksamana's Bottes +3"
	}

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']


    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
        head="Ikenga's Hat",
		neck="Iskur Gorget",
		ear1="Telos Earring",
		ear2="Enervating Earring",
        body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Ilabrat Ring",
		ring2="Crepuscular Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}},
		waist="Yemaya Belt",
		legs="Ikenga's Trousers",
		feet="Malignance Boots"
	}

    sets.midcast.RA.Acc = {ammo=gear.RAbullet,
        head="Ikenga's Hat",
		neck="Iskur Gorget",
		ear1="Telos Earring",
		ear2="Enervating Earring",
        body="Laksamana's Frac +3",
		hands="Malignance Gloves",
		ring1="Crepuscular Ring",
		ring2="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}},
		waist="Yemaya Belt",
		legs="Ikenga's Trousers",
		feet="Malignance Boots"
	}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Loricate Torque +1",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets
    sets.idle = {ammo=gear.RAbullet,
        head="Nyame Helm",
		neck="Commodore Charm +2",
		ear1="Infused Earring",
		ear2="Odnowa Earring +1",
        body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Defending Ring",
        ring2="Sheltered Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}},
		waist="Plat. Mog. Belt",
		legs="Carmine cuisses +1",
		feet="Nyame Sollerets"
		}

    sets.idle.Town = {ammo=gear.RAbullet,
        head="Laksamana's Hat",
		neck="Loricate Torque +1",
		ear1="Crepuscular Earring",
		ear2="Enervating Earring",
        body="Laksamana's Frac +3",
		hands="Malignance Gloves",
		ring1="Crepuscular Ring",
		ring2="Sheltered Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}},
		waist="Flume Belt +1",
		legs="Carmine Cuisses +1",
		feet="Skadi's Jambeaux +1"}
    
    -- Defense sets
    sets.defense.PDT = {
        head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring",
		ear2="Odnowa Earring +1",
        body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}},
		waist="Flume Belt +1",
		legs="Malignance Tights",
		feet="Malignance Boots"
		}

    sets.defense.MDT = {
        head="Nyame Helm",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring",
		ear2="Odnowa Earring +1",
        body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Defending Ring",
		--ring2="Shadow Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}},
		waist="Flume Belt +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"
	}
    

    sets.Kiting = {feet="Skadi's Jambeaux +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged.Hybrid = {main="Naegling", range="Anarchy +2", ammo=gear.RAbullet,
        head="Adhemar Bonnet +1",
		neck="Iskur Gorget",
		ear1="Cessance Earring", --Telos
		ear2="Suppanomimi",
		body="Malignance Tabard",
		hands="Adhemar Wristbands +1",
		ring1="Epona's Ring",
		ring2="Defending Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Windbuffet Belt +1",
		legs="Malignance Tights",
		feet="Malignance Boots"
	}
    
	sets.engaged.Capacity = {main="Naegling", range="Anarchy +2", ammo=gear.RAbullet,
        head="Malignance Chapeau",
		neck="Iskur Gorget",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
        body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Ilabrat ring",
		ring2="Petrov Ring",
        back="Mecistopins Mantle",
		waist="Sailfi Belt +1",
		legs="Malignance Tights",
		feet="Herculean Boots"
		}

    sets.engaged.DT = {main="Naegling", range="Anarchy +2", ammo=gear.RAbullet,
        head="Malignance Chapeau", --6dt
		neck="Iskur Gorget",
		ear1="Cessance Earring",
		ear2="Crepuscular Earring", --brutal
        body="Malignance Tabard", --9dt
		hands="Malignance Gloves", --5dt
		ring1="Ilabrat ring",
		ring2="Defending Ring", --10dt
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}, --5dt
		waist="Sailfi Belt +1",
		legs="Malignance Tights", --7dt
		feet="Herculean Boots", --feet="Malignance Boots" --7dt
		}	--dt49
		
    sets.engaged.Acc = {ammo=gear.RAbullet,
        head="Malignance Chapeau",
		neck="Iskur Gorget",
		ear1="Cessance Earring",
		ear2="Mache Earring +1",
        body="Malignance Tabard",
		hands="Malignance Tabard",
		ring1="Petrov Ring",
		ring2="Mummu Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		--waist="Gerdr Belt +1",
		legs="Malignance Tights",
		feet="Malignance Boots"
		}

    sets.engaged.DW = {main="Naegling", ammo=gear.RAbullet,
        head="Malignance Chapeau",
		neck="Iskur Gorget",
		ear1="Eabani Earring",
		ear2="Suppanomimi",
        body="Malignance Tabard",
		hands="Malignance Tabard",
		ring1="Rajas Ring",
		ring2="Epona's Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Windbuffet Belt +1",
		legs="Malignance Tights",
		feet="Malignance Boots"
		}
    
    sets.engaged.Acc.DW = {ammo=gear.RAbullet,
        head="Malignance Chapeau",
		neck="Iskur Gorget",
		ear1="Eabani Earring",
		ear2="Suppanomimi",
        body="Malignance Tabard",
		hands="Malignance Tabard",
		ring1="Rajas Ring",
		ring2="Epona's Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		--waist="Gerdr Belt +1",
		legs="Malignance Tights",
		feet="Malignance boots"
		}


    sets.engaged.Ranged = {main="Lanun Knife", ammo=gear.RAbullet,
        head="Ikenga's Hat",
		neck="Iskur Gorget",
		ear1="Telos Earring",
		ear2="Enervating Earring",
        body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Ilabrat Ring",
		ring2="Dingir Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Yemaya Belt",
		legs="Ikenga's Trousers",
		feet="Malignance Boots",
		}
		
	sets.buff['Triple Shot'] = {body="Chasseur's Frac +3"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
end

function midcast(spell)
	if spell.type == 'CorsairShot' then
		if spell.name == 'Light Shot' or spell.name == 'Dark Shot' then
			equip(sets.midcast.quickmacc)
		else
			weathercheck(spell.element,sets.QD[sets.QD.index[QD_ind]])
		end
	elseif spell.action_type == 'Ranged Attack' then
		if buffactive['Triple Shot'] then
			equip(sets.midcast['Triple Shot'])
		else
			equip(sets.midcast.RA)
		end
	end
	if (spell.name == 'Sneak' or spell.english == 'Spectral Jig' or spell.english:contains('Monomi')) and spell.target.name == player.name and buffactive["Sneak"] then
		send_command('cancel Sneak')
	elseif spell.english:contains('Utsusemi') then
		if buffactive["Copy Image"] then
			windower.send_command('wait 1;cancel 66;')
		elseif buffactive['Copy Image (2)'] then
			windower.send_command('wait 1;cancel 444')
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
    end
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 17)
end

