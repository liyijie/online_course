# == Schema Information
#
# Table name: diymenus
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  name       :string(255)
#  key        :string(255)
#  url        :string(255)
#  is_show    :boolean
#  sort       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Diymenu < ActiveRecord::Base

  validates_uniqueness_of :name

  CLICK_TYPE = "click".freeze # key
  VIEW_TYPE  = "view".freeze  # url

  has_many :sub_menus, ->{where(is_show: true).order("sort").limit(5)}, class_name: "Diymenu", foreign_key: :parent_id

  belongs_to :parent, foreign_key: :parent_id, class_name: "Diymenu"

  def has_sub_menu?
    sub_menus.present?
  end

  # 优先为 click 类型
  def type
    key.present? ? CLICK_TYPE : VIEW_TYPE
  end

  def button_type(jbuilder)
    is_view_type? ? (jbuilder.url url) : (jbuilder.key key)
  end

  def is_view_type?
    type == VIEW_TYPE
  end

  class << self

    def parent_selection(current_menu)
      where.not(id: current_menu.id).map{|menu| [menu.name, menu.id]}
    end

    def parent_menus
      includes(:sub_menus).where(parent_id: nil, is_show: true).order("sort").limit(3)
    end

    def build_menu
      Jbuilder.encode do |json|
        json.button (parent_menus) do |menu|
          json.name menu.name
          if menu.has_sub_menu?
            json.sub_button(menu.sub_menus) do |sub_menu|
              json.type sub_menu.type
              json.name sub_menu.name
              sub_menu.button_type(json)
            end
          else
            json.type menu.type
            menu.button_type(json)
          end
        end
      end
    end

    def create_menu
      weixin_client = WeixinAuthorize::Client.new(Setting.app_id, Setting.app_secret)
      if weixin_client.is_valid?
        result = weixin_client.create_menu(build_menu)
        result
      else
        msg = "invalid appid or appsecret."
      end
    end

  end

end
