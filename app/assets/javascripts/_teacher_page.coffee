#教师介绍内容切换效果
$ ->
    _info = $(".teacher-info-content .infos")
    _info.first().css("display","block")
    $(".teacher-content a").each (index) ->
      _this = $(this)
      _index = index
      _this.on 'click', ->
        _this.addClass("by-btn-bg").siblings().removeClass("by-btn-bg")
        _info.eq(_index).css("display","block").siblings().css("display","none")