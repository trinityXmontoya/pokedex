Session.setDefault('currentPage','default')

Template.display.events
  'click #display-btn': ()->
    toggleAudio()

toggleAudio = ()->
  if Session.get('currentPage') == 'show'
      text = $('#info-header').text().replace("#","") +
             $('#info-screen').text().replace("Return To Pokemon Index", "")
      toggleSpeech(text)
  else if Session.get('currentPage') == 'types'
    text = "Welcome to the Pokemon Type Index " +
            "Select a type to see Pokemon belonging to that family." +
           $('#display-screen-content').text()
    toggleSpeech(text)
  else
    toggleMusic()

toggleSpeech = (text)->
  descAudio = $('#audio audio')[0]
  if descAudio
    if descAudio.paused
      descAudio.play()
    else
      descAudio.pause()
  else
    speak(text, {noWorker: true, speed: 160, pitch: 40 })

toggleMusic = ()->
  pokeSong = $('#pokemon-theme-song')[0]
  if pokeSong.paused
    pokeSong.play()
  else
    pokeSong.pause()

Template.pokeTypeIndex.helpers
  pokeTypes: ()->
    return Pokemon.typeOpts()

Template.displayScreenContent.helpers
  currentScreen: ()->
    page = Session.get('currentPage')
    switch page
      when 'default' then Template.defaultScreen
      when 'index' then Template.pokeIndex
      when 'show' then Template.pokeShow
      when 'typeShow' then Template.pokeType
      when 'types' then Template.pokeTypeIndex
      when 'about' then Template.about
      else Template.ErrScreen

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

Template.pokeType.helpers
  pokemon: ()->
    type = Session.get('currentType')
    return Pokemon.findByType(type)

Template.pokeIndex.helpers
  pokemon: ()->
    return Pokemon.find({}, {sort: {id: 1}} )

Template.info.events
  'mousedown .arrow-key': (evt) ->
    triggerArrowKeys('mousedown', evt)

  'mouseup .arrow-key, mouseout .arrow-key': (evt) ->
    triggerArrowKeys('mouseout', evt)

  triggerArrowKeys = (evtType, evt)->
    if evtType is 'mousedown'
      dir = $(evt.currentTarget).data('direction')
      screen = $('#display-screen-content')
      scroll = screen.scrollTop()
      switch dir
        when 'down'
          bx_shadow = '0px -2px 0 0 black'
          margin = '-9px 0'
          screen.scrollTop(scroll+80)
        when 'up'
          bx_shadow = '0px 3px 0 0 black'
          margin = '-12px 0'
          $('.arrow-key-center').css('margin-top', '26px')
          screen.scrollTop(scroll-80)
        when 'left'
          bx_shadow = '2px 0px 0 0 black'
          margin = '-11px -2px'
          showPokemon('prev')
        when 'right'
          bx_shadow = '-2px 0px 0 0 black'
          margin = '-11px 2px'
          showPokemon('nxt')

      $('.arrow-key').css('box-shadow', bx_shadow)
      $('#info-arrow-keys').css('margin', margin)
    else if evtType is 'mouseout'
      $('.arrow-key').css('box-shadow','')
      $('#info-arrow-keys').css('margin','')
      $('.arrow-key-center').css('margin', '')

  showPokemon = (dir)->
    if Session.get('currentPage') =='show'
      id = Session.get('currentPokemon').id
      if dir == 'prev'
        if id == 1 then id = 151 else id -= 1
      else if dir == 'nxt'
        if id == 151 then id = 1 else id += 1
      Router.go("/poke/#{id}")

Template.info.helpers
  currentPage: ()->
    page = Session.get('currentPage')
    poke = Session.get('currentPokemon')
    type = Session.get('currentType')
    switch page
      when 'default'
        {
          title: 'Welcome To The Pokedex'
          desc: '
            <a href="/index">Pokemon Index</a>
            <br>
            <a href="/types">Type Index</a>
          '
        }
      when 'index'
        {
          title: "Complete Pokemon Index"
          desc: "Select a Pokemon to view its Stats and hear its description."
        }
      when 'show'
        {
          title: "##{poke.id} #{poke.name}"
          desc: "
            #{poke.description}
            <br>
            <a href='/index'>Return To Pokemon Index</a>
          "
        }
      when 'typeShow'
        {
          title: "#{type} POKEMON"
          desc: "
            Scroll down to see more.
            <br>
            <a href='/types'>Return to the Type Index.</a>
          "
        }
      when 'types'
        {
          title: 'Pokemon Type Index'
          desc: 'Select a type to see Pokemon belonging to that family.'
        }
      when 'about'
        {
          title: 'About & Credits'
          desc: "
            TTS: <a href='https://github.com/mattytemple/speak-js'>Speak-js</a>
            <br>
            Pokemon data: <a href='http://pokeapi.co/'>Pokéapi</a>
            <br>
            Pokemon stat images: <a href='http://www.pokemon.com/us/pokedex/'>Pokemon.com</a>
          "
        }
      else
        {
          title: '404'
          desc: "Probably not what you were looking for. <a href='/'>Return Home</a>"
        }