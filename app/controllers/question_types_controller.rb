class QuestionTypesController < ApplicationController
  before_filter :authenticate_admin!

  def question_types_for_category_type
    @category=CategoryType.find_by_category_name!(params[:category_name])
    @question_types=@category.question_types

    render :update do |page|
      page << text=""> :description} )
    end
  end
end
