require "./carta"
require "./jugador"

class MockJugador < Jugador
	def initialize dinero
		super(dinero)
		@con_cuanto_planta = 12
	end

	def pedirCarta?
		@juego.valor(1) < @con_cuanto_planta
	end

	def aperturar?
		false
	end

	def pagarSeguro?
		false
	end

	def pagarSeguro
		@apuesta_seguro = @apuestas_juegos[0]/2
		@dinero -= @apuesta_seguro
	end

  def aperturar
    @juego.aperturar
    @apuestas_juegos[1] = @apuestas_juegos[0]
    @dinero -= @apuestas_juegos[1]
  end

  def duplicar
    apuesta = @apuestas_juegos[0]
    @apuestas_juegos[0] *= 2
    @dinero -= apuesta
  end

end
