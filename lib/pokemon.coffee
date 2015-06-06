@Pokemon = new Mongo.Collection("pokemon")



	# add = (poke)->
	# 	console.log poke.name

	# HTTP.get("http://pokeapi.co/api/v1/pokedex/1/", (err,data)->
	# 	if err
	# 		console.log 'uhoh'
	# 	else if data
	# 		pokemon = JSON.parse(data.content).pokemon
	# 		add poke for poke in pokemon
	# )