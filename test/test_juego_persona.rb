require File.dirname(__FILE__) + '/helper.rb'

require 'juego_persona'
require 'mazo'

class TestJuegoPersona < Test::Unit::TestCase
	def test_suma_juego_basico
		# 10 y 6 debe dar 16
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 6
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		assert_equal(16, juego.valor(1), "El valor del juego deberia ser 16")

		# 6, 5, 8 y 4 debe dar 23
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 6
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 5
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		carta4 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 4
		juego.agregar_carta carta1
		juego.agregar_carta carta2
		juego.agregar_carta carta3
		juego.agregar_carta carta4

		assert_equal(23, juego.valor(1), "El valor del juego deberia ser 23")
	end

	def test_suma_con_aces
		# As y 8 debe dar 19
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		assert_equal(19, juego.valor(1), "As y 8 debe dar 19")

		# As, 8 debe dar 19, sale 8 debe dar 17
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		assert_equal(19, juego.valor(1), "As y 8 debe dar 19")

		juego.agregar_carta carta3

		assert_equal(17, juego.valor(1), "As, 8 y 8 debe dar 17")

		# As y as debe dar 12
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		assert_equal(12, juego.valor(1), "As y as debe dar 12")

		# As, 5 debe dar 16, sale  as debe dar 17
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 5
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		assert_equal(16, juego.valor(1), "As y 5 debe dar 16")

		juego.agregar_carta carta3

		assert_equal(17, juego.valor(1), "As, 5 y as debe dar 17")

		# As, as, y 10 debe dar 12
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		assert_equal(12, juego.valor(1), "As y as debe dar 21")

		juego.agregar_carta carta3

		assert_equal(12, juego.valor(1), "As, as y 10  debe dar 12")

		# 8, 4, As y as debe dar 14
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 4
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		carta4 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		juego.agregar_carta carta1
		juego.agregar_carta carta2
		juego.agregar_carta carta3
		juego.agregar_carta carta4

		assert_equal(14, juego.valor(1), "As, 10 y as debe dar 14")
	end

	def test_puede_aperturar
		# 8 y 8 puede aperturar
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		assert(juego.puede_aperturar?, "Con un 8 y un 8 puede aperturar")

		# 10 y 10 puede aperturar
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		assert(juego.puede_aperturar?, "Con un 10 y un 10 puede aperturar")

		# as y as puede aperturar
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		# a pesar de pedir el valor, debe poder aperturar
		juego.valor 1
		assert(juego.puede_aperturar?, "Con un 10 y un 10 puede aperturar")
	end

	def test_no_puede_aperturar
		# 8 y 10 no puede aperturar
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		assert(!juego.puede_aperturar?, "Con un 8 y un 10 no puede aperturar")

		# 4, 4 y 10 no puede aperturar, ya le pasó la oportunidad
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 4
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 4
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		juego.agregar_carta carta1
		juego.agregar_carta carta2
		juego.agregar_carta carta3

		assert(!juego.puede_aperturar?, "Con un 4, un 4 y un 10 no puede aperturar")

		# 10, 4 y 4 no puede aperturar
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 4
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 4
		juego.agregar_carta carta1
		juego.agregar_carta carta2
		juego.agregar_carta carta3

		assert(!juego.puede_aperturar?, "Con un 10, un 4 y un 4 no puede aperturar")
	end

	def test_con_apertura_no_se_pasa
		# 8 y 8, apertura, saca 10, planta, saca 10, planta
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		juego.aperturar
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		juego.agregar_carta carta3
		juego.plantar

		carta4 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		juego.agregar_carta carta4
		juego.plantar

		valor_juego_1 = juego.valor 1
		valor_juego_2 = juego.valor 2

		assert_equal(18, valor_juego_1, "El primer juego da 18")
		assert_equal(19, valor_juego_2, "El segundo juego da 19")

		# 8 y 8, apertura, saca 2, saca 4, planta, saca 2, saca 2, saca 5, planta
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		juego.aperturar
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 2
		carta4 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 4
		juego.agregar_carta carta3
		juego.agregar_carta carta4
		juego.plantar

		carta5 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 2
		carta6 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 2
		carta7 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 5
		juego.agregar_carta carta5
		juego.agregar_carta carta6
		juego.agregar_carta carta7
		juego.plantar

		valor_juego_1 = juego.valor 1
		valor_juego_2 = juego.valor 2

		assert_equal(14, valor_juego_1, "El primer juego da 14")
		assert_equal(17, valor_juego_2, "El segundo juego da 17")
	end

	def test_con_apertura_se_pasa
		# 8 y 8, apertura, saca 4, saca 10, (se pasa), saca 8, saca 8, (se pasa)
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		juego.aperturar
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 4
		carta4 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		juego.agregar_carta carta3
		juego.agregar_carta carta4

		carta5 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		carta6 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		juego.agregar_carta carta5
		juego.agregar_carta carta6

		valor_juego_1 = juego.valor 1
		valor_juego_2 = juego.valor 2

		assert_equal(22, valor_juego_1, "El primer juego da 22")
		assert_equal(24, valor_juego_2, "El segundo juego da 24")
	end

	def test_tiene_blackjack
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		assert(juego.tiene_blackjack?, "10 y as es blackjack")

		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		assert(juego.tiene_blackjack?, "as y 10 es blackjack")
	end

	def test_no_tiene_blackjack
		# suma 21 pero no es blackjack
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 5
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 6
		juego.agregar_carta carta1
		juego.agregar_carta carta2
		juego.agregar_carta carta3

		assert(false == juego.tiene_blackjack?, "suma 21 pero no es blackjack")

		# apertura pero no vale blackjack
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		juego.aperturar
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		carta4 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		juego.agregar_carta carta3
		juego.agregar_carta carta4

		assert(false == juego.tiene_blackjack?, "con apertura no se puede sacar blackjack")

		# apertura pero no vale blackjack
		juego = JuegoPersona.new
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		juego.agregar_carta carta1
		juego.agregar_carta carta2

		juego.aperturar
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta4 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		juego.agregar_carta carta3
		juego.agregar_carta carta4

		assert(false == juego.tiene_blackjack?, "con apertura no se puede sacar blackjack")
	end
end
