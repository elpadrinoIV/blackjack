require 'mazo'

class Sabot
	def initialize cantidad_mazos
		@cartas = Array.new
		(1..cantidad_mazos).each { |numero_mazo|
			@cartas += Mazo.new.get_cartas
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

	# devuelve las cartas que van a salir, en el orden que van a salir
	def mirar_proximas_cartas cantidad_cartas
		if (cantidad_cartas > 0 && cantidad_cartas <= @cartas.size)
			@cartas[-cantidad_cartas, cantidad_cartas].reverse
		else
			nil
		end
	end

	def obtener_siguiente_carta
		@cartas.pop
	end
end
