EnfeeblingMax = S{"Frazzle","Frazzle II","Distract","Distract II","Poison","Poisonga","Dispel","Break","Silence",}
EnfeeblingPot = S{"Frazzle III","Distract III","Poison II",}
EnfeeblingDur = S{"Sleep","Sleep II","Sleepga","Gravity","Gravity II","Bind","Stun",}
EnfeeblingMND = S{"Paralyze","Paralyze II","Slow","Slow II","Addle","Addle II",}
EnfeeblingINT = S{"Blind","Blind II",}
BarElements = S{"Barfire","Barfira","Barblizzard","Barblizzara","Baraero","Baraera","Barstone","Barstonra","Barthunder","Barthundra","Barwater","Barwatera"}
BarAilments = S{"Barsleep","Barsleepra","Barpoison","Barpoisonra","Barparalyze","Barparalyzra","Barblind","Barblindra","Barsilence","Barsilencera","Barpetrify","Barpetra","Barvirus","Barvira","Baramnesia","Baramnesra"}
GainSpells = S{'Gain-STR','Gain-INT','Gain-AGI','Gain-VIT','Gain-DEX','Gain-MND','Gain-CHR'}
EnSpells = S{"Enfire","Enfire II","Enblizzard","Enblizzard II","Enaero","Enaero II","Enstone","Enstone II","Enthunder","Enthunder II","Enwater","Enwater II"}
NaSpells = S{"Blindna","Erase","Paralyna","Poisona","Silena","Stona","Viruna"}
Spikes = S{"Blaze Spikes","Ice Spikes","Shock Spikes"}
SubWeapon = S{"Gleti's Knife","Daybreak","Bunzi's Rod","Thibron"}
ZeroDMG = S{"Aern Dagger","Aern Dagger II","Ceremonial Dagger","Chicken Knife II","Esikuva","Esoteric Athame","Ethereal Dagger","Hedron Dagger","Infiltrator","Norgish Dagger","Qutrub Knife","Rusty Dagger","Trainee Knife","Trainee's Needle","Wind Knife"}
res = require 'resources'
weaponlock = false
Ullr = true

include('SendCommands.lua')

