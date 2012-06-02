Given /^the following users exist:$/ do |table|
  table.hashes.each do |user|
    @user=User.create! user
  end
end

Given /^user "(.+)" has the following profile info:$/ do |email,table|
  table.hashes.each do |profile_info|
    @profile=Profile.create! profile_info.merge!(user_id: User.find_by_emaiL!(email).id)
  end
end
