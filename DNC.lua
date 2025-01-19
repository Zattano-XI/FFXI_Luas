res = require 'resources'
require('vectors')

include('SendCommands.lua')

send_command('lua l Skillchains')
send_command('lua l Steps')
AbysseaWS = S{"Red Lotus Blade","Seraph Blade","Cyclone","Energy Drain","Blade: Ei","Seraph Strike","Freezebite","Shadow of Death","Raiden Thrust","Tachi: Jinpu","Tachi: Koki","Earth Crusher","Sunburst"}
MOVEMENT_SPEED_BUFFS =  S{"Bolter's Roll","Mazurka","quickening",} -- lowercase on purpose


function get_sets()
	sets.fc = {}
	sets.precast = {}
	sets.midcast = {}
	sets.aftercast = {}
	sets.ja = {}
	sets.ws = {}
	sets.buff = {}
	sets.TP = {}
	sets.idle = {}
	ammo = {}
	sets.steps = {}
	
	ammo.melee = {ammo="Coiste Bodhar"}
	ammo.ws = {ammo="Crepuscular Pebble"}
	ammo.dt = {ammo="Coiste Bodhar"}
	ammo.fc = {ammo="Sapience Orb"}
	ammo.acc = {ammo="Yamarang"}
	ammo.matk = {ammo="Pemphredo Tathlum"}
	
	sets.movement = {feet="Skadi's Jambeaux +1"}
	
	sets.fc.base = { --27
	ammo="Sapience Orb",
    head={ name="Herculean Helm", augments={'Mag. Acc.+12','"Fast Cast"+6','MND+7',}}, --13
	neck="Baetyl Pendant", --4
	left_ear="Loquac. Earring", --2
    right_ear="Etiolation Earring", --1
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --8
	left_ring="Lebeche Ring",
	right_ring="Weather. Ring",
	waist="Sailfi Belt +1",
    legs="Rawhide Trousers", --5
	}
	
	sets.TP.index = {'Arebati', 'DT', 'STP', 'STP2', 'Aminon'}--'Standard','High Acc','Hybird',
	TP_ind = 1 --Standard set is the Default
	
	sets.TP['Standard'] = {
	ammo="Coiste Bodhar",
	head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
	neck="Etoile Gorget +2",
	left_ear="Sherida Earring",
	right_ear="Maculele Earring +2",
	body="Gleti's Cuirass",
	--body="Malignance Tabard",
	hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	left_ring="Gere Ring",
	right_ring="Epona's Ring",
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	waist="Sailfi Belt +1",
	legs="Meg. Chausses +2",
	feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+3','Attack+9',}},
	}
	
	sets.TP['High Acc'] = set_combine(sets.TP['Standard'],{
	head="Nyame Helm",
	})
	
	sets.TP['Hybird'] = { 
	ammo="Crepuscular Pebble", --3
	head="Nyame Helm",  --7
	neck="Etoile Gorget +2",
	left_ear="Sherida Earring",
	right_ear="Maculele Earring +2",
	body="Malignance Tabard",  --9
	hands="Malignance Gloves",  --5
	left_ring="Gere Ring",
	right_ring="Defending ring", --10
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	waist="Sailfi Belt +1",
	legs="Malignance Tights", --7
	feet="Malignance Boots",  --4
	}
	
	sets.TP['STP'] = {
	ammo="Coiste Bodhar",
	head="Malignance chapeau",
	neck="Etoile Gorget +2",
	left_ear="Sherida Earring",
	right_ear="Maculele Earring +2",
	body="Malignance Tabard",
	hands="Malignance Gloves",
	--left_ring={name="Chirich Ring +1", bag="wardrobe2"},
	left_ring="Moonlight Ring",
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	waist="Sailfi Belt +1",
	legs="Malignance Tights",
	feet="Maculele toe shoes +3",
	}
	
	sets.TP['STP2'] = {
	ammo="Coiste Bodhar",
	head="Maculele Tiara +3",
	neck="Etoile Gorget +2",
	left_ear="Sherida Earring",
	right_ear="Maculele Earring +2",
	body="Gleti's Cuirass",
	hands="Malignance Gloves",
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},
	--right_ring={name="Chirich Ring +1", bag="wardrobe5"},
	right_ring="Defending ring",
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	waist="Sailfi Belt +1",
	legs="Malignance Tights",
	feet="Maculele toe shoes +3",
	}
	
	sets.TP['Arebati'] = {
	ammo="Coiste Bodhar",
	head="Malignance chapeau",
	neck="Warder's charm +1",
	left_ear="Sherida Earring",
	right_ear="Maculele Earring +2",
	body="Malignance Tabard",
	hands="Malignance Gloves",
	left_ring="Moonlight Ring",
	--left_ring={name="Chirich Ring +1", bag="wardrobe2"},
	--right_ring={name="Chirich Ring +1", bag="wardrobe5"},
	right_ring="Shadow ring",
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	waist="Reiki yotai",
	legs="Malignance Tights",
	feet="Maculele toe shoes +3",
	}

	sets.TP['DT'] = {
	ammo="Coiste Bodhar",
	head="Nyame Helm",
	--neck="Etoile Gorget +2",
	neck="Warder's charm +1",
	left_ear="Sherida Earring",
	right_ear="Maculele Earring +2",
	body="Nyame mail",
	hands="Macu. Bangles +3",
	left_ring="Moonlight Ring",
	right_ring="Shadow ring",
	--right_ring="Moonlight Ring",
	--right_ring="Defending ring",
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	waist="Sailfi Belt +1",
	legs="Nyame flanchard",
	feet="Macu. Toe Sh. +3",
	}	
	
	sets.TP['Aminon'] = {
    ammo="Crepuscular Pebble",
    head="Turms Cap",
    body={ name="Gleti's Cuirass", augments={'Path: A',}},
    --hands="Gleti's Gauntlets",
	hands="Regal gloves",
    legs={ name="Gleti's Breeches", augments={'Path: A',}},
    --feet="Macu. Toe Sh. +3",
	feet="Gleti's Boots",
    neck="Etoile Gorget +2",
    waist="Plat. Mog. Belt",
    left_ear="Odnowa Earring +1",
    right_ear="Maculele Earring +2",
    left_ring="Moonlight Ring",
    right_ring="Shadow Ring",
    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.TP['Parrying'] = {
    ammo="Staunch Tathlum +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Adamantite Armor",
    hands="Turms Mittens +1",
    legs="Maculele Tights +1",
    feet="Macu. Toe Sh. +3",
    neck={ name="Etoile Gorget +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Sherida Earring",
    right_ear="Maculele Earring +2",
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.enmity = {
	neck="Unmoving Collar +1",
	left_ear="Cryptic Earring",
	right_ear="Friomisi Earring",
	body="Emet Harness +1",
	hands="Kurys Gloves",
	left_ring="Begrudging Ring",
	back="Reiki Cloak",
	waist="Chaac Belt",
	feet="Ahosi Leggings"
	}
	
	sets.ja['Provoke'] = sets.enmity
	sets.ja['Animated Flourish'] = sets.enmity
	sets.ja['Trance'] = {head="Horos Tiara",}
	sets.ja['Jigs'] = {legs="Horos Tights +3",}
	sets.ja['Fan Dance'] = {}
	sets.ja['Saber Dance'] = {legs="Horos Tights +3",}
	sets.ja['No Foot Rise'] = {body="Horos Casaque +3",}
	
	sets.step = {
	ammo="Yamarang",
	head="Maxixi Tiara +3",
	body="Gleti's Cuirass",
	--body="Malignance tabard",
	hands="Maxixi Bangles +3",
	legs="Malignance Tights",
	feet="Horos T. Shoes +3",
	neck="Etoile Gorget +2",
	waist="Kentarch Belt +1",
	left_ear="Odr Earring",
	right_ear="Maculele Earring +2",
	left_ring="Moonlight ring",
	right_ring="Defending Ring",
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.ja['Quickstep'] = sets.step
	sets.ja['Box Step'] = sets.step
	sets.ja['Stutter Step'] = sets.step
	sets.ja['Feather Step'] = set_combine(sets.step, {feet="Maculele Toe Shoes +3",})
	
	sets.ja['Climactic Flourish'] = {head="Maculele Tiara +3"}
	
	sets.ja['Violent Flourish'] = {
    ammo="Yamarang",	
	head="Maculele Tiara +3",
	body="Horos Casaque +3",
	hands="Malignance gloves",
	legs="Malignance Tights",
	feet="Maculele Toe Shoes +3",
	neck="Etoile Gorget +2",
	waist="Null Belt",
	left_ear="Dignitary's earring",
	right_ear="Maculele Earring +2",
	left_ring="Stikini Ring +1",
	right_ring="Weather. Ring",
	}
	
	sets.ja['Reverse Flourish'] = {
	hands="Maculele bangles +3",
	back="Toetapper Mantle",
	}
	
	sets.ja['Striking Flourish'] = {body="Maculele casaque +1"}
	
	sets.ja.samba = {
	head="Maxixi Tiara +3",
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.ja.jig = {legs="Horos Tights +3",}
	
	sets.ja.waltz = {
    ammo="Yamarang", --5%
    head="Nyame helm",
    head="Nyame helm",
    body="Maxixi Casaque +3",  --19%, 8% received
    hands="Nyame gauntlets",
    legs="Dashing Subligar", --10%
    feet="Maculele Toe Shoes +3",
    neck={ name="Etoile Gorget +2", augments={'Path: A',}}, --10%
    waist="Flume belt +1",
    left_ear="Genmei Earring",
    right_ear="Odnowa Earring +1",
    right_ring="Defending Ring",
    --back="Toetapper Mantle", --5
	}
	
	sets.ja['Jump'] ={
	ammo="Coiste Bodhar",
	head="Maculele Tiara +3",
	neck="Etoile Gorget +2",
	left_ear="Sherida Earring",
	right_ear="Maculele Earring +2",
	body="Malignance Tabard",
	hands="Malignance Gloves",
	left_ring={name="Chirich Ring +1", bag="wardrobe2"},
	right_ring={name="Chirich Ring +1", bag="wardrobe5"},
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	waist="Kentarch Belt +1",
	legs="Malignance Tights",
	feet="Maculele Toe shoes +3",
	}
	
	sets.ja['High Jump'] = sets.ja['Jump']
	sets.ja['Super Jump'] = sets.ja['Jump']
	
	sets.idle.index = {'Regain','DT','Regen','AminonIdle'} 
	idle_ind = 1
	
	sets.idle['DT'] = {
	ammo="Crepuscular Pebble",
	head="Nyame Helm",
	--neck="Etoile Gorget +2",
	neck="Warder's charm +1",
	left_ear="Sherida Earring",
	right_ear="Maculele Earring +2",
	body="Nyame mail",
	hands="Nyame gauntlets",
	left_ring="Moonlight Ring",
	right_ring="Shadow ring",
	--right_ring="Moonlight Ring",
	--right_ring="Defending ring",
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	waist="Sailfi Belt +1",
	legs="Nyame flanchard",
	feet="Nyame sollerets",
	}
	
	sets.idle['Regen'] = {
	head="Turms cap",
	neck="Bathy choker +1",
	left_ear="Sherida Earring",
    right_ear="Infused Earring",
    body="Turms harness",
	hands="Turms Mittens +1",
	right_ring="Paguroidea Ring",
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    legs="Turms subligar",
	feet="Tandava crackows",
	}
	
	sets.idle['Regain'] = set_combine(sets.idle['DT'],{
	head="Turms cap",
	body="Gleti's Cuirass",
	hands="Gleti's Gauntlets",
	legs="Gleti's Breeches",
	--feet="Maculele Toe Shoes +3",
	feet="Tandava crackows",
	})
	
	sets.idle['AminonIdle'] = {
    ammo="Crepuscular Pebble",
    head="Turms Cap",
    body={ name="Gleti's Cuirass", augments={'Path: A',}},
    --hands="Gleti's Gauntlets",
	hands="Regal gloves",
    legs={ name="Gleti's Breeches", augments={'Path: A',}},
    --feet="Macu. Toe Sh. +3",
	feet="Gleti's Boots",
    neck="Etoile Gorget +2",
    waist="Plat. Mog. Belt",
    left_ear="Odnowa Earring +1",
    right_ear="Macu. Earring +2",
    left_ring="Moonlight Ring",
    right_ring="Shadow Ring",
    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.phalanx = {
	head="Herculean Helm",
    body="Herculean Vest",
	hands="Herculean Gloves",
	legs="Herculean Trousers",
	feet="Herculean Boots",
	}
	
	sets.low_hp = {
	head=empty,
	body=empty,
	hands=empty,
	ring1=empty,
	ring2=empty,
	legs=empty,
	feet=empty,
	}
	
	sets.high_hp = {
    head="Nyame helm",
	body="Nyame mail",
	hands="Nyame gauntlets",
	legs="Nyame flanchard",
	feet="Horos t. shoes +3",
	waist="Gishdubar sash",
	left_ear="Tuisto Earring",
	right_ear="Etiolation Earring",
	left_ring="Ilabrat Ring",
	right_ring="Meridian Ring",
	back="Reiki cloak",
	}
	
	------Weaponskills------
	sets.ws.common = {
	--head="Nyame Helm",
	head="Maculele Tiara +3",
	neck="Etoile Gorget +2",
	left_ear="Odr Earring",
	right_ear="Maculele earring +2",
	body="Nyame mail",
	--hands="Maxixi Bangles +3",
	hands="Nyame Gauntlets",
	left_ring="Epaminondas's Ring",
	right_ring="Cornelia's ring",
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	waist="Fotia Belt",
	--legs={ name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}},
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"
	}
	
	sets.ws["Evisceration"] = set_combine(sets.ws.common, {
	ammo="Charis Feather",
	--head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
	neck="Fotia gorget",
	left_ear="Odr Earring",
    --body="Meg. Cuirie +2",
	hands="Nyame gauntlets",
    --hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	right_ring="Mummu ring",
    --feet="Mummu Gamash. +2"
	})
	
	sets.ws["Aeolian Edge"] = set_combine(sets.ws.common, {
	ammo="Pemphredo Tathlum",
	hands="Nyame gauntlets",
	neck="Baetyl pendant",
	left_ear="Friomisi Earring",
	right_ring="Dingir Ring",
	waist="Orpheus's Sash",
	legs="Nyame flanchard",
	})
	
	sets.ws["Exenterator"] = set_combine(sets.ws.common, {
	neck="Fotia Gorget",
	left_ear="Sherida Earring",
	right_ring="Ilabrat Ring",
	})
	
	sets.ws["Rudra's Storm"] = set_combine(sets.ws.common, {
	ammo="Crepuscular Pebble",
	head="Maculele Tiara +3",
	--neck="Loricate torque +1",
	--hands="Maxixi Bangles +3",
	left_ear="Odr Earring",
	--right_ring="Ilabrat Ring",
	--left_ring="Moonlight Ring",
	--right_ring="Regal Ring",
	waist="Kentarch belt +1",
	})
	
	sets.ws["Ruthless Stroke"] = set_combine(sets.ws.common, {
	ammo="Crepuscular Pebble",
	head="Maculele Tiara +3",
	--neck="Loricate torque +1",
	--hands="Maxixi Bangles +3",
	left_ear="Sherida earring",
	--left_ear="Odr Earring",
	--right_ring="Ilabrat Ring",
	--left_ring="Moonlight Ring",
	--right_ring="Regal Ring",
	waist="Kentarch belt +1",
	})
	
	sets.ws["Pyrrhic Kleos"] = set_combine(sets.ws.common, {
	body="Gleti's Cuirass",
	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
	sets.ws["Shark Bite"] = set_combine(sets.ws.common, {
	left_ear="Odr Earring",
	hands="Nyame Gauntlets",
	waist="Kentarch belt +1",
	feet="Nyame Sollerets"
	})
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
		--if (spell.name == "Provoke" or spell.name == "Animated Flourish") and player.equipment.range == 'empty' then
		--	equip(ammo.fc)
		--end
	elseif string.find(spell.english,'Waltz') and buffactive['Saber Dance'] then		
			send_command('cancel Saber Dance')
			cast_delay(0.2)
		equip(sets.ja.waltz)
		--if spell.target.type == 'SELF' then
		--	equip({head="Mummu Bonnet +2",})
		--end
	elseif string.find(spell.english,'Jig') then
		equip(sets.ja.jig)
	elseif string.find(spell.english,'Samba') then
		equip(sets.ja.samba)
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
		elseif player.tp >= 1000 and not AbysseaWS:contains(spell.name) then
			if player.equipment.main == "Aeneas" and (player.equipment.sub == "Fusetto +2" or player.equipment.sub == "Fusetto +3" or player.equipment.sub == "Centovente") then
				if (player.tp >= 1000 and player.tp < 1500) then
					equip({left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}}})
				else
					equip({left_ear="Ishvara Earring"})
				end
			elseif player.equipment.main == "Aeneas" then
				if (player.tp >= 1000 and player.tp < 2500) then
					equip({left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}}})
				else
					equip({left_ear="Ishvara Earring"})
				end
			elseif (player.equipment.sub == "Fusetto +2" or player.equipment.sub == "Fusetto +3" or player.equipment.sub == "Centovente") then
				if (player.tp >= 1000 and player.tp < 2000) then
					equip({left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}}})
				else
					equip({left_ear="Ishvara Earring"})
				end
			else
				if (player.tp >= 1000 and player.tp < 3000) then
					equip({left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}}})
				else
					equip({left_ear="Ishvara Earring"})
				end
			end
			if player.equipment.range == 'empty' then
				if spell.name == "Aeolian Edge" then
					equip(ammo.matk)
				else
					equip(ammo.ws)
				end
			end
			if sets.ws[spell.name] then
				equip(sets.ws[spell.name])
			else
				equip(sets.ws.common)
			end
			if buffactive["Climactic Flourish"] then
				equip({head="Maculele Tiara +3",ammo="Charis Feather"})
			elseif buffactive["Striking Flourish"] then
				equip({body="Maculele Casaque +1"})
			end
		end
	elseif spell.action_type == 'Magic' then
		equip(sets.fc.base)
		if player.equipment.range == 'empty' then
			equip(ammo.fc)
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
	if player.status == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
		--if check_facing() == true and (sets.TP[sets.TP.index[TP_ind]] ~= sets.TP['Hybrid'] or sets.TP[sets.TP.index[TP_ind]] ~= sets.TP['DT']) then
		--	equip({feet="Horos Toe Shoes +3"})
		--end
	else
		if sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] then
			equip(sets.TP['DT'],sets.movement)
		--elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['Hybird'] then
		--	equip(sets.TP['Hybird'],sets.movement)
		else
			equip(sets.idle[sets.idle.index[idle_ind]])--,sets.movement
		end
	end
	if player.equipment.range == 'empty' then
		if sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] or sets.TP[sets.TP.index[TP_ind]] == sets.TP['Hybird'] then
			equip(ammo.dt)
		else
			equip(ammo.melee)
		end
	end
