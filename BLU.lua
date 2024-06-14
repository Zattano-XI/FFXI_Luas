target_distance = 8

res = require 'resources'

BarElements = S{"Barfira","Barblizzara","Baraera","Barstonra","Barthundra","Barwatera"}
BarAilments = S{"Barsleepra","Barpoisonra","Barparalyzra","Barblindra","Barsilencera","Barpetra","Barvira","Baramnesra"}
NaSpells = S{"Blindna","Erase","Paralyna","Poisona","Silena","Stona","Viruna"}
BoostSpells = S{"Boost-STR","Boost-DEX","Boost-VIT","Boost-AGI","Boost-INT","Boost-MND","Boost-CHR"}
EnfeeblingMND = S{"Paralyze","Slow"}
EnfeeblingINT = S{"Blind","Bind","Dispel","Sleep","Sleep II","Sleepga","Sleepga II","Poison","Poison II","Poisonga"}

function get_sets()
	sets.fc = {}
	sets.precast = {}
	sets.midcast = {}
	sets.aftercast = {}
	sets.ja = {}
	sets.ws = {}
	sets.buff = {}
	sets.misc = {}
	sets.idle = {}
	sets.nuke = {}
	sets.TP = {}
	
----------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Fast Cast ---------------------------------------------------
----------------------------------------------------------------------------------------------------------------
	
	sets.fc.base = { --2+14+4+2+1+9+5+4+10+3+8+8=74 with Sakpata's sword
    ammo="Sapience Orb", --2
    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --14
	neck="Baetyl Pendant", --4
	left_ear="Loquac. Earring", --2
    right_ear="Etiolation Earring", --1
    body="Adamantite Armor",
    hands="Leyline Gloves", --8
	left_ring="Kishar Ring", --4
    right_ring="Lebeche Ring",
	back={ name="Fi Follet Cape +1", augments={'Path: A',}}, --10
	waist="Witful Belt", --3
    legs="Enif Cosciales", --8
    feet="Carmine Greaves +1", --8
	}
	
	sets.fc.cure = set_combine(sets.fc.base, {
	})
	
	sets.fc.healing = set_combine(sets.fc.base, {
	})
	
	sets.fc.stoneskin = set_combine(sets.fc.base, {
	})
	
	sets.fc['Enhancing Magic'] = set_combine(sets.fc.base, {
	})
	
