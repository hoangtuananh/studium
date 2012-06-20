class Admin::Materials::ParagraphsController < Admin::Materials::BaseController
  before_filter :get_question_type_id,only: [:new, :create]

  def new
    @num_questions = 6
    if params[:num_questions]
      @num_questions = params[:num_questions].to_i
    end
    respond_to do |format|
      # Render a normal form for HTML request
      format.html {
        @paragraph = Paragraph.new
      }

      # Respond to a json request
      format.json {
      }
    end
  end

  def create
    @paragraph = Paragraph.new(params[:paragraph])
    if @paragraph.save
      redirect_to admin_materials_questions_path, notice: "Question has been created."
    else
      flash[:alert] = "Invalid Question Information. Question has not been created."
      render "new"
    end
  end

  def edit
    @paragraph=Paragraph.find params[:id]
    @question=@paragraph.questions.find params[:question_id]
    @ajax=true

    respond_to do |format|
      format.html {
      }

      format.js { 
      }
    end

  rescue
    respond_to do |format|
      format.html {
      }

      format.js {
      }
    end
  end

  def update
    @paragraph=Paragraph.find params[:id]
    @question=@paragraph.questions.find params[:paragraph][:question_id]

    params[:paragraph].delete(:question_id)
    @paragraph.update_attributes! params[:paragraph]

    respond_to do |format|
      format.html {
        redirect_to admin_materials_paragraphs_path,notice: "Paragraph has been updated."
      }

      format.js {
        @notice="Paragraph has been updated."
      }

    end
  rescue
    respond_to do |format|
      format.html {
      }

      format.js {
      }
    end
  end

  def remove
    
  end

  def destroy
    
  end

private
  def get_question_type_id
    @question_type_id=params[:question_type_id]
  end
end
