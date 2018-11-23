include('Common')

function init() 
	flags.learning = false
	
	commands.learning = function(arg) 
		flags.learning = setOrToggle(flags.learning, arg)
		if flags.learning then
			equip(sets.learning)
			disable(unpack(keys(sets.learning)))
		else
			enable(unpack(keys(sets.learning)))
			update()
		end
	end
	
	sets.swords = {
		main = {
			name = "Claidheamh Soluis", 
			augments = {
				'Accuracy+11 Attack+11', 
				'"Dbl.Atk."+2',
				'DEX+16'
			}
		},
		sub = {
			name = "Claidheamh Soluis", 
			augments = {
				'Accuracy+12',
				'DEX+17'
			}
		}
	}
	
	sets.clubs = {
		main = 'Nibiru Cudgel',
		sub = 'Eminent Wand'
	}

	sets.learning = {
		hands = 'Assimilator\'s Bazubands'
	}
	
	sets.precast.magic = {
		head = 'Haruspex Hat',
		neck = 'Baetyl Pendant',
		lear = 'Loquacious Earring',
		body = 'Luhlaza Jubbah',
		rring = 'Weatherspoon Ring',
		back = 'Swith Cape',
		legs = 'Homam Cosciales'
	}
	
	sets.cures = {
		head = 'Jhakri Coronal +1',
		neck = 'Noetic Torque',
		rear = 'Lifestorm Earring',
		body = 'Jhakri Robe +1',
		hands = 'Telchine Gloves',
		lring = 'Perception Ring',
		waist = 'Penitent\'s Rope',
		legs = 'Psycloth Lappas',
		feet = 'Jhakri Pigaches +1'
	}
	
	sets.midcast['magic fruit'] = sets.cures
	
	sets.skill = {
		head = 'Luhlaza Keffiyeh',
		neck = 'Deceiver\'s Torque',
		body = 'Assimilator\'s Jubbah +1',
		hands = 'Rawhide Gloves',
		back = 'Cornflower Cape',
		legs = 'Hashishin Tayt',
		feet = 'Luhlaza Charuqs'
	}
	
	sets.midcast.occultation = sets.skill
	
	sets.precast.bluemagic = set_combine(
		sets.precast.magic,
		{
			body = 'Hashishin Mintan'
		}
	)
	
	sets.precast['azure lore'] = {
		hands = 'Luhlaza Bazubands'
	}
	
	sets.precast.diffusion = {
		feet = 'Luhlaza Charuqs'
	}

	sets.aftercast.idle = {
		head = 'Blood Mask',
		neck = 'Wiglen Gorget',
		lear = 'Ethereal Earring',
		body = 'Jhakri Robe +1',
		hands = 'Serpentes Cuffs',
		lring = 'Paguroidea Ring',
		rring = 'Sheltered Ring',
		back = 'Cheviot Cape',
		waist = 'Flume Belt',
		legs = 'Blood Cuisses',
		feet = 'Serpentes Sabots'
	}

	sets.aftercast.engaged = {
		ammo = 'Honed Tathlum',
		head = 'Herculean Helm',
		neck = 'Asperity Necklace',
		lear = 'Suppanomimi',
		rear = 'Brutal Earring',
		body = 'Rawhide Vest',
		hands = 'Rawhide Gloves',
		lring = 'Epona\'s Ring',
		rring = 'Rajas Ring',
		back = 'Rosmerta\'s Cape',
		waist = 'Windbuffet Belt',
		legs = 'Herculean Trousers',
		feet = 'Taeon Boots'
	}

	sets.precast.weaponskill = {
		neck = 'Fotia Gorget',
		lear = 'Moonshade Earring',
		rear = 'Brutal Earring',
		lring = 'Epona\'s Ring',
		rring = 'Rajas Ring',
		waist = 'Fotia Belt'
	}

	sets.precast['savage blade'] = set_combine(
		sets.precast.weaponskill,
		{
			 lring = 'Rufescent Ring'
		}
	)

	sets.precast['chant du cygne'] = set_combine(
		sets.precast.weaponskill,
		{
			ammo = 'Jukukik Feather',
			head = 'Jhakri Coronal +1',
			hands = 'Jhakri Cuffs +1',
			feet = 'Thereoid Greaves'
		}
	)

	sets.precast.requiescat = set_combine(
		sets.precast.weaponskill, 
		{
			 lring = 'Rufescent Ring'
		}
	)
	
	macc = {
		head = 'Jhakri Coronal +1',
		neck = 'Noetic Torque',
		lear = 'Pensee Earring',
		rear = 'Hecate\'s Earring',
		body = 'Jhakri Robe +1',
		hands = 'Jhakri Cuffs +1',
		lring = 'Weatherspoon Ring',
		rring = 'Perception Ring',
		back = 'Cornflower Cape',
		waist = 'Penitent\'s Rope',
		legs = 'Jhakri Slops +1',
		feet = 'Jhakri Pigaches +1'
	}
	
	sets.macc = macc
	
	sets.midcast['blank gaze'] = macc
	sets.midcast['chaotic eye'] = macc
	sets.precast['sudden lunge'] = macc
	sets.precast['auroral drape'] = macc
	
	matk = {
		head = 'Jhakri Coronal +1',
		neck = 'Baetyl Pendant',
		lear = 'Friomisi Earring',
		rear = 'Hecate\'s Earring',
		body = 'Jhakri Robe +1',
		hands = 'Jhakri Cuffs +1',
		lring = 'Weatherspoon Ring',
		rring = 'Acumen Ring',
		back = 'Cornflower Cape',
		waist = 'Penitent\'s Rope',
		legs = 'Jhakri Slops +1',
		feet = 'Jhakri Pigaches +1'
	}
	
	sets.matk = matk

	sets.midcast.subduction = matk

	sets.precast['sanguine blade'] = matk
	sets.precast['flash nova'] = matk
	
	sets.midcast['blinding fulgor'] = matk
	sets.midcast['retinal glare'] = matk
	sets.midcast['magic hammer'] = matk
	sets.midcast.entomb = matk
	sets.midcast['spectral floe'] = matk
	sets.midcast.regurgitation = matk
	sets.midcast['anvil lightning'] = matk
	sets.midcast['magic hammer'] = matk
	sets.midcast['silent storm'] = matk
	sets.midcast['searing tempset'] = matk
	sets.midcast['tenebral crush'] = matk
	sets.midcast['charged whisker'] = matk
	
	sets.decorations.aftercast.idle = {}
	sets.decorations.aftercast.engaged = {}
	
	sets.decorations.aftercast.idle.refresh = {
		legs = 'Stearc Subligar'
	}
	
	sets.decorations.aftercast.idle.dt = {
		head = 'Herculean Helm',
		neck = 'Twilight Torque',
		lear = 'Ethereal Earring',
		hands = 'Taeon Gloves',
		lring = {
			name = "Dark Ring",
			augments = {
				'Phys. dmg. taken -5%',
				'Magic dmg. taken -4%'
			}
		},
		rring = {
			name="Dark Ring",
			augments = {
				'Magic dmg. taken -5%',
				'Phys. dmg. taken -4%'
			}
		},
		waist = 'Flume Belt',
		legs = 'Herculean Trousers',
		feet = 'Taeon Boots'
	}
	
	sets.decorations.aftercast.idle.pdt = set_combine(
		sets.decorations.aftercast.idle.dt, 
		{
			 neck = 'Wiglen Gorget'
		}
	)
	
	sets.decorations.aftercast.engaged.acc = {
		neck = 'Decimus Torque',
		waist = 'Dynamic Belt',
		feet = 'Jhakri Pigaches +1'
	}
end

function handle_conditionals(spell, timing, status)
	if T(spell.targets):equals(T{'Self'}) and buffactive.diffusion then
		equip(sets.precast.diffusion)
	end
end