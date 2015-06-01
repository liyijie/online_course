$(".teachers__index").ready ->
  $(".teachers-list li").each ->
    _this = $(@)
    _this.find("a").hover ->
      _this.find("p").fadeIn("fast")
      _this.siblings().find("p").fadeOut("fast")