---------------------------------------------------------------------------------------------------------------
--------------------------------------------------- MIDCAST ---------------------------------------------------
---------------------------------------------------------------------------------------------------------------

	sets.TP.index = {'Hybrid','DT','Standard','Learning',}
	TP_ind = 1 --Standard set is the Default
	
	sets.TP['Standard'] = {
	ammo="Coiste Bodhar",
	head="Adhemar Bonnet +1",
	neck="Combatant's Torque",
	left_ear="Suppanomimi",
	right_ear="Hashi. Earring +2",
	body="Malignance Tabard",
	hands="Adhemar Wristbands +1",
	left_ring="Ilabrat Ring",
	right_ring="Petrov Ring",
	back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},	waist="Reiki Yotai",
	legs="Malignance Tights",
	feet="Gleti's Boots",
	
	--main={ name="Naegling", priority=1,},
	--sub={ name="Sakpata's Sword", priority=2,},
	--left_ear="Dedition Earring",
	--right_ear="Telos Earring",
	--hands="Magus Bazubands",
	--back="Aurist's Cape +1",
	--waist="Kentarch Belt +1",
	}
	
	sets.TP['Hybrid'] = {
		ammo="Coiste Bodhar",
		head="Nyame Helm",
		neck="Mirage Stole +2",
		left_ear="Eabani Earring",
		right_ear="Hashi. Earring +2",	
		body="Gleti's Cuirass", 
		hands="Adhemar Wristbands +1",
		left_ring={name="Chirich Ring +1", bag="wardrobe2"},
		right_ring={name="Chirich Ring +1", bag="wardrobe5"},
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},		
		waist="Reiki Yotai",
		legs="Malignance Tights",
		feet="Nyame Sollerets",
    }
	
	sets.TP['Learning'] = {
	--main={ name="Trainee Burin", priority=1,},
	--main={ name="Blizzard Brand +1", priority=1,},
	--sub={ name="Genmei Shield", priority=2,},
	ammo="Coiste Bodhar",
	head="Carmine Mask +1",
	neck="Combatant's Torque",
	left_ear="Odr Earring",
	right_ear="Telos Earring",
	body="Malignance Tabard",
	hands="Magus Bazubands",
	left_ring="Cacoethic Ring",
	right_ring="Cacoethic Ring +1",
	back="Aurist's Cape +1",
	waist="Kentarch Belt +1",
	legs="Malignance Tights",
	feet="Gleti's Boots"
	}
	
	sets.TP['DT'] = set_combine(sets.TP['Hybrid'], { --49
	head="Nyame Helm", --7
	--body="Nyame Mail", --9
	hands="Nyame Gauntlets", --7
	right_ring="Defending Ring", --10
	legs="Carmine Cuisses +1",
	feet="Nyame Sollerets" --7
	})
	
	sets.nuke.index = {'Free'}
	nuke_ind = 1 --Free set is the Default
	
	sets.nuke['Free'] = {
	--main={ name="Bunzi's Rod", priority=2,},
	--sub={ name="Maxentius", priority=1,},
	ammo="Ghastly Tathlum +1",
	head=empty,
	neck="Baetyl Pendant",
	left_ear="Regal Earring",
	right_ear="Friomisi Earring",
	body="Cohort Cloak +1",
	hands="Amalric Gages +1",
	left_ring="Stikini Ring +1",
	right_ring="Metamorph Ring +1",
	back="Aurist's Cape +1",
	waist="Orpheus's Sash",
	legs="Amalric Slops +1",
	feet="Amalric Nails +1"
	}
	
	sets.idle.index = {'Refresh','DT'}--,'PDT','MDT'}
	idle_ind = 1 --Refresh set is the Default
	
	sets.idle['Refresh'] = set_combine(sets.TP['DT'], {
	left_ring="Warp Ring",
	legs="Carmine Cuisses +1",
	})
	
	sets.idle['DT'] = sets.TP['DT']
	
	sets.midcast.enhancing = {}
	sets.midcast.enhancingduration = set_combine(sets.enhancing, {
	head="Telchine Cap",
	body="Telchine Chasuble",
	hands="Telchine Gloves",
	legs="Telchine Braconi",
	feet="Telchine Pigaches"
	})
	
	sets.midcast.blueskill = {
	--ammo="Mavi Tathlum",
	neck="Incanter's Torque",
	ear2="Hashishin Earring",
	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	ring2={name="Stikini Ring +1", bag="wardrobe5"},
	back="Cornflower Cape",
	}
	
	sets.midcast.cure = { --Stack healing skill
	ammo="Pemphredo Tathlum",
	head="Nyame Helm",
	neck="Incanter's Torque",
	left_ear="Beatific Earring",
	right_ear="Meili Earring",
	body="Nyame Mail",
	hands="Telchine Gloves",
	left_ring="Menelaus's Ring",
	right_ring="Janniston Ring",
	back="Solemnity Cape",
	waist="Bishop's Sash",
	legs="Carmine Cuisses +1",
	feet="Nyame Sollerets"
	}
	
	sets.midcast.magicacc = {
		ammo="Mavi Tathlum",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Mirage Stole +2",
		waist="Acuity Belt +1",
		left_ear="Dignitary's Earring",
		right_ear="Hashi. Earring +2",
        ring1={name="Stikini Ring +1", bag="wardrobe2"},
        ring2={name="Stikini Ring +1", bag="wardrobe5"},
		--back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%'}},
		back="Aurist's Cape +1",
	}
	
	sets.midcast.dark = set_combine(sets.nuke['Free'], {
	head="Pixie Hairpin +1",
	body="Jhakri Robe +2",
	left_ring="Archon Ring",
	})
	
	sets.midcast.breath = set_combine(sets.nuke['Free'], {
	--ammo="Mavi Tathlum",
	--head="Luh. Keffiyeh +3",
	})

