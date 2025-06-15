res = require 'resources'
require('vectors')

include('SendCommands.lua')

--Ageha/Mumei > Mumei > Shoha > > Mumei > >Kasha > Rana > Mumei
--Fudo > Kasha > Rana > Shoha
--Ageha > Gekko > Rana > Gekko > Mumei
WEAPON_ind = 1

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
	sets.mode = {}
	ammo = {}
	
	ammo.melee = {ammo="Coiste Bodhar"}
	--ammo.melee = {ammo="Coiste Bodhar"}
	ammo.ws = {ammo="Knobkierrie"}
	ammo.DT = {ammo="Staunch Tathlum +1"}
	ammo.fc = {ammo="Sapience Orb"}
	ammo.macc = {ammo="Phemphredo Tathlum"}
	ammo.shooty = {ammo="Yoichi's Arrow"}
	
	sets.movement = {feet="Danzo Sune-Ate"}
	sets.TH = {ammo="Per. Lucky Egg",body="Volte Jupon", waist="Chaac Belt",} 
	
	sets.fc.base = {
	neck="Orunmila's Torque",
	left_ear="Etiolation Earring",
	body="Sacro Breastplate",
	hands="Leyline Gloves",
	ring1="Prolix Ring",
	ring2="Lebeche Ring",
	--legs="Arjuna Breeches",
	legs="Limbo Trousers",
	}
	
	sets.ja['Meditate'] = {
	head="Wakido Kabuto +3",
	hands="Sakonji Kote +3",
	back="Smertrios's Mantle"
	}
	sets.ja['Sengikori'] = {feet="Kasuga Sune-Ate +3"}
	sets.ja['Warding Circle'] = {head="Wakido Kabuto +3"}
	sets.ja['Provoke'] = sets.enmity
	sets.ja['Souleater'] = sets.enmity
	sets.ja['Shikikoyo'] = {legs="Sakonji Haidate +3"}
	sets.ja['Blade Bash'] = {hands="Sakonji Kote +3"}

	sets.TP.index = {--[['Standard',]] 'Subtle DT', 'Subtle DT 2','Hybrid','DT',} --,'MDT'
	TP_ind = 1 --Standard set is the Default
	
	sets.TP['Standard'] = {
	head="Mpaca's Cap", --7pdt
	--head="Flamma Zucchetto +2",
	neck="Samurai's Nodowa +2",
	left_ear="Schere Earring",
	right_ear="Kasuga Earring +2",
	body="Mpaca's Doublet",
	--body="Tatenashi Haramaki +1",
	hands="Wakido Kote +3",
	--hands="Tatenashi Gote +1",
	left_ring="Niqmaddu Ring",
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
	back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --5dt
	waist="Sailfi Belt +1",
	legs="Kasuga Haidate +3", --10
	--legs="Tatenashi Haidate +1",
	feet="Mpaca's Boots"
	--feet="Ryuo Sune-Ate +1"
	}
	
	sets.TP['Acc'] = set_combine(sets.TP['Standard'], {
	head="Wakido Kabuto +3",
	body="Mpaca's Doublet",
	right_ring="Regal Ring",
	feet="Tatenashi Sune-ate +1"
	})
	
	sets.TP['Hybrid'] = set_combine(sets.TP['Standard'], { --37dt
        head="Mpaca's Cap", --7pdt
        body="Mpaca's Doublet", --10pdt
        hands="Wakido Kote +3",
        ring1="Niqmaddu Ring", 
        ring2="Defending Ring", --10dt
        --back=Smertrios.TP, 5dt
        waist="Ioskeha Belt +1",        
		--15dt, 23pdt
})
	
	sets.TP['DT'] = set_combine(sets.TP['Hybrid'], {
		head="Kasuga Kabuto +3", --10dt
		body="Kasuga Domaru +3", --14dt
		hands="Mpaca's Gloves", --8pdt
		ring2="Defending Ring", --10dt
		--back="Moonbeam Cape", --5dt
		legs="Kasuga Haidate +3", --11dt
		feet="Mpaca's Boots", --6pdt
		--total 50dt 9pdt
	})

	sets.TP['Subtle DT'] = set_combine(sets.TP['Hybrid'], {
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
		hands="Nyame Gauntlets",
		ring1="Niqmaddu Ring",
		right_ring={name="Chirich Ring +1", bag="wardrobe5"},
		legs="Kasuga Haidate +3",
		feet="Nyame Sollerets",
	})	
		
	sets.TP['Subtle DT 2'] = set_combine(sets.TP['Subtle DT'], {
		body="Dagon Breastplate", --10%
	})	
		
	sets.TP['MDT'] = set_combine(sets.TP['Standard'], {
	head="Ken. Jinpachi +1",
	body="Ken. Samue +1",
	hands="Ken. Tekko +1",
	right_ring="Defending Ring", --10%
	legs="Ken. Hakama +1",
	feet="Kendatsuba Sune-Ate +1"
	})
	
	sets.TP['Nyame'] = set_combine(sets.TP['Standard'], {
	head="Nyame Helm", --7
	body="Nyame Mail", --9
	right_ring="Defending Ring", --10%
	legs="Nyame Flanchard", --8
	feet="Nyame Sollerets", --7
	})
	
	sets.TP['Subtle'] = set_combine(sets.TP['Standard'], {
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
	})
	
	sets.idle = set_combine(sets.TP['Standard'], {
	left_ring="Warp Ring",
	feet="Danzo Sune-ate"
	})
	
	sets.regen = {
	head="Crepuscular Helm",
	neck="Bathy Choker +1",
	--neck="Bathy Choker +1",
	right_ear="Infused Earring",
	body="Hizamaru Haramaki +2",
	--hands="Rao Kote +1",
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
	--legs="Rao Haidate +1",
	--feet="Rao Sune-Ate +1",
	}
	
	sets.terror = {feet="Founder's Greaves"}
	
	sets.mode.index = {'Uncapped','Capped'} --Subtle Blow
	mode_ind = 1 --Uncapped set is the Default
	
	sets.ws.common = {
	--head="Nyame Helm",
	head="Mpaca's Cap",
	neck="Samurai's Nodowa +2",
	left_ear="Thrud Earring",
	--left_ear="Schere Earring", 
	right_ear="Kasuga Earring +2",
	body="Nyame Mail",
	hands="Kasuga Kote +3",
	left_ring="Regal Ring",
	right_ring="Cornelia's Ring",
	back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	waist="Sailfi Belt +1",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"
	}
		
	sets.ws.common.Capped = set_combine(sets.ws.common, {
	right_ring="Chirich Ring +1",
	})
	
	sets.ws['Tachi: Ageha'] = set_combine(sets.ws.common, {
	head="Kasuga Kabuto +3",
	neck="Null Loop",
	left_ear="Crepuscular Earring",
	body="Kasuga Domaru +3",
	hands="Kasuga Kote +3",
	left_ring="Stikini Ring +1",
    right_ring="Metamorph Ring +1",
	waist="Null Belt",
	legs="Kasuga Haidate +3",
	feet="Kasuga Sune-ate +3"
	})
	
	sets.ws['Tachi: Ageha'].Capped = {
	--neck="Warder's Charm +1",	
	}
	
	sets.ws['Tachi: Fudo'] = set_combine(sets.ws.common, {
	})
	
	sets.ws['Tachi: Fudo'].Capped = set_combine(sets.ws['Tachi: Fudo'], {
	right_ring="Chirich Ring +1",
	})
	
	sets.ws['Tachi: Shoha'] = set_combine(sets.ws.common, {
	})
	
	sets.ws['Tachi: Shoha'].Capped = set_combine(sets.ws['Tachi: Shoha'], {
	right_ring="Chirich Ring +1",
	})
	
	sets.ws['Tachi: Mumei'] = set_combine(sets.ws.common, {
	--left_ring="Regal Ring",
	waist="Kentarch Belt +1",
	})
	
	sets.ws['Tachi: Mumei'].Capped = set_combine(sets.ws['Tachi: Mumei'], {
	right_ring="Chirich Ring +1",
	})
	
	sets.ws['Tachi: Rana'] = set_combine(sets.ws.common, {
	feet="Kasuga Sune-Ate +3",
	})

	sets.ws['Tachi: Yukikaze'] = set_combine(sets.ws['Tachi: Ageha'], {})
	
	sets.ws['Empyreal Arrow'] = set_combine(sets.ws.common, {
	left_ear="Thrud Earring",
	left_ring="Regal Ring",
	})
	
	
	sets.ws['Namas Arrow'] = set_combine(sets.ws['Empyreal Arrow'], {})
	sets.ws['Refulgent Arrow'] = set_combine(sets.ws['Empyreal Arrow'], {})
	sets.ws['Sidewinder'] = set_combine(sets.ws['Empyreal Arrow'], {})
	sets.ws['Apex Arrow'] = set_combine(sets.ws['Empyreal Arrow'], {})
	
	sets.ws['Tachi: Jinpu'] = set_combine(sets.ws['Empyreal Arrow'], {
	right_ear="Kasuga Earring +2",
	waist="Orpheus's Sash",
	legs="Nyame Flanchard",
	})
	
	sets.ws['Tachi: Koki'] = set_combine(sets.ws['Tachi: Jinpu'], {})
	sets.ws['Tachi: Kagero'] = set_combine(sets.ws['Tachi: Jinpu'], {})
	sets.ws['Tachi: Goten'] = set_combine(sets.ws['Tachi: Jinpu'], {})
	
	sets.ws['Circle Blade'] = set_combine(sets.ws.common, {
	neck="Fotia Gorget"
	})
	
	sets.ws['Stardiver'] = set_combine(sets.ws.common, {
	--body="Tatenashi Haramaki +1",
	right_ear="Schere Earring",
	left_ring="Niqmaddu Ring",
	right_ring="Regal Ring",
	legs="Mpaca's Hose",
	feet="Tatenashi Sune-ate +1"
	})
	
	sets.WEAPON.index = {'Kusanagi','Piercing','Blunt',} --'Masamune',
	WEAPON_ind = 1 --GK set is the Default
	
	--sets.WEAPON['Masamune'] = {
	--main="Masamune",
	--sub="Utu Grip",
	--}
	
	sets.WEAPON['Kusanagi'] = {
	main="Kusanagi-No-Tsurugi",
	sub="Utu Grip",
	}
	
	sets.WEAPON['Piercing'] = {
	main="Shining One",
	sub="Utu Grip",
	}
	
	sets.WEAPON['Blunt'] = {
	main="Mafic Cudgel",
	sub="Forfend +1",
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
	legs=empty,
	feet=empty
	}
	
	sets.high_hp = {
	head="Loess Barbuta +1",
	neck="Unmoving Collar +1",
	left_ear="Tuisto Earring",
	right_ear="Odnowa Earring +1",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	left_ring="Gelatinous Ring +1",
	right_ring="Ilabrat Ring",
	back="Reiki Cloak",
	waist="Plat. Mog. Belt",
	legs="Kendatsuba Hakama +1",
	feet="Nyame Sollerets"
	}
	
	sets.stun = set_combine(sets.TP['MDT'], {
	neck="Anu Torque",
	left_ear="Dominance Earring +1",
	waist="Carrier's Sash",
	})
	
	sets.reraise = {
	head="Crepuscular Helm",
	body="Crepuscular Mail",
	}
	
	sets.refresh = {
	body="Crepuscular Mail",
	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	ring2={name="Stikini Ring +1", bag="wardrobe5"},
	}
	
	sets.phalanx = { 
	ammo="Staunch Tathlum +1",
	head="Valorous Mask",
	body="Valorous Mail",
	hands="Valorous Mitts",
	legs="Valorous Hose",
	feet="Valorous Greaves",
	neck="Null Loop",
	ear1="Odnowa earring +1",
	ring1="Shadow Ring",
	ring2="Defending Ring",
	back="Moonbeam Cape",
	waist="Null Belt",
	} --Phalanx+ on all pieces
	
	sets.enmity = {
	head="Loess Barbuta +1",
	neck="Unmoving Collar +1",
	left_ear="Cryptic Earring",
	right_ear="Friomisi Earring",
	left_ring="Pernicious Ring",
	right_ring="Begrudging Ring",
	back="Reiki Cloak",
	waist="Chaac Belt",
	}
	
	sets.enmitydouse = { --9+3+3+9+5+7+6+8=50
	--head="Lenore's Hairpin", --9
	neck="Debilis Medallion", --3
	--right_ear="Enervating Earring", --3
	--body="Kyujutsugi", --9
	left_ring="Lebeche Ring", --5
	right_ring="Janniston Ring", --7
	--back="Moondoe Mantle +1", --6
	waist="Reiki Yotai", --2
	--waist="Acerbic Sash +1", --8
	}
	
	--Snapshot > Rapid Shot [
	--[[sets.precast.RA = [{
	head="Volte Tiara",
	body="Volte Harness",
	hands="Volte Mittens",
	left_ring="Crepuscular Ring",
	waist="Yemaya Belt",
	legs="Volte Tights",
	feet="Volte Spats",
	}
	]] --This is not ideal, but for the off-chance it's needed...
	
	--r.acc/stp/crit/agi/recycle
	sets.midcast.RA = {
	head="Nyame Helm",
	neck="Samurai's Nodowa +2",
	left_ear="Telos Earring",
	right_ear="Crepuscular Earring",
	body="Kasuga Domaru +3",
	hands="Kasuga Kote +3",
	left_ring="Regal Ring",
	right_ring="Cacoethic Ring +1",
	waist="Yemaya Belt",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	}
	
	--Alchemy Craft
	sets.alchemy = {
	main="Caduceus",
	sub="Br. Escutcheon",
	head="Protective Specs.",
	neck="Alchemist's Torque",
	body="Alchemist's Smock",
	hands="Smithy's Mitts",
	ring1="Orvail ring +1", --+1
	ring2="Confectioner's Ring",
	waist="Alchemist's Belt",
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
    if player_angle < 45 and target_angle < 45 then
        return true
    end
    return false
end

function precast(spell)
	if buffactive['Stun'] or buffactive['Petrify'] or buffactive['Terror'] or ((spell.action_type == "WeaponSkill" or spell.action_type == "JobAbility") and buffactive['Amnesia']) or (spell.action_type == 'Magic' and buffactive['Silence']) then
		cancel_spell()
	elseif (sets.ja[spell.english]) then
		equip(sets.ja[spell.english])
		if spell.name == "Provoke" and player.equipment.range == 'empty' then
			equip(ammo.fc)
		end
	elseif string.find(spell.english,'Jump') then
		equip(sets.TP['Subtle DT'],sets.TH)
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
			--cancel_spell()
		--elseif spell.target.distance > (ability_distance * range_mult[ability_distance] + spell.target.model_size + player.model_size) then
			--cancel_spell()
			--add_to_chat(123, spell.name..' Canceled: [Out of Range]')
		elseif player.tp >= 1000 then
			if sets.ws[spell.name] then
				if player.equipment.range ~= 'Yoichinoyumi' and player.equipment.ammo == 'empty' then
					equip(ammo.shooty)
				end
				if sets.mode.index[mode_ind] == 'Capped' and sets.ws[spell.name].Capped ~= nil then
					equip(sets.ws[spell.name].Capped)
				else
					equip(sets.ws[spell.name])
				end
			else
				equip(sets.ws.common)
			end
			if player.equipment.main == "Dojikiri Yasutsuna" then
				if spell.name == "Tachi: Jinpu" or spell.name == "Tachi: Koki" or spell.name == "Tachi: Kagero" then
					equip({head="Nyame Helm", left_ear="Moonshade Earring"})
				elseif (player.tp >= 1000 and player.tp < 2250) or buffactive['Sekkanoki'] then
					equip({left_ear="Moonshade Earring"})
				elseif player.tp < 2500 then
					equip({left_ear="Thrud Earring"})
				elseif world.time >= (17*60) or world.time <= (7*60) then
					equip({left_ear="Lugra Earring +1"})
				else
					equip({left_ear="Thrud Earring"})
				end
			else
				if spell.name == "Tachi: Jinpu" or spell.name == "Tachi: Koki" or spell.name == "Tachi: Kagero" then
					equip({head="Nyame Helm", left_ear="Thrud Earring"})
				elseif (player.tp >= 1000 and player.tp < 2750) or buffactive['Sekkanoki'] then
					equip({left_ear="Moonshade Earring"}) --head="Mpaca's Cap", 
				elseif player.tp < 3000 then
					equip({left_ear="Thrud Earring"})
				elseif world.time >= (17*60) or world.time <= (7*60) then
					equip({left_ear="Lugra Earring +1"})
				else
					equip({left_ear="Thrud Earring"})
				end
			end
			if buffactive['Meikyo Shisui'] and player.tp >= 1750 then
				equip({feet="Sakonji sune-ate +3"})
			elseif buffactive['Sekkanoki'] then
				equip({hands="Kasuga Kote +3"})
			end
			if player.equipment.range == 'empty' then
				if spell.name == "Tachi: Ageha" or spell.name == "Tachi: Yukikaze" then
					equip(ammo.macc)
				else
					equip(ammo.ws)
				end
			end
		end
	elseif spell.action_type == 'Magic' then
		equip(sets.fc.base)
		if player.equipment.range == 'empty' then
			equip(ammo.fc)
		end
	elseif spell.action_type == 'Ranged Attack' and player.equipment.range ~= 'empty' then
		if player.equipment.ammo == 'empty' then
			equip(ammo.shooty)
		end
		equip(ammo.shooty)
		equip(sets.precast.RA)
	end
	if spell.english:contains('Circle') then
		equip({body="Founder's Breastplate"})
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
	elseif spell.action_type == 'Ranged Attack' and player.equipment.range ~= 'empty' then
		equip(sets.midcast.RA)
	end
end

function aftercast(spell)
	if player.status == 'Engaged' and player.equipment.main == "Soboro Sukehiro" then
		disable('range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
	elseif player.status == "Engaged" and (player.equipment.main ~= "Soboro Sukehiro" or player.equipment.main ~= "Quint Spear") then
		--enable('range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
		equip(sets.TP[sets.TP.index[TP_ind]])
		--if (spell.name == 'Seigan' and buffactive['Hasso']) or buffactive['Seigan'] then
		--	equip({hands="Tatenashi Gote +1"})
		--elseif spell.name == 'Hasso' or buffactive['Hasso'] then
		--	equip({hands="Wakido Kote +3"})
		--end
	elseif (player.status == 'Idle' and (player.equipment.main ~= "Soboro Sukehiro" or player.equipment.main ~= "Quint Spear")) or player.status == "Idle" then
		--enable('range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
		equip(sets.idle)
		if sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] then
			equip(sets.TP['DT'],sets.movement)
		elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['Hybrid'] then
			equip(sets.TP['Hybrid'],sets.movement)
		elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['Subtle DT'] then
			equip(sets.TP['Subtle DT'],sets.movement)
		elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['Subtle DT 2'] then
			equip(sets.TP['Subtle DT'],sets.movement)
		elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['MDT'] then
			equip(sets.TP['MDT'],sets.movement)
		end
		--if (spell.name == 'Seigan' and buffactive['Hasso']) or buffactive['Seigan'] then
		--	equip({hands="Tatenashi Gote +1"})
		--elseif spell.name == 'Hasso' or buffactive['Hasso'] then
		--	equip({hands="Wakido Kote +3"})
		--end
	end
	if player.equipment.range == 'empty' then
		if sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] or sets.TP[sets.TP.index[TP_ind]] == sets.TP['MDT'] then
			equip(ammo.dt)
		else
			equip(ammo.melee)
		end
	end
end

function status_change(new,old)
	if new == 'Idle' and player.equipment.main ~= "Soboro Sukehiro" or player.status == "Idle" then
		--enable('range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
		equip(sets.idle)
		if sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] then
			equip(sets.TP['DT'],sets.movement)
		elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['Hybrid'] then
			equip(sets.TP['Hybrid'],sets.movement)
		elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['Subtle DT'] then
			equip(sets.TP['Subtle DT'],sets.movement)
		elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['Subtle DT 2'] then
			equip(sets.TP['Subtle DT'],sets.movement)
		elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['MDT'] then
			equip(sets.TP['MDT'],sets.movement)
		end
	elseif new == 'Engaged' and (player.equipment.main == "Soboro Sukehiro" or player.equipment.main == "Quint Spear") then
		equip(sets.TP['Hybrid'])
		disable('range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
	elseif new == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
		--if buffactive['Hasso'] then
		--	equip({hands="Wakido Kote +3"})
		--elseif buffactive['Seigan'] then
		--	equip({hands="Tatenashi Gote +1"})
		--end
	end
	if player.equipment.range == 'empty' then
		if sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] or sets.TP[sets.TP.index[TP_ind]] == sets.TP['MDT'] then
			equip(ammo.dt)
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
	elseif S{"doom"}:contains(name) then
		if gain then
			send_command('@input /p Cursna - Doomed')
		end
	elseif S{"sleep"}:contains(name) and player.status == "Engaged" then
		if gain then
			if buffactive["Stoneskin"] then
				send_command('cancel Stoneskin')
			end
			equip({neck="Vim Torque +1",})
		else
			equip({neck="Samurai's Nodowa +2"})
		end
	end
end

send_command('bind !` gs c toggle mode set') -- Hit alt+`, toggles the sets
send_command('bind !s gs c toggle TP set') -- Hit alt+s, toggles the sets
send_command('bind !w gs equip sets.movement')
send_command('bind !- gs c toggle WEAPON set') -- Hit alt+-, toggles the sets
send_command('bind !r gs equip sets.regen') -- Hit alt+r, toggles the sets
send_command('bind !a gs c reequip;wait 1; input /lockstyle on') -- Hit alt+a
send_command('bind !u gs equip low_hp;wait 1; gs equip high_hp')
send_command('bind !o gs equip sets.reraise')
--send_command('bind !k gs equip sets.refresh')
send_command('alias food input /item "Grape Daifuku +1" <me>')
send_command('alias fudo @input /ws "Tachi: Fudo" <t>')
send_command('alias jinpu @input /ws "Tachi: Jinpu" <t>')


function self_command(command)
	if command == 'toggle TP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip(sets.TP[sets.TP.index[TP_ind]])
		--if buffactive['Seigan'] then
		--	equip({hands="Tatenashi Gote +1"})
		--elseif buffactive['Hasso'] then
		--	equip({hands="Wakido Kote +3"})
		--end
		if player.status == 'Idle' then
			equip(sets.movement)
		end
	end
	if command == 'toggle WEAPON set' then
		WEAPON_ind = WEAPON_ind +1
		if WEAPON_ind > #sets.WEAPON.index then WEAPON_ind = 1 end
		windower.add_to_chat(1,'<----- Weapon Set changed to '..sets.WEAPON.index[WEAPON_ind]..' ----->')
		equip(sets.WEAPON[sets.WEAPON.index[WEAPON_ind]])
		if WEAPON_ind == 1 then
			send_command('alias fudo @input /ws "Tachi: Fudo" <t>')
			send_command('alias jinpu @input /ws "Tachi: Jinpu" <t>')
		elseif WEAPON_ind == 2 then
			send_command('alias fudo @input /ws "Impulse Drive" <t>')
			send_command('alias jinpu @input /ws "Sonic Thrust" <t>')
		elseif WEAPON_ind == 3 then
			send_command('alias fudo @input /ws "Judgment" <t>')
			send_command('alias jinpu @input /ws "True Strike" <t>')
		elseif WEAPON_ind == 4 then
			send_command('alias fudo @input /ws "Tachi: Fudo" <t>')
			send_command('alias jinpu @input /ws "Tachi: Jinpu" <t>')
		end
	end
	if command == 'toggle mode set' then
		mode_ind = mode_ind +1
		if mode_ind > #sets.mode.index then mode_ind = 1 end
		windower.add_to_chat(1,'<----- mode Set changed to '..sets.mode.index[mode_ind]..' ----->')
	end
	if command == 'reequip' then
		equip(sets.WEAPON[sets.WEAPON.index[WEAPON_ind]],sets.TP[sets.TP.index[TP_ind]])
		--if buffactive['Seigan'] then
		--	equip({hands="Tatenashi Gote +1"})
		--elseif buffactive['Hasso'] then
		--	equip({hands="Wakido Kote +3"})
		--end
	end
end

function file_unload()
    send_command('unbind !`')
	send_command('unbind !q')
	send_command('unbind !w')
	send_command('unbind !e')
	send_command('unbind !r')
	send_command('unbind !a')
	send_command('unbind !s')
	send_command('unbind !p')
	send_command('unbind fudo')
	send_command('unbind jinpu')
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

WEAPON_ind = 1
 
--Page, Book--
set_macros(1,12)
--Use the Lockstyle Number--
set_style(012)

Hybrid = S{"Tachi: Goten","Tachi: Kagero","Tachi: Jinpu","Tachi: Koki"}