end

function status_change(new,old)
	if new == 'Idle' then
		equip(sets.idle[sets.idle.index[idle_ind]])
		if sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] then
			equip(sets.TP['DT'],sets.movement)
		--elseif sets.TP[sets.TP.index[TP_ind]] == sets.TP['Hybird'] then
		--	equip(sets.TP['Hybird'],sets.movement)
		--else
		--	equip(sets.idle[sets.idle.index[idle_ind]])--,sets.movement
		end
	elseif new == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
		if check_facing() == true and (sets.TP[sets.TP.index[TP_ind]] ~= sets.TP['Hybrid'] or sets.TP[sets.TP.index[TP_ind]] ~= sets.TP['DT']) then
			--equip({feet="Horos Toe Shoes +3"})
		end
	end
	if player.equipment.range == 'empty' then
		if sets.TP[sets.TP.index[TP_ind]] == sets.TP['DT'] or sets.TP[sets.TP.index[TP_ind]] == sets.TP['Hybird'] then
			equip(ammo.dt)
		end
	end
end

function buff_change(n, gain, buff_table)
	local name
	name = string.lower(n)
	if S{"doom"}:contains(name) then
		if gain then
			send_command('@input /p Cursna - Doomed')
		else
			send_command('@input /p Doom - Off')
		end
	elseif MOVEMENT_SPEED_BUFFS:contains(name) then
		if gain then
			equip(sets.movement)
		else
			if player.status == 'Engaged' then
				equip(sets.TP[sets.TP.index[TP_ind]])
			end
		end
	end
