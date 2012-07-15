require 'jugador'
require 'croupier'
require 'calculador_pago_apuestas'
require 'juego_persona'
require 'sabot'

class Game
	def initialize
		@croupier = Croupier.new 100000
		@sabot = Sabot.new 8
		@sabot.mezclar
		@jugadores = Array.new
	end
	
	def agregar_jugador jugador
		@jugadores << jugador
	end

	def get_jugadores
		@jugadores
	end

	def get_croupier
		@croupier
	end
	
	def repartir
		(1..2).each{ |i|
			@jugadores.each{ |jugador|
				if jugador.get_apuestas.first > 0
					jugador.get_juego.agregar_carta(@sabot.obtener_siguiente_carta)
				end
			}
			@croupier.get_juego.agregar_carta(@sabot.obtener_siguiente_carta)
		}
	end

	def fin_mano
    cartas = Array.new
    calculador_pago_apuestas = CalculadorPagoApuestas.new
    @jugadores.each{ |jugador|
        # para los jugadores que hayan apostado...
				if jugador.get_apuestas.first > 0
          numero_juego = 1
          hubo_apertura = (jugador.get_juego.get_juegos.size > 1)

          # para cada juego...
          jugador.get_juego.get_juegos.each{ |juego|
            cantidad_a_pagar = calculador_pago_apuestas.calcular_pago_a_jugador(@croupier, jugador)

            quien_gano = calculador_pago_apuestas.quien_gana?(@croupier.get_juego, jugador.get_juego, numero_juego, !hubo_apertura)
            case quien_gano
            when :jugador
              jugador.cobrar_apuesta(cantidad_a_pagar)
              jugador.guardar_dinero_apuesta(numero_juego)
            when :empatados
              jugador.guardar_dinero_apuesta(numero_juego)
            when :croupier
              jugador.entregar_dinero_apuesta(numero_juego)
            end

            if @croupier.get_juego.tiene_blackjack?
              jugador.guardar_dinero_apuesta_seguro
            else
              jugador.entregar_dinero_apuesta_seguro
            end
          
            numero_juego += 1
          }
					cartas << jugador.entregar_cartas
				end
			}
      cartas << @croupier.entregar_cartas
	end

  def get_sabot
    @sabot
  end
  
end

