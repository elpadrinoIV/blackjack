require 'game'
require 'jugador'

class JugadorTramposo < Jugador
  attr_accessor :dinero_apuesta
	def initialize dinero, game
		super(dinero)
		@game = game
    @dinero_apuesta = 50
	end
=begin
	def pedir_carta?
    if !super
      return false
    end

		if (@juego.valor(@juego.get_numero_juego) < @con_cuanto_planta)
      true
    else
      @juego.plantar
      @juego.sigue_en_juego?
    end

	end

	def aperturar?
    @juego.puede_aperturar?
	end

  def duplicar?
    @juego.puede_duplicar?
  end

	def pagar_seguro?
		false
	end

  def apostar
    @apuestas_juegos[0] = @dinero_apuesta
    @dinero -= @dinero_apuesta
  end
=end
end