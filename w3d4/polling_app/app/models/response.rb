# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cannot_respond_to_own_poll


  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id

  belongs_to :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

    has_one :question,
      through: :answer_choice,
      source: :question

    has_one :poll,
      through: :question,
      source: :poll

    def sibling_responses
      question.responses.where(["responses.id <> ? and ? is not NULL", self.id, self.id])
    end

    private

    def respondent_has_not_already_answered_question
      sibling_responses.each do |response|
        if response.id == self.id
          errors[:id] << "Response is not valid"
        end
      end
    end

    def author_cannot_respond_to_own_poll
      if user_id == poll.author_id
        errors[:user_id] << "Author cannot respond to this poll"
      end
    end
end
