class Carta
	def initialize numero, palo, valor
		@numero = numero
		@palo = palo
		@valor = valor
	end

	def getNumero
		@numero
	end

	def getPalo
		@palo
	end

	def getValor
		@valor
	end

	def print
		"#{@numero} #{@palo}"
	end
end
