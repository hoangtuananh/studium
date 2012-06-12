class String
  def parse(options={})
    # Parse all the markups
    self.highlight(options[:question_id])
        .blank(options[:question_id])
        .linebreak(options[:is_passage])
        .clue(options[:question_id],options[:choice_id])
        .underline
  end

  def highlight(question_id)
    # If question_id is not nil, parse the highlight markup
    if question_id
      result = self

      # Parse all the highlight markups that match question_id
      while result=~/(.*)<hl #{question_id}>(.*?)<\/hl #{question_id}>(.*)/
        result = $1 + "<b>" + $2 + "</b>" + $3
      end
      
      # Remove all other highlight markups that don't match question_id
      while result=~/(.*)<hl (\d+)>(.*?)<\/hl (\d+)>(.*)/
        result = $1 + $3 + $5
      end

      result
    end
  end

  def blank(question_id)
    # If question_id is not nil
    if question_id
      result=self

      # Parse all the blank markups that match question_id
      count=0
      while result=~/(.*?)<bl #{question_id}>(.*)/
        count+=1
        result=$1+%Q[<input type="text" id="question_#{question_id}_blank_#{count}" class="span1 focused" />]+$2
      end

      # Parse all the ordinary blanks
      while result=~/(.*)<bl \/>(.*)/
        result=$1+%Q[<input type="text" class="span1 focused" />]+$2
      end

      result
    end
  end

  def linebreak(is_passage)
    # Linebreaks within passage
    if is_passage
      # Split the string with the br tag as the delimiter
      array = self.split("<br />")

      # Add line numbers
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

