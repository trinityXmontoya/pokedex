Router
.map ()->
	this.route('/', ()->
		Session.set('currentPage', 'default')
	)
	this.route('/:route', ()->
		Session.set('currentPage', this.params.route)
	)
