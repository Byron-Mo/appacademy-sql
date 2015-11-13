class RemoveUserIdFromAnswerChoices < ActiveRecord::Migration
  def change
    remove_column :answer_choices, :user_id
  end
end
