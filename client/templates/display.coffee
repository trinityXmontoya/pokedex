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