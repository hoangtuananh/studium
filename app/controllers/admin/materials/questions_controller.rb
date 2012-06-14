class Admin::Materials::QuestionsController < Admin::Materials::BaseController
  def index
  end

  def new
    @question_type=params[:question_type][:type_name]

    if @question_type=="Reading" or @question_type=="Paragraph Improvement"
      render "form_with_paragraph" 
    else
      render "form_without_paragraph"
    end
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def category_selection
    @categories=CategoryType.order :category_name
    @category_names=@categories.collect do |category|
      category.category_name
    end
  end
end
