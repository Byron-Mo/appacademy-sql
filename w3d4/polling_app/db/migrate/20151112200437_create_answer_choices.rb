class CreateAnswerChoices < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.text :text
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
    add_index :answer_choices, :user_id
    add_index :answer_choices, :question_id
  end
end
