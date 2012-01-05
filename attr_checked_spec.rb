require "rspec"
require"./check_attr"
class Person
  include CheckedAttributes

  attr_checked :age do |v|
    v >= 18
  end
end

describe Person do
  before :each do
    @p = Person.new
  end

  it "#age == 17 return true" do
    @p.age = 15
    lambda{ @p.age == 15 }.should be_true
  end

  it "#age = 19 raise Error" do
    lambda{ @p.age = 19 }.should raise_error
  end
end

