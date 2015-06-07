Meteor.publish('pokemon', ()->
	return Pokemon.find({},{sorted: {id:1}})
)