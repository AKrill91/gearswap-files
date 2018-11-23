include('Common')

function init()

	flags.skilling = false
	
	commands.skilling = function(arg)
		flags.skilling = setOrToggle(flags.skilling, arg)
	end
	
	sets.precast.magic = {
		main = 'Sucellus',
		head = 'Haruspex Hat',
		neck = 'Baetyl Pendant',
		rear = 'Loquacious Earring',
		rring = 'Weatherspoon Ring',
		back = 'Swith Cape',
		legs = 'Geomancy Pants',
		feet = 'Merlinic Crackows'
	}
	
	sets.precast.enhancing = set_combine(
		sets.precast.magic,
		{
			waist = 'Siegel Sash'
		}
	)
	
	sets.precast.bolster = {
		body = 'Bagua Tunic'
	}
	
	sets.precast['radial arcana'] = {
		feet = 'Bagua Sandals'
	}
	
	sets.precast['healing magic'] = {
		back = 'Disperser\'s Cape'
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
		neck = 'Deceiver\'s Torque',
		body = 'Bagua Tunic',
		hands = 'Geomancy Mitaines'
	}
	
	sets.midcast.indicolure = {
		legs = 'Bagua Pants',
		feet = 'Azimuth Gaiters'
	}
	
	sets.midcast['elemental magic'] = {
		main = 'Nibiru Cudgel',
		head = 'Jhakri Coronal +1',
		neck = 'Baetyl Pendant',
		lear = 'Barkarole Earring',
		rear = 'Friomisi Earring',
		body = 'Jhakri Robe +1',
		hands = 'Jhakri Cuffs +1',
		lring = 'Perception Ring',
		rring = 'Acumen Ring',
		legs = 'Jhakri Slops +1',
		feet = { 
			name = "Merlinic Crackows", 
			augments = {
				'MND+10',
				'AGI+2',
				'Magic burst mdg.+10%',
				'Mag. Acc.+19 "Mag.Atk.Bns."+19'
			}
		}
	}
	
	sets.midcast['healing magic'] = {
		hands = 'Telchine Gloves',
		feet = 'Vanya Clogs'
	}
	
	sets.midcast['dark magic'] = {
		main = 'Nibiru Cudgel',
		head = 'Bagua Galero',
		body = 'Geomancy Tunic',
		legs = 'Azimuth Tights',
		feet = 'Merlinic Crackows'
	}
	
	sets.midcast['stoneskin'] = {
		waist = 'Siegel Sash'
	}
	
	sets.aftercast.idle = {
		head = 'Jhakri Coronal +1',
		neck = 'Wiglen Gorget',
		lear = 'Ethereal Earring',
		body = 'Jhakri Robe +1',
		hands = 'Bagua Mitaines',
		lring = 'Paguroidea Ring',
		rring = 'Sheltered Ring',
		back = 'Cheviot Cape',
		legs = 'Assiduity Pants +1',
		feet = 'Geomancy Sandals'
	}
	
	sets.aftercast.idlepet = {
		main = 'Sucellus',
		head = 'Azimuth Hood',
		hands = 'Geomancy Mitaines',
		legs = 'Psycloth Lappas',
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
	
	sets.decorations.aftercast.idle = {}
	
	sets.decorations.aftercast.idle.refresh = {
		feet = 'Serpentes Sabots'
	}
	
	sets.decorations.aftercast.idle.pdt = {
		lring = { 
			name = "Dark Ring", 
			augments = {
				'Phys. dmg. taken -5%',
				'Magic dmg. taken -4%'
			}
		},
		rring = { 
			name = "Dark Ring", 
			augments = {
				'Magic dmg. taken -5%',
				'Phys. dmg. taken -4%'
			}
		},
		feet = 'Jhakri Pigaches +1'
	}
	
	sets.decorations.aftercast.idle.mdt = set_combine(
		sets.decorations.aftercast.idle.pdt,
		{
			neck = 'Twilight Torque'
		}
	)
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