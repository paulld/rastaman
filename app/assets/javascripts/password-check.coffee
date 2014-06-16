$ ->

  MINIMUM_SCORE = 2

  glyphiconOk = ->
    $('#password-match').removeClass('glyphicon-remove password-match-no')
    $('#password-match').addClass('glyphicon-ok password-match-ok')
  glyphiconNo = ->
    $('#password-match').addClass('glyphicon-remove password-match-no')
    $('#password-match').removeClass('glyphicon-ok password-match-ok')
  glyphiconRemove = ->
    $('#password-match').removeClass('glyphicon-ok password-match-ok glyphicon-remove password-match-no')
  
  resetProgressBar = (idx) ->
    idx.removeClass('progress-bar-success')
    idx.removeClass('progress-bar-warning')
    idx.removeClass('progress-bar-info')
    idx.removeClass('progress-bar-danger')
    
  checkPasswordStrength = ->
    if zxcvbn?
      pass = $('#password').val()
      
      timeToCrack = zxcvbn(pass).crack_time_display
      score = zxcvbn(pass).score
      strength = score * 25
      progressBar = $('#password-strengh-bar')
      
      $('#password-crack-time').html timeToCrack
      progressBar.css('width', strength + '%')

      switch score
        when 2
          resetProgressBar(progressBar)
          progressBar.addClass('progress-bar-success')
        when 3
          resetProgressBar(progressBar)
          progressBar.addClass('progress-bar-warning')
        when 4
          resetProgressBar(progressBar)
          progressBar.addClass('progress-bar-danger')
        else
          resetProgressBar(progressBar)
          progressBar.addClass('progress-bar-info')

      if score >= MINIMUM_SCORE then true else false

  checkMatch = ->
    $('#password').val() is $('#password-confirmation').val()
  
  confirmationEmpty = ->
    $('#password-confirmation').val() is ""

  disableSubmit = ->
    $('#submit-password').attr('disabled', true)
  enableSubmit = ->
    $('#submit-password').attr('disabled', false)

  $('#password').keyup ->
    checkPasswordStrength()

  $('.input-field').keyup ->
    if confirmationEmpty()
      glyphiconRemove()
    else if checkMatch()
      glyphiconOk()
    else
      glyphiconNo()
    
    if checkMatch() and checkPasswordStrength()
      enableSubmit()
    else
      disableSubmit()

