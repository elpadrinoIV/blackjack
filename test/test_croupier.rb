require File.dirname(__FILE__) + '/helper.rb'

require 'croupier'
require 'mazo'

class TestCroupier < Test::Unit::TestCase
	def setup
		@croupier = Croupier.new 100
	end

	def teardown
		# nada...
	end

	def test_debe_pedir_con_menos_de_17
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 6
		@croupier.get_juego.agregar_carta carta1
		@croupier.get_juego.agregar_carta carta2

		assert(@croupier.pedir_carta?, "con 16 debe pedir otra carta")
	end
	
	def test_debe_plantar_con_17_o_mas
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		@croupier.get_juego.agregar_carta carta1
		@croupier.get_juego.agregar_carta carta2

		assert(false == @croupier.pedir_carta?, "con 17 no debe pedir otra carta")
	end

	def test_debe_plantar_con_17_o_mas_2
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 3
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		@croupier.get_juego.agregar_carta carta1
		@croupier.get_juego.agregar_carta carta2
		@croupier.get_juego.agregar_carta carta3

		assert(false == @croupier.pedir_carta?, "con 21 no debe pedir otra carta")
	end

	def test_debe_plantar_con_17_o_mas_3
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		@croupier.get_juego.agregar_carta carta1
		@croupier.get_juego.agregar_carta carta2

		assert(false == @croupier.pedir_carta?, "con blackjack no debe pedir otra carta")
	end

	def test_croupier_no_puede_aperturar
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		@croupier.get_juego.agregar_carta carta1
		@croupier.get_juego.agregar_carta carta2

		assert(false == @croupier.aperturar?, "el croupier no puede aperturar")
	end
end
