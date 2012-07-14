require 'jugador'
require 'croupier'
require 'juegoPersona'
require 'sabot'

class Game
	def initialize
		@croupier = Croupier.new 100000
		@sabot = Sabot.new 8
		@sabot.mezclar
		@jugadores = Array.new
	end
	
	def agregarJugador jugador
		@jugadores << jugador
	end

	def getJugadores
		@jugadores
	end

	def getCroupier
		@croupier
	end
	
	def repartir
		(1..2).each{ |i|
			@jugadores.each{ |jugador|
				if jugador.get_apuestas.first > 0
					jugador.get_juego.agregarCarta(@sabot.obtener_siguiente_carta)
				end
			}
			@croupier.get_juego.agregarCarta(@sabot.obtener_siguiente_carta)
		}
	end

	def finMano
	end

  def getSabot
    @sabot
  end
  
end

