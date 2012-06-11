require "spec_helper"
require_relative "../../lib/test.rb"
describe String do
  it "should parse texts containing highlight markup tags" do
    test="<hl 90>Testing highlight markup</hl 90>"
    test.highlight(90).should eql("<b>Testing highlight markup</b>")
  end
end
