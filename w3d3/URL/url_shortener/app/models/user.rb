class User < ActiveRecord::Base
  validates_uniqueness_of :email
  validates_presence_of :email

  has_many :visits,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "Visit"

  has_many :visited_urls,
    Proc.new { distinct },
    through: :visits,
    source: :short_url
  #create has_many to visits

  #create has_many short_urls through visits to short_url
end
