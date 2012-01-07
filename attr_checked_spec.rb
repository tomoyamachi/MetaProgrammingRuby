require "rspec"
#require"./check_attr"
class Person
#  include CheckedAttributes

  # attr_checked :age do |v|
  #   v >= 18
  # end
end

describe Person do
  before :each do
    add_checked_attributes(Person, :age)
    @p = Person.new
  end

  it "#age == 17 return true" do
    @p.age = 15
    lambda{ @p.age == 15 }.should be_true
  end

  # it "#age = 19 raise Error" do
  #   lambda{ @p.age = 19 }.should raise_error
  # end

  it "#age = nil raise Error" do
    lambda{ @p.age = nil }.should raise_error
  end

  it "#age = false raise Error" do
    lambda{ @p.age = false }.should raise_error
  end

end

def add_checked_attributes(clazz,attribute)
  clazz.class_eval do
    define_method "#{attribute}=" do |value|
      raise 'Invalid attribute' unless value
      instance_variable_set("@#{attribute}", value)
    end

    define_method "#{attribute}" do
      instance_variable_get "@#{attribute}"
    end
  end
end
