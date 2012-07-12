require "./mazo"
require "test/unit"

class TestMazo < Test::Unit::TestCase
	def test_cantidad_cartas_inicio
		mazo = Mazo.new
		cantidad_cartas = mazo.getCartas.size
		assert_equal(52, cantidad_cartas, "deberian haber 52 cartas")
	end
	def test_cantidad_cartas_despues_de_mezclar
		mazo = Mazo.new
		mazo.mezclar
		cantidad_cartas = mazo.getCartas.size
		assert_equal(52, cantidad_cartas, "deberian haber 52 cartas")
	end
end
