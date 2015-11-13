class Tagging < ActiveRecord::Base
  belongs_to :tag_topic,
    foreign_key: :tag_id,
    primary_key: :id,
    class_name: "TagTopic"

  belongs_to :short_url,
    foreign_key: :short_url_id,
    primary_key: :id,
    class_name: "ShortenedUrl"
end
