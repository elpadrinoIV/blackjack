require "./juegoPersona"

class Jugador
	def initialize dinero
		@dinero = dinero
		@juego = JuegoPersona.new
		@apuestas_juegos = Array.new
		@apuesta_seguro = 0
	end

	def aperturar?
	end

	def pedirCarta?
	end

	def apostar
	end

	def pagarSeguro?
	end

	def getJuego
		@juego
	end

	def getDinero
		@dinero
	end

	def cobrarApuesta dinero_ganado
		@dinero += dinero_ganado
	end
end