---------------------------------------------------------------------------------------------------------------
---------------------------------------------------- MISC -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
	
	sets.ws.common = {
	head="Nyame Helm",
	neck="Fotia Gorget",
	ear2="Hashi. Earring +2",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	ring1="Beithir Ring",
	ring2="Cornelia's Ring",
	back={name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	--back="Aurist's Cape +1",
	waist="Fotia Belt",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"
	}
	
	sets.ws['Savage Blade'] = {
    ammo="Aurgelmir Orb +1",
	--head="Hashi. Kavuk +3",
	head="Nyame Helm",
	neck="Mirage Stole +2",
    ear1="Ishvara Earring",
    ear2="Hashi. Earring +2",
	body="Nyame Mail",
    hands="Nyame Gauntlets",
	ring1="Sroda ring",
	ring2="Cornelia's Ring",
	back={name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    waist="Sailfi Belt +1",
    legs="Nyame Flanchard",
    feet="Nyame Gauntlets",
	}
	
	sets.ws['Expiacion'] = set_combine(sets.ws['Savage Blade'], {
        body="Gleti's Cuirass",
		ring1="Beithir Ring",	
        waist="Kentarch Belt +1",
        --legs="Gleti's Breeches",
    })
	
	sets.ws['Sanguine Blade'] = set_combine(sets.ws.common, {
	head="Pixie Hairpin +1",
	neck="Sibyl Scarf",
	left_ear="Regal Earring",
	right_ear="Friomisi Earring",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	left_ring="Archon Ring",
	back="Aurist's Cape +1",
	waist="Orpheus's Sash",
	legs="Nyame Flanchard",
	--feet="Amalric Nails +1"
	feet="Nyame Sollerets",
	})


    sets.ws['Chant du Cygne'] = set_combine(sets.ws.common, {
        ammo="Aurgelmir Orb +1",
		head="Adhemar Bonnet +1",
		body="Gleti's Cuirass",
        hands="Gleti's Gauntlets",
        waist="Fotia Belt",
        legs="Gleti's Breeches",
        feet="Gleti's Boots",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}, --Dex,acc/atc/Crit+10
		neck="Mirage Stole +2",
        ear1="Odr Earring",
        ear2="Mache Earring +1",
		ring1="Epona's ring",
		ring2="Ilabrat Ring",
    })
	
	sets.phalanx = {
		head="Herculean Helm",
		body="Herculean Vest",
		hands="Herculean Gloves",
		legs="Herculean Trousers",
		feet="Herculean Boots",
	}
end

function check_height() 
	selfz = math.floor(windower.ffxi.get_mob_by_index(player.index).z * 10)/10
	targetz = math.floor(windower.ffxi.get_mob_by_index(player.target.index).z * 10)/10
	heightdiff = selfz - targetz
	targdistance = math.floor(windower.ffxi.get_mob_by_index(player.target.index).distance:sqrt() * 10+0.5)/10
end

function precast(spell)
	if buffactive['Stun'] or buffactive['Petrify'] or ((spell.action_type == "WeaponSkill" or spell.action_type == "JobAbility") and buffactive['Amnesia']) or (spell.action_type == 'Magic' and buffactive['Silence']) then
		cancel_spell()
	elseif (sets.ja[spell.english]) then
		equip(sets.ja[spell.english])
	elseif spell.action_type == 'Magic' then
		equip(sets.fc.base)
	elseif spell.type == "WeaponSkill" then 
		local range_mult = {
			[2] = 1.55,
			[3] = 1.490909,
			[4] = 1.44,
			[5] = 1.377778,
			[6] = 1.30,
			[7] = 1.15,
			[8] = 1.25,
			[9] = 1.377778,
			[10] = 1.45,
			[11] = 1.454545454545455,
			[12] = 1.666666666666667,
		}
		ability_distance = res.weapon_skills[spell.id].range
		if player.tp < 1000 then
			cancel_spell()
		elseif spell.target.distance > (ability_distance * range_mult[ability_distance] + spell.target.model_size + player.model_size) then
			cancel_spell()
			add_to_chat(123, spell.name..' Canceled: [Out of Range]')
		elseif player.tp > 1000 then
			if player.tp >= 1000 and player.tp < 2750 then
				equip({left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}}})
			else
				equip({left_ear="Ishvara Earring"})
			end
			if sets.ws[spell.name] then
				equip(sets.ws[spell.name])
			else
				equip(sets.ws.common)
			end
		end
	end
