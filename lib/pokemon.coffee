@Pokemon = new Mongo.Collection("pokemon")

Pokemon.findByType = (type)->
	return Pokemon.find(
		{types: type},
		{
			sort: {id: 1}
			fields: {id: 1, name: 1}
		}
	)

Pokemon.typeOpts = ()->
	return ["poison", "grass", "fire", "flying", "water", "bug",
					"normal", "electric", "ground", "fairy", "psychic",
					"dragon", "ice", "fighting", "rock", "steel"]
