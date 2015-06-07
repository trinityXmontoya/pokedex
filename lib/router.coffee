Router
.map ()->
	this.route('/', ()->
		Session.set('currentPage', 'default')
	)
	this.route('/poke/:id', ()->
		this.wait(Meteor.subscribe('pokemon'))
		if this.ready()
			poke = Pokemon.findOne({id: parseInt(this.params.id)})
			Session.set('currentPokemon', poke)
			Session.set('currentPage','show')
		else
			console.log 'waitin'
	)
	this.route('/:route', ()->
		this.wait(Meteor.subscribe('pokemon'))
		if this.ready()
			Session.set('currentPage', this.params.route)
	)