end

function midcast(spell)
	if spell.action_type == 'Magic' and not spell.type:contains('Trust') then
		if spell.skill == 'Blue Magic' then
			if Blue_SkillBasedBuff:contains(spell.name) then
				equip(sets.midcast.blueskill)
			elseif Blue_Healing:contains(spell.name) then
				equip(sets.midcast.cure)
			elseif Blue_MagicalStat:contains(spell.name) then
				equip(sets.nuke[sets.nuke.index[nuke_ind]])
			elseif Blue_MagicalDark:contains(spell.name) then
				equip(sets.midcast.dark)
			elseif Blue_PhysicalStat:contains(spell.name) or Blue_MagicAccuracy:contains(spell.name) or Blue_StunPhysical:contains(spell.name) or Blue_StunMagical:contains(spell.name) then
				equip(sets.midcast.magicacc)
			elseif Blue_Breath:contains(spell.name) then
				equip(sets.midcast.breath)
			end
		elseif spell.skill == "Enhancing Magic" then
			equip(sets.midcast.enhancingduration)
		elseif spell.skill == 'Elemental Magic' then
			equip(sets.nuke[sets.nuke.index[nuke_ind]])
		end
	end
	
	if spell.name == "Stoneskin" and buffactive["Stoneskin"] then
		send_command('cancel Stoneskin')
	elseif (spell.name == 'Sneak' or spell.english == 'Spectral Jig') and spell.target.name == player.name and buffactive["Sneak"] then
		send_command('cancel Sneak')
	elseif string.find(spell.english,'Utsusemi') and buffactive["Copy Image"] then
		send_command('@wait 1;cancel 66;')
	end
end

function aftercast(spell)
	if player.status == "Idle" then
		equip(sets.idle[sets.idle.index[idle_ind]])
		if player.mpp <= 25 then
			equip({head="Rawhide Mask",body="Jhakri Robe +2",left_ring={name="Stikini Ring +1", bag="wardrobe2"},right_ring={name="Stikini Ring +1", bag="wardrobe5"},waist="Fucho-no-Obi"})
		end
	elseif player.status == "Engaged" then
		equip(sets.TP[sets.TP.index[TP_ind]])
		--if player.mpp <= 45 then
		--	equip({body="Jhakri Robe +2",left_ring="Stikini Ring +1",waist="Fucho-no-Obi"})
		--end
	end
end

function status_change(new,old)
	if new == 'Resting' then
		equip(sets.misc.rest)
	elseif new == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	else
		equip(sets.idle[sets.idle.index[idle_ind]])
		if player.mpp <= 45 then
			equip({waist="Fucho-no-Obi"})
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
	end
end

function weathercheck(spell_element,set)
    if not set then
		return
	end
    if spell_element == world.weather_element or spell_element == world.day_element then
		equip(set,{back="Twilight Cape",waist="Hachirin-no-Obi"})
    else
		equip(set)
    end
    if set[spell_element] then
		equip(set[spell_element])
	end
