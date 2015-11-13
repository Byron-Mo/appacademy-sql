# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text
#  poll_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :text, presence: true
  validates :poll_id, presence: true

  has_many :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id

  belongs_to :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id


  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    result_hash = Hash.new(0)
    answer_choices.each do |answer|
      result_hash[answer.text] = answer.responses.count
    end
    result_hash
  end

  def results2
    result_hash = Hash.new(0)
    answers = self.answer_choices.includes(:responses)
    answers.each do |answer|
      result_hash[answer.text] = answer.responses.length
    end
    result_hash
  end

  def results3
    result_hash = Hash.new(0)
    answers = self
      .answer_choices
      .select("answer_choices.*, COUNT(*) AS responses.length")
      .joins(:answer_choices)
      .group("answer_choices.id")
    
  end


end
