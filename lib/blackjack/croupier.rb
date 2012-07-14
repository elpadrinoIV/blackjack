require 'carta'
require 'jugador'

class Croupier < Jugador
	def initialize dinero
		super(dinero)
	end

	def pedir_carta?
		@juego.valor(1) < 17
	end

	def aperturar?
		false
	end
end
