Dir['**/test_*.rb'].each { |test_case|
  require test_case
}