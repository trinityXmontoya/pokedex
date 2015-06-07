Meteor.publish('pokemon', ()->
	return Pokemon.find({},{sorted: {id:1}})
)

Meteor.publish('pokeReady', (id)->
	return Pokemon.find({id: id})
)

Meteor.publish('pokeType', (type)->
	return Pokemon.find({types: type})
)