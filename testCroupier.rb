require "./croupier"
require "./mazo"
require "test/unit"

class TestCroupier < Test::Unit::TestCase
	def setup
		@croupier = Croupier.new
	end

	def teardown
		# nada...
	end

	def test_debe_pedir_con_menos_de_17
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 6
		@croupier.agregarCarta carta1
		@croupier.agregarCarta carta2

		assert(@croupier.pedirCarta?, "con 16 debe pedir otra carta")
	end

end
