res = require 'resources'
require('vectors')

include('SendCommands.lua')

function get_sets()
	sets.fc = {}
	sets.TP = {}
	sets.TH = {}
	sets.ws = {}
	sets.ja = {}
	sets.precast = {}
	sets.midcast = {}
	sets.mode = {}
	ammo = {}
	
	ammo.melee = {ammo="Coiste Bodhar"}
	ammo.ws = {ammo="Coiste Bodhar"}
	ammo.dt = {ammo="Staunch Tathlum +1"}
	ammo.th = {ammo="Perfect Lucky Egg"}
	ammo.fc = {ammo="Sapience Orb"}
	ammo.acc = {ammo="Yamarang"}
	ammo.shooty = {ammo="Chapuli Arrow"}
	
	sets.fc.base = {
	head="Herculean Helm",
	neck="Orunmila's Torque",
	left_ear="Etiolation Earring",
	right_ear="Loquacious Earring",
	body="Taeon Tabard",
	hands="Leyline Gloves",
	left_ring="Lebeche Ring",
	legs="Enif Cosciales",
	}
	
	sets.regen = {
	head="Gleti's Mask",
	neck="Bathy Choker +1",
	left_ear="Infused Earring",
	--body="Turms Harness",
	hands="Turms Mittens +1",
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
	--legs="Turms Subligar",
	feet="Turms Leggings +1",
	}
	
	sets.regain = {
	head="Gleti's Mask",
	body="Gleti's Cuirass",
	hands="Gleti's Gauntlets",
	legs="Gleti's Breeches",
	feet="Gleti's Boots",
	}
	
	sets.Dagger = {
	main={ name="Mpu Gandring", priority=2,},
	sub={ name="Gleti's Knife",priority=1},
	--sub={ name="Tauret", priority=1,},
	--sub={ name="Ternion Dagger +1", priority=1,},
	}
	
	-- Melee Sets --
	
	sets.TP.index = {'DT','Parry','Standard','Acc','Hybrid'}	
	TP_ind = 1 -- DT set is the Default
	
	sets.TP['Standard'] = {
	head="Skulker's Bonnet +3",
	neck="Anu Torque",
	--neck="Assassin's Gorget +2",
	left_ear="Sherida Earring",
	right_ear="Skulker's Earring +1",
	body="Pillager's Vest +3",
	hands="Adhemar Wristbands +1",
	left_ring="Epona's Ring",
	right_ring="Gere Ring",
	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	waist="Reiki Yotai",
	legs="Samnuha Tights",
	--legs="Gleti's Breeches",
	feet="Plunderer's Poulaines +3"
	}
	
	sets.TP['Acc'] = set_combine(sets.TP['Standard'], {
	hands="Malignance Gloves",
	right_ring="Regal Ring",
	legs="Pillager's Culottes +3",
	feet="Plunderer's Poulaines +3"
	})
	
	sets.TP['Hybrid'] = set_combine(sets.TP['Standard'], { --30%
	hands="Malignance Gloves",
	left_ring="Moonlight Ring",
	legs="Malignance Tights",
	})
	
	sets.TP['DT'] = set_combine(sets.TP['Standard'], { --48%
	ear1="Odnowa earring +1",
    body="Gleti's Cuirass",
	hands="Malignance Gloves",
	left_ring="Moonlight Ring",
	right_ring="Defending Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}, 
	legs="Malignance Tights",
	})
	
	sets.TP['Parry'] = set_combine(sets.TP['DT'], { --48%
	hands="Turms Mittens +1",
	feet="Turms Leggings +1",
	})
	
	sets.TH.index = {'None','TH','Full'}	
	TH_ind = 1 -- Standard set is the Default
	
	sets.TH['TH'] = {
	hands="Plun. Armlets +3",
	feet="Skulker's Poulaines +3",
	}
	
	sets.TH['Full'] = { --9
	ammo="Per. Lucky Egg",
	head="Volte Cap", --1
	body="Volte Jupon", --2
	hands="Plun. Armlets +3", --4
	waist="Chaac Belt", --11
	feet="Skulker's Poulaines +3" --3
	}
	
	sets.melee = sets.TP['Standard']
	
	sets.idle = {left_ring="Warp Ring",feet="Pillager's Poulaines +3"}
	
	sets.refresh = set_combine(sets.idle, {
	head="Rawhide Mask",
	left_ring="Stikini Ring +1",
	})
	
	sets.midcast['Enhancing Magic'] = {
	neck="Incanter's Torque",
	left_ear="Mimir Earring",
	}
	
	sets.phalanx = {
	ammo="Staunch Tathlum +1",
	head="Herculean Helm",
	body="Herculean Vest",
	hands="Herculean Gloves",
	legs="Herculean Trousers",
	feet="Herculean Boots",
	neck="Null Loop",
	ear1="Odnowa earring +1",
	left_ring="Shadow Ring",
	right_ring="Defending Ring",
	back="Moonbeam Cape",
	waist="Null Belt",	
	}
	
	-- Weaponskills --
	sets.mode.index = {'Uncapped','Capped'}
	mode_ind = 1 --Uncapped set is the Default
	
	sets.ws.common = {ammo="Coiste Bodhar",
    head="Nyame Helm",
	neck="Assassin's Gorget +2", 
	ear1="Sherida Earring",
	ear2="Skulker's Earring +1",
    body="Nyame Mail",
	hands="Nyame Gauntlets",
	left_ring="Regal Ring",
	right_ring="Cornelia's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	waist="Kentarch Belt +1",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"
		}
	
	sets.ws["Shark Bite"] = set_combine(sets.ws.common, {
	body="Plunderer's Vest +3",
	right_ring="Ilabrat Ring",
	waist="Grunfeld Rope",
	legs="Pillager's Culottes +3",
	feet="Nyame Sollerets"
	})
	
	sets.ws["Evisceration"] = set_combine(sets.ws.common, { --50% DEX, crit rate/dmg
	head="Skulker's Bonnet +3",
	body="Plunderer's Vest +3",
	right_ring="Ilabrat Ring",
	hands="Adhemar Wristbands +1",
	waist="Fotia Belt",
	legs="Pillager's Culottes +3",
	feet="Plunderer's Poulaines +3"
	})
	
	sets.ws["Aeolian Edge"] = set_combine(sets.ws.common, { --40% DEX / 40% INT
	ammo="Seething Bomblet +1",
	neck="Sibyl Scarf",
	right_ear="Friomisi Earring",
	left_ring="Dingir Ring",
	waist="Orpheus's Sash",
	})
	
	sets.ws["Rudra's Storm"] = set_combine(sets.ws.common, {
	body="Skulker's Vest +3", 
	})
	
	sets.ws["Rudra's Storm"].Capped = set_combine(sets.ws["Rudra's Storm"], {
	ammo="Crepuscular Pebble",
	head="Skulker's Bonnet +3",
	left_ear="Odr Earring",
	hands="Gleti's Gauntlets",
	legs="Gleti's Breeches",
	})
	
	sets.ws["Exenterator"] = set_combine(sets.ws.common, {
	hands="Malignance Gloves",
	left_ring="Regal Ring",
	right_ring="Ilabrat Ring",
	legs="Meghanada Chausses +2", --check this
	feet="Plunderer's Poulaines +3"
	})
	
	sets.ws["Ruthless Stroke"] = set_combine(sets.ws.common, {ammo="Coiste Bodhar",	
	body="Skulker's Vest +3", 
	legs="Nyame Flanchard",
	})
	
	sets.ws["Ruthless Stroke"].Capped = set_combine(sets.ws["Ruthless Stroke"], {
	ammo="Crepuscular Pebble",
	head="Skulker's Bonnet +3",
	ear1="Ishvara Earring",
	left_ring="Epaminondas's Ring",
	})
	
	sets.ws["Savage Blade"] = set_combine(sets.ws.common, {
	neck="Fotia Gorget",
	waist="Sailfi Belt +1",
	})
	
	sets.ws['Empyreal Arrow'] = set_combine(sets.ws.common, {
	neck="Iskur Gorget",
	left_ring="Regal Ring",
	right_ring="Cacoethic Ring +1",
	})
	
	-- Magic --
	sets.precast['Utsusemi'] = set_combine(sets.fc.base, {
	neck="Magoraga Bead Necklace",
	})
	
	sets.macc = {
	head="Nyame Helm",
	neck="Incanter's Torque",
	left_ear="Vor Earring",
	right_ear="Dignitary's Earring",
	body="Malignance Tabard",
	hands="Malignance Gloves",
	left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring={name="Stikini Ring +1", bag="wardrobe5"},
	waist="Null Belt",
	legs="Malignance Tights",
	feet="Nyame Sollerets"
	}
	
	sets.nomacc = {
	head="Pillager's Bonnet +3",
	neck="Loricate Torque +1",
	left_ear="Etiolation Earring",
	right_ear="Telos Earring",
	body="Adhemar Jacket +1",
	left_ring="Moonlight Ring", --5
	right_ring="Gelatinous Ring +1",
	waist="Sailfi Belt +1",
	legs="Turms Subligar",
	feet="Turms Leggings +1"
	}
	
	--sets.THwhore = set_combine(sets.macc, {
	sets.THwhore = set_combine(sets.nomacc, {
	ammo="Per. Lucky Egg",
	hands="Plunderer's Armlets +3",
	waist="Chaac Belt",
	feet="Skulker's Poulaines +3"
	})
	
	-- ja --
	sets.ja['Perfect Dodge'] = {hands="Plunderer's Armlets +3"}
	sets.ja['Collaborator'] = {head="Skulker's Bonnet +3"}
    sets.ja['Accomplice'] = {head="Skulker's Bonnet +3"}
    sets.ja['Flee'] = {feet="Pillager's Poulaines +3"}
    sets.ja['Conspirator'] = {body="Skulker's Vest +3"}
	sets.ja['Hide'] = {body="Pillager's Vest +3"}
	sets.ja['Steal'] = set_combine(sets.THwhore, {ammo="Barathrum",head="Pluderer's Bonnet +3",neck="Pentalagus Charm",hands="Thief's Kote",feet="Pillager's Poulaines +3"}) --legs="Assassin's Culottes"
	sets.ja['Mug'] = set_combine(sets.THwhore, {head="Assassin's Bonnet"})
	sets.ja['Flee'] = {feet="Pillager's Poulaines +3"}
	sets.ja['Despoil'] = set_combine(sets.THwhore, {ammo="Barathrum",legs="Skulker's Culottes +3",feet="Skulker's Poulaines +3",})
	sets.ja['Feint'] = {legs="Plunderer's Culottes +3"}
	
	sets.ja.waltz = {ammo="Yamarang",
        head="Mummu Bonnet +2",
        body="Gleti's Cuirass",
		left_ring="Asklepian Ring",
        legs="Pillager's Culottes +3", 
		feet="Rawhide Boots"
	}
	
	sets.ja['Sneak Attack'] = {ammo="Cath Palug Stone",
        head="Pillager's Bonnet +3",
		neck="Assassin's Gorget +2",
		ear1="Odr Earring",
		ear2="Sherida Earring",
        body="Pillager's Vest +3",
		hands="Skulker's Armlets +3",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		waist="Kentarch Belt +1",
		legs="Pillager's Culottes +3",
		feet="Plunderer's Poulaines +3"
	}

	sets.ja['Trick Attack'] = {ammo="Cath Palug Stone",
        head="Pillager's Bonnet +3",
		neck="Assassin's Gorget +2",
		ear2="Infused Earring",
		ear1="Sherida Earring",
        body="Pillager's Vest +3",
		hands="Pillager's Armlets +1",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		waist="Yemaya Belt",
		legs="Pillager's Culottes +3",
		feet="Plunderer's Poulaines +3"
	}
	
	sets.low_hp = {
	head="Pixie Hairpin +1",
	neck=empty,
	left_ear=empty,
	right_ear=empty,
	body=empty,
	hands=empty,
	left_ring="Mephitas's Ring +1",
	right_ring="Metamorph Ring +1",
	back="Solemnity Cape",
	waist="Flume Belt +1",
	legs=empty,
	feet=empty
	}
	
	sets.high_hp = {
	head="Nyame Helm",
	neck="Unmoving Collar +1",
	left_ear="Tuisto Earring",
	right_ear="Odnowa Earring +1",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	left_ring="Moonlight Ring", --5
	right_ring="Gelatinous Ring +1",
	back="Reiki Cloak",
	waist="Plat. Mog. Belt",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"
	}
	
	--Snapshot > Rapid Shot
	sets.precast.RA = {
	left_ring="Crepuscular Ring",
	--waist="Yemaya Belt", --Duke Vepar
	--legs="Adhemar Kecks +1",
	feet="Meghanada Jambeaux +2"
	}
	
	--r.acc/stp/crit/agi/recycle
	sets.midcast.RA = {
	head="Nyame Helm",
	neck="Iskur Gorget",
	left_ear="Telos Earring",
	right_ear="Crepuscular Earring",
	body="Malignance Tabard",
	hands="Malignance Gloves",
	left_ring="Crepuscular Ring",
	right_ring="Cacoethic Ring +1",
	waist="Yemaya Belt",
	legs="Malignance Tights",
	feet="Nyame Sollerets",
	}
	
	sets.alchemy = {
	main="Caduceus",
	sub="Br. Escutcheon",
	head="Protective Specs.",
	neck="Alchemist's Torque",
	body="Alchemist's Smock",
	hands="Smithy's Mitts",
	left_ring="Orvail ring +1", --+1
	right_ring="Confectioner's Ring",
	waist="Alchemist's Belt",
	}	
		
	sets.bonecraft = {
	--main="Caduceus",
	--sub="Br. Escutcheon",
	head="Protective Specs.",
	neck="boneworker's Torque",
	body="Boneworker's Smock",
	left_ring="Orvail Ring +1",
	right_ring="Patissiere's Ring",
	--right_ring="Confectioner's Ring",
	waist="Boneworker's Belt",
	}
	
	sets.blacksmith = {
	main="Caduceus",
	--sub="Smythe's Escutcheon",
	--head="Protective Specs.",
	neck="Smithy's Torque",
	body="blackmith's Apron",
	hands="Smithy's Mitts",
	left_ring="Orvail Ring +1",
	right_ring="Confectioner's Ring",
	waist="Blacksmith Belt",
	}
end

function check_height() 
	selfz = math.floor(windower.ffxi.get_mob_by_index(player.index).z * 10)/10
	targetz = math.floor(windower.ffxi.get_mob_by_index(player.target.index).z * 10)/10
	heightdiff = selfz - targetz
	targdistance = math.floor(windower.ffxi.get_mob_by_index(player.target.index).distance:sqrt() * 10+0.5)/10
end

function check_facing()
    local target = windower.ffxi.get_mob_by_target('t')
    if target == nil then return nil end
    local player = windower.ffxi.get_mob_by_target('me')
    local dir_target = V{player.x, player.y} - V{target.x, target.y}
    local dir_player = V{target.x, target.y} - V{player.x, player.y}
    local player_heading = V{}.from_radian(player.facing)
    local target_heading = V{}.from_radian(target.facing)
    local player_angle = V{}.angle(dir_player, player_heading):degree():abs()
    local target_angle = V{}.angle(dir_target, target_heading):degree():abs()
    if player_angle < 45 and target_angle > 135 then
        return true
    end
    return false
end

function precast(spell)
	if buffactive['Stun'] or buffactive['Petrify'] or buffactive['Terror'] or ((spell.action_type == "WeaponSkill" or spell.action_type == "JobAbility") and buffactive['Amnesia']) or (spell.action_type == 'Magic' and buffactive['Silence']) then
		cancel_spell()
	elseif (sets.ja[spell.english]) then
		equip(sets.ja[spell.english])
		if (spell.name == "Steal" or spell.name == "Despoil") and player.equipment.range == 'empty' then
			equip({ammo="Barathrum",})
		end
	elseif string.find(spell.english,'Waltz') then
		equip(sets.ja.waltz)
		if spell.target.type == 'SELF' then
			equip({head="Mummu Bonnet +2",})
		end
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
				if sets.mode.index[mode_ind] == 'Capped' and sets.ws[spell.name].Capped ~= nil then
					equip(sets.ws[spell.name].Capped)
				else
					equip(sets.ws[spell.name])
				end
				if spell.name == "Aeolian Edge" and (sets.TH[sets.TH.index[TH_ind]] == sets.TH['TH']) or (sets.TH[sets.TH.index[TH_ind]] == sets.TH['Full']) then
					equip({hands="Plunderer's Armlets +3",waist="Chaac Belt"})
				--elseif (player.equipment.sub == "Fusetto +2" or player.equipment.sub == "Fusetto +3" or player.equipment.sub == "Centovente") then
				--	equip(sets.ws[spell.name].capped,ammo.capped)
				end
			else
				equip(sets.ws.common)
			end
			if player.equipment.main == "Aeneas" and (player.equipment.sub == "Fusetto +2" or player.equipment.sub == "Fusetto +3" or player.equipment.sub == "Centovente") then
				if (player.tp >= 1000 and player.tp < 1500) then
					equip({left_ear="Moonshade Earring",})
				else
					equip({left_ear="Ishvara Earring"})
				end
			elseif player.equipment.main == "Aeneas" then
				if (player.tp >= 1000 and player.tp < 2500) then
					equip({left_ear="Moonshade Earring",})
				else
					equip({left_ear="Ishvara Earring"})
				end
			elseif (player.equipment.sub == "Fusetto +2" or player.equipment.sub == "Fusetto +3" or player.equipment.sub == "Centovente") then
				if (player.tp >= 1000 and player.tp < 2000) then
					equip({left_ear="Moonshade Earring",})
				else
					equip({left_ear="Ishvara Earring"})
				end
			else
				if (player.tp >= 1000 and player.tp < 3000) then
					equip({left_ear="Moonshade Earring",})
				else
					equip({left_ear="Ishvara Earring"})
				end
			end
			if player.equipment.range == 'empty' then
				if spell.name == "Aeolian Edge" or spell.name == "Rudra's Storm" or spell.name == "Savage Blade" then
					equip(ammo.ws)
				elseif spell.name == "Mandalic Stab" or spell.name == "Shark Bite" then
					equip(ammo.melee)
				else
					equip(ammo.acc)
				end
			elseif player.equipment.range == 'Ullr' and player.equipment.ammo == 'empty' then
				equip(ammo.shooty)
			end
		end
	elseif spell.action_type == 'Magic' then
		if spell.name:contains('Utsusemi:') then
			if buffactive['Copy Image (3)'] then
				cancel_spell()
			else
				equip(sets.precast['Utsusemi'])
			end
		else
			equip(sets.fc.base)
		end
		if player.equipment.range == 'empty' then
			equip(ammo.fc)
		end
	elseif spell.action_type == 'Ranged Attack' and player.equipment.range ~= 'empty' and player.equipment.range == 'Ullr' then
		if player.equipment.ammo == 'empty' then
			equip(ammo.shooty)
		end
		equip(ammo.shooty)
		equip(sets.precast.RA)
	end
end

function midcast(spell)
	if spell.skill == 'Enfeebling Magic' then
		if player.equipment.range == 'empty' then
			equip(ammo.acc)
		end
		if S{player.sub_job}:contains('BLM') or S{player.sub_job}:contains('DRK') then
			equip(sets.THwhore)
			if player.equipment.range == 'empty' then
				equip(ammo.th)
			else
				equip({waist="Chaac Belt",})
			end
		else
			weathercheck(spell.element,sets.macc)
		end
	elseif spell.skill == 'Enhancing Magic' then
		equip(sets.midcast['Enhancing Magic'])
		if spell.name == 'Phalanx' then
			equip(sets.phalanx)
		elseif spell.name == 'Stoneskin' then
			equip({right_ear="Earthcry Earring",})
		end
	elseif spell.action_type == 'Ranged Attack' and player.equipment.range ~= 'empty' then
		equip(sets.midcast.RA)
	end
	if (spell.name == 'Sneak' or spell.english == 'Spectral Jig' or spell.english:contains('Monomi')) and spell.target.name == player.name and buffactive["Sneak"] then
		send_command('cancel Sneak')
	elseif spell.name == 'Utsusemi: Ichi' then
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
	if player.status == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]],sets.TH[sets.TH.index[TH_ind]])
		if sets.TH[sets.TH.index[TH_ind]] ~= sets.TH['None'] then
			if player.equipment.range == 'empty' then
				equip(ammo.th)
			else
				equip({left_ear="Suppanomimi",waist="Chaac Belt",})
			end
		elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['Acc'] then
			if player.equipment.range == 'empty' then
				equip(ammo.acc)
			end
		elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['Hybrid'] or sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] then
			if player.equipment.range == 'empty' then
				equip(ammo.dt)
			end
		else
			if player.equipment.range == 'empty' then
				equip(ammo.melee)
			end
		end
	else
		if (S{player.sub_job}:contains('BLM') or S{player.sub_job}:contains('DRK') or S{player.sub_job}:contains('RDM')) and player.mpp <= 50 then
			equip(sets.refresh)
		else
			equip(sets.TP[sets.TP.index[TP_ind]],sets.idle)
			if player.equipment.range == 'empty' then
				--equip({ammo="Coiste Bodhar",})
				equip(ammo.acc)
			end
		end
	end
	if check_facing() == true then
		equip({body="Plunderer's Vest +3"})
	end
