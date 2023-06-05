SIRDspells = S{"Cure IV","Raise","Banishga",--[["Crusade","Reprisal",]]"Cocoon","Chaotic Eye","Sheep Song","Blank Gaze","Geist Wall","Jettatura","Sound Blast","Sandspin","Soporific","Awful Eye","Stinking Gas","Bomb Toss",}
res = require 'resources'
--Healing Breeze + Sheep Song = Auto-regen
--Cocoon
--Bomb Toss (wave3 fetter pull)
--Chaotic Eye, Blank Gaze (single target hate)
--Awful Eye, Jettatura (conal hate)
--Stinking Gas, Soporific, Geist Wall (aoe hate)
--Ice Break + Magnetite Cloud (MDB)

function get_sets()
	sets.fc = {}
	sets.ja = {}
	sets.ws = {}
	sets.buff = {}
	sets.misc = {}
	sets.sword = {}
	sets.shield = {}
	sets.TP = {}
	
	sets.movement = {legs="Carmine Cuisses +1"}
	
	sets.fc.base = { --2+14+10+5+4+10+8+13=66
	ammo="Sapience Orb", --2%
	head={name="Carmine Mask +1",priority=12}, --14%
	body={name="Reverence Surcoat +3",priority=15}, --10%
	hands="Leyline Gloves", --5%
	left_ring="Kishar ring", --4%
	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',},priority=13}, --'HP+20'
	waist="Plat. Mog. Belt",
	legs={name="Enif Cosciales",priority=11}, --8%
	feet={name="Chevalier's Sabatons +3",priority=14} --13%
	}
	
	sets.fc.cure = set_combine(sets.fc.base, {
	--right_ear="Nourishing Earring +1", --4
	})
	
	sets.fc.healing = set_combine(sets.fc.base, {})
	
	sets.fc["Enhancing Magic"] = set_combine(sets.fc.base, {
	waist="Siegel Sash",
	})
	
	sets.hp = {
	sub={name="Srivatsa",priority=8}, --150
	--ammo="Egoist's Tathlum",
	head={name="Souveran Schaller +1",priority=15}, --280
	neck={name="Unmoving Collar +1",priority=11}, --200
	left_ear={name="Tuisto Earring",priority=9}, --150
	right_ear={name="Odnowa Earring +1",priority=6}, --110
	body={name="Reverence Surcoat +3",priority=14}, --254
	hands="Regal Gauntlets",
	hands={name="Souveran Handschuhs +1",priority=13}, --239
	left_ring={name="Gelatinous Ring +1",priority=7}, --110
	right_ring={name="Moonlight Ring",priority=5}, --110
	back={name="Moonbeam Cape",priority=8}, --130
	waist="Plat. Mog. Belt",
	legs={name="Souveran diechlings +1",priority=10}, --162
	feet={name="Souveran schuhs +1",priority=12}, --227
	}
	
	sets.buff["Phalanx"] = { --30
	head="Valorous Mask", --5
	neck="Moonlight Necklace",
	body="Valorous Mail", --5
	hands={name="Souveran Handschuhs +1",priority=15}, --5
	back="Weard Mantle", --5
	waist="Audumbla Sash",
	legs={name="Sakpata's Cuisses",priority=13}, --5
	feet={name="Souveran schuhs +1",priority=14}, --5
	}
	
	sets.phalanx2 = set_combine(sets.buff["Phalanx"], { --37
	main={name="Sakpata's Sword",priority=12}, --5
	sub={name="Priwen",priority=11}, --2
	})
	
	sets.enmity = {--+107~113 Enmity
	ammo="Sapience Orb", --2
	head={name="Loess Barbuta +1",priority=12}, --9~14
	neck="Moonlight Necklace", --15
	right_ear="Cryptic Earring", --4
	body={name="Souveran cuirass +1",priority=14}, --20
	hands={name="Souveran Handschuhs +1",priority=15}, --9
	left_ring="Petrov Ring", --4
	right_ring="Apeile Ring +1", --5
	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Damage taken-5%',},priority=10},
	waist={name="Creed Baudrier",priority=9}, --5
	legs={name="Souveran Diechlings +1",priority=13}, --9
	--feet={ name="Eschite Greaves", augments={'HP+80','Enmity+7','Phys. dmg. taken -4',},priority=11},
	feet={name="Chevalier's Sabatons +3",priority=9} --15
	}
	
	sets.sird = set_combine(sets.enmity, {
	ammo="Staunch Tathlum +1", --11
	head={name="Souveran Schaller +1",priority=15}, --20
	neck="Moonlight Necklace", --15
	waist="Audumbla Sash", --10
	legs={name="Founder's Hose",priority=14}, --20
	feet="Odyssean Greaves" --20
	}) --96
	
	sets.th_sird = set_combine(sets.enmity, {
	ammo="Perfect Lucky Egg",
	head={name="Souveran Schaller +1",priority=15}, --20
	neck="Moonlight Necklace", --15
	right_ear="Knightly Earring", --9
	left_ring="Gelatinous Ring +1",
	waist="Chaac Belt",
	legs={name="Founder's Hose",priority=14}, --30
	feet={name="Odyssean Greaves",priority=13} --20
	})
	
	sets.ja["Provoke"] = sets.enmity
	sets.ja["Warcry"] = sets.enmity
	sets.ja["Invincible"] = {legs="Caballarius Breeches +3",}
	sets.ja["Holy Circle"] = {feet="Reverence Leggings +1"}
	sets.ja["Shield Bash"] = {right_ear="Knightly Earring", hands="Caballarius Gauntlets +3",--[[left_ring="Fenian Ring",]]}
	sets.ja["Weapon Bash"] = {right_ear="Knightly Earring",}
	sets.ja["Sentinel"] = set_combine(sets.enmity, {feet="Caballarius Leggings +3"})
	sets.ja["Cover"] = {--[[head="Reverence Coronet",]]}
	sets.ja["Rampart"] = set_combine(sets.enmity, {head="Caballarius Coronet +3",})
	sets.ja["Fealty"] = {body="Caballarius Surcoat +3",}
	sets.ja["Chivalry"] = {hands="Caballarius Gauntlets +3"}
	sets.ja["Divine Emblem"] = {feet="Chevalier's Sabatons +3"}
	
	sets.dt = {
	ammo={name="Staunch Tathlum +1",priority=1},
	head={name="Sakpata's Helm",priority=8},
	neck={name="Unmoving Collar +1",priority=15},
	left_ear={name="Tuisto Earring",priority=14},
	right_ear={name="Odnowa Earring +1",priority=9},
	body={name="Sakpata's Breastplate",priority=13},
	hands={name="Sakpata's Gauntlets",priority=7},
	left_ring={name="Gelatinous Ring +1",priority=11},
	right_ring={name="Moonlight Ring",priority=10},
	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Damage taken-5%',},priority=6},
	waist="Asklepian Belt",
	legs={name="Sakpata's Cuisses",priority=12},
	feet={name="Sakpata's Leggings",priority=5}
	}
	
	sets.EnhancingDuration = {
	--sub="Ajax +1",
	body="Shabti cuirass +1",
	hands="Regal Gauntlets",
	}
	
	sets.protect = set_combine(sets.EnhancingDuration, {
	main="Colada",
	sub="Duban", --srivatsa
	})
	
	sets.divine = {
	neck="Incanter's Torque",
	body={name="Reverence Surcoat +3",priority=15},
	left_ring="Stikini Ring +1",
	waist="Asklepian Belt",
	}
	
	sets.divinedmg = {
	main={name="Sakpata's Sword",priority=13}, --100
	sub={name="Forfend +1",priority=9}, --22
	ammo="Ghastly Tathlum +1",
	neck="Baetyl Pendant",
	left_ear="Dignitary's Earring",
	right_ear="Friomisi Earring",
	body={name="Cohort Cloak +1",priority=11}, --91
	hands={name="Nyame Gauntlets",priority=12}, --91
	left_ring={name="Stikini Ring +1", bag="wardrobe1"},
    right_ring={name="Stikini Ring +1", bag="wardrobe2"},
	back={name="Reiki Cloak",priority=15}, --130
	waist={name="Eschan Stone",priority=8}, --20
	legs={name="Nyame Flanchard",priority=14}, --114
	feet={name="Nyame Sollerets",priority=10}, --68
	}
	
	sets.refresh = {
	ammo="Homiliary",
	body="Crepuscular Mail",
	hands="Regal Gauntlets",
	left_ring={name="Stikini Ring +1", bag="wardrobe1"},
    right_ring={name="Stikini Ring +1", bag="wardrobe2"},
	waist="Fucho-no-obi",
	}
	
	sets.resistcharm = {
	neck="Unmoving Collar +1",
	back="Solemnity Cape",
	legs="Souveran Diechlings +1",
	}
	
	sets.sword.index = {'Burtgang', 'Sakpatas Sword','Naegling','Malevolence','Caladbolg', 'Malignance Sword',--[[,'Mafic Cudgel',]]}
	sword_ind = 1 --Malignance Sword is the Default
	
	sets.sword['Sakpatas Sword'] = {main="Sakpata's Sword"}
	sets.sword['Malignance Sword'] = {main="Malignance Sword"}
	sets.sword['Naegling'] = {main="Naegling"}
	sets.sword['Malevolence'] = {main="Malevolence"}
	sets.sword['Burtgang'] = {main="Burtgang"}
	--sets.sword['Mafic Cudgel'] = {main="Mafic Cudgel"}
	sets.sword['Caladbolg'] = {main="Caladbolg", sub="Alber Strap",}
	sets.shield.index = {'Duban','Aegis','Priwen','Blurred'} --'Srivatsa',
	shield_ind = 1 --Srivatsa is the Default
	
	sets.shield['Srivatsa'] = {sub="Srivatsa",waist="Asklepian Belt",}
	sets.shield['Aegis'] = {sub="Aegis",neck="Warder's Charm +1",waist="Carrier's Sash",}
	sets.shield['Duban'] = {sub="Duban",waist="Flume Belt +1",}
	sets.shield['Priwen'] = {sub="Priwen",waist="Flume Belt +1",}
	sets.shield['Blurred'] = {sub="Blurred Shield +1",waist="Sailfi Belt +1",}
	
	sets.TP.index = {'None','Standard','HighAcc'}
	TP_ind = 1 --None is the Default
	
	sets.TP['Standard'] = {
	ammo="Coiste Bodhar",
	head="Hjarrandi Helm",
	--head="Flamma zucchetto +2",
	neck="Vim Torque +1",
	left_ear="Telos Earring",
	right_ear="Mache Earring +1",
	body="Sakpata's Plate",
	hands="Sakpata's Gauntlets",
	left_ring="Chirich Ring +1",
	right_ring="Moonlight Ring",
	back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	waist="Sailfi Belt +1",
	legs="Sakpata's Cuisses",
	feet="Flam. Gambieras +2"
	}
	
	sets.TP['HighAcc'] = set_combine(sets.TP['Standard'], {})
	
	sets.TP['Sword'] = set_combine(sets.TP['Standard'], {
	ammo="Aurgelmir Orb +1",
	head="Hjarrandi Helm",
	body="Hjarrandi Breastplate",
	})
	
	sets.ws.common = {
	ammo="Coiste Bodhar",
	head={ name="Nyame Helm",priority=13}, --91
	neck="Fotia Gorget",
	right_ear="Thrud Earring",
	left_ear="Moonshade Earring",
	body={name="Nyame Mail",priority=15}, --136
	hands={name="Nyame Gauntlets",priority=12}, --91
	left_ring="Regal Ring",
	right_ring="Cornelia's Ring",
	back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	waist="Fotia Belt",
	legs={name="Nyame Flanchard",priority=14}, --114
	feet={name="Nyame Sollerets",priority=11} --68
	}
	
	sets.ws["Savage Blade"] = set_combine(sets.ws.common, {})
	
	sets.ws["Atonement"] = sets.enmity
	
	sets.ws['Torcleaver'] = set_combine(sets.ws.common, {
		ammo="Aurgelmir Orb +1",
	})
	
	sets.ws['Aeolian Edge'] = set_combine(sets.ws.common, {
	ammo="Ghastly Tathlum +1",
	neck="Sibyl Scarf",
	left_ring="Metamorph Ring +1",
	waist="Orpheus's Sash",
	})
	
	sets.ws['Cataclysm'] = set_combine(sets.ws['Aeolian Edge'], {
	head="Pixie Hairpin +1",
	left_ring="Archon Ring",
	})
	
	sets.ws['Shell Crusher'] = {
	neck="Moonlight Necklace",
	waist="Acuity Belt +1",
	}
	
	sets.ws['Energy Steal'] = {}
	
