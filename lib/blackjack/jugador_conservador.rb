require 'carta'
require 'jugador'

class JugadorConservador < Jugador
	def initialize dinero, con_cuanto_planta
		super(dinero)
		@con_cuanto_planta = con_cuanto_planta
	end

	def pedir_carta?
		@juego.valor(1) < @con_cuanto_planta
	end

	def aperturar?
		false
	end

	def pagar_seguro?
		false
	end

end
