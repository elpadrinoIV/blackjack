require 'carta'

class Mazo
	PALOS = [:trebol, :diamantes, :corazones, :picas]

	# Aunque "número" no es el mejor nombre
	NUMEROS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
	def initialize
		@cartas = Array.new
		NUMEROS.each { |num|
			PALOS.each { |palo|
				valor = 1
				@cartas << Carta.new(num, palo, valor)
			}
		}
	end

	def get_cartas
		@cartas
	end

	def mezclar
		cantidad_cartas = @cartas.size
		(1..cantidad_cartas).each { |carta|
			carta -= 1
			numero_random = rand(cantidad_cartas)
			temp = @cartas[numero_random]
			@cartas[numero_random] = @cartas[carta]
			@cartas[carta] = temp
		}
	end

end
