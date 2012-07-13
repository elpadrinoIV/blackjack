require 'test/unit'

tests = Dir[File.expand_path("#{File.dirname(__FILE__)}/test*.rb")]

tests.each { |file|
  
  require file
}