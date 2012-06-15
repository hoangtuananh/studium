class Admin::Materials::ParagraphsController < Admin::Materials::BaseController
  def new
    @paragraph = Paragraph.new
    6.times do
      @paragraph.questions.build(question_type_id: params[:question_type_id])
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
end
