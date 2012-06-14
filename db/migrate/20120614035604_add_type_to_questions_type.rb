class AddTypeToQuestionsType < ActiveRecord::Migration
  def change
    add_column :question_types, :type, :string
  end
end