end

function check_height() 
	selfz = math.floor(windower.ffxi.get_mob_by_index(player.index).z * 10)/10
	targetz = math.floor(windower.ffxi.get_mob_by_index(player.target.index).z * 10)/10
	heightdiff = selfz - targetz
	targdistance = math.floor(windower.ffxi.get_mob_by_index(player.target.index).distance:sqrt() * 10+0.5)/10
end

function precast(spell)
	local spell_recasts = windower.ffxi.get_spell_recasts()
	local ja_recasts = windower.ffxi.get_ability_recasts()
	if buffactive['Stun'] or buffactive['Petrify'] or buffactive['Terror'] or ((spell.action_type == "WeaponSkill" or spell.action_type == "JobAbility") and buffactive['Amnesia']) or (spell.action_type == 'Magic' and buffactive['Silence']) --[[or (spell_recasts[spell.recast_id] > 0) or (spell.type == "JobAbility" and ja_recasts[spell.recast_id] > 0)]] then
		cancel_spell()
	elseif (sets.ja[spell.english]) then
		equip(sets.ja[spell.english])
	elseif string.find(spell.english,'Jump') then
		equip({hands="Crusher's Gauntlets"})
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
		elseif player.tp >= 1000 then
			if sets.ws[spell.name] then
				equip(sets.ws[spell.name])
			else
				equip(sets.ws.common)
			end
			if spell.name ~= "Shell Crusher" then
				if (player.tp >= 1000 and player.tp < 3000) then
					equip({left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}}})
				elseif world.time >= (17*60) or world.time <= (7*60) then
					equip({left_ear="Lugra Earring +1"})
				else
					if spell.name == "Aeolian Edge" then
						equip({left_ear="Friomisi Earring"})
					else
						equip({left_ear="Ishvara Earring"})
					end
				end
			end
		end
	elseif spell.action_type == 'Magic' then
		if spell.skill == 'Healing Magic' then
			if string.find(spell.english,'Cure') then
				equip(sets.fc.cure)
			else
				equip(sets.fc.base)
			end
		elseif spell.skill == 'Enhancing Magic' then
			equip(sets.fc["Enhancing Magic"])
		else
			equip(sets.fc.base)
		end
	end
	if spell.english:contains('Circle') then
		equip({body="Founder's Breastplate"})
	end
