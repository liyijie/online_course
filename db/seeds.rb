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
		{name: '计算机信息系', school_id: 1},
		{name: '基础部', school_id: 1},
		{name: '继续教育学院', school_id: 1},
		{name: '餐饮服务学院', school_id: 1}])

    Specialty.create!([{name: '计算机科学与技术', academy_id: 7},
            {name: '网络工程', academy_id: 7}])

	Grade.create!([{name: '2015级计算机（1）班', specialty_id: 1},
			{name: '2015级计算机（2）班', specialty_id: 1}])

	

	Teacher.create!([{
        number: '498483984',
    	phone: '13636338706',
    	username: 'qianhong', 
    	password: 'dtby123456', 
    	password_confirmation: 'dtby123456',
    	name: '钱红',
    	birthday: '1981-09',
    	tec_position: '讲师',
    	email: 'ianhongq@aliyun.com',
    	qualification: '高级教师资格 信息安全师（高级）',
    	fax: '',
    	final_education: '本科',
    	final_degree: '硕士',
    	tec_expertise: 'C语言程序基础，ASP.NET项目开发，Java编程基础，数据库技术',
    	academy_id: 7,
        sex: '女'
    },{
        number: '89439934',
    	phone: '13585676467',
    	username: 'yudieqiong', 
    	password: 'dtby123456', 
    	password_confirmation: 'dtby123456',
    	name: '俞蝶琼',
    	birthday: '1982-11',
    	tec_position: '讲师',
    	email: 'yudieqiong@126.com',
    	qualification: '软件设计师 信息安全师高级',
    	fax: '',
    	final_education: '硕士',
    	final_degree: '硕士',
    	tec_expertise: '计算机应用技术',
    	academy_id: 7,
        sex: '女'
    },{
        number: '12339934',
        phone: '13916463504',
        username: 'wangxiuying', 
        password: 'dtby123456', 
        password_confirmation: 'dtby123456',
        name: '王秀英',
        birthday: '1971-03',
        tec_position: '副教授',
        email: 'xywang71@163.com',
        qualification: 'MCSE（微软认证系统工程师）、计算机网络设备调试员（三级/高级技能）',
        fax: '',
        final_education: '博士',
        final_degree: '博士',
        tec_expertise: 'Linux操作系统管理与维护、Windows 操作系统管理与维护，计算机网络与信息安全',
        academy_id: 7,
        sex: '女'
    },{
        number: '812339934',
        phone: '18800001111',
        username: 'yudieqiong', 
        password: 'dtby123456', 
        password_confirmation: 'dtby123456',
        name: '赵霞',
        birthday: '1982-11',
        tec_position: '讲师',
        email: 'zhaoxia@126.com',
        qualification: '软件设计师 信息安全师高级',
        fax: '',
        final_education: '硕士',
        final_degree: '硕士',
        tec_expertise: '计算机应用技术',
        academy_id: 7,
        sex: '女'
    },{
        number: '81223234934',
        phone: '18621633901',
        username: 'liuxionghua', 
        password: 'dtby123456', 
        password_confirmation: 'dtby123456',
        name: '刘雄华',
        birthday: '1974-09',
        tec_position: '讲师',
        email: '9553966@qq.com',
        qualification: '优秀企业家（省级）',
        fax: '',
        final_education: '硕士',
        final_degree: '硕士',
        tec_expertise: '软件开发教学',
        academy_id: 7,
        sex: '男'
    }])

    TeacherGrade.create!([{
            teacher_id: '1',
            grade_id: '1'
        },{
            teacher_id: '1',
            grade_id: '2'
        },{
            teacher_id: '2',
            grade_id: '1'
        },{
            teacher_id: '2',
            grade_id: '2'
        },{
            teacher_id: '3',
            grade_id: '1'
        },{
            teacher_id: '3',
            grade_id: '2'
        },{
            teacher_id: '4',
            grade_id: '1'
        },{
            teacher_id: '4',
            grade_id: '2'
        },{
            teacher_id: '5',
            grade_id: '1'
        },{
            teacher_id: '5',
            grade_id: '2'
        }])

    User.create!([{
            phone: '13600001111',
            username: 'wuqiong', 
            nickname: '斯塔克',
            password: 'dtby123456', 
            password_confirmation: 'dtby123456',
            name: '吴琼',
            number: '20154802001',
            position: '学生',
            grade_id: 1
        },{
            phone: '13600002222',
            username: 'lijing', 
            nickname: '乌尔奇',
            password: 'dtby123456', 
            password_confirmation: 'dtby123456',
            name: '李静',
            number: '20154802002',
            position: "学生",
            grade_id: 1,
        },{
            phone: '13600003333',
            username: 'jiangminjie', 
            nickname: 'ican队长',
            password: 'dtby123456', 
            password_confirmation: 'dtby123456',
            name: '蒋敏捷',
            number: '20154802003',
            position: "学生",
            grade_id: 1,
        },{
            phone: '13600004444',
            username: 'anran', 
            nickname: '蛮王',
            password: 'dtby123456', 
            password_confirmation: 'dtby123456',
            name: '安然',
            number: '20154802004',
            position: "学生",
            grade_id: 2,
        },{
            phone: '13600005555',
            username: 'bangyan', 
            nickname: '大唐邦彦',
            password: 'dtby123456', 
            password_confirmation: 'dtby123456',
            name: '唐邦彦',
            number: '20154802005',
            position: "学生",
            grade_id: 2,
        }
        ])
	
	
  

rescue Exception => e
	p e.message
end
