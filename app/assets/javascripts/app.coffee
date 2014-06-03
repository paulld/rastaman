$ ->
  $('input').on 'keyup', (e) ->
    input = $(@)
    id = input.attr("id")
    span = $("##{id}-text")
    if input.val().length > 0
      span.html "&larr; #{input.attr('placeholder')}"
    else
      span.html ""