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
		verbose = false
	}
	
	decorations = T{}
	
	commands = {
		verbose = function(arg) flags.verbose = setOrToggle(flags.verbose, arg) end,
		update = update,
		status = function()
			local copy = flags:copy()
			for k,v in pairs(decorations) do
				copy[k] = '{'..v:concat(', ')..'}'
			end
			print_set(copy)
		end,
		decorate = function(...) 
			--TODO consider append/prepend instead of replace?
			decorations[arg[1]] = T(arg):slice(2)
			update()
		end
	}
	
	sets.precast = T{}
	sets.midcast = T{}
	sets.aftercast = T{}
	sets.decorations = T{}
	
	init()
	
	update()
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
	
	local status = string.lower(player.status)
	
	vprint('Determining gear for {timing: '..timing..', status: '..status..'}')
	
	--First check for sets that apply regardless of spell
	if sets[timing][status] ~= nil then
		vprint('Equipping sets.'..timing..'.'..status)
		equip(sets[timing][status])
	end
	
	--Priority to apply equipment
	--e.g. magic -> blackmagic -> elementalmagic -> fire
	local priority = T{'action_type', 'type', 'skill', 'english'}
	
	for i = 1, #priority do
		local setName = string.lower(spell[priority[i]])
		if sets[timing][setName] ~= nil then
			vprint('Equipping sets.'..timing..'.'..setName)
			equip(sets[timing][setName])
		end
	end
	
	priority = priority:reverse()
	
	for i = 1, #priority do
		local setName = string.lower(spell[priority[i]])
		local decor = decorations[setName]
		if decor ~= nil and sets.decorations[setName] ~= nil then
			for key, value in pairs(decor) do
				vprint('Equipping sets.decorations.'..setName..'.'..value)
				equip(sets.decorations[setName][value])
			end
		end
	end
	
	handle_conditionals(spell, timing, status)
end

function self_command(command)
    words = T(command:split(' '))
	if(commands[words[1]] ~= nil) then
		local args = words:slice(2)
		commands[words[1]](unpack(args))
	else
		add_to_chat(8, 'unknown command \''..words[1]..'\'.')
	end
end

function handle_conditionals(spell, timing, status)

end