end

function midcast(spell)
	if sets.buff[spell.english] and sets.TP[sets.TP.index[TP_ind]] == sets.TP['None'] then
		equip(sets.buff[spell.english])
		if spell.name == "Phalanx" then
			--equip({right_ear="Mimir Earring",})
			if player.tp < 750 then
				equip(sets.phalanx2)
			end
		end
	elseif spell.action_type == 'Magic' and not spell.type:contains('Trust') then
		if SIRDspells:contains(spell.name) then
			if spell.name == "Soporific" then
				equip(sets.th_sird)
			else
				equip(sets.sird)
			end
		elseif spell.skill == 'Enhancing Magic' then
			if string.find(spell.english,'Protect') then
				equip(sets.protect)
			elseif spell.name == 'Crusade' or spell.name == 'Reprisal' then
				if player.tp < 750 then
					equip(sets.sird,sets.EnhancingDuration)
				end
			else
				equip(sets.EnhancingDuration)
			end
		elseif spell.skill == 'Divine Magic' and spell.name ~= "Flash" then
			if string.find(spell.english,'Enlight') then
				equip(sets.divine)
			elseif spell.name == "Holy II" or spell.name == "Banish II" then
				equip(sets.divinedmg)
			end
		else
			equip(sets.enmity)
		end
	end
	if (spell.name == 'Sneak' or spell.english == 'Spectral Jig' or spell.english:contains('Monomi')) and spell.target.name == player.name and buffactive["Sneak"] then
		send_command('cancel Sneak')
	elseif spell.english:contains('Utsusemi') then
		if buffactive["Copy Image"] then
			windower.send_command('wait 1;cancel 66;')
		elseif buffactive['Copy Image (2)'] then 
			windower.send_command('wait 1;cancel 444')
		elseif buffactive['Copy Image (3)'] then
			windower.send_command('wait 1;cancel 445')
		end
	end
