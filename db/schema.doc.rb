#添加表的字段意义注释
table "teachers"
    t.string   "phone"                #电话
    t.string   "encrypted_password"   #密码
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"           #用户名
    t.string   "number"             #编号
    t.string   "name"               #姓名
    t.string   "avatar"             #头像，暂时废除
    t.string   "birthday"           #生日
    t.string   "tec_position"       #专业技术职位
    t.string   "email"              #邮箱
    t.string   "qualification"      #资格证书
    t.string   "fax"                #传真
    t.string   "final_education"    #最终学历
    t.string   "final_degree"       #最终学位
    t.string   "tec_expertise"      #教学技术专长
    t.text     "resume"             #工作简历
    t.text     "tec_situation"      #教学情况
    t.text     "tec_service"        #技术服务
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sex"                #性别
    t.integer  "grade_id"           #所属班级
    t.text     "signature"          #个人签名

说明：表 courses
    市级申请 city_applied
    校级申请 college_applied