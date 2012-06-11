class String
  def parse(content,options={})
    content.highlight(options[:question_id])
           .blank(options[:question_id])
           .linebreak
           .clue(options[:choice_id])
           .underline(options[:choice_id])
  end

  def highlight(question_id)

  end

  def blank(question_id)

  end

  def linebreak

  end

  def clue(choice_id)

  end

  def underline(choice_id)

  end
end
