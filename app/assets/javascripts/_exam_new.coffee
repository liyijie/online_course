_init_exam = ->
  #默认禁止提交
  $(".js-submit-btn").attr("disabled", true)
  #运行提交按钮操作
  al_click = ->
    $(".js-submit-btn").attr("disabled", false)
  #禁止提交按钮样式和事件
  pr_click = ->
    $(".js-submit-btn").attr("disabled", true)
    $(".js-submit-btn").click ->
      return false
  #点击开始考试按钮
  $(".js-start-answer-question").click ->
    al_click()  #记时开始允许提交
    minutes = 60  #初始化时间为60
    dataStart = new Date()
    dataEnd = new Date( dataStart )
    dataEnd.setMinutes( dataStart.getMinutes() + minutes )
    $('#countdown').countdown(  #创建倒计时
      dataEnd,
      (event) ->
        $(this).html(event.strftime('%H:%M:%S'))
      )
    $(".js-start-answer-question").attr("disabled", true)
    setTimeout(pr_click, minutes*60*1000)  #超出考试时间禁止提交按钮
  $("input[type='radio']").each ->
    _this = $(this)
    _this.click ->
      _this.attr("checked", true)
      num = $("input[type='radio']:checked").length
      questionNum = $(".question-content p.title").length   #全部题目数目
      $(".already-reply-questions").text(num)               #已答题目数目
      $(".yet-reply-questions").text(questionNum - num)     #未答题目数目

#回到顶部
_back_to_top = ->
  _back = $("#back-to-top")
  $(window).scroll ->
    if ($(window).scrollTop()>100)
      _back.fadeIn(500)
    else
      _back.fadeOut(500)
  _back.click ->
    $('body,html').animate({scrollTop:0},1000)
    return false

$(".exams__new").ready ->
  _init_exam();
  _back_to_top();