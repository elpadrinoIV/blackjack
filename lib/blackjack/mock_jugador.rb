require 'carta'
require 'jugador'

class MockJugador < Jugador
  attr_accessor :dinero_apuesta
	def initialize dinero
		super(dinero)
		@con_cuanto_planta = 17
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
    @juego.puede_aperturar?
	end

	def pagar_seguro?
		false
	end

	def pagar_seguro
		@apuesta_seguro = @apuestas_juegos[0]/2
		@dinero -= @apuesta_seguro
	end

  def duplicar
    apuesta = @apuestas_juegos[0]
    @apuestas_juegos[0] *= 2
    @dinero -= apuesta
  end

  def apostar
    @apuestas_juegos[0] = @dinero_apuesta
    @dinero -= @dinero_apuesta
  end
  
end
