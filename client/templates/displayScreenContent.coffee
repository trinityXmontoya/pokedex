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