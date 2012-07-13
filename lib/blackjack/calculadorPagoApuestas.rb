
class CalculadorPagoApuestas
	def initialize
	end

	def calcularPagoAJugador croupier, jugador
		cantidad_a_pagar = 0
		apuesta = jugador.getApuestas.first
		numero_juego = 1
		hubo_apertura = (jugador.getJuego.getJuegos.size > 1)
		jugador.getJuego.getJuegos.each { |juego|
			case quienGana?(croupier.getJuego, jugador.getJuego, numero_juego, !hubo_apertura)
			when :jugador
				# pago el valor de la apuesta o 1.5 si es blackjack
				if jugador.getJuego.tieneBlackjack?
					cantidad_a_pagar += apuesta*1.5
				else
					cantidad_a_pagar += apuesta
				end
			else
				# no le pago nada
			end

			if croupier.getJuego.tieneBlackjack? && jugador.getApuestaSeguro > 0
				cantidad_a_pagar += jugador.getApuestaSeguro*2
			end

			numero_juego += 1
		}
		cantidad_a_pagar
	end

	private
=begin
	juego_croupier: el juego del croupier
	juego_jugador: el juego completo del jugador
	numero_juego: en la mayoria de los casos debería ser 1, en caso de apertura se debe pasar una vez 1 y una vez 2 
	vale_blackjack_jugador en el caso de la apertura, 10 y as cuenta como 21, no como blackjack. En ese caso es false
=end
	def quienGana? juego_croupier, juego_jugador, numero_juego, vale_blackjack_jugador = true
		valor_juego_croupier = juego_croupier.valor(1)
		valor_juego_jugador = juego_jugador.valor(numero_juego)

		if valor_juego_jugador > 21
			# si el jugador se pasa, no importa que haya pasado, pierde el jugador
			# jugador > 21
			return :croupier
		elsif valor_juego_croupier > 21
			# si el jugador no se pasó, pero el croupier si, gana el jugador
			# jugador <= 21
			# croupier > 21
			return :jugador
		elsif valor_juego_jugador > valor_juego_croupier
			# si no, si el jugador tiene más que el croupier, gana
			# jugador <= 21
			# croupier <= 21
			# jugador > croupier
			return :jugador
		elsif valor_juego_croupier > valor_juego_jugador
			# si no, si el cropier tiene más que el jugador, gana el croupier
			# jugador <= 21
			# croupier <= 21
			# croupier > jugador
			return :croupier
		elsif valor_juego_croupier == valor_juego_jugador
			# sino, estan empatados, hay que ver los distintos casos
			# jugador <= 21
			# croupier <= 21
			# croupier = jugador
			if (valor_juego_croupier < 21)
				# ninguno de los 2 tiene blackjack, estan empatados
				# jugador < 21
				# croupier < 21
				# croupier = jugador
				return :empatados
			else
				# ambos tienen 21
				cantidad_cartas_croupier = juego_croupier.getJuegos.first.size
				cantidad_cartas_jugador = juego_jugador.getJuegos[numero_juego - 1].size
				if (2 == cantidad_cartas_croupier)
					# croupier tiene blackjack, solo puede empatar en caso de que el jugador tenga blackjack
					if (2 == cantidad_cartas_jugador && vale_blackjack_jugador)
						# jugador también tiene blackjack
						return :empatados
					else
						return :croupier
					end
				else
					# croupier tiene 21 normal, solo si el jugador tiene blackjack le gana, sino empatan
					if (2 == cantidad_cartas_jugador && vale_blackjack_jugador)
						return :jugador
					else
						return :empatados
					end
				end
			end
		end

	end
end
