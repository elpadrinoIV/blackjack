=begin
%w[ calculadorPagoApuestas carta croupier game juego_persona \
jugador jugadorConservador mazo mockJugador sabot].each{ |file|
	require File.expand_path("../blackjack/#{file}", __FILE__)
=end
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "./blackjack"))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "./"))

Dir['**/*.rb'].each { |file|
  require file
}

g = Game.new
g.repartir



module Blackjack
=begin
  def self.transform_file(sourcename, targetname, model)
    source = IO.read(sourcename)
    template = Template.new(source)
    result = template.render(model)
    IO.write(targetname, result)
  end
=end
end
=begin
class NilClass
	def method_missing(*args)
		if args.length == 1
			return self
		else
			super
		end
	end
end
=end
