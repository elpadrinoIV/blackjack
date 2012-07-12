require "./carta"

class Croupier
	def initialize
		@cartas = Array.new
	end

	def agregarCarta carta
		@cartas << carta
	end

	def pedirCarta?
	end
end
