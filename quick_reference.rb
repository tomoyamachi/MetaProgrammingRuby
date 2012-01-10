# -*- coding: utf-8 -*-
# C 1.1 配列引数
def my_method(*args)
  args.map { |arg| art.reverse }
end

# C 1.2 アラウンドエイリアス
class String
  alias :old_reverse :reverse
  def reverse
    "X#{old_reverse}X"
  end
end

# C 1.3 ブランックスレート
class C
  def method_missing(name,*args)
    puts "missing!"
  end
  instance_methods.each do |m|
    undef_method m unless m.to_s =~ /object_id|method_missing|respond_to?|instance_eval|^__/
  end
end
#puts C.new.to_s

# C 1.4 クラス拡張 モジュールをクラスメソッドとして定義
module M
  def hello
    "hello"
  end
end
class << C
  include M
end
puts C.hello

# C 1.5 クラス拡張ミックスイン フックメソッドをつかってモジュールをクラスメソッドとして定義
module Mo
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def bye
      "bye"
    end
  end
end

class C
  include Mo
end
puts C.bye


# 6 クラスインスタンス変数
class C
  @my_class_instance = "Value"

  def self.class_attribute
    @my_class_instance
  end
end

puts C.class_attribute

# 7 クラスマクロ
class << C
  def my_macro(arg)
    puts "#{arg} called"
  end
end

class C
  my_macro :x
end

# 8 クリーンルーム
class CleanRoom
  def useful_method(x); x * 2;end
end

puts CleanRoom.new.instance_eval{ useful_method(5) }

# 9 コードプロセッサ 外部ファイルのコード文字列を処理
Dir.glob("*reference.txt").each do |file|
  File.readlines(file).each do |line|
    puts "#{line.chomp} #=> #{eval(line)}"
  end
end

# 10 コンテキスト探査機
class C
  def initialize
    @x = "capsulized value"
  end
end

obj = C.new
puts obj.instance_eval { @x }

# 11 遅延評価
class C
  def store(&block)
    @capsule = block
  end
  def execute
    @capsule.call
  end
end
obj = C.new
obj.store { $X = 1}
$X = 0

obj.execute
puts $X #=> 1

# 12 動的ディスパッチ
dynamic_reverse = :reverse
"abc".send(dynamic_reverse)

# 13 動的メソッド
C.class_eval do
  define_method :dynamic_my_method do
    "hello dynamic world"
  end
end
p C.new.dynamic_my_method

# 14 動的プロキシ 他のオブジェクトに転送
class MyDynamicProxy
  def initialize(target)
    @target = target
  end

  def method_missing(name,*args,&block)
    "result: #{@target.send(name,*args,&block)}"
  end
end
obj = MyDynamicProxy.new("my dynamic proxy")
p obj.reverse

# 15 フラットスコープ
class C
  def an_attribute
    @attr
  end
end
obj = C.new
flat_value = 10

obj.instance_eval do
  @attr = flat_value
end

puts obj.an_attribute

# 16 ゴーストメソッド
class Ghost
  def method_missing(name,*args)
    name.to_s.reverse
  end
end
puts Ghost.new.dont_exist_method

#17 フックメソッド 特定のイベントが発生したときに、指定したコードを実行
class C
  def self.inherited(subclass)
    puts subclass
  end
end

class InheritedClass < C;end

# 18 カーネルメソッドにメソッドを定義して、すべてのオブジェクトでつか
# えるようにする
module Kernel
  def a_method
    puts "This is Kernel#a_method"
  end
end
a_method

#19 遅延インスタンス変数
class C
  def attribute
    @attribute = @attribute || "value"
  end
end
C.new.attribute
