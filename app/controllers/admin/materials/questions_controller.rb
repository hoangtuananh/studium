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
    respond_to do |format|
      format.html do
        @question = @question_type.questions.new
        # Get the correct form (as a partial view)
        determine_form_for_question
      end
      format.js do
      end
    end
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
    @ajax=true

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

    @notice="<ul>"

    # There must be at least one non-blank choice
    has_choice=false
    params[:question][:choices_attributes].values.each do |choice| 
      has_choice=true unless choice[:content].blank? 
    end
    unless has_choice
      @error=true
      @notice << "<li>Question must have at least one choice.</li>"
    end

    # Update paragraph
    if @question.paragraph
      @paragraph=@question.paragraph
      unless @paragraph.update_attributes title: params[:paragraph_title],content: params[:paragraph_content]
        @error=true
      end
    end

    if @question.update_attributes params[:question] and !@error
      respond_to do |format|
        format.html {
          redirect_to admin_materials_questions_path, notice: "Question has been updated." 
        }
      
        format.js {
          @notice="Question has been updated."
          @error=false
        }
      end
    else
      respond_to do |format|
        format.js {
          @error=true
          @question.errors.full_messages.each do |msg|
            @notice << "<li>#{msg}</li>"
          end

          if @paragraph && @paragraph.errors.any?
            @paragraph.errors.full_messages.each do |msg|
              @notice << "<li>Paragraph #{msg}</li>"
            end
          end

          @notice << "</ul>"
          @notice=@notice.html_safe
        }
      end
    end
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

  def cancel_edit_question
    @question=Question.find params[:question_id]

    respond_to do |format|
      format.html {
      }

      format.js {
      }
    end
  end

  def disassociate_paragraph(question)
    paragraph=question.paragraph
    question.paragraph=nil
  end

  def remove_paragraph
    @question=Question.find params[:question_id]
    disassociate_paragraph(@question)

    respond_to do |format|
      format.html {
      }

      format.js {
        @question_type=@question.question_type
        determine_form_for_question
        render "edit.js.haml"
      }
    end
  end

  def remove_choice
    @question=Question.find params[:question_id]
    @choice=@question.choices.find_by_choice_letter!(params[:choice_letter])
    if @question.choices.count>1
      @question.choices.delete @choice
      @choice.destroy
      @notice="Choice #{@choice.choice_letter} has been deleted.".html_safe
    else
      @error=true
      @notice="<ul><li>Choice cannot be deleted. Question must have at least one choice.</li></ul>".html_safe
    end

    respond_to do |format|
      format.js {
      }
    end
  end

private
  # Get the question_type
  def find_question_type
    if params[:question_type]
      @question_type = QuestionType.find(params[:question_type][:id])
    elsif params[:question]
      @question_type = QuestionType.find(params[:question][:question_type_id])
    elsif params[:question_type_id]
      @question_type = QuestionType.find(params[:question_type_id])
    end
  end

  # This method determines which form to render based on question_type and store that in @partial
  def determine_form_for_question
    if @question_type.need_paragraph
      respond_to do |format|
        format.html {
          redirect_to new_admin_materials_paragraph_path(question_type_id: @question_type[:id])
        }

        format.js {
          @partial=@question.paragraph ? "form_with_paragraph" : "form_without_paragraph"
        }
      end
    else
      @partial="form_without_paragraph"
    end
  end
end
