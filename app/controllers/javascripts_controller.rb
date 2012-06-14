class JavascriptsController < ApplicationController
  def dynamic_question_types
    @question_types=QuestionType.order :type_name
  end
end
