Template.pokeShow.helpers
  typeFormat: (types)->
    s = ""
    for t in types
      s += "<a href='/type/#{t}'>#{t.capitalize()}</a> "
    return s

  evolutionFormat: (evolutions)->
    s = ""
    for e in evolutions
      s += "<a href='/poke/#{e.id}'>#{e.name}</a>"
    return s

  padId: (id)->
    id = id.toString()
    return if id.length < 3 then self.Template.pokeShow.__helpers[" padId"]("0" + id) else id