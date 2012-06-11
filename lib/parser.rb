class Parser
  class<<Parser
    def parse(content,options={})
      content=Parser.highlight(options[:question_id])
      content=Parser.blank(options[:question_id])
      content=Parser.linebreak
      content=Parser.clue(options[:choice_id])
      content=Parser.underline(options[:choice_id])
    end

    def highlight(content,question_id)
      content
    end

    def blank(content,question_id)

    end

    def linebreak(content)

    end

    def clue(content,choice_id)

    end

    def underline(content,choice_id)

    end
  end
end
