# encoding: utf-8
class Photo < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  # http://baike.baidu.com/view/182380.htm
  # http://baike.baidu.com/view/22006.htm

  # https://gist.github.com/quake/7972812
  # Blog.where(created_at: 1.week.ago.beginning_of_week..1.week.ago.end_of_week).order(view_counts: :desc).first.subject

  CATEGORY = {
    uncategorized:      '未分类',
    city_architecture:  '城市建筑',
    still_life:         '静物写生',
    people:             '人物',
    landscapes:         '风景',
    commercial:         '广告',
    concert:            '音乐会',
    family:             '家庭',
    fashion:            '时尚',
    film:               '电影',
    fineart:            '美术',
    food:               '美食',
    news:               '新闻',
    nude:               '裸体',
    performing_arts:    '表演艺术',
    sport:              '运动',
    street:             '街头',
    transportation:     '运输',
    travel:             '旅行',
    underwater:         '水下',
    urban_exploration:  '城市探险',
    wedding:            '婚礼',
    abstract:           '抽象',
    animals:            '动物'
  }
  CATEGORY_INVERT = CATEGORY.invert

  LICENSE = {
    not_authorized:                               '不授权（版权所有 不得转载）',
    attribution_non_commercial:                   '署名-非商用',
    attribution_non_commercial_authorized_share:  '署名-非商用-授权分享',
    attribution_non_commercial_do_not_modify:     '署名-非商用-禁止修改',
    signature:                                    '署名',
    signature_authorized_share:                   '署名-授权分享',
    attribution_do_not_modify:                    '署名-禁止修改'
  }
  LICENSE_INVERT = LICENSE.invert

  PRIVACY = {
    :published => '公开',
    :private   => '不公开',
    :follower  => '对关注者公开'
  }
  PRIVACY_INVERT = PRIVACY.invert

  default_scope { order('created_at DESC') }

  scope :editors,     -> { where.not(:editor_id => nil)   }
  scope :published,   -> { where(:privacy => 'published') }
  scope :private,     -> { where(:privacy => 'private')   }
  scope :follower,    -> { where(:privacy => ['published', 'follower']) }

  scope :audited,     -> { where(:state => 'audited')     }
  scope :unaudited,   -> { where(:state => 'unaudited')   }
  scope :unaccepted,  -> { where(:state => 'unaccepted')  }

  scope :unpublished, -> { where("state != 'audited' or privacy != 'published'") }


  paginates_per 120

  acts_as_taggable

  serialize :tag_cache, Array

  belongs_to :user

  belongs_to :editor, :class_name => 'User', :foreign_key => :editor_id

  belongs_to :album

  has_many :comments, :as => :entity, :dependent => :destroy

  has_many :favorites, :as => :favoriteable, :dependent => :destroy

  has_many :favorite_users, :through => :favorites, :source => :user

  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :like_users, :through => :likes, :source => :user

  after_initialize :default_values

  before_save :set_tag_cache#, :set_exifr_data

  after_save :check_photo_status

  Settings.photo.versions.each do |key, style|
    define_method key do
      return "#{Settings.private_cdn_domain}/#{image}/#{style}?token=#{generate_download_token(style)}" if is_unpublished?
      "#{Settings.cdn_domain}/#{image}/#{style}"
    end
  end

  def is_unpublished?
    !(privacy == "published" and state == "audited")
  end

  def siblings(limit = 10)
    user.photos.order(:id => :desc).where("id > ?", id).limit(limit) + user.photos.order(:id => :desc).where("id <= ?", id).limit(limit)
  end

  def is_editor?
    !attributes['editor_id'].blank?
  end

  def generate_download_token(style)
    Qiniu::RS.generate_download_token :expires_in => 60 * 5, :pattern => "#{Settings.private_cdn_domain}/#{image}/#{style}".gsub("http://","")
  end

  def check_photo_status
    if is_unpublished?
      Qiniu::RS.move(Settings.photo_bucket, image, Settings.private_bucket, image) if Qiniu::RS.stat(Settings.photo_bucket, image)
    else
      Qiniu::RS.move(Settings.private_bucket, image, Settings.photo_bucket, image) if Qiniu::RS.stat(Settings.private_bucket, image)
    end
  end

  private

    def default_values
      self.category ||= "uncategorized" #if self.new_record?
      self.license  ||= "not_authorized"
      self.privacy  ||= "published"
      self.state    ||= "unaudited"
    end

    def set_tag_cache
      self.tag_cache  = self.tags.map { |tag| tag.name }
      self.album      = self.user.albums.where(:id => self.album_id).first
    end

end
