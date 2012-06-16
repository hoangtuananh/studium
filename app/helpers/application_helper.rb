module ApplicationHelper
  def javascript(*files)
    content_for(:head) {javascript_include_tag(*files)}
  end
  def link_to_remove_question(name, f)
    f.hidden_field(:_destroy) + link_to(name,"#",onclick: "remove_question(this)",class: "btn btn-danger")
  end

  def link_to_add_question(name, f, index, question_type_id, paragraph)
    new_question = paragraph.questions.build(question_type_id: question_type_id)
    new_question.choices.build(choice_letter: cycle("A","B","C","D","E"))
    fields = f.fields_for :questions do |builder|
       render("questions_fields",:f => builder, index: index, question_type_id: question_type_id)
    end
    link_to(name,"#", onclick: "add_question(this, \"#{escape_javascript(fields)}\")",class: "btn btn-primary")
  end
end
