class Admin::Materials::QuestionsController < Admin::Materials::BaseController
  before_filter :find_question_type, except: [:index,:category_selection,:destroy]

  def index
  end

  def new
    # Create a question prototype for the form
    @question = @question_type.questions.new

    # Get the correct form (as a partial view)
    determine_form_for_question
  end

  def create
    @question = @question_type.questions.new(params[:question])

    # Get the correct form (as a partial view)
    determine_form_for_question

    if @question.save
      redirect_to admin_materials_questions_path, notice: "Question has been created." 
    else
      flash[:alert] = "Invalid Question Information. Question has not been created."
      render "new"
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

private
  # Get the question_type
  def find_question_type
    if params[:question_type]
      @question_type = QuestionType.find(params[:question_type][:id])
    elsif params[:question]
      @question_type = QuestionType.find(params[:question][:question_type_id])
    end
  end

  # This method determines which form to render based on question_type and store that in @partial
  def determine_form_for_question
    if @question_type.need_paragraph
      @partial="form_with_paragraph"
    else
      @partial="form_without_paragraph"
    end
  end
end
