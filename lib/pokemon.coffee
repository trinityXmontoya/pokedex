@Pokemon = new Mongo.Collection("pokemon")


Pokemon.findByType = (type)->
	return Pokemon.find(
		{types: type},
		{
			sort: {id: 1}
			fields: {id: 1, name: 1}
		}
	)