require File.dirname(__FILE__) + '/helper.rb'

require 'croupier'
require 'game'
require 'jugador_conservador'

class TestGame < Test::Unit::TestCase
	def setup
		@game = Game.new
		(1..3).each{ |jugador|
			@game.agregar_jugador(JugadorConservador.new(10000, 12))
		}
	end

	def teardown
		# nada...
	end

	def test_repartir_solo_a_los_que_apostaron
		# apuestan los primeros 2, solo deben recibir cartas esos 2, y el croupier
		nro_jugador = 1
		@game.get_jugadores.each { |jugador|
			if (nro_jugador <= 2)
				jugador.apostar
			end

			nro_jugador += 1
		}

		@game.repartir

		@game.get_jugadores.each { |jugador|
			cartas_jugador = jugador.get_juego.get_juegos.first
			apuesta_jugador = jugador.get_apuestas.first
			if (apuesta_jugador > 0)
				assert_equal(2, cartas_jugador.size, "El jugador aposto, deberia haber recibido cartas")
			else
				assert_equal(0, cartas_jugador.size, "El jugador no aposto, no deberia haber recibido cartas")
			end
		}

		cartas_croupier = @game.get_croupier.get_juego.get_juegos.first
		assert_equal(2, cartas_croupier.size, "El croupier deberia haber recibido cartas")
	end

	def test_cuando_termina_la_mano_todo_a_cero
		# se reparte, se juega, se termina la mano. Las apuestas deben quedar todas en 0,
		# ningun jugador debe tener cartas, seguro, etc
		
		@game.get_jugadores.each { |jugador|
			jugador.apostar
		}

		@game.repartir
		@game.fin_mano

		@game.get_jugadores.each { |jugador|
			jugador.get_juego.get_juegos.each{ |juego|
				assert_equal(0, juego.size, "Cuando termina la mano el jugador no debe tener mas cartas")
			}

			jugador.get_apuestas.each{ |apuesta|
				assert_equal(0, apuesta, "Cuando termina la mano no hay mas apuestas")
			}

			assert_equal(0, jugador.get_apuesta_seguro, "Cuando termina la mano no hay mas apuestas")
		}

		@game.get_croupier.get_juego.get_juegos.each{ |juego|
			assert_equal(0, juego.size, "Cuando termina la mano el croupier no debe tener mas cartas")
		}
	end
end