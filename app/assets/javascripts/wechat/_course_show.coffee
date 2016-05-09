   #点击收藏按钮
  $("#courseCollectBtn").click ->
    $("#courseCollectPraise").attr("action",course_collect_wechat_path)
    $("#courseCollectPraise").submit()