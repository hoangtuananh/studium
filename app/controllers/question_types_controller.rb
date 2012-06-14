class QuestionTypesController < ApplicationController
  before_filter :authenticate_admin!

  def dynamic_question_types
    @question_types=QuestionType.order :type_name
  end
end
