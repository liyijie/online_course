$ ->
  $("#subCourseCollectPraise a").click ->
    $("#scope").val($(this).attr("scope"))  
    $("#subCourseCollectPraise").submit()