end

function aftercast(spell)
	--reequip()
	send_command('@input //gs c reequip')
	if player.mpp <= 35 then
		equip({ammo="Homiliary",--[[waist="Fucho-no-obi",]]})
	elseif player.mpp <= 42 then
		equip({waist="Flume Belt +1",})
	end
end

function status_change(new,old)
    if new == 'Engaged' then
		--reequip()
		send_command('@input //gs c reequip')
	elseif new == 'Idle' then
		equip(sets.dt,sets.movement)
    end
end

function buff_change(n, gain, buff_table)
	local name
	name = string.lower(n)
	if S{"doom"}:contains(name) then
		if gain then
			send_command('@input /p Cursna - Doomed')
		end
	elseif S{"stoneskin"}:contains(name) then
		if gain then
			send_command('cancel Stoneskin')
		end
	end
end

send_command('bind @q gs equip dt') -- Hit cmd+q, equips dt set
send_command('bind @w gs equip movement') -- Hit cmd+w, equips movement equipment
send_command('bind @a gs c reequip;wait 1; input /lockstyle on') -- Hit alt+a, reequips your gear with toggled sword/shield
send_command('bind @= gs c toggle shield set') -- Hit cmd+`, toggles the sets
send_command('bind @- gs c toggle sword set') -- Hit cmd+`, toggles the sets
send_command('bind @s gs c toggle TP set') -- Hit cmd+s, equips tp set

