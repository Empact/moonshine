require 'rubygems'
require 'spec/autorun'
require 'spec/test/unit'
require 'ginger'

require 'pathname'
$here = Pathname.new(__FILE__).dirname

# rails version specific kludge to get generator tests working
require 'rails/version'
if Rails::VERSION::MAJOR == 2
  require 'support/rails_2_generator_kludge'
end
require 'support/moonshine_matchers'

require 'moonshine'
require 'shadow_puppet/test'
require 'mocha'


Test::Unit::TestCase.class_eval do
  def fake_rails_root
    self.class.fake_rails_root
  end

  def self.fake_rails_root
    $here.join('rails_root')
  end

  def generator_rails_root
    self.class.generator_rails_root
  end

  def self.generator_rails_root
    $here.join('generator_rails_root')
  end

  def in_apache_if_module(contents, some_module)
    contents.should =~ /<IfModule #{some_module}>(.*)<\/IfModule>/m

    contents.match(/<IfModule #{some_module}>(.*)<\/IfModule>/m)
    yield $1 if block_given?
  end

end
