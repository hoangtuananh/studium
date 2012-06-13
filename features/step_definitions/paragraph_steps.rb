Given /the following paragraphs exist:/ do |table|
  table.hashes.each do |paragraph|
    @paragraph=Paragraph.create! paragraph
  end
end
