class String
  def highlight(question_id)
    if question_id
      result = self
      while result=~/(.*)<hl #{question_id}>(.*?)<\/hl #{question_id}>(.*)/
        result = $1 + "<b>" + $2 + "</b>" + $3
      end
      result
    end
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

