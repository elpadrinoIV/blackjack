require 'carta'
require 'jugador'

class JugadorConservador < Jugador
	def initialize dinero, con_cuanto_planta
		super(dinero)
		@con_cuanto_planta = con_cuanto_planta
    @dinero_apuesta = 50
	end

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
		false
	end

  def duplicar?
    false
  end

	def pagar_seguro?
		false
	end

  def apostar
    @apuestas_juegos[0] = @dinero_apuesta
    @dinero -= @dinero_apuesta
  end

end
