require "./calculadorPagoApuestas"
require "./mockJugador"
require "./croupier"
require "./mazo"
require "test/unit"

class TestCalculadorPagoApuestas < Test::Unit::TestCase
	def setup
		@calculador_pago = CalculadorPagoApuestas.new
		@croupier = Croupier.new 10000
		@jugador = MockJugador.new 10000

	end

	def teardown
		# nada...
	end

	def test_apuesta_comun_gana_jugador_no_se_pasan
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(apuesta, pago_a_jugador, "se le debe pagar #{apuesta} al jugador")
	end
	
	def test_apuesta_comun_gana_croupier_no_se_pasan
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(0, pago_a_jugador, "no se le debe pagar al jugador")
	end

	def test_apuesta_comun_empatan_no_se_pasan
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(0, pago_a_jugador, "no se le debe pagar al jugador porque empataron")
	end

	def test_apuesta_comun_jugador_se_pasan_ambos
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2
		@croupier.getJuego.agregarCarta carta3

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2
		@jugador.getJuego.agregarCarta carta3

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(0, pago_a_jugador, "no se le debe pagar al jugador porque se paso")
	end

	def test_apuesta_blackjack_jugador_no_blackjack_croupier
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(apuesta*1.5, pago_a_jugador, "blackjack paga 1 y medio")
	end

	def test_apuesta_blackjack_jugador_blackjack_croupier_sin_seguro
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(0, pago_a_jugador, "Blackjack ambos empatan, no se paga nada")
	end

	def test_apuesta_blackjack_jugador_blackjack_croupier_con_seguro
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta

		@jugador.pagarSeguro

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(@jugador.getApuestaSeguro()*2, pago_a_jugador, "Blackjack ambos empatan, pero se lleva lo del seguro")
	end
	
	def test_apuesta_blackjack_jugador_21_croupier
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 6
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 5
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2
		@croupier.getJuego.agregarCarta carta3

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(apuesta*1.5, pago_a_jugador, "Blackjack paga 1 y medio")
	end

	def test_apuesta_comun_croupier_gana_con_blackjack_con_seguro
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 6
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta
		@jugador.pagarSeguro

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(@jugador.getApuestaSeguro()*2, pago_a_jugador, "Se le debe pagar el seguro")
	end

	def test_apuesta_apertura_gana_ambas_normal
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta

		@jugador.aperturar
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 9
		@jugador.getJuego.agregarCarta carta3
		@jugador.getJuego.plantar

		carta4 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 9
		@jugador.getJuego.agregarCarta carta4
		@jugador.getJuego.plantar

		@jugador.getJuego.getJuegos.each{ |juego|
			puts juego
			juego.each{|carta|
				carta.print
			}
			puts "---"
		}

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(apuesta*2, pago_a_jugador, "Se le debe pagar los 2 juegos por aperturar")
	end

=begin
	def test_apuesta_apertura_gana_ambas_con_blackjack
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta

		@jugador.aperturar
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		@jugador.getJuego.agregarCarta carta3
		@jugador.getJuego.plantar

		carta4 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 11
		@jugador.getJuego.agregarCarta carta4
		@jugador.getJuego.plantar

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(apuesta*2, pago_a_jugador, "Se le debe pagar los 2 juegos por aperturar, pero no cuenta como blackjack")
	end

	def test_apuesta_apertura_pierde_una_gana_una_normal
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta

		@jugador.aperturar
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 6
		carta4 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 8
		@jugador.getJuego.agregarCarta carta3
		@jugador.getJuego.agregarCarta carta4

		carta5 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 9
		@jugador.getJuego.agregarCarta carta4
		@jugador.getJuego.plantar

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(apuesta, pago_a_jugador, "Se le debe pagar 1 solo juego")
	end

	def test_apuesta_duplica_gana
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 5
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 5
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta

		@jugador.duplicar
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		@jugador.getJuego.agregarCarta carta3

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(apuesta*2, pago_a_jugador, "Se le debe pagar doble por duplicar")
	end

	def test_apuesta_duplica_pierde
		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 10
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		@croupier.getJuego.agregarCarta carta1
		@croupier.getJuego.agregarCarta carta2

		carta1 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 5
		carta2 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 5
		@jugador.getJuego.agregarCarta carta1
		@jugador.getJuego.agregarCarta carta2

		apuesta = 50
		apuestas = @jugador.getApuestas
		apuestas[0] = apuesta

		@jugador.duplicar
		carta3 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		carta4 = Carta.new Mazo::NUMEROS.first, Mazo::PALOS.first, 7
		@jugador.getJuego.agregarCarta carta3
		@jugador.getJuego.agregarCarta carta4

		pago_a_jugador = @calculador_pago.calcularPagoAJugador(@croupier, @jugador)

		assert_equal(0, pago_a_jugador, "No se le debe pagar nada")
	end
=end
end
