Template.pokeType.helpers
  pokemon: ()->
    type = Session.get('currentType')
    return Pokemon.findByType(type)