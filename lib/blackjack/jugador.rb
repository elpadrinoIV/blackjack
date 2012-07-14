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

  # Cuando el jugador pierde, debe entregar el dinero de la apuesta
  def entregar_dinero_apuesta numero_apuesta
    cantidad = @apuestas_juegos[numero_apuesta - 1]
    @apuestas_juegos[numero_apuesta - 1] = 0
    cantidad
  end

  def entregar_dinero_apuesta_seguro
    cantidad = @apuesta_seguro
    @apuesta_seguro = 0
    cantidad
  end

  # Cuando el jugador gana o empata, se queda con el dinero de la apuesta
  def guardar_dinero_apuesta numero_apuesta
    @dinero += @apuestas_juegos[numero_apuesta - 1]
    @apuestas_juegos[numero_apuesta - 1] = 0
  end

  def guardar_dinero_apuesta_seguro
    @dinero += @apuesta_seguro
    @apuesta_seguro = 0
  end

  def entregar_cartas
    cartas = Array.new
    @juego.get_juegos.each{|juego|
      juego.each{ |carta|
        cartas << carta
      }
    }

    @juego.resetear
  end
  
end
