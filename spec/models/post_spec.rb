require 'rails_helper'

RSpec.describe Post, type: :model do

describe "Validations" do
  it "should have a title"
  it "should have a minimum of 7 characters"
  it "should have a body"
  it 
end
- Validation of the presence of Post's title
- Validation of the minimum length of Post's title (7 characters)
- Validation of the presence of Post's body
- Test drive a method `body_snippet`  that returns a maximum of a 100 characters with "..." of the body if it's more than a 100 characters long.

end