end

function self_command(command)
	if command == 'toggle TP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip(sets.TP[sets.TP.index[TP_ind]])
		--if check_facing() == true and sets.TP[sets.TP.index[TP_ind]] ~= sets.TP['DT'] and player.status == "Engaged" then
		--	equip({feet="Horos Toe Shoes +3"})
		--end
		if player.status == 'Idle' then
			--equip(sets.movement)
			equip(sets.idle[sets.idle.index[idle_ind]])
		end
	end
	if command == 'toggle idle set' then
		idle_ind = idle_ind +1
		if idle_ind > #sets.idle.index then idle_ind = 1 end
		windower.add_to_chat(1,'<----- idle Set changed to '..sets.idle.index[idle_ind]..' ----->')
		equip(sets.idle[sets.idle.index[idle_ind]])
	end
	if command == 'reequip' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	end
end

send_command('bind @s gs c toggle TP set') -- Hit alt+q, toggles the sets
send_command('bind @w gs c toggle Buff set') -- Hit alt+w, toggles the sets
send_command('bind @e gs c toggle idle set') -- Hit alt+e, toggles the sets
send_command('alias 500hp gs equip low_hp;wait 1; gs equip high_hp')
send_command('alias food input /item "Grape Daifuku +1" <me>')
send_command('alias mount input /mount Fenrir')
send_command('alias reequip gs c reequip;wait 1; input /lockstyle on') -- Hit alt+a
send_command('alias trust exec trust.txt')
send_command('alias pana input /item "Panacea" <me>')
send_command('alias jig input /ja "Spectral Jig" <me>')
send_command('equip(sets.idle[\'Regain\'],sets.movement)')

function file_unload()
    send_command('unbind @q')
	send_command('unbind @w')
	send_command('unbind @e')
	--send_command('lua u Skillchains')
	send_command('lua u Steps')
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
    add_to_chat (55, 'You are on '..('Dancer '):color(5)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
end
 
--Page, Book--
set_macros(1,19)
--Use the Lockstyle Number--
set_style(019)