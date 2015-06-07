if Meteor.isClient

  # Template.pokeIndex.onCreated ()->
  #   this.subscribe("pokemon")

  Session.setDefault('currentPage','default')

  Template.display.events
    'click #display-btn': ()->
      toggleMusic()

  toggleMusic = ()->
    pokeSong = document.getElementById('pokemon-theme-song')
    if pokeSong.paused
      pokeSong.play()
    else
      pokeSong.pause()

  Template.displayScreenContent.helpers
    currentScreen: ()->
      page = Session.get('currentPage')
      switch page
        when 'default' then Template.defaultScreen
        when 'index' then Template.pokeIndex
        when 'show' then Template.pokeShow
        else Template.ErrScreen

  Template.pokeShow.rendered = ()->
    console.log Session.get('currentPokemon')
  #     # id = Session.get('currentPokeId')
  #     # console.log id
  #     Session.set('currentPokemon',Pokemon.findOne({id: id}))
  #     console.log Session.get('currentPokemon'), "here"
  # Template.pokeShow.helpers
  #   currentPokemon: ()-> Session.get('currentPokemon')
    # pokeShow: ()->


  Template.pokeIndex.helpers
    pokemon: ()->
      return Pokemon.find({}, {sort: {id: 1}} )

  Template.info.events
    'mousedown .arrow-key': (evt) ->
      $('#info-arrow-keys').css('margin','-9px 0')
    'mouseup .arrow-key, mouseout .arrow-key': (evt) ->
      $('#info-arrow-keys').css('margin','-11px 0')

  Template.info.helpers
    currentPage: ()->
      page = Session.get('currentPage')
      poke = Session.get('currentPokemon')
      switch page
        when 'default'
          {
            title: 'Welcome To The Pokedex'
            desc: '
              <a href="/index">Pokemon Index</a>
              <br>
              <a href="/types">Type Index</a>
              <br>
              <a href="/battle">Battle</a>
            '
          }
        when 'index'
          {
            title: "Complete Pokemon Index"
            desc: "Select a Pokemon to view its Stats."
          }
        when 'show'
          {
            title: "##{poke.id} #{poke.name}"
            desc: "
            TYPE: #{poke.types}
            <br>
            <a href='/index'>Return To Pokemon Index</a>
            "
          }
        when 'battle'
          {
            title: "Battle Royale"
            desc: "Please choose your trainer to send into battle."
          }
        when 'dogs'
          {
            title: "dogs"
            desc: "we made it!!!"
          }
        else
          {
            title: '404'
            desc: '<a href="/">Return Home</a>'
          }