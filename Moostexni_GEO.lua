include('Common')

function init()

	flags.skilling = false
	
	commands.skilling = function(arg)
		flags.skilling = setOrToggle(flags.skilling, arg)
	end
	
	sets.precast.magic = {
		head = 'Haruspex Hat',
		rear = 'Loquacious Earring',
		legs = 'Geomancy Pants',
		back = 'Swith Cape'
	}
	
	sets.precast.bolster = {
		body = 'Bagua Tunic'
	}
	
	sets.precast['radial arcana'] = {
		feet = 'Bagua Sandals'
	}
	
	sets.precast['elemental magic'] = {
		lear = 'Barkarole Earring',
		hands = 'Bagua Mitaines'
	}
	
	sets.precast['full circle'] = {
		head = 'Azimuth Hood',
		hands = 'Bagua Mitaines'
	}
	
	sets.precast['life cycle'] = {
		body = 'Geomancy Tunic'
	}
	
	sets.midcast.magic = {
		back = 'Ogapepo Cape'
	}
	
	sets.midcast.geomancy = {
		head = 'Azimuth Hood',
		body = 'Bagua Tunic',
		hands = 'Geomancy Mitaines'
	}
	
	sets.midcast.indicolure = {
		legs = 'Bagua Pants',
		feet = 'Azimuth Gaiters'
	}
	
	sets.midcast['elemental magic'] = {
		head = 'Geomancy Galero',
		lear = 'Barkarole Earring',
		rear = 'Friomisi Earring',
		body = 'Azimuth Coat',
		hands = 'Helios Gloves',
		lring = 'Perception Ring',
		rring = 'Acumen Ring',
		legs = 'Azimuth Tights',
		feet = 'Wayfarer Clogs'
	}
	
	sets.midcast['healing magic'] = {
		hands = 'Telchine Gloves',
		feet = 'Vanya Clogs'
	}
	
	sets.midcast['dark magic'] = {
		head = 'Bagua Galero',
		body = 'Geomancy Tunic',
		legs = 'Azimuth Tights'
	}
	
	sets.aftercast.idle = {
		head = 'Azimuth Hood',
		neck = 'Wiglen Gorget',
		lear = 'Ethereal Earring',
		body = 'Azimuth Coat',
		hands = 'Bagua Mitaines',
		lring = 'Paguroidea Ring',
		rring = 'Sheltered Ring',
		back = 'Cheviot Cape',
		legs = 'Telchine Braconi',
		feet = 'Geomancy Sandals'
	}
	
	sets.aftercast.idlepet = {
		head = 'Azimuth Hood',
		hands = 'Geomancy Mitaines',
		feet = 'Bagua Sandals'
	}
	
	sets.aftercast.engaged = {
		head = 'Espial Cap',
		rear = 'Brutal Earring',
		body = 'Espial Gambison',
		hands = 'Espial Bracers',
		rring = 'Rajas Ring',
		legs = 'Telchine Braconi',
		feet = 'Espial Socks'
	}
	
	sets.decorations.idle = {}
	
	sets.decorations.idle.refresh = {
		legs = 'Stearc Subligar',
		feet = 'Serpentes Sabots'
	}
end

function handle_conditionals(spell, timing, status)
	local spellName = string.lower(spell.english)
	if timing == 'precast' then
		
	elseif timing == 'midcast' then
		if string.sub(spellName, 1, 4) == 'indi' then
			vprint('Equipping sets.midcast.indicolure')
			equip(sets.midcast.indicolure)
		end
	elseif timing == 'aftercast' then
		local killsPet = T{'full circle', 'radial arcana', 'concentric pulse'}:contains(spellName)
		if status == 'idle' and (pet.isvalid or string.sub(spellName, 1, 3)  == 'geo') and not killsPet then
			vprint('Equipping sets.aftercast.idlepet')
			equip(sets.aftercast.idlepet)
		end
	end
end