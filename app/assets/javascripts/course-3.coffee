$ ->
  btns = $(".related-courses .listBar a")
  content = $(".partContent")
  content.first().show()
  btns.each (index) ->
    _this = $(@)
    _index = index
    _this.click ->
      $(@).addClass("btn-primary").parent().siblings().find("a").removeClass("btn-primary")
      content.eq(_index).slideDown().siblings(".partContent").slideUp()
      titleBars = content.eq(_index).find(".titleBar")
      if titleBars.length == 1
        content.eq(_index).find("ul").show()

$ ->
  $(".titleContent").click ->
    oUl = $(@).siblings("ul")
    oUl.slideToggle()
    $(@).find(".titleBar").toggleClass("up")