end

function status_change(new,old)
	if new == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]],sets.TH[sets.TH.index[TH_ind]])
		if sets.TH[sets.TH.index[TH_ind]] ~= sets.TH['None'] then
			if player.equipment.range == 'empty' then
				equip(ammo.th)
			else
				equip({left_ear="Suppanomimi",waist="Chaac Belt",})
			end
		elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['Acc'] then
			if player.equipment.range == 'empty' then
				equip(ammo.acc)
			end
		elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['Hybrid'] or sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] then
			if player.equipment.range == 'empty' then
				equip(ammo.dt)
			end
		else
			if player.equipment.range == 'empty' then
				equip(ammo.melee)
			end
		end
		if check_facing() == true then
			equip({body="Plunderer's Vest +3"})
		end
	elseif new == 'Idle' then
		if (S{player.sub_job}:contains('BLM') or S{player.sub_job}:contains('DRK') or S{player.sub_job}:contains('RDM')) and player.mpp <= 50 then
			equip(sets.refresh)
		else
			equip(sets.TP[sets.TP.index[TP_ind]],sets.idle)
			if player.equipment.range == 'empty' then
				equip(ammo.melee)
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
send_command('bind !q gs c toggle mode set') -- Hit alt+q, toggles the sets
send_command('bind !s gs c toggle TP set') -- Hit alt+q, toggles the sets
send_command('bind !w gs c toggle TH set') -- Hit alt+q, toggles the sets
send_command('bind !a gs c reequip') -- Hit alt+a, reequips your gear
send_command('bind !r gs equip sets.regen')
send_command('bind !u gs equip low_hp;wait 1; gs equip high_hp')

