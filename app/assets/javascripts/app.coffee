$ ->
  $('.input-field').on 'keyup', (e) ->
    input       = $(@)
    id          = input.attr("id")
    placeholder = input.attr("placeholder")
    span        = $("##{id}-text")
    if input.val().length > 0
      span.html "&nbsp;&larr; #{placeholder}"
    else
      span.html ""