end

function zodiaccheck(spell_element)
    if spell_element == world.day_element and spell_element ~= 'Dark' and spell_element ~= 'Light' then
        equip({left_ring="Zodiac Ring"})
    end
end

function self_command(command)
	if command == 'toggle TP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip(sets.TP[sets.TP.index[TP_ind]])
    end
	if command == 'toggle idle set' then
		idle_ind = idle_ind +1
		if idle_ind > #sets.idle.index then idle_ind = 1 end
		windower.add_to_chat(1,'<----- idle Set changed to '..sets.idle.index[idle_ind]..' ----->')
		equip(sets.idle[sets.idle.index[idle_ind]])
	end
	if command == 'toggle nuke set' then
		nuke_ind = nuke_ind +1
		if nuke_ind > #sets.nuke.index then nuke_ind = 1 end
		windower.add_to_chat(1,'<----- nuke Set changed to '..sets.nuke.index[nuke_ind]..' ----->')
	end
end

send_command('bind @s gs c toggle TP set') -- Hit win+s, toggles the sets
send_command('bind @e gs c toggle idle set') -- Hit win+e, toggles the sets
send_command('bind @n gs c toggle nuke set') -- Hit win+n, toggles the sets
send_command('bind @u gs equip low_hp;wait 1; gs equip high_hp')

function file_unload()
    send_command('unbind @q')
	send_command('unbind @e')
	send_command('unbind @a')
	send_command('unbind @n')
	send_command('unbind @u')
end

windower.register_event('zone change',function()
		if world.area:contains("Windurst") or world.area:contains("Heaven's") then
		elseif world.area:contains("Bastok") or world.area:contains("Metalworks") then
		elseif world.area:contains("San d'Oria") or world.area:contains("Chateau d'Oraguille") then
		elseif world.area:contains("Adoulin") then
			equip({body="Councilor's Garb"})
		end
end)

------------------------------------------
-- Macro and Style Change on Job Change
------------------------------------------

function set_macros(sheet,book)
    if book then
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
	add_to_chat (55, 'You are on '..('Blue Mage'):color(5)..('. '):color(55)..''..('Macros set!'):color(121))
end
 
function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end

WEAPON_ind = 1
 
--Page, Book--
set_macros(1,16)
--Use the Lockstyle Number--
set_style(016)

-- Physical spell list, not enough difference to be specified
Blue_PhysicalStat = S{'Bilgestorm','Heavy Strike','Battle Dance','Bloodrake','Death Scissors','Dimensional Death','Empty Thrash','Quadrastrike','Saurian Slide','Sinker Drill','Spinal Cleave','Sweeping Gouge','Uppercut','Vertical Cleave','Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment','Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad','Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive','Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam','Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash','Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream','Pinecone Bomb','Spiral Spin','Wild Oats','Mandibular Bite','Queasyshroom','Ram Charge','Screwdriver','Tourbillion','Bludgeon'}

--[[
--- Physical spells with no particular (or known) stat mods
-Blue_Physical = S{'Bilgestorm'}
-
--- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
-Blue_PhysicalAcc = S{'Heavy Strike'}
-
--- Physical spells with Str stat mod
-Blue_PhysicalStr = S{'Battle Dance','Bloodrake','Death Scissors','Dimensional Death','Empty Thrash','Quadrastrike','Saurian Slide','Sinker Drill','Spinal Cleave','Sweeping Gouge','Uppercut','Vertical Cleave'}
-
--- Physical spells with Dex stat mod
-Blue_PhysicalDex = S{'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment','Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad','Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive'}
-
--- Physical spells with Vit stat mod
-Blue_PhysicalVit = S{'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam','Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'}
-
--- Physical spells with Agi stat mod
-Blue_PhysicalAgi = S{'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream','Pinecone Bomb','Spiral Spin','Wild Oats'}
-
--- Physical spells with Int stat mod
-Blue_PhysicalInt = S{'Mandibular Bite','Queasyshroom'}
-
--- Physical spells with Mnd stat mod
-Blue_PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'}
-
--- Physical spells with Chr stat mod
-Blue_PhysicalChr = S{'Bludgeon'}

-- Physical spells with HP stat mod
Blue_PhysicalHP = S{'Final Sting'}
]]

