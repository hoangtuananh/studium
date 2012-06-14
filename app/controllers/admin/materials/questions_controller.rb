class Admin::Materials::QuestionsController < Admin::Materials::BaseController
  before_filter :find_question_type, except: [:index,:category_selection,:create, :update, :destroy]
  def index
  end

  def new
    @question = @question_type.questions.new
    if @question_type.need_paragraph
      #render "form_with_paragraph" 
    else
      5.times do
        choice = @question.choices.build
      end
      render "form_without_paragraph"
    end
  end

  def create
    @question = Question.new(params[:question])
    if @question.save
      redirect_to admin_materials_questions_path, notice: "Question has been created." 
    else
      render "new", alert: "Invalid Question Information. Question has not been created."
    end
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
    @question_type = QuestionType.find(params[:question_type][:id])
  end

end
