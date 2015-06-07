UI.registerHelper('session', (input)->
	return Session.get(input)
)

String.prototype.capitalize = ()->
  return this.toLowerCase().replace( /\b\w/g, (m)->
    return m.toUpperCase();
  );