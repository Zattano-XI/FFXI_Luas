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
	sets.IDLE = {}
	sets.DEF = {}
	sets.WEAPON = {}
	
	sets.movement = {legs="Carmine Cuisses +1"}
	
	--sets.fashion = {
		--head="Sakpata's Helm",
		--body="Sakpata's Plate",
		--hands="Sakpata's Gauntlets",
		--legs="Sakpata's Cuisses",
		--feet="Sakpata's Leggings"
	--}
	
	 sets.fc.base = { --68
    ammo="Sapience Orb",
    head="Carmine Mask +1",
    left_ear="Odnowa Earring +1",
    right_ear="Etiolation Earring",
    neck="Orunmila's Torque",
	--neck={ name="Abyssal Beads +1", augments={'Path: A',}},
	body="Sacro Breastplate",
	--body={ name="Fall. Cuirass +3", augments={'Enhances "Blood Weapon" effect',}},
    hands="Leyline Gloves",
    left_ring="Kishar Ring",
    right_ring="Rahab Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	legs="Enif Cosciales",
	--legs="Fall. Flanchard +3",
    --feet={ name="Odyssean Greaves", augments={'"Fast Cast"+5','"Mag.Atk.Bns."+15',}},
	feet="Carmine Greaves +1",
	}
	
	sets.ja['Last Resort'] = {
	    ammo="Staunch Tathlum +1",
		--neck="Yngvi Earring", --5
        --left_ear="Halasz Earring", --3
        --right_ear="Novia Earring", --7
		--body="Crepuscular Cloak", --15
        hands="Sakpata's Gauntlets",
        --left_ring="Persis Ring", --5
        --right_ring="Prolix Ring", --3
		--back={ name="Ankou's Mantle", augments={'HP+60','HP+20','Enmity-10','"Regen"+5',}},
        waist="Plat. Mog. Belt",
        legs="Sakpata's Cuisses",
		feet="Fallen's Sollerets +3",
	}
	sets.ja['Souleater'] = {head="Ig. Burgeonet +3"}
	sets.ja['Arcane Circle'] = {feet="Ig. Sollerets +2"}
	sets.ja['Blood Weapon'] = {body="Fall. Cuirass +3"}
	sets.ja['Dark Seal'] = {head="Fall. Burgeonet +3"}
	sets.ja['Nether Void'] = {legs="Heath. flanchard +1"}
	sets.ja['Weapon Bash'] = {hands="Ig. Gauntlets +3"}
	sets.ja['Diabolic Eye'] = {hands="Fall. Fin. Gaunt. +3"}
	
	
	sets.TP.index = {'Standard','DT','High Acc','DW'}
	TP_ind = 1 --Standard set is the Default
	
	sets.TP['Standard'] = {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		--legs="Ignominy flanchard +3",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Vim Torque +1",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Moonlight Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.TP['DT'] = set_combine(sets.TP['Standard'], { --54/56%
		--body="Sakpata's Plate", --10
		--hands="Sakpata's Gauntlets", --8
		--legs="Sakpata's Cuisses", --9
		--feet="Sakpata's Leggings", --6
		--neck={ name="Abyssal Beads +1", augments={'Path: A',}},
		--waist="Plat. Mog. Belt", --3
		left_ring={name="Chirich Ring +1", bag="wardrobe2"},
		--right_ring="Moonlight Ring", --5
		--back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	})
	
	sets.TP['High Acc'] = { 
        ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands="Emicho gauntlets +1",
		legs="Sakpata's Cuisses",
		feet="Flam. Gambieras +2",
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Mache Earring +1",
		left_ring={name="Chirich Ring +1", bag="wardrobe2"},
		right_ring={name="Chirich Ring +1", bag="wardrobe5"},
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.TP['DW'] = { 
        ammo="Coiste Bodhar",
    head="Hjarrandi Helm",
    body="Hjarrandi Breast.",
    hands="Emicho gauntlets +1",
    legs="Sakpata's Cuisses",
    feet="Flam. Gambieras +2",
    neck={ name="Vim Torque +1", augments={'Path: A',}},
	waist="Reiki Yotai",
    --waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Mache Earring +1",
    left_ring={name="Chirich Ring +1", bag="wardrobe2"},
    right_ring={name="Chirich Ring +1", bag="wardrobe5"},
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	
	sets.idle = set_combine(sets.TP['Standard'], {
    ammo="Staunch tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata Plate",
    hands="Sakpata's Gauntlets",
    feet="Sakpata's leggings",
    neck="Abyssal Beads +1",
    waist="Plat. Mog. Belt",
	legs="Carmine Cuisses +1",
    left_ear="Ethereal Earring",
    right_ear="Etiolation earring",
    left_ring="Defending Ring",
    right_ring="Karieyh Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	})
	
	sets.regen = {
        ammo="Staunch Tathlum +1",
        --head="Baghere Salade", --2/0
        neck="Bathy Choker +1",
        left_ear="Odnowa Earring +1",
		--right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','Latent effect: "Refresh"+1',}}, --0/1
        --body="Sacro Breastplate", --13/0
		--hands={ name="Yorium Gauntlets", augments={'Rng.Atk.+10','"Regen"+2','VIT+1',}}, --2/0
        --left_ring="Sheltered Ring", --1/0
        --right_ring="Paguroidea Ring", --2/0
		--back={ name="Ankou's Mantle", augments={'HP+60','HP+20','Enmity-10','"Regen"+5',}},
        waist="Plat. Mog. Belt",
		--legs={ name="Carmine Cuisses +1", augments={'Accuracy+12','DEX+12','MND+20',}},
        --feet="Sakpata's Leggings",
	}
	
	sets.ws.common = {
    ammo="Knobkierrie",
    head="Nyame Helm",
    neck="Rep. plat. medal",
    left_ear="Moonshade Earring",
	right_ear="Thrud Earring",
    body="Nyame Mail",
	--body="Ignominy Cuirass +3",
    hands="Nyame Gauntlets",
    left_ring="Cornelia's Ring",
    right_ring="Regal Ring",
    waist="Sailfi belt +1",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	legs="Nyame Flanchard",
    --legs="Fall. Flanchard +3",
    feet="Nyame Sollerets",
	--neck="Abyssal Beads +1",
	}
	
	sets.ws['Catastrophe'] = set_combine(sets.ws.common, {
		head="Ratri Sallet",
        hands={ name="Odyssean Gauntlets", augments={'STR+8','Mag. Acc.+8 "Mag.Atk.Bns."+8','Weapon skill damage +7%',}},
        --left_ring="Beithir Ring",
		feet="Ratri Sollerets +1",
	})
	
	sets.ws['Cross Reaper'] = set_combine(sets.ws.common, {
		--legs="Ratri cuisses",
		--feet="Ratri Sollerets",
		--feet="Sulev. leggings +2",
		right_ring="Niqmaddu ring",
	})
	
	sets.ws['Entropy'] = set_combine(sets.ws.common, {
        ammo="Coiste Bodhar",
		--neck="Fotia Gorget",
		head="Sakpata's	helm",
		body="Sakpata's breastplate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's cuisses",
        feet="Nyame sollerets",
		right_ring="Niqmaddu ring",
	})
	
	sets.ws['Torcleaver'] = set_combine(sets.ws.common, {
        head="Nyame Helm",
		body="Nyame mail",
		hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
		right_ring="Beithir Ring",
        left_ear="Moonshade Earring",
        back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Damage taken-5%',}},
        feet="Nyame Sollerets",
	})
	
	sets.ws['Resolution'] = set_combine(sets.ws.common, {
        ammo="Coiste Bodhar",
        head="Flam. Zucchetto +2",
		body="Sakpata's breastplate",
		hands="Sakpata's gauntlets",
        back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		right_ring="Regal ring",
		left_ring="Niqmaddu ring",
		right_ear="Schere Earring",
		legs="Ig. Flanchard +3",
        feet="Flam. Gambieras +2",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
	})
	
	sets.ws['Shadow of Death'] = set_combine(sets.ws.common, {
		body={ name="Fall. Cuirass +3", augments={'Enhances "Blood Weapon" effect',}},
		hands="Fall. fin. Gauntlets +3",
		waits="Orpheus's sash",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		left_ear="Friomisi Earring",
		right_ring="Archon Ring",
		
		})
		
		sets.ws['Savage Blade'] = set_combine(sets.ws.common, {
		head="Ratri Sallet",
        --right_ear="Ishvara Earring",
		--hands="Odyssean Gauntlets",
		hands={ name="Odyssean Gauntlets", augments={'STR+8','Mag. Acc.+8 "Mag.Atk.Bns."+8','Weapon skill damage +7%',}},
        --left_ring="Beithir Ring",
		waist="Sailfi belt +1",
		legs="Fall. flanchard +3",
		feet="Nyame sollerets",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
	})
	
	sets.ja['Provoke'] = {--set_combine(sets.enmity, {
		--ammo="Aqreqaq Bomblet",
		head="Rabid Visor",
		--neck="Warder's Charm +1",
		left_ear="Cryptic Earring",
		--right_ear="Trux Earring",
		body="Emet Harness +1",
		--left_ring="Eihwaz Ring",
		--right_ring="Pernicious Ring",
		--back="Earthcry Mantle",
		--waist="Chaac Belt",
	}--)
	
	sets.weapon = set_combine(sets.TP['Standard'], {
	main="Apocalypse",
	sub="Utu Grip",
	})
	
	sets.WEAPON.index = {'Apocalypse', 'Anguta', 'Caladbolg', 'Sword'} --'Great Sword',
	WEAPON_ind = 3 --Caladbolg set is the Default
	
	sets.WEAPON['Apocalypse'] = {
	main="Apocalypse",
	sub="Utu Grip",
	}
	
	sets.WEAPON['Anguta'] = {
	main="Anguta",
	sub="Utu Grip",
	}
	
	sets.WEAPON['Caladbolg'] = {
	main="Caladbolg",
	sub="Utu Grip",
	}
	
	--sets.WEAPON['Great Sword'] = {
	--main="Ragnarok",
	--main="Caladbolg",
	--sub="Utu Grip",
	--}
	
	sets.WEAPON['Sword'] = {
	main="Naegling",
	sub="Blurred Shield +1",
	}
	
	sets.low_hp = {
		--head="Wakido Kabuto",
		--body="Kasuga Domaru +1",
		--hands="Valorous Mitts",
		--left_ring="Mephitas's Ring +1",
		--right_ring="Metamorph Ring",
		--legs="Limbo Trousers",
		--feet="Kasuga Sune-Ate +1"
	}
	
	sets.high_hp = {
        --main="Agwu's Claymore",
		--sub="Utu Grip",
		ammo="Coiste Bodhar",
		head="Ratri Sallet",
		body="Heath. Cuirass +1",
		hands="Ratri Gadlings",
		legs="Ratri Cuisses",
		feet="Ratri Sollerets +1",
		neck="Unmoving Collar +1",
		waist="Plat. Mog. Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Etiolation Earring",
		left_ring="Regal Ring",
		right_ring="Moonbeam Ring",
		back="Moonbeam cape",
	}
	
	
	sets.tpgain = {
		--head={ name="Valorous Mask", augments={'Attack+8','Sklchn.dmg.+1%','Weapon skill damage +7%',}},
		--neck="Vim Torque +1",
	}
	
	sets.midcast.magic = { --540 Dark Magic Skill
        main={ name="Apocalypse", augments={'Path: A',}},
		sub="Utu Grip",
		ammo="Pemphredo Tathlum",
		head="Ig. Burgeonet +3",
		body={ name="Fall. Cuirass +3", augments={'Enhances "Blood Weapon" effect',}},
		hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
		feet="Ratri Sollerets +1",
		neck="Erra Pendant",
		waist="Null Belt",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Evanescence Ring",
		right_ring="Kishar Ring",
		back="Niht Mantle",
        }
		
	sets.midcast.Drain = set_combine(sets.midcast.magic, {
        
		
        head="Fall. burgonet +3",
		neck="Erra pendant",
		body="Carm. Sc. Mail",
		hands="Fallen's finger gauntlets +3",
		--waist="Austerity Belt +1",
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		legs="Fall. flanchard +3",
        feet="Ig. Sollerets +3",
		-- left_ear="Hirudinea Earring",
		back="Niht Mantle",
        })
		
	sets.midcast.Elemental = set_combine(sets.midcast.magic, {
        ammo="Pemphredo Tathlum",
		head="Nyame Helm",
		--body={ name="Fall. Cuirass +3", augments={'Enhances "Blood Weapon" effect',}},
		body="Nyame Mail",
		--hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
		hands="Nyame Gauntlets",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Null Loop",
		waist="Orpheus's Sash",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Metamor. Ring +1",
		right_ring="Kishar Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		--back={ name="Niht Mantle", augments={'Attack+7','Dark magic skill +10','"Drain" and "Aspir" potency +25',}},
        })
		
	sets.midcast.Endark = set_combine(sets.midcast.magic, {
        ammo="Pemphredo Tathlum",
		head="Ig. Burgonet +2",
		neck="Erra pendant",
		body="Carm. Sc. Mail",
        --waist="Casso sash",
		hands="Fallen's finger gauntlets +3",
		left_ring="Evanescence Ring",
		right_ring="Stikini Ring +1",
        feet="Ratri Sollerets +1",
		back="Niht Mantle",
        })
		
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.magic, {
        --head="Fall. burgonet +3",
		neck="Erra pendant",
		--body="Carm. Sc. Mail +1",
		--hands="Fallen's finger gauntlets +3",
		waist="Austerity Belt +1",
		--left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		--legs="Fall. flanchard +3",
        -- feet="Ig. Sollerets +3",
		-- left_ear="Hirudinea Earring",
		back={ name="Niht Mantle", augments={'Attack+7','Dark magic skill +10','"Drain" and "Aspir" potency +25',}},
        })

	sets.phalanx = {
		ammo="Staunch Tathlum +1",
		head="Valorous Mask",
		body="Valorous Mail",
		hands="Valorous Mitts",
		legs="Valorous Hose",
		feet="Valorous Greaves",
		neck="Null Loop",
		ear1="Odnowa earring +1",
		left_ring="Shadow Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		waist="Null Belt",	
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
			if player.equipment.main == "Anguta" then
				if (player.tp >= 1000 and player.tp < 2500) or buffactive['Sekkanoki'] then
					equip({left_ear="Moonshade Earring"})
				elseif world.time >= (17*60) or world.time <= (7*60) then
					equip({left_ear="Lugra Earring +1"})
				else
					equip({left_ear="Ishvara Earring"})
				end
			else
				if (player.tp >= 1000 and player.tp < 3000) or buffactive['Sekkanoki'] then
					equip({left_ear="Moonshade Earring"})
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
		end
	elseif spell.action_type  == "Magic" then
        equip(sets.fc.base)
	end
	end

function midcast(spell)
    if spell.action_type == 'Magic' and not spell.type:contains('Trust') then
        if spell.skill == 'Dark Magic' then
            if spell.english:contains('Drain') or spell.english:contains('Aspir') then 
				equip(sets.midcast.Drain)
			elseif spell.name == 'Dread Spikes' then
				equip(sets.high_hp)
			else
				equip(sets.midcast.magic)
            end
        elseif spell.skill == 'Ninjutsu' then
		elseif spell.skill == 'Elemental' then
			equip(sets.midcast.Elemental)
        elseif spell.type == "Item" then
            return
        else
            equip(sets.midcast.conservemp)
        end
    end
    if (spell.name == 'Sneak' or spell.english == 'Spectral Jig') and spell.target.name == player.name and buffactive["Sneak"] then
        send_command('cancel Sneak')
    elseif string.find(spell.english,'Utsusemi') and buffactive["Copy Image"] then
        send_command('@wait 1;cancel 66;')
    end
end

function aftercast(spell)
    if player.status == "Engaged" then
        equip(sets.TP[sets.TP.index[TP_ind]])
    else
        equip(sets.idle)
    end
end

function status_change(new,old)
    if new == 'Idle' then
        equip(sets.idle)
    elseif new == 'Engaged' then
        equip(sets.TP[sets.TP.index[TP_ind]])
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

function buff_change(n, gain, buff_table)
	local name
	name = string.lower(n)
	if S{"doom"}:contains(name) then
		if gain then
			send_command('@input /p Cursna - Doomed')
		end
	elseif S{"silence"}:contains(name) then
		if gain then
			--send_command('@input /item "Echo Drops" <me>')
			send_command('@input /item "Remedy" <me>')
		end
	end
end

send_command('bind !s gs c toggle TP set') -- Hit ALT+S, toggles the sets
send_command('bind !w gs equip sets.movement')
send_command('bind !- gs c toggle WEAPON set') -- Hit cmd+-, toggles the sets
send_command('bind !r gs equip sets.regen') -- Hit cmd+r, toggles the sets
send_command('bind !a gs equip sets.weapon') -- Hit cmd+a
--send_command('wait 5;gs equip fashion;wait 1;input /lockstyle on;wait 1;gs equip idle')
send_command('bind !u gs equip low_hp;wait 1; gs equip high_hp')
send_command('bind !p gs equip sets.tpgain')
send_command('bind !d gs equip sets.midcast.magic')

function self_command(command)
	if command == 'toggle TP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip(sets.TP[sets.TP.index[TP_ind]])
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
	send_command('unbind !s')
	send_command('unbind !p')
end

function set_macros(sheet,book)
    if book then
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
	add_to_chat (55, 'You are on '..('Dark Knight'):color(5)..('. '):color(55)..''..('Macros set!'):color(121))
end
 
function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end

--Page, Book--
set_macros(1,8)
--Use the Lockstyle Number--
set_style(008) 