require File.dirname(__FILE__) + '/../helper.rb'

require 'calculador_estadisticas'

class TestEstadistica < Test::Unit::TestCase
	def setup
		@calculador_estadisticas = Estadistica::CalculadorEstadisticas.new
	end

	def teardown
		# nada...
	end

	def test_media_aritmetica
    valores = [2, 2, 2, 3, 4, 5, 7, 7, 7, 7, 7, 7, 9, 10]
    media_aritmetica = @calculador_estadisticas.media_aritmetica valores
    media_esperada = 5.64285714285714
    assert_near(media_esperada, media_aritmetica, 0.000005, "se esperaba #{media_esperada} pero se obtuvo #{media_aritmetica}")
  end

  def test_desvio
    valores = [2, 2, 2, 3, 4, 5, 7, 7, 7, 7, 7, 7, 9, 10]
    desvio_standard = @calculador_estadisticas.desvio_standard valores
    desvio_esperado = 2.64886
    assert_near(desvio_esperado, desvio_standard, 0.00005, "se esperaba #{desvio_esperado} pero se obtuvo #{desvio_standard}")
  end

  def assert_near(esperado, obtenido, margen = 0.000005, mensaje = "")
    # dentro de rango cuando obtenido esta dentro de esperado +- margen
    dentro_de_rango = (obtenido >= esperado - margen && obtenido <= esperado + margen)
    assert(dentro_de_rango, mensaje)
  end
end
