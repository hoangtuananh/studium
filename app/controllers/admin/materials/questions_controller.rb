class Admin::Materials::QuestionsController < Admin::Materials::BaseController
  def index
  end

  def new
    @question_type_id=params[:question_type][:id]

    if @question_type_id==QuestionType.find_by_title!("Reading").id or @question_type_id==QuestionType.find_by_title!("Paragraph Improvement").id 
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

private
  def find_question_type
    @question_type = QuestionType.find(params[:question_type])
  end
end
