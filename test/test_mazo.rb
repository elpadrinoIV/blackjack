require File.dirname(__FILE__) + '/helper.rb'

require 'mazo'

class TestMazo < Test::Unit::TestCase
  def setup
    @mazo = Mazo.new
  end

	def test_cantidad_cartas_inicio
		cantidad_cartas = @mazo.get_cartas.size
		assert_equal(52, cantidad_cartas, "deberian haber 52 cartas")
	end

	def test_cantidad_cartas_despues_de_mezclar
		@mazo.mezclar
		cantidad_cartas = @mazo.get_cartas.size
		assert_equal(52, cantidad_cartas, "deberian haber 52 cartas")
	end

  def test_valor_cartas
    @mazo.get_cartas.each { |carta|
      case carta.get_numero
      when "1"
        assert_equal(11, carta.get_valor, "El as vale 11")
      when "2"
        assert_equal(2, carta.get_valor, "El 2 vale 2")
      when "3"
        assert_equal(3, carta.get_valor, "El 3 vale 3")
      when "4"
        assert_equal(4, carta.get_valor, "El 4 vale 4")
      when "5"
        assert_equal(5, carta.get_valor, "El 5 vale 5")
      when "6"
        assert_equal(6, carta.get_valor, "El 6 vale 6")
      when "7"
        assert_equal(7, carta.get_valor, "El 7 vale 7")
      when "8"
        assert_equal(8, carta.get_valor, "El 8 vale 8")
      when "9"
        assert_equal(9, carta.get_valor, "El 9 vale 9")
      when "10", "J", "Q", "K"
        assert_equal(10, carta.get_valor, "10, J, Q y K valen 10")
      end
    }
  end
end
