require "spec_helper"
require_relative "../../lib/parser.rb"

describe String do
  ######### Highlight ############
  it "should parse single hl tags" do
    test="<hl 90>Testing highlight markup</hl 90>"
    test.highlight(90).should eql("<b>Testing highlight markup</b>")
  end

  it "should parse multiple detached hl tags" do
    test2 = "<hl 1>Test one</hl 1> Not highlighted <hl 1>Highlighted</hl 1>"
    test2.highlight(1).should eql("<b>Test one</b> Not highlighted <b>Highlighted</b>")
  end

  it "should parse nested hl tags" do
    test3 = "<hl 1>Test one<hl 1> Not highlighted </hl 1>Highlighted</hl 1>"
    test3.highlight(1).should eql("<b>Test one<b> Not highlighted </b>Highlighted</b>")
  end

  it "should parse hl tags with different ids" do
    test4 = "<hl 2>Should not be highlighted</hl 2> Not highlighted <hl 1>Highlighted</hl 1>"
    test4.highlight(1).should eql("Should not be highlighted Not highlighted <b>Highlighted</b>")
  end

  it "should parse nested hl tags with different ids" do
    test5 = "<hl 1>This is one <hl 2>This is one and two</hl 2></hl 1>"
    test5.highlight(1).should eql("<b>This is one This is one and two</b>")
    test5.highlight(2).should eql("This is one <b>This is one and two</b>")
  end

  it "should parse semi-nested hl tags with different ids" do
    test6 = "<hl 1>This<hl 2> is one and two</hl 1> he he </hl 2>"
    test6.highlight(1).should eql("<b>This is one and two</b> he he ")
    test6.highlight(2).should eql("This<b> is one and two he he </b>")
  end

  ######### Blank ############
  it "should parse texts that contain no blanks" do
    test = "This is some text without blank markup."
    test.blank(1).should eql("This is some text without blank markup.")
  end

  it "should parse some text that contains a blank associated with a question" do
    test = "This is some text that contains <bl /> a blank associated with a question."
    test.blank(1).should eql(%Q[This is some text that contains <input type="text" id="question_1_blank_1" class="span1 focused" /> a blank associated with a question.])
  end

  it "should parse some text that contains two blanks associated with a question" do
    test = "This is some text that contains <bl /> two blanks <bl /> associated with one question."   
    test.blank(1).should eql(%Q[This is some text that contains <input type="text" id="question_1_blank_1" class="span1 focused" /> two blanks <input type="text" id="question_1_blank_2" class="span1 focused" /> associated with one question.])
  end
  
  it "should parse some text that contains multiple blanks associated with a question" do
    test = "This is some text that contains <bl /> multiple blanks <bl /> associated with <bl /> a question."   
    test.blank(1).should eql(%Q[This is some text that contains <input type="text" id="question_1_blank_1" class="span1 focused" /> multiple blanks <input type="text" id="question_1_blank_2" class="span1 focused" /> associated with <input type="text" id="question_1_blank_3" class="span1 focused" /> a question.])
  end

  ######### Linebreak ############
  indent = "        "

  it "should parse single line break" do
    test = "This is a line<br />This is a second line"
    test.linebreak(true).should eql(indent+"This is a line<br />"+indent+"This is a second line<br />")
  end

  it "should parse multiple line breaks" do
    test = "This is a line<br />This is a second line<br />Hehe"
    test.linebreak(true).should eql(indent+"This is a line<br />"+indent+"This is a second line<br />"+indent+"Hehe<br />")
  end

  it "should parse line breaks and add line numbers" do
    test = "Line 1<br />Line 2<br />Line 3<br />Line 4<br />Line 5<br />Line 6<br />Line 7<br />Line 8<br />Line 9<br />Line 10<br />"
    test.linebreak(true).should eql(indent+"Line 1<br />"+indent+"Line 2<br />"+indent+"Line 3<br />"+indent+"Line 4<br />  (5)  Line 5<br />"+indent+"Line 6<br />"+indent+"Line 7<br />"+indent+"Line 8<br />"+indent+"Line 9<br />"+"  (10)  "+"Line 10<br />")
  end

  ######### Underline ############
  it "should parse ordinary underline markups" do
    test = "This text contains some <ul 0> ordinary underline markup. </ul 0>"
    test.underline(1,1).should eql(%Q[This text contains some <span id="question_1_underline"><ul> ordinary underline markup. </ul></span>])
  end 

  it "should parse a single underline markup" do
    test = "This text contains an <ul 5> underline markup. </ul 5>"
    test.underline(1,5).should eql(%Q[This text contains an <span id="question_1_underline_5"><ul> underline markup. </ul></span>])
  end

  it "should parse multiple underline markups" do
    test = "This <ul 1>contains</ul 1> <ul 2>multiple</ul 2> <ul 3>underline</ul 3> <ul 4>markups.</ul 4>"
    test.underline(1,1).underline(1,2).underline(1,3).underline(1,4).should eql(%Q[This <span id="question_1_underline_1"><ul>contains</ul></span> <span id="question_1_underline_2"><ul>multiple</ul></span> <span id="question_1_underline_3"><ul>underline</ul></span> <span id="question_1_underline_4"><ul>markups.</ul></span>])
  end
end
