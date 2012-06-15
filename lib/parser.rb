class String
  def parse(options={})
    # Parse all the markups
    self.highlight_render(options[:question_id])
        .blank(options[:question_id])
        .linebreak(options[:is_passage])
        .underline(options[:question_id])
  end

  def highlight_render(question_id)
    result = self
    
    # If question_id is not nil, parse the highlight markup
    if question_id
      # Parse all the highlight markups that match question_id
      while result=~/(.*)<hl #{question_id}>(.*?)<\/hl #{question_id}>(.*)/m
        result = $1 + "<b>" + $2 + "</b>" + $3
      end
      
      # Remove all other highlight markups that don't match question_id
      while result=~/(.*)<hl (\d+)>(.*?)<\/hl (\d+)>(.*)/m
        result = $1 + $3 + $5
      end
    end

    result
  end

  def blank(question_id)
    result=self

    # If question_id is not nil
    if question_id
      # Parse all the blank markups that match question_id
      count=0
      while result=~/(.*?)<bl \/>(.*)/m
        count+=1
        result=$1+%Q[<input type="text" id="question_#{question_id}_blank_#{count}" class="span1 focused" />]+$2
      end
    end
    
    result
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
    else
      self
    end
  end

  def underline(question_id)
    result=self

    if question_id
      count=1

      #Underline tags associated with specific choices, used in error identification questions
      while result=~/(.*?)<un>(.*?)<\/un>(.*)/m
        choice_letter="A"
        choice_letter="B" if count==2
        choice_letter="C" if count==3
        choice_letter="D" if count==4
        choice_letter="E" if count==5

        result=$1+%Q[<span id="question_#{question_id}_underline_#{choice_letter}"><u>]+$2+%Q[</u></span>]+$3
        count+=1
      end
    end

    result
  end
end
