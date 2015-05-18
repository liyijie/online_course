#首页，申报材料， 课程设置等切换效果
_category_toggle = ->
  _list = $(".category-list a")
  _list_content = $(".category-list-content .text-content")
  _list_content.first().css("display","block")
  _list.each (index) ->
    _this = $(this);
    _index = index;
    _this.hover ->
      _this.addClass("active public-active-style").siblings().removeClass("active public-active-style")
      _list_content.eq(_index).css("display","block").siblings().not("a").css("display","none");
#展开效果
_drop_down = ->
  $(".drop-down-arrow").on 'click', ->
    $(".related-courses .courses-list").css("height","auto")

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