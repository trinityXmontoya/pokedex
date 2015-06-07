Meteor.startup ()->
	if Pokemon.find().count() == 0
		console.log 'none!'
		Pokemon.seedData()

Pokemon.seedData = ()->
	evId = (evUri)->
		return parseInt evUri.match(/(?:\/api\/v1\/pokemon\/)+(\d+)(?=\/)/)[1]

	descId = (descId)->
		return parseInt descId.match(/(?:\/api\/v1\/description\/)+(\d+)(?=\/)/)[1]

	scrape = (i)->
		HTTP.get("http://pokeapi.co/api/v1/pokemon/#{i}/", (err, data)->
			if data.statusCode is 200
				poke = JSON.parse(data.content)
				descriptionId = descId(poke.descriptions[0].resource_uri)
				HTTP.get("http://pokeapi.co/api/v1/description/#{descriptionId}/", (err2, data2)->
					if data2.statusCode is 200
						Pokemon.insert({
							id: poke.national_id
							name: poke.name
							types: poke.types.map (t)-> return t.name
							weight: poke.weight * .220462
							height: poke.height * .328084
							hp: poke.hp
							attack: poke.attack
							defense: poke.defense
							speed: poke.speed
							special_attack: poke.sp_atk
							special_defense: poke.sp_def
							evolutions: poke.evolutions.map (e)->
								return {
									lvl: e.level
									id: evId(e.resource_uri)
									name: e.to
								}
							description: JSON.parse(data2.content).description
						})
					else
						console.log 'uhoh spaghettio 2', err2
				)
			else
				console.log 'uhoh spaghettio', err
		)

	#only get the original 151
	scrape i for i in [1..151]