class Carta
	def initialize numero, palo, valor
		@numero = numero
		@palo = palo
		@valor = valor
	end

	def get_numero
		@numero
	end

	def get_palo
		@palo
	end

	def get_valor
		@valor
	end

	def print
		"#{@numero} #{@palo}"
	end
end
