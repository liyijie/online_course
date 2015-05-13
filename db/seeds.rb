# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
begin
	School.create!({
			name: '上海工商职业技术学院'
		})

	Academy.create!([{name: '珠宝系', school_id: 1},
		{name: '艺术设计系', school_id: 1},
		{name: '汽车工程系', school_id: 1},
		{name: '应用外语系', school_id: 1},
		{name: '机电工程系', school_id: 1},
		{name: '商务管理系', school_id: 1},
		{name: '计算机系', school_id: 1},
		{name: '基础系', school_id: 1},
		{name: '继续教育系', school_id: 1},
		{name: '餐饮服务系', school_id: 1}])

	Grade.create!([{name: '2015级计算机（1）班', academy_id: 7},
			{name: '2015级计算机（2）班', academy_id: 7}])

	User.create!([{
			phone: '13600001111',
			username: 'dtby', 
			password: 'dtby123456', 
			password_confirmation: 'dtby123456',
			name: '唐邦彦',
			number: '20154802001',
			grade_id: 1
		},{
			phone: '13600002222',
			username: 'dtby', 
			password: 'dtby123456', 
			password_confirmation: 'dtby123456',
			name: '唐邦彦2号',
			number: '20154802002',
			grade_id: 1,
		}])

	Teacher.create!([{
			phone: '18800001111',
			username: 'dtby', 
			password: 'dtby123456', 
			password_confirmation: 'dtby123456',
			name: '钱红',
			birthday: '1981-08',
			tec_position: '讲师',
			email: 'ianhongq@aliyun.com',
			qualification: '高级教师资格 信息安全师（高级）',
			fax: '',
			final_education: '本科',
			final_degree: '硕士',
			tec_expertise: 'C语言基础、java变成基础、数据库安全与设计',
			resume: ''
		},{
			phone: '18800002222',
			username: 'dtby', 
			password: 'dtby123456', 
			password_confirmation: 'dtby123456',
			name: '赵红',
			birthday: '1988-08',
			tec_position: '教授',
			email: 'zha0hongq@aliyun.com',
			qualification: '高级教师资格 信息安全师（高级）',
			fax: '',
			final_education: '本科',
			final_degree: '硕士',
			tec_expertise: 'C语言基础、java变成基础、数据库安全与设计',
			resume: ''
		}])
rescue Exception => e
	pp e.message
end