-- Magical spell list, not enough difference to be specified
Blue_MagicalStat = S{'Anvil Lightning','Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Droning Whirlwind','Embalming Earth','Entomb','Firespit','Foul Waters','Ice Break','Leafstorm','Maelstrom','Molting Plumage','Nectarous Deluge','Regurgitation','Rending Deluge','Scouring Spate','Silent Storm','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb','Blinding Fulgor','Diffusion Ray','Radiant Breath','Rail Cannon','Retinal Glare','Acrid Stream','Magic Hammer','Mind Blast','Mysterious Light','Thermal Pulse','Charged Whisker','Gates of Hades'}

-- Magical spells with the typical Int mod
--Blue_Magical = S{'Anvil Lightning','Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Droning Whirlwind','Embalming Earth','Entomb','Firespit','Foul Waters','Ice Break','Leafstorm','Maelstrom','Molting Plumage','Nectarous Deluge','Regurgitation','Rending Deluge','Scouring Spate','Silent Storm','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb'}

Blue_MagicalDark = S{'Dark Orb','Death Ray','Eyes On Me','Evryone. Grudge','Palling Salvo','Tenebral Crush'}

--[[
Blue_MagicalLight = S{'Blinding Fulgor','Diffusion Ray','Radiant Breath','Rail Cannon','Retinal Glare'}

-- Magical spells with a primary Mnd mod
Blue_MagicalMnd = S{'Acrid Stream','Magic Hammer','Mind Blast'}

-- Magical spells with a primary Chr mod
Blue_MagicalChr = S{'Mysterious Light'}

-- Magical spells with a Vit stat mod (on top of Int)
Blue_MagicalVit = S{'Thermal Pulse'}

-- Magical spells with a Dex stat mod (on top of Int)
Blue_MagicalDex = S{'Charged Whisker','Gates of Hades'}
]]
-- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
-- Add Int for damage where available, though.
Blue_MagicAccuracy = S{'1000 Needles','Absolute Terror','Actinic Burst','Atra. Libations','Auroral Drape','Awful Eye', 'Blank Gaze','Blistering Roar','Blood Saber','Chaotic Eye','Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest','Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar','Geist Wall','Infrasonics','Jettatura','Light of Penance','Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind','Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas','Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'}

-- Breath-based spells
Blue_Breath = S{'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave','Magnetite Cloud','Poison Breath','Self-Destruct','Thunder Breath','Vapor Spray','Wind Breath'}

-- Stun spells
Blue_StunPhysical = S{'Frypan','Head Butt','Sudden Lunge','Tail slap','Whirl of Rage'}
Blue_StunMagical = S{'Blitzstrahl','Temporal Shift','Thunderbolt'}

-- Healing spells
Blue_Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','Wild Carrot'}

-- Buffs that depend on blue magic skill
Blue_SkillBasedBuff = S{'Diamondhide','Magic Barrier','Metallic Body','Occultation'}

-- Other general buffs
Blue_Buff = S{'Amplification','Animating Wail','Barrier Tusk','Carcharian Verve','Cocoon','Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell','Memento Mori','Nat. Meditation','Orcish Counterstance','Plasma Charge','Pyric Bulwark','Reactor Cool','Refueling','Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion','Zephyr Mantle'}

Blue_Refresh = S{'Battery Charge'}

-- Spells that require Unbridled Learning to cast.
Unbridled_spells = S{'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Cesspool','Crashing Thunder','Cruel Joke','Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard','Polar Roar','Pyric Bulwark','Tearing Gust','Thunderbolt','Tourbillion','Uproot'}