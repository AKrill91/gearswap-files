include('Common')

function init()
	sets.aftercast.idle = {
		neck = 'Wiglen Gorget',
		lear = 'Ethereal Earring',
		lring = 'Paguroidea Ring',
		rring = 'Sheltered Ring',
		back = 'Cheviot Cape',
	}

	sets.aftercast.engaged = {
		head = 'Herculean Helm',
		neck = 'Asperity Necklace',
		lear = 'Suppanomimi',
		rear = 'Brutal Earring',
		body = 'Rawhide Vest',
		hands = 'Rawhide Gloves',
		lring = 'Epona\'s Ring',
		rring = 'Rajas Ring',
		back = 'Pantin Cape',
		waist = 'Windbuffet Belt',
		legs = 'Herculean Trousers',
		feet = 'Naga Kyahan'
	}

	sets.precast.weaponskill = {
		neck = 'Fotia Gorget',
		lear = 'Moonshade Earring',
		rear = 'Brutal Earring',
		lring = 'Epona\'s Ring',
		rring = 'Rajas Ring',
		waist = 'Fotia Belt'
	}
	
	sets.precast.maneuvers = {
		hands = 'Puppetry Dastanas +1'
	}
	
	sets.precast['dark maneuver'] = sets.precast.maneuvers
	sets.precast['earth maneuver'] = sets.precast.maneuvers
	sets.precast['fire maneuver'] = sets.precast.maneuvers
	sets.precast['ice maneuver'] = sets.precast.maneuvers
	sets.precast['light maneuver'] = sets.precast.maneuvers
	sets.precast['thunder maneuver'] = sets.precast.maneuvers
	sets.precast['water maneuver'] = sets.precast.maneuvers
	sets.precast['wind maneuver'] = sets.precast.maneuvers
	
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
		feet = 'Naga Kyahan'
	}
	
	sets.decorations.aftercast.idle.pdt = set_combine(
		sets.decorations.aftercast.idle.dt, 
		{
			 neck = 'Wiglen Gorget'
		}
	)
	
	sets.decorations.aftercast.engaged.acc = {
		neck = 'Decimus Torque',
		waist = 'Dynamic Belt'
	}
end

function handle_conditionals(spell, timing, status)
	if T(spell.targets):equals(T{'Self'}) and buffactive.diffusion then
		equip(sets.precast.diffusion)
	end
end