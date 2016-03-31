Diymenu.destroy_all

Diymenu.create!([{
  id: 1, parent_id: nil, name: '课程中心', key: '', url: '', is_show: true, sort: 0
},{
  id: 2, parent_id: 1, name: '学习中心', key: '', url: 'http://112.124.97.145/learning_center', is_show: true, sort: 2
},{
  id: 3, parent_id: 1, name: '已收藏课程', key: '已收藏课程', url: 'http://112.124.97.145/learning_center', is_show: true, sort: 1
},{
  id: 4, parent_id: nil, name: '讨论中心', key: '', url: '', is_show: true, sort: 1
},{
  id: 5, parent_id: 4, name: '创新创意论坛', key: '', url: 'http://112.124.97.145/discusses/innovations', is_show: true, sort: 3
},{
  id: 6, parent_id: 4, name: '课程学习讨论', key: '', url: 'http://112.124.97.145/discusses/learns', is_show: true, sort: 2
},{
  id: 7, parent_id: 4, name: '专业人才培养校企论坛', key: '', url: 'http://112.124.97.145/discusses', is_show: true, sort: 1
},{
  id: 8, parent_id: nil, name: '个人中心', key: '', url: '', is_show: true, sort: 2
},{
  id: 9, parent_id: 8, name: '修改密码', key: '', url: 'http://112.124.97.145/user', is_show: true, sort: 4
},{
  id: 10, parent_id: 8, name: '个人资料', key: '', url: 'http://112.124.97.145/user', is_show: true, sort: 3
},{
  id: 11, parent_id: 8, name: '我的问答', key: '', url: 'http://112.124.97.145/user/my_questions', is_show: true, sort: 2
},{
  id: 12, parent_id: 8, name: '我的测试', key: '', url: 'http://112.124.97.145/user/my_exams', is_show: true, sort: 1
}])