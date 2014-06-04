$ ->
  $('.form-key-up').on 'keyup', (e) ->
    input       = $(@)
    id          = input.attr("id")
    placeholder = input.attr("placeholder")
    span        = $("##{id}-text")
    if input.val().length > 0
      span.html "&larr; #{placeholder}"
      # span.html "&larr; ok"
    else
      span.html ""