function file_unload()
	send_command('unbind !`')
    send_command('unbind !q')
	send_command('unbind !w')
	send_command('unbind !a')
	send_command('unbind !s')
	send_command('unbind !r')
	send_command('unbind !u')
end

function self_command(command)
	if command == 'toggle TP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip(sets.TP[sets.TP.index[TP_ind]],sets.TH[sets.TH.index[TH_ind]])
		if player.status == 'Idle' then
			equip(sets.TP[sets.TP.index[TP_ind]],sets.idle)
			if sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] then
				equip({right_ring="Defending Ring",})
			end
		elseif player.status == 'Engaged' then
			if player.equipment.range == 'empty' then
				if sets.TP[sets.TP.index[TP_ind]] == sets.TP['Acc'] then
					equip(ammo.acc)
				elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['Hybrid'] or sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] then
					equip(ammo.dt)
				else
					equip(ammo.acc)
				end
			end
			equip(sets.TP[sets.TP.index[TP_ind]],sets.TH[sets.TH.index[TH_ind]])
		end
    end
	if command == 'toggle TH set' then
		TH_ind = TH_ind +1
		if TH_ind > #sets.TH.index then TH_ind = 1 end
		windower.add_to_chat(1,'<----- TH Set changed to '..sets.TH.index[TH_ind]..' ----->')
		if player.status == 'Engaged' then
			equip(sets.TP[sets.TP.index[TP_ind]],sets.TH[sets.TH.index[TH_ind]])
		elseif player.status == 'Idle' then
			equip(sets.TP[sets.TP.index[TP_ind]],sets.idle)
			if sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] then
				equip({right_ring="Defending Ring",})
			end
		end
		if sets.TH[sets.TH.index[TH_ind]] ~= sets.TH['None'] then
			if player.equipment.range == 'empty' then
				equip(ammo.th)
			else
				equip({left_ear="Suppanomimi",waist="Chaac Belt",})
			end
		else
			if player.equipment.range == 'empty' and (sets.TP[sets.TP.index[TP_ind]] ~= sets.TP['DT'] or sets.TP[sets.TP.index[TP_ind]] ~= sets.TP['Hybrid']) then
				equip(sets.TP[sets.TP.index[TP_ind]],ammo.acc)
			end
		end
	end
	if command == 'toggle mode set' then
		mode_ind = mode_ind +1
		if mode_ind > #sets.mode.index then mode_ind = 1 end
		windower.add_to_chat(1,'<----- mode Set changed to '..sets.mode.index[mode_ind]..' ----->')
	end
	if command == 'reequip' then
		equip(sets.TP[sets.TP.index[TP_ind]],sets.Dagger)
		--equip(sets.TP[sets.TP.index[TP_ind]],sets.TH[sets.TH.index[TH_ind]])
		if sets.TH[sets.TH.index[TH_ind]] ~= sets.TH['None'] then
			if player.equipment.range == 'empty' then
				equip(ammo.th)
			else
				equip({left_ear="Suppanomimi",waist="Chaac Belt",})
			end
		else
			if player.equipment.range == 'empty' then
				equip(sets.TP[sets.TP.index[TP_ind]],ammo.acc)
			end
		end
		if player.status == 'Idle' then
			equip(sets.TP[sets.TP.index[TP_ind]],sets.idle)
			if sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] then
				equip({right_ring="Defending Ring",})
			end
		end
	end
end

function set_macros(sheet,book)
    if book then
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
	add_to_chat (55, 'You are on '..('Samurai'):color(5)..('. '):color(55)..''..('Macros set!'):color(121))
end

function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
 
--Page, Book--
set_macros(1,6)
--Use the Lockstyle Number
set_style(006) 