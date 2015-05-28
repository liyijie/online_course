$(".home__index").ready ->
  $(".info-teachers-content .teacher-content").each ->
    _this = $(@)
    _this.find("a").hover ->
      _this.find("p").fadeIn("fast")
      _this.siblings().find("p").fadeOut("fast")
$(".home__index").ready ->
  $('#xc-carousel').responsiveCarousel({
    carousel_item_width_default: .20
  })

# $(".home__index").ready ->
# 	$(".department-tabs span.tab-select-span").each ->
# 		_this = $(this)
# 		_this.click ->
# 			_this.find("a").addClass("active")
# 			_this.siblings().find("a").removeClass("active")
#       $(".department-tabs span:eq(0) a").removeClass("factive")