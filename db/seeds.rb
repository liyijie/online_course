# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
begin
  School.delete_all
	School.create!({
	  id: 1, name: '上海工商职业技术学院'
	})

  Manager.delete_all
  Manager.create!({
    id: 1, name: '管理员', roles: "0", password: "dtby123456", password_confirmation: "dtby123456", number: "000000", email: "admin@dtby.com"
  })

  Academy.delete_all
  Academy.create!([{
      id: 1, school_id: 1, academy_code: "1", name: "商务与管理系"
    },{
      id: 2, school_id: 1, academy_code: "2", name: "机电工程系"
    },{
      id: 3, school_id: 1, academy_code: "3", name: "计算机信息系"
    },{
      id: 4, school_id: 1, academy_code: "4", name: "餐旅服务学院"
    },{
      id: 5, school_id: 1, academy_code: "5", name: "汽车工程系"
    },{
      id: 6, school_id: 1, academy_code: "6", name: "应用外语系"
    },{
      id: 7, school_id: 1, academy_code: "7", name: "艺术设计系"
    },{
      id: 8, school_id: 1, academy_code: "8", name: "珠宝系"
    }])

  Specialty.delete_all
  Specialty.create!([{
      id: 1, academy_id: 8, code: "670109", name: "珠宝首饰工艺及鉴定"    
    },{
      id: 2, academy_id: 8, code: "540110", name: "宝玉石鉴定与加工技术"    
    },{
      id: 3, academy_id: 1, code: "520605", name: "报关与国际货运"    
    },{
      id: 4, academy_id: 1, code: "620405", name: "电子商务"    
    },{
      id: 5, academy_id: 1, code: "620503", name: "商务管理"    
    },{
      id: 6, academy_id: 1, code: "620505", name: "物流管理"    
    },{
      id: 7, academy_id: 1, code: "620305", name: "国际商务"    
    },{
      id: 8, academy_id: 1, code: "620203", name: "会计"    
    },{
      id: 9, academy_id: 1, code: "640107", name: "会展策划与管理"    
    },{
      id: 10, academy_id: 2, code: "580103", name: "数控技术"    
    },{
      id: 11, academy_id: 2, code: "580201", name: "机电一体化技术"    
    },{
      id: 12, academy_id: 3, code: "590102", name: "计算机网络技术"    
    },{
      id: 13, academy_id: 3, code: "590106", name: "计算机信息管理"    
    },{
      id: 14, academy_id: 3, code: "590101", name: "计算机应用技术"    
    },{
      id: 15, academy_id: 3, code: "590301", name: "通信技术"    
    },{
      id: 16, academy_id: 4, code: "640106", name: "酒店管理"    
    },{
      id: 17, academy_id: 4, code: "640101", name: "旅游管理"    
    },{
      id: 18, academy_id: 5, code: "580403", name: "汽车电子技术"    
    },{
      id: 19, academy_id: 5, code: "580414", name: "汽车定损与评估"    
    },{
      id: 20, academy_id: 5, code: "520104", name: "汽车运用技术"    
    },{
      id: 21, academy_id: 5, code: "580405", name: "汽车技术服务与营销"    
    },{
      id: 22, academy_id: 6, code: "660112", name: "文秘"    
    },{
      id: 23, academy_id: 6, code: "660102", name: "应用英语"    
    },{
      id: 24, academy_id: 6, code: "660103", name: "应用日语"    
    },{
      id: 25, academy_id: 1, code: "670114", name: "应用艺术设计"    
    }])
rescue Exception => e
	p e.message
end
