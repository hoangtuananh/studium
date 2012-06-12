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

  it "should parse texts that contain an ordinary blank without question_id" do
    test = "This is some text that contains <bl /> some ordinary blank."
    test.blank(1).should eql %Q[This is some text that contains <input type="text" class="span1 focused" /> some ordinary blank.]
  end

  it "should parse some text that contains a blank associated with a question" do
    test = "This is some text that contains <bl 1> a blank associated with a question."
    test.blank(1).should eql(%Q[This is some text that contains <input type="text" id="question_1_blank_1" class="span1 focused" /> a blank associated with a question.])
  end

  it "should parse some text that contains multiple blanks associated with a question" do
    test = "This is some text that contains <bl 1> multiple blanks <bl 1> associated with one question."   
    test.blank(1).should eql(%Q[This is some text that contains <input type="text" id="question_1_blank_1" class="span1 focused" /> multiple blanks <input type="text" id="question_1_blank_2" class="span1 focused" /> associated with one question.])
  end

  it "should parse some text that contains multiple blanks associated with two questions" do
    test="This is some text that contains <bl 1> multiple blanks <bl 2> associated with two questions."
    test.blank(1).should eql(%Q[This is some text that contains <input type="text" id="question_1_blank_1" class="span1 focused" /> multiple blanks <bl 2> associated with two questions.])
  end
  
  it "should parse some text that contains multiple blanks associated with a question" do
    test = "This is some text that contains <bl 1> multiple blanks <bl 1> associated with <bl 2> two questions."   
    test.blank(1).should eql(%Q[This is some text that contains <input type="text" id="question_1_blank_1" class="span1 focused" /> multiple blanks <input type="text" id="question_1_blank_2" class="span1 focused" /> associated with <bl 2> two questions.])
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
end
