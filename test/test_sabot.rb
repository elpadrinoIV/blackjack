require File.dirname(__FILE__) + '/helper.rb'

require 'sabot'

class TestSabot < Test::Unit::TestCase
	def test_cantidad_cartas_inicio
		(1..10).each { |cantidad_mazos|
			sabot = Sabot.new cantidad_mazos
			cantidad_cartas = sabot.getCartas.size
			cantidad_cartas_esperadas = 52*cantidad_mazos
		
			assert_equal(cantidad_cartas_esperadas, cantidad_cartas, "deberian haber #{cantidad_cartas_esperadas} cartas")
		}
	end
	def test_cantidad_cartas_despues_de_mezclar
		(1..10).each { |cantidad_mazos|
			sabot = Sabot.new cantidad_mazos
			sabot.mezclar
			cantidad_cartas = sabot.getCartas.size
			cantidad_cartas_esperadas = 52*cantidad_mazos
		
			assert_equal(cantidad_cartas_esperadas, cantidad_cartas, "deberian haber #{cantidad_cartas_esperadas} cartas")
		}
	end

	def test_no_cambia_cantidad_despues_de_mirar
		sabot = Sabot.new 1

		(1..10).each { |cantidad_cartas|
			cantidad_de_cartas_antes = sabot.getCartas.size
			sabot.mirarProximasCartas cantidad_cartas
			cantidad_de_cartas_despues = sabot.getCartas.size

			assert_equal(cantidad_de_cartas_antes, cantidad_de_cartas_despues, "No debe cambiar la cantidad de cartas cuando se las mira")
		}
	end

	def test_cambia_cantidad_despues_de_obtener_siguiente_carta
		sabot = Sabot.new 1

		cantidad_de_cartas_antes = sabot.getCartas.size
		sabot.obtenerSiguienteCarta
		cantidad_de_cartas_despues = sabot.getCartas.size


		assert_equal(cantidad_de_cartas_antes - 1, cantidad_de_cartas_despues, "Si se obtiene una carta se debe sacar del sabot")
	end

	def test_mezclar_debe_dejar_las_mismas_cartas
		# mezclar solo debe cambiar el orden, pero las cartas son las mismas

		(1..3).each { |cantidad_mazos|
			hash_cartas = Hash.new
			# inicializo hash con 0 para cada carta
			Mazo::NUMEROS.each{ |num|
				Mazo::PALOS.each{ |palo|
					hash_cartas[ [num, palo] ] = 0
				}
			}

			sabot = Sabot.new cantidad_mazos
			sabot.mezclar

			while carta = sabot.obtenerSiguienteCarta
				hash_cartas[ [carta.getNumero, carta.getPalo] ] += 1
			end

			todas_las_cartas_bien = true
			hash_cartas.values.each { |value|
				if value != cantidad_mazos
					todas_las_cartas_bien = false
				end
			}

			assert(todas_las_cartas_bien, "Cada carta deberia aparecer #{cantidad_mazos} veces")

		}
	end

	def test_mirar_debe_devolver_las_cartas_a_obtener
		# si miro la próxima carta y obtengo la próxima carta, deberían ser la misma
		sabot = Sabot.new 1
		sabot.mezclar

		(1..5).each {|cantidad_cartas|
			proximas_cartas = sabot.mirarProximasCartas cantidad_cartas
			cartas_obtenidas = Array.new

			(1..cantidad_cartas).each { |carta|
				cartas_obtenidas << sabot.obtenerSiguienteCarta
			}

			assert_equal(proximas_cartas, cartas_obtenidas, "La carta obtenida debe ser la misma que la espiada")
		}
		
	end

end
