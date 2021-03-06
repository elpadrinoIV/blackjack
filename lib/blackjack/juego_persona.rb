require 'carta'

class JuegoPersona
	def initialize
		# como se puede aperturar, pueden haber varios juegos
		# Arranco inicializando el primer juego con un array de cartas vacío
		@juegos = [ [] ]
		@numero_juego = 0
    @sigue_en_juego = true
    @duplico = false
	end

	def agregar_carta carta
    if !@sigue_en_juego
      return
    end

		if nil == @juegos[@numero_juego]
			@juegos[@numero_juego] = Array.new
		end

		if (self.valor(@numero_juego + 1) < 21)
			@juegos[@numero_juego] << carta
		end

    # si apertura con 2 aces, solo puede poner una carta en cada juego
    if 2 == @juegos.size
      if 2 == @juegos[@numero_juego].size && 11 == @juegos[@numero_juego][0].get_valor
        if (nil != @juegos[@numero_juego + 1])
          @numero_juego += 1
        else
          @sigue_en_juego = false
        end
      end
    end

    # si duplicó, solo puede tener una carta
    if @duplico
      @sigue_en_juego = false
    end

		# si al agregar la carta se pasa o da 21, si tiene otro juego pasa automáticamente al otro juego,
		# sino, se queda ahi
		if (self.valor(@numero_juego + 1) >= 21)
        if (nil != @juegos[@numero_juego + 1])
          @numero_juego += 1
        else
          @sigue_en_juego = false
        end
		end

	end

	def valor numero_juego
		suma = 0
		cantidad_cartas_con_valor_especial = 0
		@juegos[numero_juego - 1].each{ |carta|
			suma += carta.get_valor
			if 11 == carta.get_valor
				cantidad_cartas_con_valor_especial += 1
			end
		}

		while (suma > 21 && cantidad_cartas_con_valor_especial > 0)
			suma -= 10
			cantidad_cartas_con_valor_especial -= 1
		end
		suma
	end

	def plantar
    if (nil != @juegos[@numero_juego + 1])
      @numero_juego += 1
    else
      @sigue_en_juego = false
    end
	end

	def aperturar
		if self.puede_aperturar?
			segunda_carta = @juegos[@numero_juego].pop
			@numero_juego += 1
			self.agregar_carta segunda_carta
			@numero_juego -= 1
		end
	end

  def duplicar
    @duplico = true
  end

	def puede_aperturar?
		# para poder aperurar:
		#  - se puede solo en el primer juego
		#  - debe haber solo 2 cartas
		#  - el valor de las 2 cartas debe ser igual 

		if (0 == @numero_juego && 2 == @juegos[0].size)
			juego = @juegos[0]
			juego[0].get_valor == juego[1].get_valor
		end
	end

  def puede_duplicar?
		# para poder aperurar:
		#  - se puede solo en el primer juego
		#  - debe haber solo 2 cartas
		#  - el valor de las 2 cartas debe sumar 10 u 11

		if (0 == @numero_juego && 2 == @juegos[0].size)
			suma = self.valor(1)
			10 == suma || 11 == suma
		end
	end

	def get_juegos
		@juegos
	end

	def tiene_blackjack?
		return (1 == @juegos.size && (2 == @juegos[0].size) && 21 == self.valor(1))
	end

  def resetear
    @juegos = [ [] ]
		@numero_juego = 0
    @sigue_en_juego = true
    @duplico = false
  end

  def get_numero_juego
    @numero_juego + 1
  end

  def sigue_en_juego?
    @sigue_en_juego
  end
end
