require "./carta"

class JuegoPersona
	def initialize
		# como se puede aperturar, pueden haber varios juegos
		# Arranco inicializando el primer juego con un array de cartas vacío
		@juegos = Array.new
		@numero_juego = 0
	end

	def agregarCarta carta
		if nil == @juegos[@numero_juego]
			@juegos[@numero_juego] = Array.new
		end

		if (self.valor(@numero_juego + 1) < 21)
			@juegos[@numero_juego] << carta
		end

		# si al agregar la carta se pasa o da 21, si tiene otro juego pasa automáticamente al otro juego,
		# sino, se queda ahi
		if (self.valor(@numero_juego + 1) >= 21 && nil != @juegos[@numero_juego + 1])
			@numero_juego += 1
		end
	end

	def valor numero_juego
		suma = 0
		cantidad_cartas_con_valor_especial = 0
		@juegos[numero_juego - 1].each{ |carta|
			suma += carta.getValor
			if 11 == carta.getValor 
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
		@numero_juego += 1
	end

	def aperturar
		if self.puedeAperturar?
			segunda_carta = @juegos[@numero_juego].pop
			@numero_juego += 1
			self.agregarCarta segunda_carta
			@numero_juego -= 1
		end
	end

	def puedeAperturar?
		# para poder aperurar:
		#  - se puede solo en el primer juego
		#  - debe haber solo 2 cartas
		#  - el valor de las 2 cartas debe ser igual 

		if (0 == @numero_juego && 2 == @juegos[0].size)
			juego = @juegos[0]
			juego[0].getValor == juego[1].getValor
		end
	end
end
