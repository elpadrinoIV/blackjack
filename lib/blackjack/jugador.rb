require 'juegoPersona'

class Jugador
	def initialize dinero
		@dinero = dinero
		@juego = JuegoPersona.new
		@apuestas_juegos = [0]
		@apuesta_seguro = 0
	end

	def aperturar?
	end

	def duplicar?
	end

	def pedirCarta?
	end

	def apostar
	end

	def pagarSeguro
	end

	def aperturar
	end

	def duplicar
	end

	def getJuego
		@juego
	end

	def getDinero
		@dinero
	end

	def getApuestas
		@apuestas_juegos
	end

	def getApuestaSeguro
		@apuesta_seguro
	end

	def cobrarApuesta dinero_ganado
		@dinero += dinero_ganado
	end
end
