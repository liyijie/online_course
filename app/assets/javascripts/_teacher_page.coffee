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


  #选择了任意一个专业或者课程才能进入下一步
  $('#scoreSearch :radio').click ->
  	$('#nextStep').removeAttr('disabled')

  #选择了任意一个班级则可以进入下一步，否则下一步disabled
  $('#selectGradeForm :checkbox').click ->
  	haveChecked = false
  	$('#selectGradeForm :checkbox').each ->
  	  if $(this).prop('checked') 
  	    haveChecked = true
  	if haveChecked
  	  $('#nextStep').removeAttr('disabled')
  	else
  	  $('#nextStep').prop('disabled',true)
