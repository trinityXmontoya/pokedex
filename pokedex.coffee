if Meteor.isClient


  Template.shell.helpers counter: ->
    Session.get 'counter'
  Template.shell.events 'click button': ->
    # increment the counter when button is clicked
    Session.set 'counter', Session.get('counter') + 1

  Template.display.helpers counter: ->
    Session.get 'counter'
  Template.display.events 'click button': ->
    # increment the counter when button is clicked
    Session.set 'counter', Session.get('counter') + 1
    return

  Template.info.helpers counter: ->
    Session.get 'counter'
  Template.info.events
    'mousedown .arrow-key': (evt) ->
      $('#info-arrow-keys').css('margin','-9px 0')
    'mouseup .arrow-key, mouseout .arrow-key': (evt) ->
      $('#info-arrow-keys').css('margin','-11px 0')

if Meteor.isServer
  Meteor.startup ->
    # code to run on server at startup
    return