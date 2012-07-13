%w[ calculadorPagoApuestas carta croupier game juego_persona \
jugador jugadorConservador mazo mockJugador sabot].each{ |file|
	require File.expand_path("../blackjack/#{file}", __FILE__)
	]

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
