$ ->
  $(".show-content li").click ->
  	#将点击的菜单选中
    $(".show-content li").removeAttr("class")
    $(this).attr("class","active")
    #显示对应的内容
    $(".div-content").hide()
    $(".div-content").eq($(this).index()).show()