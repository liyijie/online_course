$ ->
  $(".info-teachers-content .teacher-content").each ->
    _this = $(@)
    _this.find("a").hover ->
      _this.find("p").fadeIn("fast")
      _this.siblings().find("p").fadeOut("fast")
$ ->
  $('#school-slide-content').bxCarousel({
    display_num: 4,
    move: 1,
    margin: 20
  });