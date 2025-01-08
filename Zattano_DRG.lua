res = require 'resources'

include('SendCommands.lua')

function get_sets()
	sets.fc = {}
	sets.precast = {}
	sets.midcast = {}
	sets.aftercast = {}
	sets.ja = {}
	sets.ws = {}
	sets.Obis = {}
	sets.buff = {}
	sets.misc = {}
	sets.TP = {}
	sets.WEAPON = {}
	
	sets.movement = {legs="Carmine cuisses +1"}
	
	--sets.fashion = {
	--main="Mutsunokami",
	--head=empty,
	--body="Samnuha coat",
	--hands="Shadow gauntlets",
	--legs="Emicho hose",
	--feet="Shadow sabatons"
	--}
	
	sets.fc.base = {
	--ammo="Sapience Orb",
	head="Carmine Mask +1",
	left_ear="Etiolation Earring",
	hands="Leyline Gloves",
	left_ring="Rahab ring",
	--legs="Arjuna Breeches",
	feet="Carmine Greaves +1",
	}
	
	
	sets.ja['Spirit Surge'] = {body="Pteroslaver Mail +1",}
	sets.ja['Call Wyvern'] = {body="Pteroslaver Mail +1", right_ear="Peltast's Earring +1",}
	sets.ja['Ancient Circle'] = {Legs="Vishap Brais +3",}
	sets.ja['Spirit Link'] = {
	
		head="Vishap armet +2",
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		hands="Peltast's Vambraces +1",
		}
	sets.ja['Steady Wing'] = {}
	sets.ja['Spirit Surge'] = {feet="Kasuga Sune-Ate +1"}
	
	sets.ja['Jump'] = {
    ammo="Seething bomblet",
    head="Flam. Zucchetto +2",
    body="Pteroslaver mail +3",
    --hands="Vis. Fng. Gaunt. +3",
	hands="Crusher's gauntlets",
    legs="Pteroslaver brais +3",
    --feet="Ostro Greaves",
    feet="Maenadic gambieras",
	neck="Vim Torque +1",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}, --stp?
    }
	
	sets.ja['High Jump'] = sets.ja['Jump']
	sets.ja['Spirit Jump'] = set_combine(sets.ja['Jump'], 
	{
	feet="peltast's schynbalds +1",
	body="Pteroslaver mail +3",
	})
	
    sets.ja['Soul Jump'] = set_combine(sets.ja['Jump'], 
	{
	body="Vishap Mail +2",
	--hands={ name="Acro Gauntlets", augments={'Accuracy+20 Attack+20','"Store TP"+6','STR+7 DEX+7',}},
	})
	
	sets.ja['Super Jump'] = {}

    sets.ja['Angon'] = {ammo="Angon", hands="Ptero. Fin. G. +3"}
	
	
	sets.TP.index = {'Hybrid', 'DT','High ACC',} --'Pet','Standard',
	TP_ind = 1 --Standard set is the Default
	
	sets.TP['Standard'] = { --sub war +27% + 56% gear = 83%
	ammo={ name="Coiste Bodhar", augments={'Path: A',}}, --3
    head="Nyame Helm", --7
    body={ name="Gleti's Cuirass", augments={'Path: A',}}, --5
    hands="Sulev. Gauntlets +2", --6
    legs={ name="Valorous Hose", augments={'Attack+17','"Dbl.Atk."+4','AGI+1',}}, --7
    feet="Flam. Gambieras +2", --6
    neck="Vim Torque +1",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}}, --5
    left_ear="Sherida Earring", --5
    right_ear="Telos Earring", --3
    left_ring="Niqmaddu Ring",  
    right_ring="Chirich Ring +1",
    --back={ name="Brigantia's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Attack+10','"Dbl.Atk."+10','Pet: "Regen"+5',}}, --10
	 back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
sets.TP['Hybrid'] = set_combine(sets.TP['Standard'], { --24DT, 48PDT, 8PetDT
	ammo="Coiste Bodhar", 
    --head="Hjarrandi Helm", --10DT
    body="Gleti's Cuirass", --9PDT
    --hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
    hands="Gleti's Gauntlets", --7PDT
	legs="Gleti's Breeches", --8PDT
    feet={ name="Nyame Sollerets", augments={'Path: B',}}, --7DT
    --neck={ name="Dgn. Collar +1", augments={'Path: A',}},
    neck="Vim Torque +1",
	waist="Ioskeha Belt +1", --sailfi
    left_ear="Sherida Earring",
    right_ear="Telos Earring", --telos?
    left_ring="Niqmaddu Ring",
    right_ring="Moonlight Ring",
    --back={ name="Brigantia's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Attack+10','"Dbl.Atk."+10','Pet: "Regen"+5',}},
	})

	sets.TP['DT'] = set_combine(sets.TP['Standard'], { --48%
	ammo="Staunch Tathlum +1",
    head="Nyame Helm", --7
    body="Nyame Mail", --9
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet={ name="Nyame Sollerets", augments={'Path: B',}}, --7
    --neck={ name="Dgn. Collar +1", augments={'Path: A',}},
    neck="Vim Torque +1",
	waist="Ioskeha Belt +1",
    left_ear="Odnowa Earring +1",
    right_ear="Telos Earring",
    left_ring="Defending Ring",
    right_ring="Moonlight Ring",
    --back="Moonbeam Cape",
	})
	
	sets.TP['High Acc'] = {
	ammo="Seething bomblet",
    head="Hjarrandi Helm",
    body="Hjarrandi Breastplate",
    hands="Emicho Gauntlets +1",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet="Flam. Gambieras +2",
    neck="Vim Torque +1",
    waist="Ioskeha Belt +1",
    left_ear="Digni. earring",
    right_ear="Telos Earring",
    left_ring="Varar Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Brigantia's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Attack+10','"Dbl.Atk."+10','Pet: "Regen"+5',}},
	}
	
	sets.TP['Pet'] = {
	ammo="Staunch Tathlum +1",
    head={ name="Valorous Mask", augments={'Pet: Mag. Acc.+11','Pet: "Regen"+5','Pet: Accuracy+11 Pet: Rng. Acc.+11','Pet: Attack+11 Pet: Rng.Atk.+11',}},
    body={ name="Gleti's Cuirass", augments={'Path: A',}},
    hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
    legs={ name="Emicho Hose", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3',}},
    feet={ name="Valorous Greaves", augments={'Pet: Attack+26 Pet: Rng.Atk.+26','Pet: "Regen"+1','Pet: Accuracy+11 Pet: Rng. Acc.+11',}},
    neck={ name="Dgn. Collar +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Moonlight Ring",
    --back={ name="Brigantia's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Attack+10','"Dbl.Atk."+10','Pet: "Regen"+5',}},
	 back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
		
	sets.idle = set_combine(sets.TP['Standard'], {
	ammo="Staunch tathlum +1",
	head="Crepuscular Helm",
	body="Crepuscular Mail",
	legs="Gleti's breeches",
	feet="Gleti's boots",
	neck="Dragoon collar +1",
	right_ear="Odnowa earring +1",
	left_ear="Odnowa earring",
	right_ring="Moonlight ring",
	left_ring="Cornelia's ring",
	waist="Ioskeha belt +1",
	back="Moonbeam cape",
	})
	
	sets.regen = {
	neck="Sanctity Necklace",
	--neck="Bathy Choker +1",
	right_ear="Infused Earring",
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
	}
	
	
	
	sets.ws.common = {
	 ammo="Knobkierrie",
    head="Nyame Helm",
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Nyame Gauntlets", --Pteroslayer finger gauntlets +3
    legs="Nyame Flanchard",
    feet="Sulev. Leggings +2",
	neck="Dragoon's collar +1",
    waist="Sailfi Belt +1",
    left_ear="Thrud Earring",
    right_ear="Peltast's Earring +1",
    left_ring="Regal ring",
    right_ring="Cornelia's Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws['Camlann\'s Torment'] = set_combine(sets.ws.common, {
	
	})
	
	sets.ws['Drakesbane'] = set_combine(sets.ws.common, {
	ammo="Knobkierrie",
    head="Gleti's Mask",
	--head="Blistering sallet +1",
	body="Hjarrandi Breast.",
    hands="Gleti's gauntlets",
    legs="Peltast's cuissots +1",
    feet="Sulev. Leggings +2",
	neck="Dragoon's collar +2",
    waist="Sailfi Belt +1",
    --right_ear="Sherida Earring",
    --left_ear="Thrud Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
	})
	
	sets.ws['Impulse Drive'] = set_combine(sets.ws.common, {
	
	body="Gleti's Cuirass",
	right_ring="Niqmaddu ring",
	left_ring="Regal ring",	
	})
	
	sets.ws['Sonic Thrust'] = set_combine(sets.ws.common, {
	head="Nyame Helm",
	body="Nyame Mail",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	waist="Eschan Stone",
	--right_ear="Thrud earring",
	--left_ear="Moonshade earring",
	right_ring="Niqmaddu ring",
	left_ring="Regal ring",	
	})
	
	
	sets.ws['Stardiver'] = set_combine(sets.ws.common, {
	ammo="Coiste Bodhar",
	neck="Fotia Gorget",
	--right_ear="Friomisi Earring",
	body="Gleti's cuirass",
	hands="Sulev.'s Gauntlets +2",
	waist="Sailfi belt +1",
	feet="Flamma gambieras +2",
	})
	
	sets.ws['Savage Blade'] = set_combine(sets.ws.common, {
	ammo="Knobkierrie",
	--head="Pteroslaver armet +3",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    --hands="Pteroslaver finger gauntlets +3",
    hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
    feet="Nyame Sollerets",
	--neck="Dragoon's collar +1",
    neck="Rep. Plat. Medal",
	waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    --left_ear="Moonshade Earring",
    --right_ear="Thrud Earring",
    --left_ring="Metamorph ring +1",
	left_ring="Regal Ring",
    right_ring="Cornelia's Ring",
	})
	
	sets.ja['Provoke'] = {--set_combine(sets.enmity, {
	ammo="Sapience Orb",
	head="Loess Barbuta +1",
	--neck="Unmoving Collar +1",
	left_ear="Cryptic Earring",
	right_ear="Friomisi Earring",
	left_ring="Eihwaz Ring",
	right_ring="Pernicious Ring",
	back="Reiki Cloak",
	--waist="Chaac Belt",
	}--)
	
	sets.weapon = set_combine(sets.TP['Standard'], {
	main="Trishula",
	sub="Utu Grip",
	})
	
	sets.WEAPON.index = {'Slashing','Piercing','Impulse','Blunt','Omen'}
	WEAPON_ind = 2 --Trishula set is the Default
	
	sets.WEAPON['Slashing'] = {
	main="Naegling",
	--sub="Utu Grip",
	}
	
	sets.WEAPON['Piercing'] = {
	main="Trishula",
	--main="Quint Spear",
	sub="Utu Grip",
	}
	
	sets.WEAPON['Impulse'] = {
	main="Shining one",
	sub="Utu grip",
	}
	
	sets.WEAPON['Blunt'] = {
	main="Mafic Cudgel",
	--sub=empty,
	}
	
	sets.WEAPON['Omen'] = {
	main="Quint Spear",
	sub="Utu grip",
	}
	
	sets.low_hp = {
	
	}
	
	sets.high_hp = {
	head="Nyame helm",
	neck="Sanctity Necklace",
	left_ear="Odnowa Earring",
	right_ear="Odnowa Earring +1",
	body="Hjarrandi Breastplate",
	hands="Gleti's Gauntlets",
	left_ring="Regal Ring",
	right_ring="Moonlight Ring",
	back="Moonbeam cape",
	legs="Nyame flanchard",
	feet="Nyame sollerets",
	}
	
	sets.tpgain = {
	head="Valorous Mask",
	neck="Vim Torque +1",
	body="Gleti's cuirass",
	legs="Gleti's breeches",
	feet="Gleti's boots",
	left_ring="Karieyh ring",
	}
	
	sets.reraise = {
	head="Crepuscular Helm",
	body="Crepuscular Mail",
	}
end

function check_height() 
	selfz = math.floor(windower.ffxi.get_mob_by_index(player.index).z * 10)/10
	targetz = math.floor(windower.ffxi.get_mob_by_index(player.target.index).z * 10)/10
	heightdiff = selfz - targetz
	targdistance = math.floor(windower.ffxi.get_mob_by_index(player.target.index).distance:sqrt() * 10+0.5)/10
end

function precast(spell)
	if (sets.ja[spell.english]) then
		equip(sets.ja[spell.english])
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
		if player.tp < 1000 or player.status == "Idle" then
			cancel_spell()
		elseif spell.target.distance > (ability_distance * range_mult[ability_distance] + spell.target.model_size + player.model_size) then
			cancel_spell()
			add_to_chat(123, spell.name..' Canceled: [Out of Range]')
		elseif player.tp > 1000 then
			if player.equipment.main == "Trishula" then
				if (player.tp >= 1000 and player.tp < 2500) or buffactive['Sekkanoki'] then
					equip({{ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}}})
				elseif world.time >= (17*60) or world.time <= (7*60) then
					equip({left_ear="Lugra Earring +1"})
				else
					equip({left_ear="Ishvara Earring"})
				end
			else
				if (player.tp >= 1000 and player.tp < 3000) or buffactive['Sekkanoki'] then
					equip({left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}}})
				elseif world.time >= (17*60) or world.time <= (7*60) then
					equip({left_ear="Lugra Earring +1"})
				else
					equip({left_ear="Ishvara Earring"})
				end
			end
			if sets.ws[spell.name] then
				equip(sets.ws[spell.name])
			else
				equip(sets.ws.common)
			end
			if buffactive['Meikyo Shisui'] and player.tp >= 1750 then
				--equip({feet="Sakonji sune-ate +3"})
			elseif buffactive['Sekkanoki'] then
				--equip({hands="Kasuga Kote +1"})
			end
		end
	end
end

function midcast(spell)
	if (spell.name == 'Sneak' or spell.english == 'Spectral Jig' or spell.english:contains('Monomi')) and spell.target.name == player.name and buffactive["Sneak"] then
		send_command('cancel Sneak')
	elseif spell.english:contains('Utsusemi') then
		if buffactive["Copy Image"] then
			windower.send_command('wait 1;cancel 66;')
		elseif buffactive['Copy Image (2)'] then 
			windower.send_command('wait 1;cancel 444')
		elseif buffactive['Copy Image (3)'] then
			windower.send_command('wait 1;cancel 445')
		elseif buffactive['Copy Image (4+)'] then
			windower.send_command('wait 1;cancel 446')
		end
	end
end

function aftercast(spell)
	if new == 'Engaged' and player.equipment.main == "Quint spear" then
		disable('ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
	elseif player.status == "Engaged" then
		equip(sets.TP[sets.TP.index[TP_ind]])
		if (spell.name == 'Seigan' and buffactive['Hasso']) or buffactive['Seigan'] then
			--equip({hands="Tatenashi Gote +1"})
		elseif spell.name == 'Hasso' or buffactive['Hasso'] then
			--equip({hands="Wakido Kote +1"})
		end
	elseif (new == 'Idle' and player.equipment.main ~= "Quint Spear") or player.status == "Idle" then
		enable('ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
		equip(sets.idle)
	end
end

function status_change(new,old)
	if (new == 'Idle' and player.equipment.main ~= "Soboro Sukehiro") or player.status == "Idle" then
		enable('ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
		equip(sets.idle)
		if sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] then
			equip(sets.TP['DT'],sets.movement)
		end
	elseif new == 'Engaged' and player.equipment.main == "Quint Spear" then
		equip(sets.TP['Standard'])
		disable('ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
	elseif new == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
		if buffactive['Hasso'] then
			--equip({hands="Wakido Kote +1"})
		elseif buffactive['Seigan'] then
			--equip({hands="Tatenashi Gote +1"})
		end
	end
end

function buff_change(n, gain, buff_table)
	local name
	name = string.lower(n)
	if S{"hasso"}:contains(name) then
		if gain then
		else
			if player.status == "Engaged" and not buffactive['Seigan'] then
				send_command('@input /ja "Hasso" <me>')
			end
		end
	elseif S{"seigan"}:contains(name) then
		if gain then
		else
			if player.status == "Engaged" and not buffactive['Hasso'] then
				send_command('@input /ja "Seigan" <me>')
			end
		end
	end
end

send_command('bind @s gs c toggle TP set') -- Hit alt+q, toggles the sets
send_command('bind @w gs equip sets.movement') -- Hit alt+w, toggles movement set
send_command('bind @` gs c toggle WEAPON set') -- Hit alt+`, toggles the sets
send_command('bind @r gs equip sets.regen') -- Hit alt+r, toggles the sets
send_command('bind @a gs equip sets.weapon') -- Hit alt+a, toggles sets
send_command('wait 5;gs equip fashion;wait 1;input /lockstyle on;wait 1;gs equip idle')
send_command('bind @u gs equip low_hp;wait 1; gs equip high_hp') -- Hit alt+u, toggles HP
send_command('bind @p gs equip sets.tpgain') -- Hit alt+p, toggles the TPgain

function self_command(command)
	if command == 'toggle TP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip(sets.TP[sets.TP.index[TP_ind]])
		if player.status == 'Idle' then
			equip(sets.movement)
		end
	elseif command == 'reverse TP set' then
		TP_ind = TP_ind -1
		if TP_ind == 0 then TP_ind = #sets.TP.index end
		windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip(sets.TP[sets.TP.index[TP_ind]])
	end
	if command == 'toggle WEAPON set' then
		WEAPON_ind = WEAPON_ind +1
		if WEAPON_ind > #sets.WEAPON.index then WEAPON_ind = 1 end
		equip(sets.WEAPON[sets.WEAPON.index[WEAPON_ind]])
	elseif command == 'reverse WEAPON set' then
		WEAPON_ind = WEAPON_ind -1
		if WEAPON_ind == 0 then WEAPON_ind = #sets.WEAPON.index end
		equip(sets.WEAPON[sets.WEAPON.index[WEAPON_ind]])
	end
end

function file_unload()
    send_command('unbind !q')
	send_command('unbind !w')
	send_command('unbind !e')
	send_command('unbind !r')
	send_command('unbind !a')
	send_command('unbind !`')
	send_command('unbind !p')
end

function set_macros(sheet,book)
    if book then
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
	add_to_chat (55, 'You are on '..('Dragoon'):color(5)..('. '):color(55)..''..('Macros set!'):color(121))
end
 
function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset 	'..sheet)
end
 
--Page, Book--
set_macros(1,14)
--Use the Lockstyle Number--
set_style(014) 