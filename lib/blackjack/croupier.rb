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

  def cobrar_dinero_jugadores dinero
    @dinero += dinero
  end

  def entregar_dinero_para_pagar dinero
    @dinero -= dinero
  end
end
