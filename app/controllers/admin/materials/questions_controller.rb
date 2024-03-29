class Admin::Materials::QuestionsController < Admin::Materials::BaseController
  # Require parser in the library to parse text
  require "parser"

  # Get the question type for some actions
  before_filter :find_question_type, except: [:index,:category_selection,:destroy]

  # Get the question for some actions
  before_filter :find_question,only: [:remove_paragraph,:remove_choice,:cancel_edit_question,:destroy,:update,:edit]

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
        # Query question with filter
        @question_type_id=params[:question_type] ? params[:question_type][:id] : nil;
        @questions=query_with_question_type_id(@question_type_id)
      end
    end
  end

  def new

    respond_to do |format|
      format.html do
        if @question_type.need_paragraph?
          redirect_to new_admin_materials_paragraph_path(question_type_id: @question_type.id)
        else
          # Create a question prototype for the form
          @question = @question_type.questions.new
          choices = ["A","B","C","D","E"]
          choices.each do |choice|
            @question.choices.build({choice_letter: choice})
          end
        end
      end
    end
  end

  def create
    @question = @question_type.questions.new(params[:question])

    flash[:notice] = params[:question][:choices_attributes]

    if @question.save
      redirect_to admin_materials_questions_path, notice: "Question has been created." 
    else
      flash[:alert] = "Invalid Question Information. Question has not been created."
      params[:question][:choices_attributes].each do |choice|
        if choice[1][:content].blank?
          @question.choices.build({choice_letter: choice[1][:choice_letter]})
        end
      end
      render "new"
    end
  end

  def edit
    @question_type=@question.question_type
    
    # Respond to different request formats
    respond_to do |format|
      format.js {
        @ajax=true
      }
    end
  end

  def update
    # The notice to be displayed after update (either for error or success)
    @notice="<ul>"

    # Validate blank choices (@error'd be true if all choices are blank)
    validate_blank_choices(params[:question][:choices_attributes].values)

    # Update paragraph
    if @question.paragraph
      @paragraph=@question.paragraph

      # Should report validation errors if @paragraph fails to update its attibutes
      @error=true unless @paragraph.update_attributes title: params[:paragraph_title],content: params[:paragraph_content]
    end

    # If no error occured and @question updates fine
    if @question.update_attributes params[:question] and !@error
      respond_to do |format|
        format.js {
          @notice="Question has been updated."
        }
      end

    # If any errors occurred while updating the paragraph or question
    else
      respond_to do |format|
        format.js {
          # Set @error to be true so the edit form will be rendered again
          @error=true

          # Copy the paragraph's errors into the question's errors
          if @paragraph && @paragraph.errors.any?
            @paragraph.errors.full_messages.each do |error_msg|
              @question.errors.add :paragraph,error_msg
            end
          end

        # Add errors in question to @notice (will be rendered by js)
        @question.errors.full_messages.each do |msg|
          @notice << "<li>#{msg}</li>"
        end
        @notice << "</ul>"

        # Prepare @notice to be rendered as html
        @notice=@notice.html_safe
        }
      end
    end
  end

  def destroy
    # Find and destroy the question
    @question.destroy

    # Respond to different request formats
    respond_to do |format|
      format.js {
        # Get question_type_id from the submitted form on index.html.haml
        @question_type_id=params[:question_type_id]
        @question_type_id=nil if @question_type_id=="0"
        
        # Get the questions with filter
        @questions=query_with_question_type_id(@question_type_id)

        # Set up the notice
        @notice="Question has been deleted."

        # Rerender index.js.haml to get the accordion right
        render "index.js.haml"
      }
    end
  end

  # The intermediate page between index and questions#new
  # Can be used to get the category and question types ready for select tags
  def category_selection
    # Get the category types
    @category_types=(CategoryType.order :category_name).collect do |category_type|
      [category_type.category_name, category_type.id]
    end

    # Get the question types
    @question_types = QuestionType.all.collect do |question_type| 
      [question_type.type_name, question_type.id]
    end
  end

  # Handles when user clicks cancel while editing a question
  def cancel_edit_question
    respond_to do |format|
      format.js {
      }
    end
  end

  # Handles when user clicks remove paragraph while editing a question
  def remove_paragraph
    # Disassociate the paragraph from question
    @question.paragraph=nil

    respond_to do |format|
      format.js {
        # Rerender the inner of the corresponding accordion group
        @question_type=@question.question_type
        render "edit.js.haml"
      }
    end
  end

  # Handles when user clicks remove choice while editing a question
  def remove_choice
    # Get the choices
    @choice=@question.choices.find_by_choice_letter!(params[:choice_letter])

    # Only remove choice if the question stil has more than one choice
    if @question.choices.count>1
      @question.choices.delete @choice
      @choice.destroy
      @notice="Choice #{@choice.choice_letter} has been deleted.".html_safe

    # User is trying to remove the very last choice, raise error
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

  # Find question and set @question for some actions
  def find_question
    @question=params[:question_id] ? Question.find(params[:question_id]) : Question.find(params[:id])

  # If question cannot be found, redirect to question index page if html request
  rescue
    respond_to do |format|
      format.html {
        redirect_to admin_materials_questions_path,alert: "The page you were looking for could not be found."
      }
    end
  end

  # Query for questions of specific question type or all if the specified
  # question_type_id is nil
  def query_with_question_type_id(question_type_id)
    # Determine the filter for the query
    query_filter=question_type_id ? "question_type_id=#{question_type_id}" : nil

    # Query for questions and return the results
    query_filter ? Question.where(query_filter).order(:title) : Question.order(:title)
  end

  # Accepts an array of choice hashes. Set @error to true
  # And add error message to @notice if contents of all choices in the hashes are blank
  def validate_blank_choices(choice_hashes)
    # There must be at least one non-blank choice
    has_choice=false
    choice_hashes.each do |choice| 
      has_choice=true unless choice[:content].blank? 
    end
    unless has_choice
      @error=true
      @notice << "<li>Question must have at least one choice.</li>"
    end
  end
end
