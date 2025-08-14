include('organizer-lib')
include('SendCommands.lua')

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
    Custom commands:
    
    gs c petweather
        Automatically casts the storm appropriate for the current avatar, if possible.
    
    gs c siphon
        Automatically run the process to: dismiss the current avatar; cast appropriate
        weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
        and re-summon the avatar.
        
        Will not cast weather you do not have access to.
        Will not re-summon the avatar if one was not out in the first place.
        Will not release the spirit if it was out before the command was issued.
        
    gs c pact [PactType]
        Attempts to use the indicated pact type for the current avatar.
        PactType can be one of:
            cure
            curaga
            buffOffense
            buffDefense
            buffSpecial
            debuff1
            debuff2
            sleep
            nuke2
            nuke4
            bp70
            bp75 (merits and lvl 75-80 pacts)
            astralflow
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false

    spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
    avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith", "Siren"}

    magicalRagePacts = S{
        'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen',
        'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
        'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV',
        'Thunderspark','Burning Strike','Meteorite','Nether Blast','Flaming Crush',
        'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall','Thunderstorm',
        'Holy Mist','Lunar Bay','Night Terror','Level ? Holy', 'Tornado II'}


    pacts = {}
    pacts.cure = {['Carbuncle']='Healing Ruby'}
    pacts.curaga = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
    pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega', ['Ramuh']='Rolling Thunder',
        ['Fenrir']='Ecliptic Growl',['Siren']='Katabatic Blades'}
    pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II', ['Siren']='Chinook'}
    pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', ['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud',
        ['Carbuncle']='Soothing Ruby', ['Fenrir']='Heavenward Howl', ['Cait Sith']='Raise II', ['Siren']="Wind's Blessing"}
    pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
        ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye', ['Siren']='Bitter Elegy'}
    pacts.debuff2 = {['Shiva']='Sleepga', ['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence', ['Siren']='Lunatic Voice'}
    pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby', ['Siren']='Sonic Buffet'}
    pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
        ['Ramuh']='Thunder II', ['Leviathan']='Water II'}
    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
        ['Ramuh']='Thunder IV', ['Leviathan']='Water IV', ['Siren']='Tornado II'}
    pacts.bp70 = {['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
        ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
        ['Diabolos']='Nether Blast',['Cait Sith']='Regal Scratch', ['Siren']='Roundouse'}
    pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
        ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
        ['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy', ['Siren']='Hysteric Assault'}
    pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
        ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
        ['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor", ['Siren']='Clarsach Call'}

   end
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    gear.perp_staff = {name=""}
    
    select_default_macro_book()
	send_command('@input ; wait 1; input /lockstyleset 3')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {head="Glyphic Horn +3"}
    
    sets.precast.JA['Elemental Siphon'] = {
	main="Chatoyant Staff",sub="Vox Grip",ammo="Esper Stone +1",
	head="Baayami Hat +1",neck="Incanter's Torque",ear1="C. Palug Earring",ear2="Lodurr Earring",
	body="Beck. Doublet +1",hands="Baayami Cuffs +1",left_ring="Evoker's Ring",right_ring={name="Stikini Ring +1",bag="Wardrobe 2"},
	back="Conveyance Cape",waist="Kobo Obi",legs="Baayami Slops +1",feet="Beck. Pigaches +1"}

    sets.precast.JA['Mana Cede'] = {hands="Beck. Bracers +1"}

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = {main="Espiritus",sub="Vox Grip",ammo="Epitaph",
	head="Beckoner's Horn +1",neck="Incanter's Torque",ear1="C. Palug Earring",ear2="Lodurr Earring",
	body="Baayami Robe",hands="Baayami Cuffs +1",left_ring="Evoker's Ring",right_ring={name="Stikini Ring +1",bag="Wardrobe 2"},
    back="Conveyance Cape",waist="Kobo Obi",legs="Baayami Slops +1",feet="Baayami Sabots +1"}

    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        head={ name="Merlinic Hood", augments={'"Fast Cast"+6','Mag. Acc.+2','"Mag.Atk.Bns."+9',}},
		neck="Orunmila's Torque",
		ear1="Malignance Earring",
		ear2="Loquacious Earring",
        body="Inyanga Jubbah +2",
		hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+21','"Fast Cast"+6','"Mag.Atk.Bns."+4',}},
		left_ring="Kishar Ring",
		right_ring="Lebeche Ring",
		back="Fi Follet Cape +1",
        waist="Witful Belt",
		legs="Psycloth Lappas",
		feet={ name="Merlinic Crackows", augments={'"Fast Cast"+6','"Mag.Atk.Bns."+12',}}}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {}
	
	sets.precast.WS['Garland of Bliss'] = {ammo="Pemphredo Tathlum",
	head="Nyame Helm",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Malignance Earring",
	body="Nyame Mail",hands="Nyame Gauntlets",left_ring="Metamor. Ring +1",right_ring="Freke Ring",
	back={ name="Campestres's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},waist=gear.ElementalObi,legs="Nyame Flanchard",feet="Nyame Sollerets"}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}

	sets.midcast['Summoning Magic'] = {
	main="Espiritus",
	sub="Vox Grip",
	ammo="Epitaph",
	head="Beckoner's Horn +1",
	neck="Incanter's Torque",
	ear1="C. Palug Earring",
	ear2="Beck. Earring +1",
	body="Baayami Robe",
	hands="Baayami Cuffs +1",
	left_ring="Evoker's Ring",
	right_ring={name="Stikini Ring +1",bag="Wardrobe 2"},
	back="Campestres's Cape",
	--back="Conveyance Cape",
	waist="Kobo Obi",
	legs="Baayami Slops +1",
	feet="Bunzi's Sabots"
	}

    sets.midcast.Cure = {
	main="Daybreak",
	sub="Sors Shield",
	ammo="Esper Stone +1",
	head="Vanya Hood",
	neck="Incanter's Torque",
	ear1="Mendi. Earring",
	body="Bunzi's Robe",
	hands="Inyan. Dastanas +2",
	left_ring="Sirona's Ring",
	right_ring="Janniston Ring",
	legs="Vanya Slops",
	feet="Vanya Clogs"
	}

    sets.midcast.Stoneskin = {}

    sets.midcast['Elemental Magic'] = {}

    sets.midcast['Dark Magic'] = {}


    -- Avatar pact sets.  All pacts are Ability type.
    
    sets.midcast.Pet.BloodPactWard = {main="Espiritus",sub="Vox Grip",ammo="Epitaph",
	head="Baayami Hat +1",neck="Incanter's Torque",ear1="C. Palug Earring",ear2="Lodurr Earring",
	body="Baayami Robe",hands="Baayami Cuffs +1",left_ring="Evoker's Ring",right_ring={name="Stikini Ring +1",bag="Wardrobe 2"},
	back="Conveyance Cape",waist="Kobo Obi",legs="Baayami Slops +1",feet="Baaya. Sabots +1"}

    sets.midcast.Pet.DebuffBloodPactWard = {}
    
    sets.midcast.Pet.PhysicalBloodPactRage = {main="Nirvana",sub="Elan Strap +1",ammo="Epitaph",
	head="C. Palug Crown",
	neck="Smn. Collar +2",
	ear1="Gelos Earring",
	ear2="Lugalbanda Earring",
	body="Con. Doublet +3",
	hands="Merlinic Dastanas",
	left_ring="C. Palug Ring",
	right_ring="Varar Ring +1",
	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	waist="Incarnation Sash",
	legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
	feet="Convo. Pigaches +3"}

    sets.midcast.Pet.PhysicalBloodPactRage.Acc = {}

    sets.midcast.Pet.MagicalBloodPactRage = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+5','Pet: INT+14','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+25',}},sub="Elan Strap +1",ammo="Epitaph",
	head="Glyphic Horn +3",neck="Adad Amulet",ear1="Gelos Earring",ear2="Lugalbanda Earring",
	body="Apo. Dalmatica +1",hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+18','Blood Pact Dmg.+10','Pet: INT+3',}},left_ring="Speaker's Ring",right_ring="Varar Ring +1",
	back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Pet: Damage taken -5%',}},waist="Regal Belt",legs={ name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},feet="Apogee Pumps +1"}

    sets.midcast.Pet.MagicalBloodPactRage.Acc = {}
	
	sets.midcast.Pet["Wind's Blessing"] = set_combine(sets.midcast.Pet.BloodPactWard,{main="Nirvana",
	head={ name="Merlinic Hood", augments={'Pet: "Mag.Atk.Bns."+19','Pet: Crit.hit rate +4','Pet: MND+15','Pet: Mag. Acc.+7',}},
	neck="Smn. Collar +2",
	body={ name="Merlinic Jubbah", augments={'Pet: Mag. Acc.+2','"Blood Pact" ability delay -1','Pet: MND+15','Pet: "Mag.Atk.Bns."+9',}},
	hands="Lamassu Mitts +1",
	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	legs="Assid. Pants +1",
	feet={ name="Merlinic Crackows", augments={'Pet: "Dbl. Atk."+1','Pet: MND+15','Pet: Mag. Acc.+15','Pet: "Mag.Atk.Bns."+9',}}})


    -- Spirits cast magic spells, which can be identified in standard ways.
    
    sets.midcast.Pet.WhiteMagic = set_combine(sets.midcast.Pet["Wind's Blessing"])
    
    sets.midcast.Pet['Elemental Magic'] = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+5','Pet: INT+14','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+25',}},sub=" ",ammo="Epitaph",
	head="Glyphic Horn +3",neck="Adad Amulet",ear1="Gelos Earring",ear2="Lugalbanda Earring",
	body="Apo. Dalmatica +1",hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+18','Blood Pact Dmg.+10','Pet: INT+3',}},left_ring="Speaker's Ring",right_ring="Varar Ring +1",
	back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Pet: Damage taken -5%',}},waist="Regal Belt",legs="Glyphic Spats +3",feet="Apogee Pumps +1"}
    

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {main="Nirvana",sub="Khonsu",ammo="Epitaph",
	head="Beckoner's Horn +1",neck="Loricate Torque +1",ear1="C. Palug Earring",ear2="Tuisto Earring",
	body="Shomonjijoe +1",hands="Asteria Mitts +1",left_ring={name="Stikini Ring +1",bag="Wardrobe2"},right_ring={name="Stikini Ring +1",bag="Wardrobe5"},
	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},waist="Fucho-no-Obi",legs="Assid. Pants +1",feet="Crier's Gaiters"}

    sets.idle.PDT = {}
    
    sets.idle.Avatar = {main="Gridarvor",
	sub="Vox Grip",
	ammo="Epitaph",
	head="Beckoner's Horn +1",
	neck="Loricate Torque +1",
	ear1="C. Palug Earring",
	ear2="Tuisto Earring",
	body="Shomonjijoe +1",
	hands="Asteria Mitts +1",
	left_ring="Evoker's Ring",
	right_ring="Stikini Ring +1",
	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	waist="Fucho-no-Obi",
	legs="Inyanga Shalwar +2",
	feet="Beck. Pigaches +1"
	}

    sets.idle.PDT.Avatar = {}

    sets.idle.Spirit = {main="Gridarvor",sub="Vox Grip",ammo="Epitaph",
	head="Beckoner's Horn +1",neck="Loricate Torque +1",ear1="C. Palug Earring",ear2="Tuisto Earring",
	body="Shomonjijoe +1",hands="Asteria Mitts +1",left_ring="Evoker's Ring",right_ring={name="Stikini Ring +1",bag="Wardrobe 2"},
	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	waist="Fucho-no-Obi",
	legs="Inyanga Shalwar +2",
	feet="Beck. Pigaches +1"}

    -- Favor uses Caller's Horn instead of Convoker's Horn for refresh
    sets.idle.Avatar.Favor = {
	main="Espiritus",
	sub="Vox Grip",
	ammo="Epitaph",
	head="Beckoner's Horn +1",
	neck="Incanter's Torque",
	ear1="C. Palug Earring",
	ear2="Lodurr Earring",
	body="Beck. Doublet +1",
	hands="Baayami Cuffs +1",
	left_ring="Evoker's Ring",
	right_ring={name="Stikini Ring +1",bag="Wardrobe 2"},
	back="Conveyance Cape",
	waist="Lucidity Sash",
	legs="Baayami Slops +1",
	feet="Baaya. Sabots +1"
	}
	
    sets.idle.Avatar.Melee = {
	main="Gridarvor",
	sub="Vox Grip",
	ammo="Epitaph",
	head="Beckoner's Horn +1",
	neck="Incanter's Torque",
	ear1="C. Palug Earring",
	ear2="Lodurr Earring",
	body="Beck. Doublet +1",
	hands="Baayami Cuffs +1",
	left_ring="Evoker's Ring",
	right_ring={name="Stikini Ring +1",bag="Wardrobe 2"},
	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	waist="Lucidity Sash",
	legs="Beck. Spats +1",
	feet="Beck. Pigaches +1"
	}
        
    sets.perp = {}
    
    sets.perp.Day = {}
    sets.perp.Weather = {}
    sets.perp.Carbuncle = {"Asteria Mitts +1"}
	sets.perp['Cait Sith'] = {"Lamassu Mitts +1"}
    sets.perp.Alexander = sets.midcast.Pet.BloodPactWard
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {feet="Crier's Gaiters"}
    
    sets.latent_refresh = {waist="Fucho-no-obi"}
    
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
	left_ring="Shadow Ring",
	right_ring="Defending Ring",
	back="Moonbeam Cape",
	waist="Null Belt",
	}		

    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {
	ammo="Epitaph",
	head="Blistering Sallet +1",
	neck="Shulmanu Collar",
	ear1="Brutal Earring",
	ear2="Crep. Earring",
	body="Glyphic Doublet +3",
	hands="Bunzi's Gloves",
	left_ring="C. Palug Ring",
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Haste+10','Phys. dmg. taken-10%',}},
	waist="Windbuffet Belt +1",
	legs="Nyame Flanchard",
	feet="Battlecast Gaiters"
	}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.english == "Astral Conduit" then
		disable('main','sub','range','ammo','head','neck','ear1','ear2','body','hands','left_ring','right_ring','back','waist','legs','feet')
	end
end


function job_midcast(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
	if buff == "Astral Conduit" and not gain then
		enable('main','sub','range','ammo','head','neck','ear1','ear2','body','hands','left_ring','right_ring','back','waist','legs','feet')
	end
end


-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    else
        select_default_macro_book('reset')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell)
    if spell.type == 'BloodPactRage' then
        if magicalRagePacts:contains(spell.english) then
            return 'MagicalBloodPactRage'
        else
            return 'PhysicalBloodPactRage'
        end
    elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
        return 'DebuffBloodPactWard'
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        if pet.element == world.day_element then
            idleSet = set_combine(idleSet, sets.perp.Day)
        end
        if pet.element == world.weather_element then
            idleSet = set_combine(idleSet, sets.perp.Weather)
        end
        if sets.perp[pet.name] then
            idleSet = set_combine(idleSet, sets.perp[pet.name])
        end
        gear.perp_staff.name = elements.perpetuance_staff_of[pet.element]
        if gear.perp_staff.name and (player.inventory[gear.perp_staff.name] or player.wardrobe[gear.perp_staff.name]) then
            idleSet = set_combine(idleSet, sets.perp.staff_and_grip)
        end
        if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Favor)
        end
        if pet.status == 'Engaged' then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
        end
    end
    
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'petweather' then
        handle_petweather()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'siphon' then
        handle_siphoning()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'pact' then
        handle_pacts(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1] == 'reset_ward_flag' then
        wards.flag = false
        wards.spell = ''
        eventArgs.handled = true
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Cast the appopriate storm for the currently summoned avatar, if possible.
function handle_petweather()
    if player.sub_job ~= 'SCH' then
        add_to_chat(122, "You can not cast storm spells")
        return
    end
        
    if not pet.isvalid then
        add_to_chat(122, "You do not have an active avatar.")
        return
    end
    
    local element = pet.element
    if element == 'Thunder' then
        element = 'Lightning'
    end
    
    if S{'Light','Dark','Lightning'}:contains(element) then
        add_to_chat(122, 'You do not have access to '..elements.storm_of[element]..'.')
        return
    end 
    
    local storm = elements.storm_of[element]
    
    if storm then
        send_command('@input /ma "'..elements.storm_of[element]..'" <me>')
    else
        add_to_chat(123, 'Error: Unknown element ('..tostring(element)..')')
    end
