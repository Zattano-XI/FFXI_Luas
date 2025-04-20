res = require 'resources'
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
	
	sets.movement = {feet="Hermes' sandals"}
	
	--sets.fashion = {
		--head="Sakpata's Helm",
		--body="Sakpata's Plate",
		--hands="Sakpata's Gauntlets",
		--legs="Sakpata's Cuisses",
		--feet="Sakpata's Leggings"
	--}
	
	 sets.fc.base = { --SIRD96%/FC29%
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Odyss. Chestplate", augments={'"Fast Cast"+4','MND+1','Accuracy+20 Attack+20','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
    legs={ name="Founder's Hose", augments={'MND+9','Mag. Acc.+13','Attack+14','Breath dmg. taken -4%',}},
    feet={ name="Odyssean Greaves", augments={'"Fast Cast"+5','"Mag.Atk.Bns."+15',}},
    neck="Moonbeam Necklace",
    waist="Ioskeha Belt +1",
    left_ear="Odnowa Earring +1",
    right_ear="Etiolation Earring",
    left_ring="Evanescence Ring",
    right_ring="Rahab Ring",
    back="Moonbeam Cape",
	}
	
	
	sets.ja['Warcry'] = {head="Agoge Mask +3"}
	sets.ja['Berserk'] = {feet="Agoge Calligae +3", body="Pummeler's Lorica +3"}
	sets.ja['Aggressor'] = {head="Pummeler's mask +2", body="Agoge lorica +3"}
	sets.ja['Mighty Strikes'] = {hands="Agoge Mufflers +1"}
	sets.ja['Tomahawk'] = {feet="Agoge Calligae +3",}
	sets.ja['Retaliation'] = {hands="Pummeler's mufflers +1", feet="Boii Calligae +2"}
	sets.ja['Blood Rage'] = {body="Boii Lorica +3",}
	
	
	sets.TP.index = {'Standard','DT', 'MDT', 'High Acc','Fencer','DW','Zanshin','Hybrid'}
	TP_ind = 1 --Standard set is the Default
	
	sets.TP['Standard'] = {
	ammo="Coiste Bodhar", --3
    head="Sakpata's helm", --5 8
    body="Sakpata's breastplate",   --8 16
	hands="Sakpata's Gauntlets", --5 21
    legs="Agoge cuisses +3", --6 27
    feet="Pummeler's calligae +3", --9 36
	neck="Warrior's bead necklace +1", --6 42
    waist="Ioskeha Belt +1", --9 51
    left_ear="Dedition Earring",
    right_ear="Schere Earring", --6 57
    left_ring="Niqmaddu Ring",
	right_ring="Chirich Ring +1",
    back={ name="Chicol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','"Damage taken"-5%'}}, --10 67
	}
	
	sets.TP['DT'] = { 
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Breastplate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's leggings",
    neck="War. Beads +1",
    waist="Ioskeha Belt +1",
    left_ear="Odnowa Earring +1",
    right_ear="Boii Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+10 Attack+10','Attack+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.TP['MDT'] = { 
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Breastplate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's leggings",
    neck="Diemer Gorget",
    waist="Ioskeha Belt +1",
	waist="Carrier's sash",
    left_ear="Odnowa Earring +1",
    right_ear="Odnowa Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+10 Attack+10','Attack+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.TP['High Acc'] = { 
    ammo="Coiste Bodhar",
    head="Hjarrandi Helm",
    body="Boii Lorica +3",
    hands="Boii Mufflers +3",
    legs="Boii Cuisses +3",
    feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
    neck={ name="War. Beads +1", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Schere Earring",
    right_ear="Boii Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.TP['Fencer'] = { --Fencer capped - Neck +1, Blurred +1, Legs +4/ DA=70%
    ammo={ name="Coiste Bodhar", augments={'Path: A',}}, --3%
    head="Sakpata's helm", --5% 
    body="Boii Lorica +3", 
    hands="Sakpata's Gauntlets", --6% 
    legs="Boii Cuisses +3", --8% 
    feet="Pumm. Calligae +3", --9% 
    neck={ name="War. Beads +1", augments={'Path: A',}}, --6% 
    waist="Ioskeha Belt +1", --9% 54
    left_ear={ name="Schere Earring", augments={'Path: A',}}, --6% 
    right_ear="Boii Earring +1", --8% 
    left_ring="Chirich Ring +1",
    right_ring="Moonbeam Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}, 
	}
	
	sets.TP['DW'] = { --DA 63
    ammo={ name="Coiste Bodhar", augments={'Path: A',}}, --3
    head="Hjarrandi Helm", --6 9
    body="Sakpata's Plate", --8 17
    hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
    legs="Sakpata's Cuisses", --7 24
    feet="Pumm. Calligae +3", --9 33
    neck="War. Beads +1", --6 39
    waist="Reiki Yotai",
    left_ear={ name="Schere Earring", augments={'Path: A',}}, --6 45
    right_ear="Boii earring +1", --8 53
    left_ring="Chirich Ring +1",
    right_ring="Niqmaddu ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}, --10 63
	}
	
	sets.TP['Zanshin'] = { 
    ammo="Coiste Bodhar",
    head="Flamma zucchetto +2",
    body="Boii Lorica +3",
    hands="Tatenashi gote +1",
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
    feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
    neck="Vim Torque +1",
    waist="Sailfi belt +1",
    left_ear="Schere Earring",
    right_ear="Telos Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.TP['Hybrid'] = { 
    ammo="Coiste Bodhar", --3
    head="Sakpata's Helm", --5 8
    body="Sakpata's Breastplate", --8 16
    hands="Sakpata's Gauntlets", --6 22
    legs="Sakpata's Cuisses", --7 29
    feet="Sakpata's leggings", --4 33
    neck={ name="War. Beads +1", augments={'Path: A',}}, --6 39
    waist="Ioskeha Belt +1", --9 48
    left_ear="Schere Earring", --6 54
    right_ear="Boii Earring +1", --8 62
    left_ring="Niqmaddu Ring",
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+10 Attack+10','Attack+10','Weapon skill damage +10%','Damage taken-5%',}}, --10 72
	}
	
	sets.idle = set_combine(sets.TP['Standard'], {
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Breastplate",
    hands="Sakpata's Gauntlets",    
    neck="Warrior's Bead Necklace +1",
    waist="Carrier's sash",
	legs="Sakpata's Cuisses",
	feet="Sakpata's leggings",
    --left_ear="Odnowa Earring",
    --right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Moonbeam ring",
   -- back="Moonbeam cape",
	})
	
	sets.regen = {
        ammo="Staunch Tathlum +1",
        --head="Baghere Salade", --2/0
        neck="Sanctity Necklace",
        left_ear="Odnowa Earring +1",
		--right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','Latent effect: "Refresh"+1',}}, --0/1
        --body="Sacro Breastplate", --13/0
		--hands={ name="Yorium Gauntlets", augments={'Rng.Atk.+10','"Regen"+2','VIT+1',}}, --2/0
        --left_ring="Sheltered Ring", --1/0
        right_ring="Chirich Ring +1", --1/0
		--back={ name="Ankou's Mantle", augments={'HP+60','HP+20','Enmity-10','"Regen"+5',}},
        --waist="Flume Belt",
		--legs={ name="Carmine Cuisses +1", augments={'Accuracy+12','DEX+12','MND+20',}},
        --feet="Sakpata's Leggings",
	}
	
	sets.ws.common = {
    ammo="Knobkierrie",
    head="Agoge Mask +3",
    body="Nyame mail",
    hands="Boii Mufflers +3",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet="Nyame Sollerets",
    neck="Warrior bead necklace +1",
    waist="Sailfi Belt +1",
    right_ear="Thrud Earring",
    left_ring="Epaminondaas's Ring",
    right_ring="Cornelia's Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
	}
	
	sets.ws['Metatron Torment'] = set_combine(sets.ws.common, {
		hands={ name="Odyssean Gauntlets", augments={'STR+8','Mag. Acc.+8 "Mag.Atk.Bns."+8','Weapon skill damage +7%',}},
        --left_ring="Beithir Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
	})
	
	sets.ws['Impulse Drive'] = set_combine(sets.ws.common, {
		--head="Boii Mask +1",
		--body="Hjarrandi Breastplate",
		--hands="Flamma Manopolas +2",
		--legs="Agoge cuisses +3",
		feet="Boii Calligage +2",
        --right_ring="Niqmaddu Ring",
		--left_ring="Karieyh Ring",
		--right_ear="Schere Earring",
		--back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
		ammo="Coiste Bodhar",
        head="Agoge Mask +3",
		body="Nyame mail",
		hands="Sakpata Gauntlets",
		--legs="Tatenashi Haidate +1",
		legs="Boii Cuisses +3",
        --feet="Sakpata's leggings",
		--feet="Sakpata Boots"
		right_ring="Niqmaddu Ring",
		left_ring="Regal Ring",
		right_ear="Schere Earring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
		
	})
	
	sets.ws['Savage Blade'] = set_combine(sets.ws.common, {
        --neck="Fotia Gorget",
		head="Agoge Mask +3",
		hands="Boii Mufflers +3",
		body="Nyame mail",
		waist="Sailfi belt +1",
		legs="Boii Cuisses +3",
        feet="Nyame Sollerets",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
	})
	
	sets.ws['Upheaval'] = set_combine(sets.ws.common, {
        ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Nyame mail",
		hands="Sakpata's Gauntlets",
		legs="Nyame flanchard",
		feet="Sakpata's Leggings",
		neck={ name="War. Beads +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		--left_ear=Moonbeam goes here
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+10 Attack+10','Attack+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
	sets.ws['Resolution'] = set_combine(sets.ws.common, {
        ammo="Coiste Bodhar",
        head="Sakpata's helm",
		body="Tatenashi Harama +1",
		hands="Sakpata Gauntlets",
		legs="Boii Cuisses +3",
		--legs="Agoge Cuisses +3",
        feet="Flamma Gambieras +2",
		--feet="Sakpata Boots"
		right_ring="Niqmaddu Ring",
		left_ring="Regal Ring",
		right_ear="Schere Earring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
	})
	
	
	sets.ws['Mistral Axe'] = set_combine(sets.ws.common, {
        ammo="Knobkierrie",
        head="Agoge Mask +3",
		body="Nyame mail",
		hands="Boii Mufflers +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Nyame Sollerets",
		neck="Warrior bead necklace +1",
		waist="Prosilio Belt +1",
		right_ear="Thrud Earring",
		left_ring="Epaminondaas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
	})
	
	sets.ws['Cloudsplitter'] = set_combine(sets.ws.common, {
		--head="Boii Mask +1",
		head="Agoge Mask +3",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Nyame sollerets",
		waist="Orpheus's Sash",
        right_ring="Niqmaddu Ring",
		left_ring="Regal ring",
		right_ear="Friomisi earring",
		back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}},
	})
	
	sets.ws['Decimation'] = set_combine(sets.ws.common, {
		ammo="Coiste Bodhar",
        head="Sakpata's Helm",
		body="Sakpata's plate",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
        feet="Sakpata's leggings",
		--feet="Sakpata Boots"
		right_ring="Niqmaddu Ring",
		left_ring="Regal Ring",
		right_ear="Boii Earring +1",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
	})
	
	sets.ws['Calamity'] = set_combine(sets.ws.common, {
		 ammo="Knobkierrie",
        head="Agoge Mask +3",
		--body="Pummeler's Lorica +3",
		--hands="Sakpata Gauntlets",
		hands="Boii Mufflers +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Nyame Sollerets",
		neck="Warrior bead necklace +1",
		waist="Prosilio Belt +1",
		right_ear="Thrud Earring",
		left_ring="Epaminondaas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%',}},
	})
	
	sets.ws['Asuran Fists'] = set_combine(sets.ws.common, {
		 ammo="Knobkierrie",
        ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Sakpata's Helm", augments={'Path: A',}},
		body={ name="Tatena. Harama. +1", augments={'Path: A',}},
		hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
		legs="Boii Cuisses +3",
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		neck={ name="War. Beads +1", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Moonbeam Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
	})
	
	sets.ws['Cataclysm'] = set_combine(sets.ws.common, {
		--head="Boii Mask +1",
		head="Pixie Hairpin +1",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Nyame sollerets",
		waist="Orpheus's Sash",
        right_ring="Archon Ring",
		left_ring="Regal ring",
		right_ear="Friomisi earring",
		back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}},
	})
	
	sets.ws['Aeolian Edge'] = set_combine(sets.ws.common, {
		--head="Boii Mask +1",
		head="Agoge Mask +3",
		body="Nyame mail",
		hands="Nyame gauntlets",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Nyame sollerets",
		waist="Orpheus's Sash",
        right_ring="Niqmaddu Ring",
		left_ring="Regal ring",
		right_ear="Friomisi earring",
		back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}},
	})
	
	sets.ja['Provoke'] = {set_combine(sets.enmity, {
	ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Souv. Cuirass +1",
    hands="Souv. Handsch. +1",
    legs="Souv. Diechlings +1",
    feet="Eschite Greaves",
    neck="Moonbeam Necklace",
    waist="Ioskeha Belt +1",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Warp Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},
	})}
	
	sets.weapon = set_combine(sets.TP['Standard'], {
	main="Chango",
	sub="Utu Grip",
	})
	
	sets.WEAPON.index = {'Great Axe','Bravura','Chango','Great Sword','Sword', 'Polearm', 'Axe', 'AxeDW', 'Club'}
	WEAPON_ind = 3 --Chango set is the Default
	
	sets.WEAPON['Great Axe'] = {
	main="Lycurgos",
	sub="Utu Grip",
	}
	
	sets.WEAPON['Bravura'] = {
	main="Bravura",
	sub="Utu Grip",
	}
	
	sets.WEAPON['Chango'] = {
	main="Chango",
	sub="Utu Grip",
	}
	
	sets.WEAPON['Great Sword'] = {
	--main="Ragnarok",
	main="Montante +1",
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
	
	sets.WEAPON['AxeDW'] = {
	main="Dolichenus",
	sub="Ikenga's Axe",
	}
	
	sets.WEAPON['Club'] = {
	main="Loxotic Mace +1",
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
        main={ name="Montante +1", augments={'Path: A',}},
		sub="Utu Grip",
		ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Hjarrandi Breast.",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck={ name="War. Beads +1", augments={'Path: A',}},
		waist="Platinum moogle belt",
		left_ear="Odnowa Earring +1",
		right_ear="Odnowa Earring",
		left_ring="Moonbeam Ring",
		right_ring="Regal Ring",
		back="Moonbeam cape",
	}
	
	sets.tpgain = {
		head="Valorous Mask",
		neck="Vim Torque +1",
		right_ring="Karieyh ring",
	}
	
	sets.midcast.magic = { --540 Dark Magic Skill
        --ammo="Hydrocera",
        --head="Flam. Zucchetto +2",
        --neck="Erra Pendant",
        --left_ear="Malignance Earring",
        --right_ear="Mani Earring",
        --body="Flamma Korazin +2",
        --hands="Fall. Fin. Gaunt. +3",
        --left_ring="Evanescence Ring",
        --right_ring={ name="Stikini Ring +1", bag="wardrobe2"},
        --right_ring="Archon Ring",
		--back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
        --waist="Null Belt",
		--legs="Fall. Flanchard +3",
        --feet="Flam. Gambieras +2",
        }
		
	sets.midcast.Drain = set_combine(sets.midcast.magic, {
        -- left_ear="Hirudinea Earring",
		--back={ name="Niht Mantle", augments={'Attack+7','Dark magic skill +10','"Drain" and "Aspir" potency +25',}},
        --waist="Austerity Belt +1",
		--left_ring="Excelsis Ring",
        -- feet="Ig. Sollerets +3",
        })

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

send_command('bind !q gs c toggle TP set') -- Hit alt+q, toggles the sets
send_command('bind !w gs equip sets.movement')
send_command('bind !s gs c toggle WEAPON set') -- Hit alt+s, toggles the sets
send_command('bind !r gs equip sets.regen') -- Hit alt+r, toggles the sets
send_command('bind !a gs equip sets.weapon') -- Hit alt+a
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
	add_to_chat (55, 'You are on '..('Warrior'):color(5)..('. '):color(55)..''..('Macros set!'):color(121))
end
 
function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end

--Page, Book--
set_macros(1,2)
--Use the Lockstyle Number--
set_style(057) 