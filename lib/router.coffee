Router
.map ()->
	this.route('/', ()->
		Session.set('currentPage', 'default')
	)
	this.route('/:route', (a,b)->
		Session.set('currentPage', this.params.route)
	)
	# this.route('/dogs', ()->
	# 	Session.set('currentPage', 'dogs')
	# )
