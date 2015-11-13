class ShortenedUrl < ActiveRecord::Base
  include SecureRandom

  has_many :visits,
    foreign_key: :short_url_id,
    primary_key: :id,
    class_name: "Visit"

  has_many :users,
    Proc.new { distinct },
    through: :visits,
    source: :user

  has_one :tag,
    foreign_key: :short_url_id,
    primary_key: :id
    class_name: "TagTopic"


  validates_presence_of :long_url, :short_url
  validates_uniqueness_of :short_url

  def self.random_code
    random_code = SecureRandom.urlsafe_base64
    while ShortenedUrl.find_by_short_url(random_code)
      random_code = SecureRandom.urlsafe_base64
    end

    random_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create(long_url: long_url, short_url: ShortenedUrl.random_code, submitter_id: user.id)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.users.count
  end

  def num_recent_uniques
    self.visits.where("created_at < ?", 10.minutes.ago).select(:user_id).count
  end




  #create has_many users through visits to users

end