function file_unload()
    send_command('unbind !q')
	send_command('unbind !w')
	send_command('unbind !a')
	send_command('unbind !`')
	send_command('unbind ^`')
	send_command('unbind !s')
end

function self_command(command)
	if command == 'toggle sword set' then
		sword_ind = sword_ind +1
		if sword_ind > #sets.sword.index then sword_ind = 1 end
		windower.add_to_chat(1,'<----- Sword Set changed to '..sets.sword.index[sword_ind]..' ----->')
		equip(sets.dt,sets.sword[sets.sword.index[sword_ind]])
	end
	if command == 'toggle shield set' then
		shield_ind = shield_ind +1
		if shield_ind > #sets.shield.index then shield_ind = 1 end
		windower.add_to_chat(1,'<----- Shield Set changed to '..sets.shield.index[shield_ind]..' ----->')
		equip(sets.dt,sets.shield[sets.shield.index[shield_ind]])
	end
	if command == 'toggle TP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		if player.status == 'Engaged' then
			equip(sets.TP[sets.TP.index[TP_ind]])
		end
	end
	if command == 'reequip' then
		if sets.TP[sets.TP.index[TP_ind]] ~= sets.TP['None'] then
			equip(sets.TP[sets.TP.index[TP_ind]])
		else
			equip(sets.dt,sets.shield[sets.shield.index[shield_ind]],sets.sword[sets.sword.index[sword_ind]])
		end
    end
end

------------------------------------------
-- Macro and Style Change on Job Change
------------------------------------------
function set_macros(sheet,book)
    if book then
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
	
end
 
function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
    add_to_chat (55, 'You are on '..('Paladin'):color(5)..''..('. '):color(55)..''..('Macros set!'):color(121))
end
 
--Page, Book--
set_macros(1,7)
--Use the Lockstyle Number--
set_style(007)