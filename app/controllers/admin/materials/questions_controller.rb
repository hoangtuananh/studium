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
    @category_types=(CategoryType.order :category_name).collect do |category_type|
      [category_type.category_name, category_type.id]
    end
    @question_types = QuestionType.all.collect do |question_type| 
      [question_type.type_name, question_type.id]
    end
  end

  def find_question_type
    @question_type = QuestionType.find(params[:question_type])
  end

end
