Template.pokeIndex.helpers
  pokemon: ()->
    return Pokemon.find({}, {sort: {id: 1}} )