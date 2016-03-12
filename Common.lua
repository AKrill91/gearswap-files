include('organizer-lib')

function setOrToggle(current, incoming)
	local output = not current
	if(incoming ~= nil) then
		output = incoming
	end
	
	return output
end

function vprint(str) 
	if flags.verbose then
		add_to_chat(str)
	end
end

function vprintset(set) 
	if flags.verbose then
		print_set(set)
	end
end

function init()

end

function get_sets()
	enable(
		'main', 
		'sub', 
		'range', 
		'ammo', 
		'head', 
		'neck', 
		'lear', 
		'rear', 
		'body', 
		'hands', 
		'lring', 
		'rring', 
		'back', 
		'waist', 
		'legs', 
		'feet'
	)

	flags = T{
		verbose = true
	}
	
	decorations = T{
		precast = T{},
		midcast = T{},
		aftercast = T{}
	}
	
	commands = {
		verbose = function(arg) flags.verbose = setOrToggle(flags.verbose, arg) end,
		update = update,
		status = function()
			local copy = flags:copy()
			for k, v in pairs(decorations) do
				local key = 'decorations_'..k
				for l, w in pairs(v) do
					copy[key..'_'..l] = '{'..w:concat(', ')..'}'
				end
			end
			print_set(copy)
		end,
		decorate = function(...) 
			if #arg >= 2 then
				local status = string.lower(arg[1])
				local spell = string.lower(arg[2])
				
				local decor = sets.decorations
				
				if decor[status] ~= nil and decor[status][spell] ~= nil then 
					vprint('Updating decorations.'..status..'.'..spell)
					--TODO consider append/prepend instead of replace?
					decorations[status][spell] = T(arg):slice(3)
					update()
				end
			end
		end
	}
	
	sets.precast = T{}
	sets.midcast = T{}
	sets.aftercast = T{}
	sets.decorations = T{
		precast = T{},
		midcast = T{},
		aftercast = T{}
	}
	
	init()
	
	send_command('gs org')
end

function update()
	if(not midaction()) then
		determine_gear(
			{
				english = 'status',
				skill = 'status',
				type = 'status',
				action_type = 'status'
			}, 
			'aftercast'
		)
	end
end

function precast(spell)
	local spellName = string.lower(spell.english)

	if(spellName == 'spectral jig' and buffactive.sneak) then
		cast_delay(0.2)
		send_command('cancel sneak')
	end

	determine_gear(spell, 'precast')
end

function midcast(spell)
	determine_gear(spell, 'midcast')
end

function aftercast(spell)
	determine_gear(spell, 'aftercast')
end

function status_change(new, old)
	update()
end

function determine_gear(spell, timing)
	if(sets[timing] == nil) then
		return
	end
	
	--Priority to apply equipment
	--e.g. magic -> blackmagic -> elementalmagic -> fire
	local priority = T{'action_type', 'type', 'skill', 'english'}
	local status = string.lower(player.status)
	
	vprint('Determining gear for {timing: '..timing..', status: '..status..'}')
	
	--First check for sets that apply regardless of spell
	if sets[timing][status] ~= nil then
		vprint('Equipping sets.'..timing..'.'..status)
		equip(sets[timing][status])
	end
	
	for i = 1, #priority do
		local setName = string.lower(spell[priority[i]])
		if sets[timing][setName] ~= nil then
			vprint('Equipping sets.'..timing..'.'..setName)
			equip(sets[timing][setName])
		end
	end
	
	--After primary gear check for decorations
	handle_decorations(spell, timing, status)
	
	--After decorations check for conditionals
	handle_conditionals(spell, timing, status)
end

function self_command(command)
	command = string.gsub(command, '%s+', ' ')
    words = T(command:split(' '))
	if(commands[words[1]] ~= nil) then
		local args = words:slice(2)
		commands[words[1]](unpack(args))
	else
		add_to_chat(8, 'unknown command \''..words[1]..'\'.')
	end
end

function handle_decorations(spell, timing, status)
	local priority = T{'action_type', 'type', 'skill', 'english'}
	local decor = decorations[timing]
	local decorSets = sets.decorations[timing]
	
	if decor ~= nil and decorSets ~= nil then
		if decor[status] ~= nil and decorSets[status] ~= nil then
			for key, value in pairs(decor[status]) do
				if decorSets[status][value] ~= nil then
					vprint('Equipping sets.decorations.'..timing..'.'..status..'.'..value)
					equip(decorSets[status][value])
				end
			end
		end
		
		for i = 1, #priority do
			local setName = spell[priority[i]]
			local spellDecor = decor[setName]
			local spellDecorSets = decorSets[setName]
			
			if spellDecor ~= nil and spellDecorSets ~= nil then
				for key, value in pairs(spellDecor) do
					if spellDecorSets[value] ~= nil then
						vprint('Equipping sets.decorations.'..timing..'.'..setName..'.'..value)
						equip(spellDecorSets[value])
					end
				end
			end
		end
	end
end

function handle_conditionals(spell, timing, status)

end