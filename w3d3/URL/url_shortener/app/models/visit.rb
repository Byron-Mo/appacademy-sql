class Visit < ActiveRecord::Base
  validates_presence_of :user_id, :short_url

  def self.record_visit!(user, shortened_url)
    Visit.create(user_id: user.id, short_url_id: shortened_url.id )
  end

  belongs_to :short_url,
    foreign_key: :short_url_id,
    primary_key: :id,
    class_name: "ShortenedUrl"

  belongs_to :user,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "User"
end
