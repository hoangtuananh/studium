class AddNeedParagraphToQuestionTypes < ActiveRecord::Migration
  def change
    add_column :question_types, :need_paragraph, :boolean
  end
end
