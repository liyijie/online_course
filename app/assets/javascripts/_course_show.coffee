#首页，申报材料， 课程设置等切换效果
_category_toggle = ->
  _list = $(".category-list a")
  _list_content = $(".category-list-content .text-content")
  _list_content.first().css("display","block")
  _list.each (index) ->
    _this = $(this);
    _index = index;
    _this.on 'click', ->
      _this.addClass("active public-active-style").siblings().removeClass("active public-active-style")
      _list_content.eq(_index).css("display","block").siblings().not("a").css("display","none");

#展开效果
_drop_down = ->
  oLenght = $(".courses-list li").length
  liHeight = $(".courses-list li").height() + 3 + 'px'
  oHeight = oLenght * liHeight
  if(oLenght <= 4)
    $(".courses-list").css("height", oHeight)
    $(".drop-down-arrow").css("display","none")
  else
    $(".courses-list").css("height", "200px")
  $(".drop-down-arrow").on 'click', ->
    if($(".courses-list").height() == 200)
      $(".related-courses .courses-list").css("height","auto")
      $(".drop-down-arrow").text("收起").addClass("slide-up")
    else
      $(".related-courses .courses-list").css("height","200px")
      $(".drop-down-arrow").text("展开").removeClass("slide-up")

#只有首页存在的最低部切换效果
_entry_toggle_btn = ->
  _entry_content = $(".fast-entry-content .entry-content")
  _entry_links = $(".fast-entry .fast-entry-links a")
  _entry_content.first().css("display","block")
  _entry_links.first().removeClass("btn-default").addClass("btn-primary");
  _entry_links.each (index) ->
    _this = $(this);
    _index = index;
    _this.on 'click', ->
      _this.removeClass("btn-default").addClass("btn-primary")
      _this.siblings().addClass("btn-default").removeClass("btn-primary")
      _entry_content.eq(index).show().siblings().hide()




$(".courses__show").ready ->
  _drop_down()
  _category_toggle()
  _entry_toggle_btn()

  
  #点击收藏按钮
  $("#courseCollectBtn").click ->
    $("#courseCollectPraise").attr("action",course_collect_path)
    $("#courseCollectPraise").submit()

  #鼠标移入收藏按钮
  $("#courseCollectBtn").mouseenter ->
    collect_str = ""
    if $("#collectFont").attr("iscollect") is "true"
      collect_str = "取消"
    else
      collect_str = "收藏"
    $("#collectFont").text(collect_str)

  #鼠标移出收藏按钮
  $("#courseCollectBtn").mouseleave ->
    count = $("#collectFont").attr("count")
    $("#collectFont").text(count)  

  #点击赞按钮
  $("#coursePraiseBtn").click ->
    $("#courseCollectPraise").attr("action",course_praise_path)
    $("#courseCollectPraise").submit()

  #鼠标移入赞按钮
  $("#coursePraiseBtn").mouseenter ->
    praise_str = ""
    if $("#praiseFont").attr("ispraise") is "true"
      praise_str = "取消"
    else
      praise_str = "赞"
    $("#praiseFont").text(praise_str)

  #鼠标移出赞按钮
  $("#coursePraiseBtn").mouseleave ->
    count = $("#praiseFont").attr("count")
    $("#praiseFont").text(count)  
