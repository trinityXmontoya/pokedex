Template.controlPanel.events
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

Template.controlPanel.helpers
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
            <br>
            <a href="/about">About</a>
          '
        }
      when 'index'
        {
          title: "Complete Pokemon Index"
          desc: "Select a Pokemon to view its Stats and read its description."
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
