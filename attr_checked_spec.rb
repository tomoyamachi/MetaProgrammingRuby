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
  s = <<END
    class #{clazz}
      def #{attribute}=(value)
        raise 'Invalid attribute' unless value
        @#{attribute} = value
      end

      def #{attribute}()
        @#{attribute}
      end
    end
END
    eval s
end
