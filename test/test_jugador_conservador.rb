require File.dirname(__FILE__) + '/helper.rb'

require 'jugador_conservador'
require 'mazo'

class TestJugadorConservador < Test::Unit::TestCase
	def setup
		@con_cuanto_planta = 12
		@jugador = JugadorConservador.new(1000, @con_cuanto_planta)
	end

	def teardown
		# nada...
	end

	def test_debe_pedir_con_menos_de
		# con menos de <con_cuanto_planta> no puede perder nunca
		carta1 = Carta.new(Mazo::NUMEROS.first, Mazo::PALOS.first, @con_cuanto_planta/2)
		carta2 = Carta.new(Mazo::NUMEROS.first, Mazo::PALOS.first, @con_cuanto_planta/2 - 1)
		@jugador.get_juego.agregar_carta carta1
		@jugador.get_juego.agregar_carta carta2

		assert(@jugador.pedir_carta?, "con menos de #{@con_cuanto_planta} debe pedir otra carta")
	end
	
	def test_debe_plantar_con_mas_de
		carta1 = Carta.new(Mazo::NUMEROS.first, Mazo::PALOS.first, @con_cuanto_planta/2)
		carta2 = Carta.new(Mazo::NUMEROS.first, Mazo::PALOS.first, @con_cuanto_planta/2)
		@jugador.get_juego.agregar_carta carta1
		@jugador.get_juego.agregar_carta carta2

		assert(false == @jugador.pedir_carta?, "con #{@con_cuanto_planta} no debe pedir otra carta")
	end

	def test_debe_plantar_con_mas_de_2
		carta1 = Carta.new(Mazo::NUMEROS.first, Mazo::PALOS.first, @con_cuanto_planta/2)
		carta2 = Carta.new(Mazo::NUMEROS.first, Mazo::PALOS.first, @con_cuanto_planta/2 + 1)
		@jugador.get_juego.agregar_carta carta1
		@jugador.get_juego.agregar_carta carta2

		assert(false == @jugador.pedir_carta?, "con #{@con_cuanto_planta} no debe pedir otra carta")
	end

	def test_jugador_no_debe_aperturar
		# el conservador no apertura ni paga seguro
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		@jugador.get_juego.agregar_carta carta1
		@jugador.get_juego.agregar_carta carta2

		assert(false == @jugador.aperturar?, "el jugador no debe aperturar")
	end

	def test_jugador_no_debe_pagar_seguro
		# el conservador no apertura ni paga seguro
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		@jugador.get_juego.agregar_carta carta1
		@jugador.get_juego.agregar_carta carta2

		assert(false == @jugador.pagar_seguro?, "el jugador no debe pagar seguro")
	end
end
