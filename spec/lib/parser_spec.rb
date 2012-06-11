require "spec_helper"
require_relative "../../lib/parser.rb"
describe String do
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
end
