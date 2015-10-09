class Ability
  include CanCan::Ability

  def initialize(manager)
    manager ||= Manager.new
    if manager.administer?
      role_administer
    elsif manager.charge?
      role_charge
    elsif manager.teacher?
      role_teacher
    else
      can :manage, :all
    end
  end

  #管理员对所有模型有操作权限
  def role_administer
    can :manage, :all
  end

  #负责人对所负责课程有操作权限
  def role_charge
    can :index, Course
  end

  #课程老师对所教课程有查看权限
  def role_teacher
    cannot :manage, :all
  end

  # # 角色（教育部门, 对后台栏目拥有查阅权限）
  # def role_manage
  #   can :index, :home
  #   can :index, Notification
  #   can [:show, :list], TrainingCourse
  #   can [:index, :list], UserTrainingCourse
  #   can [:index, :list], Journal
  #   can :index, Task
  #   can :list, UserTask
  #   can [:index, :edit_profile, :update_profile, :edit_password, :update_password], Admin
  #   can :index, User
  #   can :index, Teacher
  # end

  # # 角色（管理部门, 即秘书处, 对后台拥有超级管理员权限）
  # def role_charge
  #   can :index, :home
  #   can :manage, :all
  #   can :manage, TrainingCourse
  #   can :manage, Journal
  #   cannot [:list], AdminUserTask
  #   cannot [:list_by_school, :list_by_teacher], TrainingCourse
  #   can [:add, :added], UserTrainingCourse
  # end

  # # 角色（培训机构）
  # def role_trainer
  #   can :index, :home
  #   can [:list_by_school, :detail], TrainingCourse
  #   cannot :list, TrainingCourse
  #   can [:index, :list], UserTrainingCourse
  #   can [:index, :list, :show], Journal
  #   can :index, Task
  #   can :list, UserTask
  #   can [:index, :edit_profile, :update_profile, :edit_password, :update_password], Admin
  # end

  # # 角色（评审专家）
  # def role_specialist
  #   can :index, :home
  #   can [:list, :edit, :update], AdminUserTask
  #   can [:index, :edit_profile, :update_profile, :edit_password, :update_password], Admin
  # end

  # # 角色（班级负责人）
  # def role_management
  #   can :index, :home
  #   can :index, Journal
  #   can [:index, :list, :add, :added], UserTrainingCourse
  #   can [:index, :list, :show], Journal
  #   can :manage, Task
  #   can [:list, :show, :index], UserTask
  #   can :manage, ManagerFeedback
  #   can :manage, StudentFeedback
  #   can :manage, Appraise
  #   can :manage, CourseResource
  #   can [:list_by_teacher, :detail], TrainingCourse
  #   can [:index, :edit_profile, :update_profile, :edit_password, :update_password], Admin
  # end
end
