class String
  def parse(options={})
    self.highlight(options[:question_id])
        .blank(options[:question_id])
        .linebreak(options[:is_passage])
        .clue(options[:question_id],options[:choice_id])
        .underline
  end

  def highlight(question_id)
    if question_id
      result = self
      while result=~/(.*)<hl #{question_id}>(.*?)<\/hl #{question_id}>(.*)/
        result = $1 + "<b>" + $2 + "</b>" + $3
      end

      while result=~/(.*)<hl (\d+)>(.*?)<\/hl (\d+)>(.*)/
        result = $1 + $3 + $5
      end

      result
    end
  end

  def blank(question_id)
  end

  def linebreak(is_passage)
    if is_passage
      array = self.split("<br />")
      (1..array.length).each do |ln|
        if ln%5==0
          array[ln-1]="  ("+ln.to_s+")  "+array[ln-1]+"<br />"
        else
          array[ln-1]="        "+array[ln-1]+"<br />"
        end
      end
      array.join
    end
  end

  def clue(choice_id)
  end

  def underline(choice_id)
  end
end

