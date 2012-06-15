class AddDefaultToNeedParagraphInQuestionTypes < ActiveRecord::Migration
  def up
    change_column :question_types,:need_paragraph,:boolean,default: false
  end

  def down
    change_column :question_types,:need_paragraph,:boolean,default: nil
  end
end
