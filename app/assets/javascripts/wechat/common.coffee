$ ->
  'use strict'

  $(document).on 'pageInit', (e, id, page) ->
    # toast提示
    $(".notice").each (index)->
      notice = $(this).data("notice").trim()
      if notice
        $.toast notice
    return
  $.init()



  return