end


-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end

    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
    
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
            if not S{'Light','Dark','Lightning'}:contains(pet.element) then
                stormElementToUse = pet.element
            end
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            -- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            if world.weather_element == elements.weak_to[world.day_element] and
                (not pet.isvalid or world.weather_element ~= pet.element) then
                -- We can't cast lightning/dark/light weather, so use a neutral element
                if S{'Light','Dark','Lightning'}:contains(world.day_element) then
                    stormElementToUse = 'Wind'
                else
                    stormElementToUse = world.day_element
                end
            end
        end
    end
    
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end
    
    local command = ''
    local releaseWait = 0
    
    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end
    
    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
    
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
        
        command = command..'input /pet "Release" <me>;'
    end
    
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
    
    send_command(command)
end

-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
function handle_pacts(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use pacts in town.')
        return
    end

    if not pet.isvalid then
        add_to_chat(122,'No avatar currently available. Returning to default macro set.')
        select_default_macro_book('reset')
        return
    end

    if spirits:contains(pet.name) then
        add_to_chat(122,'Cannot use pacts with spirits.')
        return
    end

    if not cmdParams[2] then
        add_to_chat(123,'No pact type given.')
        return
    end
    
    local pact = cmdParams[2]:lower()
    
    if not pacts[pact] then
        add_to_chat(123,'Unknown pact type: '..tostring(pact))
        return
    end
    
    if pacts[pact][pet.name] then
        if pact == 'astralflow' and not buffactive['astral flow'] then
            add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
            return
        end
        
        -- Leave out target; let Shortcuts auto-determine it.
        send_command('@input /pet "'..pacts[pact][pet.name]..'"')
    else
        add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
    end
end

function job_self_command(command)
		if command[1] == 'PhysAC' then
			equip(sets.midcast.Pet.PhysicalBloodPactRage)
		elseif command[1] == 'MagicAC' then
			equip(sets.midcast.Pet.MagicalBloodPactRage)
		end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    set_macro_page(1, 15)
end