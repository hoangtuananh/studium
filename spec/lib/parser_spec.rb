require "spec_helper"

describe Parser do
  it "should parse texts containing highlight markup tags" do
    test="<hl 90>Testing highlight markup</hl 90>"
    Parser.highlight(test,90).should eql("<hl 90>Testing highlight markup</hl 90>")
  end
end
