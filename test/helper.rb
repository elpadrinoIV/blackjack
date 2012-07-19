require 'test/unit'
# require File.dirname(__FILE__) + '/../lib/blackjack'
%w[blackjack estadistica].each{ |libreria|
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "../lib/#{libreria}"))
}

