class TagTopic < ActiveRecord::Base
  validates :topic, inclusion: { in: %w(news sports music),
    message: "NOPE" }

  has_many :taggings,
    foreign_key: :tag_id,
    primary_key: :id,
    class_name: "Tagging"

  has_many :short_url,
    through: :taggings,
    source: :short_url

  def self.most_popular

  end
end
