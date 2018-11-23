include('Common')

function init() 
	sets.aftercast.idle = {
		head = 'Blood Mask',
		neck = 'Wiglen Gorget',
		lear = 'Ethereal Earring',
		hands = 'Serpentes Cuffs',
		lring = 'Paguroidea Ring',
		rring = 'Sheltered Ring',
		waist = 'Flume Belt',
		legs = 'Blood Cuisses',
	}

	sets.aftercast.engaged = {
		ammo = 'Hagneia Stone',
		head = 'Despair Helm',
		neck = 'Asperity Necklace',
		lear = 'Suppanomimi',
		rear = 'Brutal Earring',
		body = 'Espial Gambison',
		hands = 'Buremte Gloves',
		lring = 'Apate Ring',
		rring = 'Rajas Ring',
		back = 'Atheling Mantle',
		waist = 'Windbuffet Belt',
		legs = 'Taeon Tights',
		feet = 'Thereoid Greaves'
	}

	sets.precast.weaponskill = {
		neck = 'Fotia Gorget',
		lear = 'Moonshade Earring',
		waist = 'Fotia Belt'
	}
	
	sets.precast['ancient circle'] = {
		legs = 'Drachen Brais +1'
	}
	
	sets.precast.jump = {
		feet = 'Drachen Greaves'
	}
	
	sets.precast['high jump'] = {
		legs = 'Wyrm Brais',
		feet = 'Drachen Greaves'
	}
	
	sets.precast['spirit jump'] = {
		legs = 'Lancer\'s Cuissots +2',
		feet = 'Drachen Greaves'
	}
	
	sets.precast['soul jump'] = {
		legs = 'Lancer\'s Cuissots +2',
		feet = 'Lancer\'s Schynbalds +2'
	}
	
	sets.precast['spirit link'] = {
		hands = 'Lancer\'s Vambraces +2'
	}
	
	sets.decorations.aftercast.idle = {}
	sets.decorations.aftercast.engaged = {}
	
	sets.decorations.aftercast.idle.dt = {
		neck = 'Twilight Torque',
		lear = 'Ethereal Earring',
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
		waist = 'Flume Belt'
	}
	
	sets.decorations.aftercast.idle.pdt = set_combine(
		sets.decorations.aftercast.idle.dt, 
		{
			 neck = 'Wiglen Gorget'
		}
	)
end

function handle_conditionals(spell, timing, status)
	if T(spell.targets):equals(T{'Self'}) and buffactive.diffusion then
		equip(sets.precast.diffusion)
	end
end