function get_sets()
	sets.fc = {}
	sets.midcast = {}
	sets.buff = {}
	sets.ja = {}
	sets.nuke = {}
	sets.TP = {}
	sets.idle = {}
	sets.ws = {}
	sets.main = {}
	sets.sub = {}
	cape = {}
	
	cape.AmbuBackDW = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
	--cape.AmbuBackOH = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	--cape.AmbuBackOH = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	
	sets.fc.crocea = {
	--[[main="Crocea Mors",]]
	}
	
	sets.fc.base = { --30(base)(8JP)=38 +44
	--ammo="Impatiens", --2 qm
	head="Atrophy Chapeau +3", --16
	--neck="Baetyl Pendant", --4
	--left_ear="Malignance Earring", --4
	--right_ear="Loquacious Earring", --2
	body="Vitiation Tabard +3", --15
	--hands="Leyline Gloves", --5
	--left_ring="Kishar Ring", --4
	right_ring="Lebeche Ring", --2 qm
	back="Perimede Cape", --4 qm
	waist="Witful Belt", --3 qm
	legs="Volte Brais", --8
	feet="Carmine Greaves +1" --8
	}
	
	sets.fc.cure = set_combine(sets.fc.base, {
	})
	
	sets.fc.stoneskin = set_combine(sets.fc.base, {
	--head="Umuthi Hat", --15
	})
	
	sets.fc.healing = set_combine(sets.fc.base, {
	})
	
	sets.fc.utsusemi = set_combine(sets.fc.base, {
	--neck="Magoraga Bead Necklace", --10
	})
	
	sets.fc.impact = { --59
	main="Crocea Mors", --20
	sub="Chanter's Shield", --3
	ammo="Sapience Orb", --2
	head=empty,
	neck="Baetyl Pendant", --4
	left_ear="Malignance Earring", --4
	right_ear="Loquacious Earring", --2
	body="Crepuscular Cloak",
	hands="Leyline Gloves", --5
	left_ring="Kishar Ring", --4
	right_ring="Lebeche Ring", --2 qm
	back="Perimede Cape", --4 qm
	waist="Witful Belt", --3/3 qm
	legs="Volte Brais", --7
	feet="Carmine Greaves +1" --8
	}
	
	sets.midcast.conservemp = {
	head="Vanya Hood", --6
	neck="Loricate Torque +1",
	right_ear="Gifted Earring", --3
	body="Vedic Coat", --10
	hands="Shrieker's Cuffs", --7
	left_ring="Mephitas's Ring +1", --15
	back="Solemnity Cape", --5
	waist="Shinjutsu-no-obi +1",
	--waist="Austerity Belt +1", --9
	legs="Vanya Slops", --12
	feet="Carmine Greaves +1" --8
	}
	
	sets.midcast.cure = set_combine(sets.midcast.conservemp, { --I+48  II+5
	ammo="Regal Gem",
	head="Vanya Hood", --10
	--neck="Nodens Gorget", --5
	hands="Kaykaus Cuffs +1", --10
	right_ring="Menelaus's Ring", --5
	--left_ring="Janniston Ring", --II+5
	back="Solemnity Cape", --7
	legs="Atrophy Tights +3", --11
	})
	
	sets.midcast.cursna = set_combine(sets.midcast.conservemp, {
	head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
	neck="Debilis Medallion",
	left_ear="Beatific Earring",
	right_ear="Meili Earring",
	body="Vitiation Tabard +3",
	left_ring="Haoma's Ring",
	right_ring="Menelaus's Ring",
	waist="Bishop's Sash",
	legs="Carmine Cuisses +1",
	--feet="Gendewitha Galoshes +1",
	feet="Vanya Clogs",
	})
	
	sets.nuke.index = {'Free','MB', 'Occult'}
	nuke_ind = 1 --Free set is the Default
	
	sets.nuke['Free'] = {
	main="Bunzi's Rod",
	sub="Ammurapi Shield",
	ammo="Pemphredo Tathlum",
	head="Lethargy Chappel +3",
	neck="Sibyl Scarf",
	left_ear="Regal Earring",
	right_ear="Malignance Earring",
	body="Lethargy Sayon +3",
	hands="Lethargy Gantherots +3",
	--left_ring="Stikini Ring +1",
	left_ring="Metamorph Ring +1",
	right_ring="Freke Ring",
	back="Aurist's Cape +1",
	waist="Acuity Belt +1",
	legs="Lethargy Fuseau +3",
	feet="Lethargy Houseaux +3"
	}
	
	sets.nuke['MB'] = set_combine(sets.nuke['Free'], {
	head="Ea Hat",  -- +1
	neck="Mizukage-no-Kubikazari",
	body="Ea Houppelande", -- +1
	hands="Bunzi's Gloves",
	--legs="Ea Slops", -- +1
	--feet="Bunzi's Sabots",
	})
	
	sets.nuke['Occult'] = set_combine(sets.nuke['Free'], {
	--ammo="Seraphic Ampulla", --7 Occult
    --head="Mall. Chapeau +2", --11 Occult
    --hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+12 "Mag.Atk.Bns."+12','"Occult Acumen"+11','CHR+8','Mag. Acc.+2','"Mag.Atk.Bns."+4',}}, --11 Occult
    legs="Perdition Slops", --30 Occult
    --feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22','"Occult Acumen"+10','INT+2',}}, --10 Occult
    neck="Combatant's Torque", --4 STP
    waist="Oneiros Rope", --20 Occult 2 STP
    left_ear="Crep. Earring", --6 STP
    right_ear="Telos Earring", --5 STP
    left_ring="Crepuscular Ring", --6 STP
    right_ring="Chirich Ring +1", --5 STP
	})
	
	sets.midcast.raise = set_combine(sets.midcast.conservemp, { --30(base)(8JP) +51  +21 haste
	sub="Chanter's Shield", --3
	head="Carmine Mask +1", --14 --8
	neck="Baetyl Pendant", --4
	left_ear="Malignance Earring", --4
	left_ring="Kishar Ring", --4
	right_ring="Lebeche Ring", --2 qm
	legs="Volte Brais", --8 --9
	feet="Carmine Greaves +1" --8 --4
	})
	
	sets.midcast.Enfeebling = {
	main="Daybreak",
	sub="Ammurapi Shield",
	head="Vitiation Chapeau +3",
	neck="Duelist's Torque +2",
	right_ear="Snotra Earring",
	hands="Lethargy Gantherots +3",
	ring1={name="Stikini Ring +1", bag="wardrobe2"},
    ring2={name="Stikini Ring +1", bag="wardrobe5"},
	waist="Obstinate Sash",
	feet="Vitiation Boots +3",
	}
	
	sets.midcast.maxenfacc = set_combine(sets.midcast.Enfeebling, {
	main="Bunzi's Rod",
	sub="Ammurapi Shield",
	range="Ullr",
	--head="Lethargy Chappel +3",
	left_ear="Regal Earring",
	body="Atrophy Tabard +3",
	hands="Lethargy Gantherots +3",
	back="Aurist's Cape +1",
	waist="Obstinate Sash",
	legs="Chironic Hose",
	})
	
	sets.midcast.SkillEnfeebles = set_combine(sets.midcast.Enfeebling, {
	--main={ name="Contemplator +1", priority=2,},
	--sub={ name="Enki Strap", priority=1,},
	ammo="Regal Gem",
	neck="Incanter's Torque",
	left_ear="Vor Earring",
	body="Atrophy Tabard +3",
	hands="Lethargy Gantherots +3",
	right_ring="Metamorph Ring +1",
	waist="Obstinate Sash",
	back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	legs="Lethargy Fuseau +3",
	})
	
	sets.midcast.enfeebleMND = set_combine(sets.midcast.Enfeebling, {
	main="Daybreak",
	sub="Ammurapi Shield",
	ammo="Regal Gem",
	left_ear="Regal Earring",
	body="Lethargy Sayon +3",
	right_ring="Metamorph Ring +1",
	back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	waist="Obstinate Sash",
	legs="Lethargy Fuseau +3",
	})
	
	sets.midcast.enfeebleINT = set_combine(sets.midcast.enfeebleMND, {})
	
	sets.midcast.enfduration = set_combine(sets.midcast.Enfeebling, {
	range="Ullr",
	--ammo="Regal Gem",
	left_ear="Regal Earring",
	body="Atrophy Tabard +3",
	--hands="Regal Cuffs",
	right_ring="Kishar Ring",
	back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	waist="Obstinate Sash",
	legs="Chironic Hose", --augments={'Mag. Acc.+13','MND+15','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
	})
	
	sets.midcast.dia = set_combine(sets.midcast.Enfeebling, {
	ammo="Regal Gem",
	head="Lethargy Chappel +3",
	body="Lethargy Sayon +3",
	hands="Regal Cuffs",
	right_ring="Kishar Ring",
	back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	waist="Obstinate Sash",
	legs="Lethargy Fuseau +3",
	feet="Lethargy Houseaux +3"
	})
	
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.conservemp, {
	main="Pukulatmuj +1",
	sub="Ammurapi Shield",
	head="Befouled Crown",
	neck="Incanter's Torque",
	left_ear="Mimir Earring",
	right_ear="leth. earring +1",
	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	ring2={name="Stikini Ring +1", bag="wardrobe5"},
	legs="Atrophy Tights +3",
	})
	
	sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {
	main="Colada",
	head="Lethargy Chappel +3",
	neck="Duelist's Torque +2",
	body="Lethargy Sayon +3",
	hands="Atrophy Gloves +3",
	back="Ghostfyre Cape",
	waist="Embla Sash",
	legs="Lethargy Fuseau +3",
	feet="Lethargy Houseaux +3"
	})
	
	sets.midcast['Dark Magic'] = {
	--main="Rubicundity",
	main="Bunzi's Rod",
	sub="Ammurapi Shield",
	range="Ullr",
	head="Leth. Chappel +3",
	neck="Erra Pendant",
	left_ear="Malignance Earring",
	right_ear="leth. earring +1",
	body="Lethargy Sayon +3",
	hands="Leth. Ganth. +3",
	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	ring2={name="Stikini Ring +1", bag="wardrobe5"},
	back="Perimede Cape",
	waist="Acuity Belt +1",
	legs="Lethargy Fuseau +3",
	feet="Leth. Houseaux +3",
	}
		--body="Shango Robe",
		
	sets.midcast.drain = set_combine(sets.midcast['Dark Magic'], {
	head="Pixie Hairpin +1",
	left_ear="Malignance Earring",
	right_ear="Dignitary's Earring",
	--body="Merlinic Jubbah",
	--hands="Merlinic Dastanas",
	left_ring="Archon Ring",
	back="Aurist's Cape +1",
	waist="Fucho-no-Obi",
	--legs="Merlinic Shalwar",
	--feet="Merlinic Crackows"
	})
	
	 sets.midcast.absorb = set_combine(sets.midcast['Dark Magic'], {
    main="Crocea Mors",
	neck="Null Loop",
	back="Null Cape",
    })
	--body="Vitiation Tabard +3",
	
	sets.midcast.bar_element = {}
	
	sets.midcast.regen =  set_combine(sets.midcast.EnhancingDuration, {
	main="Bolelabunga",
	feet="Bunzi's Sabots",
    })
	
	sets.midcast.impact = {
	sub="Ammurapi Shield",
	range="Ullr",
	head=empty,
	neck="Duelist's Torque +2",
	left_ear="Malignance Earring",
	right_ear="Snotra Earring",
	body="Crepuscular Cloak",
	--hands="Regal Cuffs",
	hands="Lethargy Gantherots +3",
	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	right_ring="Metamorph Ring +1",
	back="Aurist's Cape +1",
	waist="Acuity Belt +1",
	legs="Chironic Hose",
	feet="Vitiation Boots +3",
	}
	
	--Occult Acumen
	sets.midcast.impact.Occult =  {
	ammo="Coiste Bodhar",
	neck="Combatant's Torque", --4 STP
	left_ear="Crep. Earring", --6 STP
    right_ear="Telos Earring", --5 STP
    body="Crepuscular Cloak",
	hands="Malignance Gloves",
    left_ring="Crepuscular Ring", --6 STP
    right_ring="Chirich Ring +1", --6 STP    
    waist="Oneiros Rope", --20 Occult 2 STP
	legs="Perdition Slops", --30 Occult
    feet="Malignance Boots",
	}
	
	
	sets.buff.skulk = set_combine(sets.midcast.EnhancingDuration, {}) --skulker's cape
	
	sets.buff['Phalanx'] = set_combine(sets.midcast.EnhancingDuration, {})
	
	sets.buff.selfphalanx = set_combine(sets.buff['Phalanx'], {
	main="Sakpata's Sword",
	--head="Chironic Hat",
	--body="Chironic Doublet",
	hands="Chironic Gloves", --augments={'Phys. dmg. taken -2%','Pet: "Store TP"+7','Phalanx +5','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
	legs="Chironic Hose",
	feet="Chironic Slippers",
	})
	
	sets.buff['Refresh III'] = set_combine(sets.midcast.EnhancingDuration, {
	head="Amalric Coif +1",
	body="Atrophy Tabard +3",
	legs="Lethargy Fuseau +3",
	})
	
	sets.buff.selfrefresh = set_combine(sets.buff['Refresh III'], {
	--waist="Gishdubar Sash",
	--feet="Inspirited Boots"(?)
	})
	
	sets.buff['Stoneskin'] = {
	neck="Nodens Gorget",
	left_ear="Earthcry earring",
	--hands="Stone Mufflers",
	waist="Siegel Sash",
	legs="Shedir Seraweels",
	}
	
	sets.buff['Aquaveil'] = {
	head="Chironic Hat",
	head="Amalric Coif +1",
	--hands="Regal Cuffs",
	waist="Emphatikos Rope",
	legs="Shedir Seraweels",
	}
	
	sets.buff.enspell = {
	main="Pukulatmuj +1",
	sub="Forfend +1",
	head="Befouled Crown",
	neck="Incanter's Torque",
	left_ear="Andoaa Earring",
	right_ear="Mimir Earring",
	body={ name="Vitiation Tabard +3", augments={'Enhances "Chainspell" effect',}},
	hands="Vitiation Gloves +3",
	ring1={name="Stikini Ring +1", bag="wardrobe2"},
    ring2={name="Stikini Ring +1", bag="wardrobe5"},
	back="Ghostfyre Cape",
	waist="Olympus Sash",
	legs="Atrophy Tights +3",
	feet="Lethargy Houseaux +3"
	}
	
	sets.ja['Chainspell'] = {body="Vitiation Tabard +3",}
	sets.ja['Vallation'] = sets.enmity
	sets.ja['Swordplay'] = sets.enmity
	sets.ja['Pflug'] = sets.enmity
	sets.ja['Valiance'] = sets.enmity
	sets.ja['Animated Flourish'] = sets.enmity
	
	sets.TP.index = {'Standard','EnSpell',}
	TP_ind = 1 --Standard set is the Default
	
	sets.TP['Standard'] = {
	ammo="Coiste Bodhar",
	head="Bunzi's Hat",
	neck="Combatant's Torque",
	left_ear="Sherida Earring",
	right_ear="leth. earring +1",
	body="Malignance Tabard",
	hands="Malignance Gloves",
	ring1={name="Chirich Ring +1", bag="wardrobe2"},
	ring2={name="Chirich Ring +1", bag="wardrobe5"},
	back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --DW?
	waist="Reiki Yotai",
	legs="Malignance Tights",
	feet="Nyame Sollerets",
	}
	
	sets.TP['EnSpell'] = {
	range="Ullr",
	head="Nyame Helm",
	neck="Combatant's Torque",
	ear1="Eabani Earring",
	ear2="leth. earring +1",
	body="Malignance Tabard",
	hands="Aya. Manopolas +2",
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},
	right_ring="Ilabrat Ring",
	--back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	waist="Orpheus's Sash",
	legs="Malignance Tights",
	feet="Nyame Sollerets"
	}
	
