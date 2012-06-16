class Admin::Materials::QuestionsController < Admin::Materials::BaseController
  before_filter :find_question_type, except: [:index,:category_selection,:destroy]
  require "parser"

  def index
    # Respond to different formats
    respond_to do |format|
      format.html do 
        @questions=Question.order :title

        # Get the category and question types for the filter
        category_selection

        # Add "All" option to category type
        @category_types.insert 0,["All",0]
      end

      format.js do
        # Get question_type_id from the submitted form on index.html.haml
        @question_type_id=params[:category_type][:id]!=0 && params[:question_type] ? params[:question_type][:id] : 0
        
        # Determine the filter for the query
        query_filter=@question_type_id==0 ? nil : "question_type_id=#@question_type_id"

        # Query for questions
        @questions=query_filter ? Question.where(query_filter).order(:title) : Question.order(:title)
      end
    end
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

    # Determine if the question is correct
    @question.choices[0].update_attributes! correct: true if params[:question][:choices_attributes][0]
    @question.choices[1].update_attributes! correct: true if params[:question][:choices_attributes][1]
    @question.choices[2].update_attributes! correct: true if params[:question][:choices_attributes][2]
    @question.choices[3].update_attributes! correct: true if params[:question][:choices_attributes][3]
    @question.choices[4].update_attributes! correct: true if params[:question][:choices_attributes][4]

    if @question.save
      redirect_to admin_materials_questions_path, notice: "Question has been created." 
    else
      flash[:alert] = "Invalid Question Information. Question has not been created."
      render "new"
    end
  end

  def edit
    @question=Question.find params[:id]
    @question_type=@question.question_type

    # Respond to different request formats
    respond_to do |format|
      format.html {
      }

      format.js {
        # Get the correct form (as a partial view)
        determine_form_for_question
      }
    end
  end

  def update
    @question = Question.find params[:id]
    @question.update_attributes! params[:question]

    # Determine if the question is correct
    @question.choices[0].update_attributes! correct: true if params[:question][:choices_attributes][0]
    @question.choices[1].update_attributes! correct: true if params[:question][:choices_attributes][1]
    @question.choices[2].update_attributes! correct: true if params[:question][:choices_attributes][2]
    @question.choices[3].update_attributes! correct: true if params[:question][:choices_attributes][3]
    @question.choices[4].update_attributes! correct: true if params[:question][:choices_attributes][4]

    redirect_to admin_materials_questions_path, notice: "Question has been updated." 

  rescue
    flash[:alert] = "Invalid Question Information. Question has not been updated."
    render "edit"
  end

  def destroy
    @question=Question.find params[:id]
    @question.destroy

    # Respond to different request formats
    respond_to do |format|
      format.html {
      }

      format.js {
        # Get question_type_id from the submitted form on index.html.haml
        @question_type_id=params[:category_type_id]!="0" && params[:question_type_id] ? params[:question_type_id] : 0
        
        # Determine the filter for the query
        query_filter=@question_type_id==0 ? nil : "question_type_id=#@question_type_id"

        # Query for questions
        @questions=query_filter ? Question.where(query_filter).order(:title) : Question.order(:title)

        @notice="Question has been deleted."

        render "index.js.haml"
      }
    end

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
    if !@question_type.need_paragraph
      @partial="form_without_paragraph"
    else
      #@partial="form_with_paragraph"
      redirect_to new_admin_materials_paragraph_path(question_type_id: @question_type[:id])
    end
  end
end
