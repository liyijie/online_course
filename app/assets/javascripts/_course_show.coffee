#展开效果
_drop_down = ->
  oLenght = $(".courses__show .courses-list li").length
  liHeight = $(".courses__show .courses-list li").height() + 3 + 'px'
  oHeight = oLenght * liHeight
  if(oLenght <= 4)
    $(".courses__show .courses-list").css("height", oHeight)
    $(".courses__show .drop-down-arrow").css("display","none")
  else
    $(".courses__show .courses-list").css("height", "200px")
  $(".drop-down-arrow").on 'click', ->
    if($(".courses__show .courses-list").height() == 200)
      $(".courses__show .related-courses .courses-list").css("height","auto")
      $(".courses__show .drop-down-arrow").text("收起").addClass("slide-up")
    else
      $(".courses__show .related-courses .courses-list").css("height","200px")
      $(".courses__show .drop-down-arrow").text("展开").removeClass("slide-up")

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

  $(".course-content-step-nav").click ->
    #将点击的菜单选中
    $(".course-content-step-nav").removeClass("btn-primary by-btn-bg")
    $(this).addClass("btn-primary by-btn-bg")
    #显示对应的内容
    $(".course-content-step-div").hide()
    $(".course-content-step-div").eq($(this).index()).show()

    
  $(".course-content-method-nav").click ->
    #将点击的菜单选中
    $(".course-content-method-nav").removeClass("btn-primary by-btn-bg")
    $(this).addClass("btn-primary by-btn-bg")
    #显示对应的内容
    $(".course-content-method-div").hide()
    $(".course-content-method-div").eq($(this).index()).show()

  $(".course-content-nav").click ->
    #将点击的菜单选中
    $(".course-content-nav").removeClass("btn-primary by-btn-bg")
    $(this).addClass("btn-primary by-btn-bg")
    #显示对应的内容
    $(".course-content-div").hide()
    $(".course-content-div").eq($(this).index()).show()

  $(".course-content-effect-nav").click ->
    #将点击的菜单选中
    $(".course-content-effect-nav").removeClass("btn-primary by-btn-bg")
    $(this).addClass("btn-primary by-btn-bg")
    #显示对应的内容
    $(".course-content-effect-div").hide()
    $(".course-content-effect-div").eq($(this).index()).show()
    
  $(".course-content-condition-nav").click ->
    #将点击的菜单选中
    $(".course-content-condition-nav").removeClass("btn-primary by-btn-bg")
    $(this).addClass("btn-primary by-btn-bg")
    #显示对应的内容
    $(".course-content-condition-div").hide()
    $(".course-content-condition-div").eq($(this).index()).show()

  $(".course-content-policy-nav").click ->
    #将点击的菜单选中
    $(".course-content-policy-nav").removeClass("btn-primary by-btn-bg")
    $(this).addClass("btn-primary by-btn-bg")
    #显示对应的内容
    $(".course-content-policy-div").hide()
    $(".course-content-policy-div").eq($(this).index()).show()

  $(".fast-entry-links a").click ->
    $(".entry-content").hide()
    $(".entry-content").eq($(this).index()).show()

  $("#teamwork a").each (index) ->
    _this = $(@)
    _this.click ->
      $(@).addClass("btn-primary by-btn-bg").siblings().removeClass("btn-primary by-btn-bg");
      $("#teamworkContent .teamwork").eq(index).css("display", "block").siblings().css("display", "none")
