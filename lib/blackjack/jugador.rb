require 'juego_persona'

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

	def pedir_carta?
	end

	def apostar
	end

	def pagar_seguro
	end

	def aperturar
	end

	def duplicar
	end

	def get_juego
		@juego
	end

	def get_dinero
		@dinero
	end

	def get_apuestas
		@apuestas_juegos
	end

	def get_apuesta_seguro
		@apuesta_seguro
	end

	def cobrar_apuesta dinero_ganado
		@dinero += dinero_ganado
	end
end