sets.TP.zerodamage = set_combine(sets.TP['EnSpell'], {
		main="Aern Dagger",
		sub="Aern Dagger II",
		--head="Malignance Chapeau",
		neck="Duelist's Torque +2",
		ring2="Hetairoi Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		legs="Carmine Cuisses +1",	
		--feet="Malignance Boots"
	})
	
	sets.subjobnin = {left_ear="Eabani Earring",legs="Carmine Cuisses +1"}
	sets.subjobdnc = set_combine(sets.subjobnin, {
	--back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	})

	
	sets.ws.common = {
	ammo="Coiste Bodhar",
	head="Nyame Helm",
	neck="Rep. Plat. Medal",
	left_ear="Sherida Earring",
	right_ear="leth. earring +1",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	left_ring="Sroda Ring",
	right_ring="Cornelia's Ring",
	back={ name="Sucellos's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	waist="Kentarch Belt +1",
	legs="Nyame Flanchard",
	Feet="Nyame Sollerets",
	}
	
	sets.ws["Savage Blade"] = set_combine(sets.ws.common, {
	ammo="Crepuscular Pebble",
	head="Nyame Helm",
	neck="Duelist's Torque +2",
	right_ear="Sherida Earring",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	left_ring="Sroda Ring",
	waist="Sailfi Belt +1",
	legs="Nyame Flanchard",
	feet="Lethargy Houseaux +3"
	})
		
	sets.ws["Sanguine Blade"] = set_combine(sets.ws.common, { --Crocea Mors/Bunzi's Rod
	ammo="Pemphredo Tathlum",
	head="Pixie Hairpin +1",
	neck="Baetyl Pendant",
	left_ear="Malignance Earring",
	right_ear="Regal Earring",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	left_ring="Archon Ring",
	waist="Orpheus's Sash",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"
	})
	
	sets.ws["Seraph Blade"] = set_combine(sets.ws.common, { --Crocea Mors/Daybreak
	ammo="Pemphredo Tathlum",
	head="Nyame Helm",
	neck="Duelist's Torque +2",
	right_ear="Malignance Earring",
	body="Nyame Mail",
	left_ring="Metamorph Ring +1",
	waist="Orpheus's Sash",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"
	})
	
	sets.ws["Aeolian Edge"] = set_combine(sets.ws.common, {
	ammo="Pemphredo Tathlum",
	head="Nyame Helm",
	neck="Sibyl Scarf",
	right_ear="Malignance Earring",
	body="Nyame Mail",
	left_ring="Freke Ring",
	waist="Orpheus's Sash",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"
	})
	
	sets.ws["Ruthless Stroke"] = set_combine(sets.ws.common, {
	ammo="Coiste Bodhar",
	left_ring="Ilabrat Ring",
	back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --DW?
	})
	
	sets.ws["Black Halo"] = set_combine(sets.ws.common, {
	ammo="Crepuscular Pebble",
	head="Nyame Helm",
	neck="Duelist's Torque +2",
	right_ear="leth. earring +1",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	left_ring="Sroda Ring",
	waist="Kentarch Belt +1", --Sailfi if Acc capped
	legs="Nyame Flanchard",
	feet="Lethargy Houseaux +3"
	})

	sets.idle.index = {'Idle','Flans','DW'}
	idle_ind = 1
	
	sets.idle['Idle'] = {
	--main="Sakpata's Sword",
	--sub="Genmei Shield",
	ammo="Homiliary",
	head="Vitiation Chapeau +3",
	neck="Loricate Torque +1",
	left_ear="Etiolation Earring",
	right_ear="Dominance Earring +1",
	body="Lethargy Sayon +3",
	hands="Volte Gloves",
	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	right_ring="Defending Ring",
	back="Solemnity Cape",
	waist="Shinjutsu-no-obi +1",
	legs="Carmine Cuisses +1",
	feet="Volte Gaiters"
	}
	
	sets.idle['Flans'] = sets.TP['EnSpell']
	
	sets.idle['DW'] = sets.idle['Idle']
	
	sets.resting = {}
	
	sets.main.index = {'Crocea Mors','Naegling','Mpu Gandring','Maxentius'}
	main_ind = 1 --Crocea Mors is the Default
	
	sets.main['Crocea Mors'] = {main="Crocea Mors"}
	sets.main['Naegling'] = {main="Naegling"}
	sets.main['Mpu Gandring'] = {main="Mpu Gandring"}
	sets.main['Maxentius'] = {main="Maxentius"}
	
	sets.sub.index = {'Gleti\'s Knife','Daybreak','Bunzi\'s Rod',} --'Thibron', 'Crepuscular Knife'
	sub_ind = 1 --Gleti's Knife is the Default
	
	sets.sub['Gleti\'s Knife'] = {sub="Gleti's Knife"}
	sets.sub['Daybreak'] = {sub="Daybreak"}
	sets.sub['Bunzi\'s Rod'] = {sub="Bunzi's Rod"}
	sets.sub['Thibron'] = {sub="Thibron"}
	sets.sub['Crepuscular Knife'] = {sub="Crepuscular Knife",}
	
end

function check_height() 
	selfz = math.floor(windower.ffxi.get_mob_by_index(player.index).z * 10)/10
	targetz = math.floor(windower.ffxi.get_mob_by_index(player.target.index).z * 10)/10
	heightdiff = selfz - targetz
	targdistance = math.floor(windower.ffxi.get_mob_by_index(player.target.index).distance:sqrt() * 10+0.5)/10
end

function precast(spell)
	busy = true
	if weaponlock then
		disable('main','sub','range')
		if player.equipment.range ~= "empty" then
			disable('ammo')
		end
	else
		enable('main','sub','range','ammo')
	end
	if player.equipment.main ~= "Daybreak" and spell.name == 'Dispelga' then
		equip({main="Daybreak"})
	elseif player.equipment.body ~= "Crepuscular Cloak" and spell.name == 'Impact' then
		equip({body="Crepuscular Cloak"})
	end
	if buffactive['Stun'] or buffactive['Petrify'] or buffactive['Terror'] or ((spell.action_type == "WeaponSkill" or spell.action_type == "JobAbility") and buffactive['Amnesia']) or (spell.action_type == 'Magic' and buffactive['Silence']) then
		cancel_spell()
	elseif buffactive['Weakness'] and spell.name == "Sublimation" then
		cancel_spell()
		add_to_chat(123, spell.name..' Canceled: [Weakness]')
	elseif (buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete']) and spell.name == "Sublimation" and player.mpp >= 85 then
		cancel_spell()
	elseif (sets.ja[spell.english]) then
		equip(sets.ja[spell.english])
	elseif spell.action_type == 'Magic' then
		if spell.skill == 'Healing Magic' then
			if string.find(spell.english,'Cur') and spell.english ~= 'Cursna' then
				weathercheck(spell.element,sets.fc.cure)
			else
				equip(sets.fc.healing)
			end
		elseif spell.skill == 'Enhancing Magic' then
			if spell.name == "Phalanx II" and spell.target.type == 'SELF' then
				cancel_spell()
				send_command('@input /ma "Phalanx" <me>')
			elseif spell.name == "Stoneskin" then
				if buffactive["Stoneskin"] then
					send_command('cancel 37')
				end
				equip(sets.fc.stoneskin)
			elseif spell.name == 'Sneak' and spell.target.name == player.name and buffactive["Sneak"] then
				send_command('cancel 71')
			else
				equip(sets.fc.base)
			end
		elseif spell.skill == 'Elemental Magic' and spell.name == "Impact" then
			equip(sets.fc.impact)
		elseif spell.skill == 'Ninjutsu' then
			if spell.name == "Utsusemi: Ichi" then
				if buffactive["Copy Image"] then
					send_command('cancel 66;')
				elseif buffactive['Copy Image (2)'] then
					send_command('cancel 444;')
				end
				equip(sets.fc.utsusemi)
			else
				if spell.name:contains('Monomi') and buffactive["Sneak"] then
					send_command('cancel 71')
				end
				equip(sets.fc.base)
			end
		else
			equip(sets.fc.base)
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
				equip(sets.ws.common)
			end
			if (player.tp >= 1000 and player.tp < 2750) then
				equip({left_ear="Moonshade Earring"})  
			elseif player.tp < 3000 then
				equip({left_ear="Regal Earring"})
			elseif spell.name == "Ruthless Stroke" then --or spell.name == "Savage Blade" 
				equip({left_ear="Sherida Earring"})
			else
				equip({left_ear="Regal Earring"})
			end
		end
	end
end

function midcast(spell)
	if spell.action_type == 'Magic' and not spell.type:contains('Trust') then
		if sets.midcast[spell.name] then
			weathercheck(spell.element,sets.midcast[spell.name])
		elseif spell.skill == 'Healing Magic' then
			if string.find(spell.english,'Cur') and spell.english ~='Cursna' then
				weathercheck(spell.element,sets.midcast.cure)
			elseif spell.english == 'Cursna' then
				weathercheck(spell.element,sets.midcast.cursna)
			elseif NaSpells:contains(spell.name) then
				equip(sets.midcast.conservemp)
			elseif spell.english:contains('raise') then
				equip(sets.midcast.raise)
			end
		elseif spell.skill == 'Elemental Magic' then
				if spell.name == "Impact" and sets.nuke.index[nuke_ind] == 'Occult' then 
				equip(sets.midcast.impact.Occult)
				elseif spell.name == "Impact" then
				equip(sets.midcast.impact)
			else
				if spell.english == "Fire" or spell.english == "Stone" or spell.english == "Blizzard" or spell.english == "Thunder" or spell.english == "Water" or spell.english == "Aero" then
					equip(sets.TP['DT'])
				else
					weathercheck(spell.element,sets.nuke[sets.nuke.index[nuke_ind]])
					zodiaccheck(spell.element)
				end
			end
		elseif spell.skill == "Enhancing Magic" and not S{'Warp','Warp II','Retrace','Teleport-Holla','Teleport-Mea','Teleport-Dem','Teleport-Altep','Teleport-Vahzl','Teleport-Yhoat','Recall-Jugner','Recall-Pashh','Recall-Meriph'}:contains(spell.english) then
			if spell.english == "Sneak" or spell.english == "Invisible" then
				equip(sets.buff.skulk)
			elseif string.find(spell.english,'Regen') then
				equip(sets.midcast.regen)
			elseif BarElements:contains(spell.name) then
				equip(sets.midcast.bar_element)
			elseif sets.buff[spell.name] then
				equip(sets.buff[spell.name])
				if string.find(spell.english,'Refresh III') then
					equip(sets.buff.selfrefresh)
				elseif string.find(spell.english,'Phalanx') and spell.target.type == 'SELF' then
					equip(sets.buff.selfphalanx)
				end
			elseif EnSpells:contains(spell.name) or spell.name == "Temper II" then
				equip(sets.buff.enspell)
			elseif string.find(spell.english,'En') and (buffactive['Enfire II'] or buffactive['Enblizzard II'] or buffactive['Enaero II'] or buffactive['Enstone II'] or buffactive['Enthunder II'] or buffactive['Enwater II']) then
				send_command('cancel 277; cancel 278; cancel 279; cancel 280; cancel 281; cancel 282')
			elseif spell.name == "Foil" then
				equip(sets.enmity)
			else
				equip(sets.midcast.EnhancingDuration)
				if buffactive['Composure'] and spell.target.type ~= 'SELF' and not buffactive["Accession"] then
					equip({head="Lethargy Chappel +3",body="Lethargy Sayon +3",legs="Lethargy Fuseau +3",})
				end
				if GainSpells:contains(spell.name) then
					equip({hands="Vitiation Gloves +3",})
				elseif Spikes:contains(spell.name) then
					equip({legs="Vitiation Tights +2",})
				end
				if string.find(spell.english,'Protect') or string.find(spell.english,'Shell') and spell.target.type == 'SELF' then
					equip({right_ring="Sheltered Ring"})
				end
			end
		elseif spell.skill == 'Enfeebling Magic' then
			if spell.name == "Dispelga" then
				equip({main="Daybreak"})
			elseif EnfeeblingMax:contains(spell.name) then
				equip(sets.midcast.maxenfacc)
			elseif EnfeeblingPot:contains(spell.name) then
				equip(sets.midcast.SkillEnfeebles)
			elseif EnfeeblingMND:contains(spell.name) then
				equip(sets.midcast.enfeebleMND)
			elseif EnfeeblingINT:contains(spell.name) then
				equip(sets.midcast.enfeebleINT)
			elseif EnfeeblingDur:contains(spell.name) then
				equip(sets.midcast.enfduration)
			else
				equip(sets.midcast.dia)
			end
		elseif spell.skill == 'Dark Magic' and not spell.english:contains("Tractor") then
			if spell.english:startswith('Drain') or spell.english:startswith('Aspir') then
				weathercheck(spell.element,sets.midcast.drain)
			elseif spell.english:startswith('Absorb') then
				equip(sets.midcast.absorb)
			else
				equip(sets.midcast['Dark Magic'])
			end
		elseif spell.skill == 'Divine Magic' then
			if spell.name == "Flash" then
				equip(sets.enmity)
			end
		elseif spell.skill == 'Blue Magic' then
			equip(sets.enmity)
		elseif spell.skill == 'Ninjutsu' then
		else
			equip(sets.midcast.conservemp)
		end
	end
end

function aftercast(spell)
	if player.status == "Engaged" then
	disable('main','sub','range')
		if ZeroDMG:contains(player.equipment.main) and ZeroDMG:contains(player.equipment.sub) then
			equip(sets.TP.zerodamage)
		else
			equip(sets.TP[sets.TP.index[TP_ind]])
			determine_dual_wield()
			if buffactive[EnSpells] then
				equip({hands="Ayanmo Manopolas +2",})
			end
		end
	elseif player.status == "Idle" then
		equip(sets.idle[sets.idle.index[idle_ind]])
	end
	busy = false
end

function status_change(new,old)
	if new == 'Resting' then
		equip(sets.resting)
	elseif new == 'Engaged' then
		if ZeroDMG:contains(player.equipment.main) and (ZeroDMG:contains(player.equipment.sub) or player.equipment.sub == "empty" or player.skills.shield > 350) then
			if Ullr and player.equipment.range ~= "Ullr" then
				enable('range')
				equip({range="Ullr"})
				disable('range','ammo')
			end
			equip(sets.TP.zerodamage)
		else
			disable('main','sub','range')
			equip(sets.TP[sets.TP.index[TP_ind]])
			determine_dual_wield()
			if buffactive[EnSpells] then
				equip({hands="Ayanmo Manopolas +2",})
			end
		end
	elseif new == 'Idle' then
		equip(sets.idle[sets.idle.index[idle_ind]])
	end
end

function buff_change(n, gain, buff_table)
	local name
	name = string.lower(n)
	if S{"silence"}:contains(name) then
        if gain then
			--send_command('@input /item "Echo Drops" <me>')
			--send_command('@input /item "Remedy" <me>')
		end
	elseif S{"reraise"}:contains(name) then
		if gain then
		else
			if player.hp ~= 0 then
				add_to_chat(123, 'Reraise: [lost]')
			end
		end
	elseif S{"sleep"}:contains(name) then
		if player.status == "Idle" then
			if gain then
				if buffactive["Stoneskin"] then
					send_command('cancel Stoneskin')
				end
				equip({main="Caliburnus",})
			else
				equip({main="Daybreak"})
			end
		end
	end
end

function weathercheck(spell_element,set)
    if not set then
		return
	end
    if spell_element == world.weather_element or spell_element == world.day_element then
		equip(set,{waist="Hachirin-no-Obi"})
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

function determine_dual_wield()
	--if player.equipment.sub:contains('Shield') or player.equipment.sub:contains('Bulwark') or player.equipment.sub:contains('Buckler') or player.equipment.sub:contains('Grip') or player.equipment.sub == 'empty' or player.equipment.sub:contains('Forfend') then
	if player.sub_job_level == 0 or (player.sub_job ~= "NIN" and player.sub_job ~= "DNC") then
		equip(sets.main[sets.main.index[main_ind]],sets.sub['Shield'])
		equip({back=cape.AmbuBackOH})
	else
		equip(sets.main[sets.main.index[main_ind]],sets.sub[sets.sub.index[sub_ind]])
		--[[if player.sub_job == "DNC" then --21 DW with 43.75% magic haste
			if ((buffactive["Haste"] and buffactive["Embrava"]) or (buffactive["March"] == 2) or (buffactive["Haste"] and buffactive[580]) or ((buffactive["March"] == 1) and buffactive["Haste"]) and buffactive["Haste Samba"] then --43.75%+5%  9 DW
				equip({})
			elseif (buffactive["Haste"] and buffactive["Embrava"]) or (buffactive["March"] == 2) or (buffactive["Haste"] and buffactive[580]) or ((buffactive["March"] == 1) and buffactive["Haste"]) then --43.75%  21 DW
				equip()
			else --30% (assumes self Haste II)  41 DW
				
			end
		else]]if player.sub_job == "NIN" then --11 DW with 43.75% magic haste
			if (buffactive["Haste"] and buffactive["Embrava"]) or (buffactive["March"] == 2) or (buffactive["Haste"] and buffactive[580]) or ((buffactive["March"] == 1) and buffactive["Haste"]) then --47.75%  11 DW
				if cape.AmbuBackDW == "empty" then
					equip(sets.subjobnin)
				else
					equip({back=cape.AmbuBackDW})
				end
			else --30% (assumes self Haste II)  31 DW
				equip(sets.subjobnin,{back=cape.AmbuBackDW,waist="Reiki Yotai"})
			end
		end
	end
end

runspeed = false

if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
	
	mov = {counter=0}
	if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
		mov.x = windower.ffxi.get_mob_by_index(player.index).x
		mov.y = windower.ffxi.get_mob_by_index(player.index).y
		mov.z = windower.ffxi.get_mob_by_index(player.index).z
	end
	moving = false
	
	windower.raw_register_event('prerender',function()
		mov.counter = mov.counter + 1;
		if mov.counter>30 then
			local pl = windower.ffxi.get_mob_by_index(player.index)
			if pl and pl.x and mov.x then
				local movement = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 ) > 0.1
				if movement and not moving then
					send_command('gs c toggle runspeed')
					moving = true
				elseif not movement and moving then
					send_command('gs c toggle runspeed')
					moving = false
				end
			end
	
			if pl and pl.x then
				mov.x = pl.x
				mov.y = pl.y
				mov.z = pl.z
			end
			mov.counter = 0
		end
	end)
end

function updateRunspeedGear( value )

    if not value and not busy then
		equip({legs=sets.idle.pants})
    else
		if player.status == "Idle" and not busy then 
			equip({legs="Carmine Cuisses +1",})
		end
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
		enable('main','sub','range')
		equip(sets.idle[sets.idle.index[idle_ind]])
	end
	if command == 'toggle nuke set' then
		nuke_ind = nuke_ind +1
		if nuke_ind > #sets.nuke.index then nuke_ind = 1 end
		windower.add_to_chat(1,'<----- nuke Set changed to '..sets.nuke.index[nuke_ind]..' ----->')
	end
	if command == 'toggle main set' then
		main_ind = main_ind +1
		if main_ind > #sets.main.index then main_ind = 1 end
		windower.add_to_chat(1,'<----- main Set changed to '..sets.main.index[main_ind]..' ----->')
		enable('main','sub','range')
		equip(sets.main[sets.main.index[main_ind]])
		if main_ind == 1 then
			send_command('alias savage @input /ws "Savage Blade" <t>')
			send_command('alias seraph @input /ws "Seraph Blade" <t>')
		elseif main_ind == 2 then
			send_command('alias savage @input /ws "Savage Blade" <t>')
			send_command('alias seraph @input /ws "Seraph Blade" <t>')
		elseif main_ind == 3 then
			send_command('alias savage @input /ws "Ruthless Stroke" <t>')
			send_command('alias seraph @input /ws "Aeolian Edge" <t>')
		elseif main_ind == 4 then
			send_command('alias savage @input /ws "Black Halo" <t>')
			send_command('alias seraph @input /ws "Brainshaker" <t>')
		end
	end
	if command == 'toggle sub set' then
		if sets.idle[sets.idle.index[idle_ind]] == sets.idle['DW'] then
			sub_ind = sub_ind +1
			if sub_ind > #sets.sub.index then sub_ind = 1 end
			windower.add_to_chat(1,'<----- sub Set changed to '..sets.sub.index[sub_ind]..' ----->')
			enable('main','sub','range')
			equip(sets.sub[sets.sub.index[sub_ind]])
		end
	end
	if command == 'toggle weaponlock' then
		weaponlock = not weaponlock
		windower.add_to_chat(1,'<----- Weapon Locked: '..tostring(weaponlock)..' ----->')
	end	
	if command == 'reequip' then
		equip(sets.TP[sets.TP.index[TP_ind]],sets.main[sets.main.index[main_ind]],sets.sub[sets.sub.index[sub_ind]])
		--equip(sets.TP[sets.TP.index[TP_ind]],sets.TH[sets.TH.index[TH_ind]])
		if player.status == 'Idle' then
			equip(sets.TP[sets.TP.index[TP_ind]],sets.idle)
			if sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] then
				equip({right_ring="Defending Ring",})
			end
		end
	end
	if command == 'toggle runspeed' then
		runspeed = not runspeed
		updateRunspeedGear(runspeed)
	end
end

send_command('bind !a gs c reequip;wait 1; input /lockstyle on') -- Hit alt+a, reequips your gear with toggled sword/shield
send_command('bind !s gs c toggle TP set') -- Hit win+q, toggles the sets
send_command('bind !e gs c toggle idle set') -- Hit win+e, toggles the sets
send_command('bind !m gs c toggle nuke set') -- Hit win+m, toggles the sets
--send_command('wait 5;gs equip fashion;wait 1;input /lockstyle on;wait 1;gs equip refresh')
send_command('bind !- gs c toggle main set') -- Hit win+-, toggles the sets
send_command('bind != gs c toggle sub set') -- Hit win+=, toggles the sets
send_command('bind !w gs c toggle weaponlock') -- Hit win+w, toggles the sets

send_command('bind !i send @all /mount Ixion')
send_command('bind !l send @all /lightshot zattano')
send_command('bind !d send @all /darkshot <bt>')
send_command('bind !t send tigertale /dia2 <bt>')
send_command('bind !b send @all /Bolters roll')
send_command('bind !c send @all /Chaos Roll')
send_command('bind !v send @all /Samurai Roll')

function file_unload()
	send_command('unbind !a')
	send_command('unbind !s')
	send_command('unbind !e')
	send_command('unbind !m')
	send_command('unbind !-')
	send_command('unbind !=')
	send_command('unbind !w')
	send_command('unbind !l')
	send_command('unbind !d')
	send_command('unbind !b')
	send_command('unbind savage')
	send_command('unbind seraph')
	
	
	send_command('unbind !i')
	send_command('unbind !l')
	send_command('unbind !d')
	send_command('unbind !t')
	send_command('unbind !b')
	send_command('unbind !c')
	send_command('unbind !v')
end

--function zone_change(new,old)
--	if areas.Cities:contains(world.area) then
--		equip(sets.idle[sets.idle.index[idle_ind]])
--		if world.area:contains("Bastok") or world.area:contains("Metalworks") then
--		elseif world.area:contains("Adoulin") then
--			equip({body="Councilor's Garb"})
--		elseif world.area:contains("Windurst") or world.area:contains("Heaven's") then
		--end
	--end
--end

------------------------------------ Alias -------------------------------------

send_command('alias cl enable(\'main\',\'sub\');gs equip sets.main[\'Crocea Mors\'];gs equip sets.sub[\'Daybreak\']')
send_command('alias nuke enable(\'main\',\'sub\');gs equip sets.main[\'Daybreak\'];gs equip sets.sub[\'Bunzi Rod\']')
send_command('alias savage @input /ws "Savage Blade" <t>')
send_command('alias seraph @input /ws "Seraph Blade" <t>')

---------------------------------- Stratagems ----------------------------------

local strat_charge_time = {[1]=240,[2]=120,[3]=80,[4]=60,[5]=48}
local settings = {pos={x=0,y=0}}
local stratBox = texts.new(settings)

windower.register_event('prerender', function()
	if player then
		if S{player.main_job, player.sub_job}:contains('SCH') then
			local strats = get_available_stratagem_count()
			local col = '\\cs(0,255,0)'
			if (strats == 0) then
				col = '\\cs(255,0,0)'
			end
			stratBox:text('Stratagems: '..col..strats..'\\cr')
			stratBox:visible(true)
		else
			stratBox:hide()
		end
	else
		stratBox:hide()
	end
end)

-- Calculates and returns the maximum number of SCH stratagems available for use. --
function get_max_stratagem_count()
	if S{player.main_job, player.sub_job}:contains('SCH') then
		local lvl = (player.main_job == 'SCH') and player.main_job_level or player.sub_job_level
		return math.floor(((lvl  - 10) / 20) + 1)
	else
		return 0
	end
end

--[[
	Calculates the number of SCH stratagems that are currently available for use. Calculated from the combined recast timer for stratagems and the maximum number
	of stratagems that are available.  The recast time for each stratagem charge corresponds directly with the maximum number of stratagems that can be used.
--]]
function get_available_stratagem_count()
	local recastTime = windower.ffxi.get_ability_recasts()[231] or 0
	local maxStrats = get_max_stratagem_count()
	if (maxStrats == 0) then return 0 end
	local stratsUsed = (recastTime/strat_charge_time[maxStrats]):ceil()
	return maxStrats - stratsUsed
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
	add_to_chat (55, 'You are on '..('Red Mage'):color(5)..('. '):color(55)..''..('Macros set!'):color(121))
end
 
function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end
 
--Page, Book--
set_macros(1,5)
--Use the Lockstyle Number--
set_style(005)  