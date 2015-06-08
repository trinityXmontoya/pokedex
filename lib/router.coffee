Router.onBeforeAction ()->
	$('#audio audio').remove()
	$('#pokemon-theme-song')[0].pause()
	this.next()

Router
.map ()->
	this.route('/', ()->
		Session.set('currentPage', 'default')
	)
	this.route('/poke/:id', ()->
		id = parseInt(this.params.id)

		if id not in [1..151]
			Session.set('currentPage','404')
			this.next()
		else
			this.wait(Meteor.subscribe('pokeReady', id))
			if this.ready()
				poke = Pokemon.findOne({id: id})
				Session.set('currentPokemon', poke)
				Session.set('currentPage','show')
				this.next()
	)
	this.route('/type/:type', ()->
		type = this.params.type

		if type not in Pokemon.typeOpts()
			Session.set('currentPage','404')
			this.next()
		else
			this.wait(Meteor.subscribe('pokeType', type))
			if this.ready()
				Session.set('currentType', type)
				Session.set('currentPage', 'typeShow')
				this.next()
	)
	this.route('/:route', ()->
		this.wait(Meteor.subscribe('pokemon'))
		if this.ready()
			Session.set('currentPage', this.params.route)
			this.next()
	)
