UI.registerHelper('session', (input)->
	return Session.get(input)
)

UI.registerHelper('capitalize', (string)->
	console.log string
	# return string.charAt(0).toUpperCase() + string.slice(1)
)