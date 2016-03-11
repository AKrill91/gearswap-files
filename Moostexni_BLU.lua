include('Common')

function keys(t)
	local keys = {}
	local n = 0
	
	for k, v in pairs(t) do
		n = n + 1
		keys[n] = k
	end
	
	return keys
end

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

	sets.learning = {
		hands = 'Assimilator\'s Bazubands'
	}
	
	sets.precast.magic = {
		head = 'Haruspex Hat',
		lear = 'Loquacious Earring',
		body = 'Luhlaza Jubbah',
		back = 'Swith Cape',
	}
	
	sets.precast.bluemagic = set_combine(
		sets.precast.magic,
		{
			body = 'Mavi Mintan +2'
		}
	)
	
	sets.precast.diffusion = {
		feet = 'Luhlaza Charuqs'
	}

	sets.aftercast.idle = {
		head = 'Blood Mask',
		neck = 'Wiglen Gorget',
		lear = 'Ethereal Earring',
		body = 'Assimilator\'s Jubbah',
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
		head = 'Taeon Chapeau',
		neck = 'Asperity Necklace',
		lear = 'Suppanomimi',
		rear = 'Brutal Earring',
		body = 'Thaumas Coat',
		hands = 'Buremte Gloves',
		lring = 'Epona\'s Ring',
		rring = 'Rajas Ring',
		back = 'Atheling Mantle',
		waist = 'Windbuffet Belt',
		legs = 'Taeon Tights',
		feet = 'Taeon Boots'
	}

	sets.precast.weaponskill = {
		lear = 'Moonshade Earring',
		rear = 'Brutal Earring',
		body = 'Espial Gambison',
		lring = 'Epona\'s Ring',
		rring = 'Rajas Ring',
	}

	sets.precast['savage blade'] = set_combine(
		sets.precast.weaponskill,
		{
			neck = 'Soil Gorget',
			waist = 'Soil Belt'
		}
	)

	sets.precast['chant du cygne'] = set_combine(
		sets.precast.weaponskill,
		{
			head = 'Taeon Chapeau',
			neck = 'Light Gorget',
			hands = 'Taeon Gloves',
			waist = 'Light Belt',
			legs = 'Taeon Tights'
		}
	)

	sets.precast.requiescat = set_combine(
		sets.precast.weaponskill, 
		{
			neck = 'Soil Gorget',
			waist = 'Soil Belt',
			legs = 'Telchine Braconi',
		}
	)

	sets.midcast.subduction = {
		head = 'Assimilator\'s Keffiyeh',
		neck = 'Noetic Torque',
		lear = 'Friomisi Earring',
		rear = 'Hecate\'s Earring',
		body = 'Wayfarer Robe',
		hands = 'Helios Gloves',
		lring = 'Perception Ring',
		rring = 'Acumen Ring',
		back = 'Cornflower Cape',
		waist = 'Penitent\'s Rope',
		legs = 'Telchine Braconi',
		feet = 'Hashishin Basmak'
	}

	sets.precast['sanguine blade'] = sets.midcast.subduction
	sets.precast['flash nova'] = sets.midcast.subduction
	
	sets.midcast['blinding fulgor'] = sets.midcast.subduction
	sets.midcast['retinal glare'] = sets.midcast.subduction
	sets.midcast['magic hammer'] = sets.midcast.subduction
	sets.midcast.entomb = sets.midcast.subduction
	sets.midcast['spectral floe'] = sets.midcast.subduction
	
	sets.decorations.idle = {}
	sets.decorations.engaged = {}
	
	sets.decorations.idle.refresh = {
		legs = 'Stearc Subligar'
	}
	
	sets.decorations.idle.pdt = {
		head = 'Taeon Chapeau',
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
		legs = 'Taeon Tights',
		feet = 'Taeon Boots'
	}
	
	sets.decorations.engaged.acc = {
		body = 'Luhlaza Jubbah',
		waist = 'Anguinus Belt'
	}
end

function handle_conditionals(spell, timing, status)
	if T(spell.targets):equals(T{'Self'}) and buffactive.diffusion then
		equip(sets.precast.diffusion)
	end
end