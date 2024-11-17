res = require 'resources'

include('SendCommands.lua')

function get_sets()
	sets.fc = {}
	sets.ja = {}
	sets.ws = {}
	sets.TP = {}
	sets.DEF = {}
	sets.misc = {}
	sets.pole = {}
	
---------------------------------------------------------------------------------------------------------------
------------------------------------------------ Gear Sets ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

	sets.fc.base = {
	ammo="Impatiens",
    head={ name="Herculean Helm", augments={'Mag. Acc.+12','"Fast Cast"+6','MND+7',}}, --13
	neck="Baetyl Pendant", --4
	left_ear="Loquac. Earring", --2 
	right_ear="Etiolation Earring", --1
	hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --8
	left_ring="Defending Ring",
	right_ring="Weather. Ring", --5
	back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	waist="Moonbow Belt +1",
	legs="Rawhide trousers",
	feet="Anch. Gaiters +3"
	}
	
	sets.fc.utsusemi = set_combine(sets.fc.base, {
	--neck="Magoraga Beads",
	--body="Passion Jacket",
	})
	
	sets.TP.index = {'DT2', 'Standard', 'High Acc','Hybrid', 'Ngai', 'DT'}
	TP_ind = 1 --Standard set is the Default
	
	sets.TP['Standard'] = {
	ammo="Coiste Bodhar",
	head="Ken. Jinpachi +1",
	neck="Mnk. Nodowa +2",
	left_ear="Sherida Earring",
	right_ear="Bhikku Earring +2",
	body="Ken. Samue +1",
	hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	left_ring="Gere Ring",
	right_ring="Niqmaddu Ring",
	back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	waist="Moonbow Belt +1",
	legs="Bhikku hose +3",
	--legs="Hesychast's Hose +3",
	feet="Anch. Gaiters +3"
	}
	
	sets.TP['High Acc'] = set_combine(sets.TP['Standard'], {
	legs="Ken. Hakama +1",
	feet="Anch. Gaiters +3"
	})

	sets.TP['Hybrid'] = set_combine(sets.TP['Standard'], {
	ammo="Crepuscular Pebble",
	head="Malignance Chapeau",  --kenda?
	body="Malignance Tabard",
	hands="Malignance Gloves",
    --legs="Malignance Tights",
	legs="Bhikku hose +3",	
    feet="Malignance Boots",
    left_ring="Defending Ring",
	})
	
	sets.TP['Ngai'] = set_combine(sets.TP['Hybrid'], {
	neck="Warder's charm +1",
	right_ring="Shadow Ring",
	})

	sets.TP['DT'] = {
	ammo="Crepuscular Pebble",
    head={ name="Mpaca's Cap", augments={'Path: A',}}, --7%
    body={ name="Mpaca's Doublet", augments={'Path: A',}}, --10%
	hands="Mpaca's gloves", --8%
    legs="Mpaca's Hose", --9%
    feet="Mpaca's Boots", --6%
	neck="Mnk. Nodowa +2",
    waist="Moonbow belt +1",
	left_ear="Sherida Earring",
	right_ear="Bhikku Earring +2",
    left_ring="Defending Ring",
	right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.TP['DT2'] = {
	ammo="Coiste Bodharf",
    head="Bhikku Crown +3", --7%
    body={ name="Mpaca's Doublet", augments={'Path: A',}}, --10%
	hands="Mpaca's gloves", --8%
    legs="Bhikku hose +3", --9%
    feet="Mpaca's Boots", --6%
	neck="Mnk. Nodowa +2",
    waist="Moonbow belt +1",
	left_ear="Sherida Earring",
	right_ear="Bhikku Earring +2",
    left_ring="Gere Ring",
	right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.DEF.index = {'DT'}
	DEF_ind = 1 --DT set is the Default
	
	sets.DEF['DT'] = {
	ammo="Crepuscular Pebble",
	head="Ken. Jinpachi +1",
	neck="Loricate Torque +1",
	left_ear="Sherida Earring",
	right_ear="Bhikku Earring +2",
	body="Malignance Tabard",
	hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	left_ring="Defending Ring",
	right_ring="Gelatinous Ring +1",
	back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	waist="Moonbow Belt +1",
    legs="Mpaca's Hose", --9%
	feet="Anch. Gaiters +3"
	}
	
	sets.right_ear ={right_ear="Schere Earring",}
	
	sets.impetus = set_combine(sets.right_ear, {
	--right_ear="Telos Earring",
	body="Bhikku Cyclas +3",
	})
	
	sets.footwork = {
	--legs="Hesychast's Hose +3",
	--legs="Bhikku hose +3",
	--feet="Anchorite's Gaiters +3"
	}
	
	sets.idle = set_combine(sets.TP['Standard'], {
	--ammo="Coiste Bodhar",
	head="Bhikku Crown +3",
	body="Mpaca's Doublet",
	--body="Hiza. Haramaki +2",
	neck="Bathy Choker +1",
	hands={ name="Hes. Gloves +3", augments={'Enhances "Invigorate" effect',}},
	left_ear="Cryptic earring",
	right_ear="Infused Earring",
	left_ring="Warp ring",
	right_ring="Paguroidea Ring",
	back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	waist="Moonbow Belt +1",
	legs="Ken. Hakama +1",
	feet="Hermes' Sandals"
    })
	
	sets.enmity = {
	body="Emet harness +1",  		--10
	neck="Unmoving Collar +1", 		--10
	ear1="Cryptic Earring",    		--4
	ear2="Friomisi Earring",      	--2
	hands="Kurys gloves", 			--9
	right_ring="Begrudging Ring", 	--5
	back="Reiki cloak",				--6
	feet="Ahosi leggings",			--7
	}								--64
	
	sets.pole = {
	main={ name="Reikikon", priority=2,},
    sub={ name="Alber strap", priority=1,},
	}
	
---------------------------------------------------------------------------------------------------------------
---------------------------------------------- Job Abilities --------------------------------------------------
---------------------------------------------------------------------------------------------------------------
	
	sets.ja['Focus'] = {head="Anchor. Crown +1"}
	sets.ja['Dodge'] = {feet="Anchorite's Gaiters +3"}
	sets.ja['Footwork'] = {feet="Bhikku Gaiters +3"}
	sets.ja['Hundred Fists'] = {legs="Hesychast's Hose +3"}
	sets.ja['Invigorate'] = {hands="Hesychast's Gloves +3"}
	sets.ja['Formless Strikes'] = {}
	sets.ja['Mantra'] = {feet="Hesychast's Gaiters +3"}
	sets.ja['Boost'] = {--[[hands="Anchorite's gloves"]]}
	sets.ja['Counterstance'] = {feet="Hesychast's Gaiters +3"}
	sets.ja['Provoke'] = sets.enmity
	sets.ja['Warcry'] = sets.enmity
	sets.ja.waltz = {head="Mummu bonnet +2",waist="Gishdubar Sash",legs="Dashing subligar",}
	sets.ja['Impetus'] = {body="Bhikku Cyclas +3",}
	sets.ja['Perfect Counter'] = {head="Bhikku Crown +3",}

	
	sets.ja['Chakra'] = {
	ammo="Crepuscular pebble",
	head="Genmei Kabuto",
	body="Anch. Cyclas +2",
	hands={ name="Hes. Gloves +3", augments={'Enhances "Invigorate" effect',}},
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
    feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
	neck="Unmoving Collar +1",
	left_ear="Tuisto Earring",
	right_ear="Handler's Earring +1",
	left_ring="Regal Ring",
	right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','"Dbl.Atk."+10',}},
	}
	
	sets.ja['Chi Blast'] = {
	head={ name="Hes. Crown", augments={'Enhances "Penance" effect',}},
    body={ name="Herculean Vest", augments={'Weapon skill damage +2%','Crit. hit damage +3%','"Treasure Hunter"+2','Accuracy+6 Attack+6','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    hands={ name="Herculean Gloves", augments={'Accuracy+3','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','"Treasure Hunter"+2',}},
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
	feet="Shukuyu Sune-Ate",
	neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
	left_ring="Regal Ring",
	waist="Chaac Belt",
	back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
---------------------------------------------------------------------------------------------------------------
----------------------------------------------- Weaponskills --------------------------------------------------
---------------------------------------------------------------------------------------------------------------

	sets.ws["Shijin Spiral"] = { --Fotia Neck + % Hit
	ammo="Coiste Bodhar",
    head={ name="Mpaca's Cap", augments={'Path: A',}},
	body="Bhikku cyclas +3",
	hands="Bhikku gloves +2",
    legs="Mpaca's Hose", --9%
	feet="Mpaca's boots",
	neck="Fotia gorget",
	waist="Moonbow belt +1",
	left_ear="Sherida earring",
	right_ear="Bhikku Earring +2",
	left_ring="Gere Ring",
	right_ring="Niqmaddu ring",
	back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.ws["Victory Smite"] = { --Fotia Neck + Crit
	ammo="Coiste Bodhar",
    head={ name="Mpaca's Cap", augments={'Path: A',}},
    body={ name="Mpaca's Doublet", augments={'Path: A',}}, --10%
	hands="Nyame Gauntlets",
	legs="Mpaca's Hose", --9%
	feet="Nyame Sollerets",	neck="Fotia gorget",
	waist="Moonbow belt +1",
	left_ear="Sherida earring",
	right_ear="Odr earring",
	left_ring="Gere Ring",
	right_ring="Niqmaddu ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.ws["Tornado Kick"] = { --WSD + Kick DMG
	ammo="Coiste Bodhar",
    head={ name="Mpaca's Cap", augments={'Path: A',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Rep. Plat. Medal",	
	--feet="Anch. Gaiters +3",
	--neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
	waist="Moonbow belt +1",
	left_ear="Sherida earring",
	right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	left_ring="Gere Ring",
	right_ring="Niqmaddu ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.ws["Asuran Fists"] = { --15% STR/DEX
	ammo="Coiste Bodhar",
    head={ name="Mpaca's Cap", augments={'Path: A',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
	neck="Fotia gorget",
	waist="Fotia belt",
	left_ear="Sherida earring",
	right_ear="Bhikku earring +2",
	left_ring="Gere Ring",
	right_ring="Regal ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.ws["Howling Fist"] = {
	ammo="Coiste Bodhar",
    head={ name="Mpaca's Cap", augments={'Path: A',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Rep. Plat. Medal",
	waist="Moonbow belt +1",
	left_ear="Sherida earring",
	right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	left_ring="Gere Ring",
	right_ring="Niqmaddu ring",
    back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','"Dbl.Atk."+10',}},
	
	}
	
	sets.ws["Raging Fists"] = { --30% STR / 30% DEX
	ammo="Coiste Bodhar",
    head={ name="Mpaca's Cap", augments={'Path: A',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
	neck="Fotia gorget",
	waist="Moonbow belt +1",
	left_ear="Sherida earring",
	right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	left_ring="Gere Ring",
	right_ring="Niqmaddu ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.ws["Ascetic's Fury"] = sets.ws["Victory Smite"]  --STR 50% VIT 50%  Fotia Neck + Crit
	sets.ws["Shoulder Tackle"] = sets.ws["Howling Fist"]  --VIT 100%
	sets.ws["One Inch Punch"] = sets.ws["Howling Fist"]  --VIT 100%
	sets.ws["Spinning Attack"] = sets.ws["Asuran Fists"]  --STR 100%
	sets.ws["Dragon Kick"] = sets.ws["Tornado Kick"]
	sets.ws["Backhand Blow"] = sets.ws["Victory Smite"]  --STR 50% VIT 50%  Fotia Neck + Crit

	
	sets.ws["Cataclysm"] = {
	sub="Alber strap",
	ammo="Pemphredo Tathlum",
	head="Pixie Hairpin +1",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Baetyl Pendant",
	waist="Orpheus's sash",
	left_ear="Friomisi Earring",
	right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	left_ring="Archon Ring",
	right_ring="Metamor. Ring +1",
    back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','"Dbl.Atk."+10',}},
	}
	
	sets.ws["Shell Crusher"] = {
	ammo="Pemphredo Tathlum",
	head="Pixie Hairpin +1",
    body="Malignance Tabard",
	hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
	neck="Sanctity necklace",
	waist="Luminary sash",
	left_ear="Digni. Earring",
	right_ear="Crep. Earring",
	left_ring="Stikini Ring +1",
	right_ring="Metamor. Ring +1",
    back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','"Dbl.Atk."+10',}},
	}
	
	sets.ws.Ngai = {}
	
---------------------------------------------------------------------------------------------------------------
--------------------------------------------------- Misc ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
	
	sets.low_hp = {
	head=empty,
	body=empty,
	hands=empty,
	ring2=empty,
	legs=empty,
	feet=empty,
	}
	
	sets.high_hp = {
    head="Genmei kabuto",
	body="Nyame mail",
	hands="Nyame gauntlets",
	legs="Ken. Hakama +1",
	feet={ name="Hesychast's Gaiters +3", augments={'Enhances "Mantra" effect',}},
	neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
	waist="Gishdubar sash",
	left_ear="Tuisto Earring",
	right_ear="Etiolation Earring",
	left_ring="Ilabrat Ring",
	right_ring="Meridian Ring",
	back="Reiki cloak",
	}
	
	sets.phalanx = {
		head="Herculean Helm",
		body="Herculean Vest",
		hands="Herculean Gloves",
		legs="Herculean Trousers",
		feet="Herculean Boots",
	}
	
	sets.misc.rest = {}

end

function check_height() 
	selfz = math.floor(windower.ffxi.get_mob_by_index(player.index).z * 10)/10
	targetz = math.floor(windower.ffxi.get_mob_by_index(player.target.index).z * 10)/10
	heightdiff = selfz - targetz
	targdistance = math.floor(windower.ffxi.get_mob_by_index(player.target.index).distance:sqrt() * 10+0.5)/10
end

function precast(spell)
	if buffactive['Stun'] or buffactive['Petrify'] or buffactive['Terror'] or ((spell.action_type == "WeaponSkill" or spell.action_type == "JobAbility") and buffactive['Amnesia']) or (spell.action_type == 'Magic' and buffactive['Silence']) then
		cancel_spell()
	elseif (sets.ja[spell.english]) then
		equip(sets.ja[spell.english])
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
			if player.equipment.main == "Godhands" and (spell.name == "Tornado Kick" or spell.name == "Howling Fist" or spell.name == "Raging Fists") then
                if player.tp >= 1000 and player.tp < 2050 then
                    equip({head="Mpaca's Cap",right_ear="Moonshade Earring"})
                elseif player.tp >= 1250 and player.tp < 2500 then
                    equip({right_ear="Moonshade Earring",})
                else
                    equip({right_ear="Schere Earring"})
                end
            else
                if player.tp >= 1000 and player.tp < 2550 then
                    equip({head="Mpaca's Cap",right_ear="Moonshade Earring"})
                elseif player.tp >= 2550 and player.tp < 3000 then
                    equip({right_ear="Moonshade Earring",})
                else
                    equip({right_ear="Schere Earring"})
                end
            end
			
			if sets.ws[spell.name] then
				equip(sets.ws[spell.name])
				if spell.name == "Victory Smite" and buffactive['Impetus'] then
                    equip({body="Bhikku Cyclas +3",})
				end
			else
				equip(sets.ws.common)
			end
		end
	elseif spell.action_type == 'Magic' then
		if spell.english:contains('Utsusemi') then
			equip(sets.fc.utsusemi)
		else
			equip(sets.fc.base)
		end
	end
end

function midcast(spell)
	if (spell.name == 'Sneak' or spell.english == 'Spectral Jig' or spell.english:contains('Monomi')) and spell.target.name == player.name and buffactive["Sneak"] then
		send_command('cancel Sneak')
	elseif spell.english:contains('Utsusemi') and buffactive["Copy Image"] then
		windower.send_command('wait 1;cancel 66;')
	end
end

function aftercast(spell)
	if player.status == "Engaged" then
		if player.equipment.main == "Godhands" then
			if buffactive['Impetus'] and buffactive['Footwork'] then
				equip(sets.impetus,sets.footwork)
			elseif buffactive['Impetus'] then
				equip(sets.TP[sets.TP.index[TP_ind]],sets.impetus)
			elseif buffactive['Footwork'] then
				equip(sets.TP[sets.TP.index[TP_ind]],sets.footwork)
			else
				equip(sets.TP[sets.TP.index[TP_ind]])
			end
		else
			if buffactive['Impetus'] and buffactive['Footwork'] then
				equip(sets.impetus,sets.footwork)
			elseif buffactive['Impetus'] then
				equip(sets.TP[sets.TP.index[TP_ind]],sets.impetus)
			elseif buffactive['Footwork'] then
				equip(sets.TP[sets.TP.index[TP_ind]],sets.footwork,sets.right_ear)
			else
				equip(sets.TP[sets.TP.index[TP_ind]],sets.right_ear)
			end
		end
	elseif player.status == "Idle" then
		equip(sets.idle)
	end
end

function status_change(new,old)
	if new == "Idle" then
		equip(sets.idle)
	elseif new == 'Engaged' then
		if player.equipment.main == "Godhands" then
			if buffactive['Impetus'] and buffactive['Footwork'] then
				equip(sets.impetus,sets.footwork)
			elseif buffactive['Impetus'] then
				equip(sets.TP[sets.TP.index[TP_ind]],sets.impetus)
			elseif buffactive['Footwork'] then
				equip(sets.footwork)
			else
				equip(sets.TP[sets.TP.index[TP_ind]])
			end
		else
			if buffactive['Impetus'] and buffactive['Footwork'] then
				equip(sets.impetus,sets.footwork)
			elseif buffactive['Impetus'] then
				equip(sets.TP[sets.TP.index[TP_ind]],sets.impetus)
			elseif buffactive['Footwork'] then
				equip(sets.TP[sets.TP.index[TP_ind]],sets.footwork,sets.right_ear)
			else
				equip(sets.TP[sets.TP.index[TP_ind]],sets.right_ear)
			end
		end
	elseif new == 'Rest' then
		equip(sets.misc.rest)
	end
end

function buff_change(n, gain, buff_table)
	local name
	name = string.lower(n)
	if S{"impetus"}:contains(name) then
		if gain then
--			if player.status == "Idle" then
--				equip(sets.idle)
--			elseif player.status == "Engaged" then
--				equip(sets.TP[sets.TP.index[TP_ind]],sets.impetus)
--				if buffactive['Footwork'] then
--					equip(sets.footwork)
--				end
--			end
		else
			if player.status == "Idle" then
				equip(sets.idle)
			elseif player.status == "Engaged" then
				if player.equipment.main == "Godhands" then
					equip(sets.TP[sets.TP.index[TP_ind]])
					if buffactive['Footwork'] then
						equip(sets.footwork)
					end
				else
					if buffactive['Footwork'] then
						equip(sets.footwork,sets.right_ear)
					else
						equip(sets.TP[sets.TP.index[TP_ind]],sets.right_ear)
					end
				end
			end
		end
	elseif S{"footwork"}:contains(name) then
		if gain then
--			if player.status == "Idle" then
--				equip(sets.idle)
--			elseif player.status == "Engaged" then
--				if buffactive['Impetus'] then
--					equip(sets.TP[sets.TP.index[TP_ind]],sets.impetus)
--				end
--				if player.equipment.main == "Godhands" then
--					equip(sets.footwork)
--				else
--					equip(sets.footwork,sets.right_ear)
--				end
--			end
		else
			if player.status == "Engaged" then
				equip(sets.TP[sets.TP.index[TP_ind]])
				if buffactive['Impetus'] then
					equip(sets.impetus)
				end
			end
		end	
	elseif S{"doom"}:contains(name) then
		if gain then
			send_command('@input /p Cursna - Doomed')
		else
			send_command('@input /p Doom - Off')
		end
	end
		
end


function self_command(command)
    if command == 'toggle TP set' then
        TP_ind = TP_ind +1
        if TP_ind > #sets.TP.index then TP_ind = 1 end
        windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
        equip(sets.TP[sets.TP.index[TP_ind]])
        if player.status == "Engaged" then
            if buffactive['Impetus'] then
                equip(sets.TP[sets.TP.index[TP_ind]],sets.impetus)
            end
            if buffactive['Footwork'] then
                equip(sets.footwork)
            end
        end
    elseif command == 'reverse TP set' then
        TP_ind = TP_ind -1
        if TP_ind == 0 then TP_ind = #sets.TP.index end
        windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
        equip(sets.TP[sets.TP.index[TP_ind]])
        if player.status == "Engaged" then
            if buffactive['Impetus'] then
                equip(sets.TP[sets.TP.index[TP_ind]],sets.impetus)
            end
            if buffactive['Footwork'] then
                equip(sets.footwork)
            end
        end
    end
    if command == 'toggle DEF set' then
        DEF_ind = DEF_ind +1
        if DEF_ind > #sets.DEF.index then DEF_ind = 1 end
        windower.add_to_chat(1,'<----- DEF Set changed to '..sets.DEF.index[DEF_ind]..' ----->')
        equip(sets.DEF[sets.DEF.index[DEF_ind]])
    elseif command == 'reverse DEF set' then
        DEF_ind = DEF_ind -1
        if DEF_ind == 0 then DEF_ind = #sets.DEF.index end
        windower.add_to_chat(1,'<----- DEF Set changed to '..sets.DEF.index[DEF_ind]..' ----->')
        equip(sets.DEF[sets.DEF.index[DEF_ind]])
    end
	if command == 'reequip' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	end
end

-- Ark Sash & Boost --
function buff_change(n, gain, buff_table)
	local name
	name = string.lower(n)
	if S{"boost"}:contains(name) then
		if gain then
			equip({waist="Ask Sash"})
			disable('waist')
		else
			enable('waist')
			equip({waist="Moonbow belt +1"})
		end
	end
end

send_command('bind !q gs c toggle TP set') -- Hit alt+q, toggles the sets
send_command('bind !e gs c toggle DEF set') -- Hit alt+e, toggles the sets
send_command('alias 500hp gs equip low_hp;wait 1; gs equip high_hp')
send_command('alias food input /item "Grape Daifuku" <me>')
send_command('lua l Skillchains')
send_command('alias reequip gs equip ')
send_command('alias mount input /mount Fenrir')
send_command('alias pole gs equip sets.pole')
send_command('alias vere input /equip main "Verethragna"')
send_command('alias gh input /equip main "Godhands"')
send_command('alias trust input /boost; wait 2; exec trust.txt')




function file_unload()
    send_command('unbind !q')
	send_command('unbind !e')
	send_command('unbind !u')
	--send_command('lua u Skillchains')

end

windower.register_event('zone change',function()
	if world.area:contains("Dynamis") and player.name == "Drakelth" then
		send_command('lua l treasury')
	elseif world.area:contains("Reisenjima Henge") and player.name == "Drakelth" then
		send_command('lua u treasury')
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
	
end
 
function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
    add_to_chat (55, 'You are on '..('Monk '):color(5)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
end
 
--Page, Book--
set_macros(1,2)
--Use the Lockstyle Number--
set_style(002)