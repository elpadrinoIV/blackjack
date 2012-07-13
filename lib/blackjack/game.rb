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
				if jugador.getApuestas.first > 0
					jugador.getJuego.agregarCarta(@sabot.obtenerSiguienteCarta)
				end
			}
			@croupier.getJuego.agregarCarta(@sabot.obtenerSiguienteCarta)
		}
	end

	def finMano
	end
end

