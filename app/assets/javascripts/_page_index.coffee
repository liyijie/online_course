$ ->
  $(".info-teachers-content .teacher-content").each ->
    _this = $(@)
    _this.find("a").hover ->
      _this.find("p").fadeIn("fast")
      _this.siblings().find("p").fadeOut("fast")
$ ->
  $('#xc-carousel').responsiveCarousel({
    carousel_item_width_default: .20
  })