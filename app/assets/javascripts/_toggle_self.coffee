#首页，申报材料， 课程设置等切换效果
$ ->
  _list = $(".category-list a")
  _category = $(".category-list")
  _list_content = $(".category-list-content .text-content")
  _list.last().addClass("active public-active-style")
  _list_content.last().show()
  _list.first().removeClass("active public-active-style")
  _list_content.first().hide()
  _list.each (index) ->
    _this = $(this)
    _index = index
    _this.on 'click', ->
      _this.addClass("active public-active-style").siblings().removeClass("active public-active-style")
      _list_content.eq(_index).css("display","block").siblings().not("a").css("display","none");
      if _index is 0
        $(".fast-entry").show()
      else
        $(".fast-entry").hide()