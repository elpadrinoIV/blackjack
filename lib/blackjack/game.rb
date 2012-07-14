require 'jugador'
require 'croupier'
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
    # falta la parte de pagar
	end

  def get_sabot
    @sabot
  end
  
end

