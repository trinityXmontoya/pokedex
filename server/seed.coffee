Meteor.startup ()->
	if Pokemon.find().count() == 0
		Pokemon.seedData()
	# Meteor.publish('dbLoaded')

Pokemon.seedData = ()->
	evIdRegex = (evUri)->
		return parseInt evUri.match(/(?:\/api\/v1\/pokemon\/)+(\d+)(?=\/)/)[1]

	scrape = (i)->
		HTTP.get("http://pokeapi.co/api/v1/pokemon/#{i}/", (err,data)->
			if data.statusCode is 200
				poke = JSON.parse(data.content)
				console.log poke
				Pokemon.insert({
					id: poke.national_id
					name: poke.name
					types: poke.types.map (t)-> return t.name
					weight: poke.weight
					height: poke.height
					hp: poke.hp
					attack: poke.attack
					defense: poke.defense
					speed: poke.speed
					special_attack: poke.sp_atk
					special_defense: poke.sp_def
					evolutions: poke.evolutions.map (e)-> return {lvl: e.level, id: evIdRegex(e.resource_uri)}
				})
			else
				console.log 'uhoh spaghettio'
		)

	#only get the original 151
	scrape i for i in [1..151]