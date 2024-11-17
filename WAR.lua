res = require 'resources'
	
include('SendCommands.lua')
	
	sets.ja = {}
	sets.ws = {}
	sets.Obis = {}
	sets.buff = {}
	sets.misc = {}

function get_sets()
	sets.fc = {}
	sets.precast = {}
	sets.midcast = {}
	sets.aftercast = {}
	sets.TP = {}
	sets.IDLE = {}
	sets.DEF = {}
	sets.WEAPON = {}
	
	
	sets.ja['Warcry'] = {head="Agoge Mask +3"}
	sets.ja['Berserk'] = {feet="Agoge Calligae +3", body="Pummeler's Lorica +3"}
	sets.ja['Aggressor'] = {head="Pummeler's mask +1", body="Agoge lorica +3"}
	sets.ja['Mighty Strikes'] = {hands="Agoge Mufflers +3"}
	sets.ja['Tomahawk'] = {ammo="Throwing Tomahawk", feet={ name="Agoge Calligae +3", augments={'Enhances "Tomahawk" effect',}},}
	sets.ja['Jump'] = {hands="Crusher\'s gauntlets", feet="Ostro greaves"}
	sets.ja['High Jump'] = {hands="Crusher\'s gauntlets", feet="Ostro greaves"}
	sets.ja['Blood Rage'] = {body="Boii lorica +3"}
	
	sets.TP.index = {'Standard','DT','Empy','DADmg'}
	TP_ind = 1 --Standard set is the Default
	
	sets.TP['Standard'] = {
	ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body="Boii Lorica +3",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs="Pumm. Cuisses +3",
    feet="Pumm. Calligae +3",
    neck={ name="Vim Torque +1", augments={'Path: A',}},
    waist="Windbuffet Belt +1",
    left_ear={ name="Schere Earring", augments={'Path: A',}},
    right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+17','Mag. Acc.+17','Crit.hit rate+6','STR+9 VIT+9',}},
    left_ring={ name="Moonlight Ring", bag="wardrobe1"},
    right_ring="Niqmaddu Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	
	sets.TP['DT'] = { 
    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body={ name="Sakpata's Plate", augments={'Path: A',}},
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
    feet={ name="Sakpata's Leggings", augments={'Path: A',}},
    neck="Warder's Charm +1",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Schere Earring", augments={'Path: A',}},
    right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+17','Mag. Acc.+17','Crit.hit rate+6','STR+9 VIT+9',}},
    left_ring={name="Moonlight Ring", bag="wardrobe1"},
    right_ring="Niqmaddu Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.idle = {
    ammo="Staunch Tathlum +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Adamantite Armor",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Sanctity Necklace",
    --waist="Plat. Mog. Belt",
    --left_ear="Odnowa Earring",
    --right_ear="Tuisto Earring",
    left_ring="Defending Ring",
    right_ring="Shneddick Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
	
	sets.TP['Empy']= {
    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Boii Mask +3",
    body="Boii Lorica +3",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs="Boii Cuisses +3",
    feet="Boii Calligae +3",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear={ name="Schere Earring", augments={'Path: A',}},
    right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+17','Mag. Acc.+17','Crit.hit rate+6','STR+9 VIT+9',}},
    left_ring={name="Moonlight Ring", bag="wardrobe1"},
    right_ring={name="Moonlight Ring", bag="wardrobe2"},
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	sets.TP['DADmg']= {
	ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body="Boii Lorica +3",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
    feet="Pumm. Calligae +3",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear={ name="Schere Earring", augments={'Path: A',}},
    right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+17','Mag. Acc.+17','Crit.hit rate+6','STR+9 VIT+9',}},
    left_ring={name="Moonlight Ring", bag="wardrobe1"},
    right_ring={name="Moonlight Ring", bag="wardrobe2"},
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	}
	
	sets.ws.common = {
    ammo="Knobkierrie",
    head="Boii Mask +3",
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Boii Mufflers +3",
    legs="Boii Cuisses +3",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+17','Mag. Acc.+17','Crit.hit rate+6','STR+9 VIT+9',}},
    left_ring="Cornelia's Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
}
	
	sets.ws["Ukko\'s Fury"] =  {
	ammo="Yetshila +1",
    head="Boii Mask +3",
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Boii Mufflers +3",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet="Boii Calligae +3",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Schere Earring", augments={'Path: A',}},
	right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+17','Mag. Acc.+17','Crit.hit rate+6','STR+9 VIT+9',}},
    left_ring="Sroda Ring",
    right_ring="Begrudging Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Damage taken-5%',}}}

	
	sets.ws['Impulse Drive'] = {
	ammo="Yetshila +1",
    head="Boii Mask +3",
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Boii Mufflers +3",
    legs="Boii Cuisses +3",
    feet="Boii Calligae +3",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+17','Mag. Acc.+17','Crit.hit rate+6','STR+9 VIT+9',}},
    left_ring="Cornelia's Ring",
    right_ring="Sroda Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
}
	
	sets.ws['Stardiver'] = sets.ws["Impulse Drive"]
	
	sets.ws['Upheaval'] = set_combine(sets.ws.common, {
        --left_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%'},
	}})
		
	sets.ws['Cloudsplitter'] = {
	ammo="Seeth. Bomblet +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Baetyl Pendant",
    waist="Orpheus's Sash",
    right_ear="Friomisi Earring",
    left_ring="Regal Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}
	
	sets.ws['Cataclysm'] = {
	ammo="Seeth. Bomblet +1",
    head="Pixie Hairpin +1",
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Baetyl Pendant",
    waist="Orpheus's Sash",
    left_ear="Hecate's Earring",
    right_ear="Friomisi Earring",
    left_ring="Archon Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}
	
	sets.ws['Sanguine Blade'] = sets.ws['Cataclysm']
	
	sets.ws['Full Break'] = {
	ammo="Pemphredo Tathlum",
    head="Boii Mask +3",
    body="Boii Lorica +3",
    hands="Boii Mufflers +3",
    legs="Boii Cuisses +3",
    feet="Boii Calligae +3",
    neck="Sanctity Necklace",
    waist="Skrymir Cord",
    left_ear="Crep. Earring",
    right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+17','Mag. Acc.+17','Crit.hit rate+6','STR+9 VIT+9',}},
    left_ring={name="Stikini Ring +1", bag="wardrobe4"},
    right_ring={name="Stikini Ring +1", bag="wardrobe7"},
    back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}
	sets.ws['Armor Break'] = sets.ws ['Full Break']
	
	sets.ws['Weapon Break'] = sets.ws ['Full Break']
	
	sets.ws['Shell Crusher'] = sets.ws ['Full Break']
	
	sets.ws['Fimbulvetr'] = {
	ammo="Knobkierrie",
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Boii Mufflers +3",
    legs="Boii Cuisses +3",
	feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	right_ear="Thrud Earring",
    left_ring="Cornelia's Ring",
    right_ring="Sroda Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
}

	sets.ws['Resolution'] = {
	ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Boii Mask +3",
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs="Boii Cuisses +3",
    feet={ name="Sakpata's Leggings", augments={'Path: A',}},
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    right_ear="Thrud Earring",
    left_ring="Sroda Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
}
	sets.ws['Mistral\'s Axe'] = {
	ammo="Knobkierrie",
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Boii Mufflers +3",
    legs="Boii Cuisses +3",
    feet={ name="Sakpata's Leggings", augments={'Path: A',}},
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+17','Mag. Acc.+17','Crit.hit rate+6','STR+9 VIT+9',}},
    left_ring="Cornelia's Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
}

	sets.ws['Calamity'] = sets.ws['Mistral\'s Axe']
	
	sets.ws['Raging Axe'] = sets.ws['Mistral\'s Axe']
	
	
	sets.reraise = {
	head="Crepuscular Helm",
	body="Twilight Mail",
	}
	
	sets.phalanx = {
	head={ name="Valorous Mask", augments={'"Triple Atk."+1','"Drain" and "Aspir" potency +2','Phalanx +4','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
    body={ name="Yorium Cuirass", augments={'DEF+19','Spell interruption rate down -10%','Phalanx +3',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	}
	
	sets.weapon = set_combine(sets.TP['Standard'], {
	main="Ukonvasara",
	sub="Utu Grip",
	})
	
	sets.WEAPON.index = {'Great Axe', 'Polearm', 'GSword', 'Sword', 'Axe', 'Club', 'Axe2', 'Staff'}
	WEAPON_ind = 1 --Scythe set is the Default
	
	sets.WEAPON['Great Axe'] = {
	--main="Anguta",
	main="Ukonvasara",
	sub="Utu Grip",
	}
	
	sets.WEAPON['Polearm'] = {
	--main="Ragnarok",
	main="Shining One",
	sub="Utu Grip",
	}
	
	sets.WEAPON['Sword'] = {
	main="Naegling",
	sub="Blurred Shield +1",
	}
	
	sets.WEAPON['Axe'] = {
	main="Ikenga's Axe",
	sub="Blurred Shield +1",
	}
	
	sets.WEAPON['Club'] = {
	main="Loxotic Mace +1",
	sub="Blurred Shield +1",
	}
	
	sets.WEAPON['Axe2'] = {
	main="Farsha",
	sub="Blurred Shield +1",
	}
	
	sets.WEAPON['Staff'] = {
	main="Xoanon",
	sub="Utu Grip",}
	
	sets.WEAPON['GSword'] ={
	main="Helheim",
	sub="Utu Grip",}
	
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
			if player.equipment.main == "Chango" then
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
					equip({left_ear="Ishvara Earring",})
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
			--send_command('@input /item "Remedy" <me>')
		end
	end
end

send_command('bind !q gs c toggle TP set') -- Hit alt+q, toggles the sets
send_command('bind !w gs equip sets.idle')
send_command('bind !s gs c toggle WEAPON set') -- Hit alt+s, toggles the sets
send_command('bind !r gs equip sets.reraise') -- Hit alt+r, toggles the sets
send_command('bind !a gs equip sets.weapon') -- Hit alt+a
--send_command('wait 5;gs equip fashion;wait 1;input /lockstyle on;wait 1;gs equip idle')
send_command('bind !u gs equip low_hp;wait 1; gs equip high_hp')
send_command('bind !p gs equip sets.phalanx')
send_command('bind !d gs equip sets.midcast.magic')
send_command('alias pana input /item "Panacea" <me>')
send_command('alias rem input /item "Remedy" <me>')
send_command('alias mount input /mount Ixion')
send_command('lua l Skillchains')


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
	add_to_chat (55, 'You are on '..('Warrior'):color(5)..('. '):color(55)..''..('Macros set!'):color(121))
end
 
function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end

--Page, Book--
set_macros(6,1)
--Use the Lockstyle Number--
set_style(199) 