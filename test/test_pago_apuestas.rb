require File.dirname(__FILE__) + '/helper.rb'

require 'mock_jugador'

class TestPagoApuestas < Test::Unit::TestCase
  def setup
    @dinero_inicial = 10000
    @dinero_apuesta = 50
    @jugador = MockJugador.new @dinero_inicial
    @jugador.dinero_apuesta = @dinero_apuesta
  end
  
	def test_jugador_gana_comun
    @jugador.apostar
    
    # jugador gana normal
    dinero_ganado = @dinero_apuesta
    @jugador.cobrar_apuesta(dinero_ganado)
    @jugador.guardar_dinero_apuesta 1

    dinero_que_deberia_tener = @dinero_inicial + @dinero_apuesta
    
		assert_equal(dinero_que_deberia_tener, @jugador.get_dinero, "El jugador gano y deberia haber cobrado")
    # me fijo que no quede plata en las apuestas

    @jugador.get_apuestas.each{ |apuesta|
      assert_equal(0, apuesta, "Despues de terminar la mano no deberia haber dinero en las apuestas")
    }
	end

  def test_jugador_pierde_comun
    @jugador.apostar

    dinero_cobrado = @jugador.entregar_dinero_apuesta 1

    dinero_que_deberia_tener = @dinero_inicial - @dinero_apuesta

		assert_equal(dinero_que_deberia_tener, @jugador.get_dinero, "El jugador perdio y no deberia haber cobrado")
    assert_equal(@dinero_apuesta, dinero_cobrado, "La banca deberia haber cobrado porque perdio el jugador")
    # me fijo que no quede plata en las apuestas
    @jugador.get_apuestas.each{ |apuesta|
      assert_equal(0, apuesta, "Despues de terminar la mano no deberia haber dinero en las apuestas")
    }
	end

  def test_jugador_apertura_y_gana_ambas
    @jugador.apostar
    @jugador.aperturar

    dinero_ganado = @dinero_apuesta*2
    @jugador.cobrar_apuesta(dinero_ganado)
    @jugador.guardar_dinero_apuesta 1
    @jugador.guardar_dinero_apuesta 2

    dinero_que_deberia_tener = @dinero_inicial + @dinero_apuesta*2

		assert_equal(dinero_que_deberia_tener, @jugador.get_dinero, "El jugador gano y deberia haber cobrado")
    # me fijo que no quede plata en las apuestas

    @jugador.get_apuestas.each{ |apuesta|
      assert_equal(0, apuesta, "Despues de terminar la mano no deberia haber dinero en las apuestas")
    }
	end

  def test_jugador_apertura_y_gana_una
    @jugador.apostar
    @jugador.aperturar

    dinero_ganado = @dinero_apuesta
    @jugador.cobrar_apuesta(dinero_ganado)
    @jugador.guardar_dinero_apuesta 1
    dinero_cobrado = @jugador.entregar_dinero_apuesta 2

    dinero_que_deberia_tener = @dinero_inicial

		assert_equal(dinero_que_deberia_tener, @jugador.get_dinero, "El jugador gano y deberia haber cobrado")
    assert_equal(@dinero_apuesta, dinero_cobrado, "La banca deberia haber cobrado porque perdio el jugador")

    # me fijo que no quede plata en las apuestas
    @jugador.get_apuestas.each{ |apuesta|
      assert_equal(0, apuesta, "Despues de terminar la mano no deberia haber dinero en las apuestas")
    }
	end

  def test_jugador_duplica_y_gana
    @jugador.apostar
    @jugador.duplicar

    dinero_ganado = @dinero_apuesta*2
    @jugador.cobrar_apuesta(dinero_ganado)
    @jugador.guardar_dinero_apuesta 1
    
    dinero_que_deberia_tener = @dinero_inicial + @dinero_apuesta*2

		assert_equal(dinero_que_deberia_tener, @jugador.get_dinero, "El jugador gano y deberia haber cobrado")
    
    # me fijo que no quede plata en las apuestas
    @jugador.get_apuestas.each{ |apuesta|
      assert_equal(0, apuesta, "Despues de terminar la mano no deberia haber dinero en las apuestas")
    }
	end

  def test_jugador_duplica_y_pierde
    @jugador.apostar
    @jugador.duplicar
    
    dinero_cobrado = @jugador.entregar_dinero_apuesta 1

    dinero_que_deberia_tener = @dinero_inicial - @dinero_apuesta*2

		assert_equal(dinero_que_deberia_tener, @jugador.get_dinero, "El jugador gano y deberia haber cobrado")
    assert_equal(@dinero_apuesta*2, dinero_cobrado, "La banca deberia haber cobrado porque perdio el jugador")

    # me fijo que no quede plata en las apuestas
    @jugador.get_apuestas.each{ |apuesta|
      assert_equal(0, apuesta, "Despues de terminar la mano no deberia haber dinero en las apuestas")
    }
	end

  def test_jugador_paga_seguro_no_blackjack_y_gana
    # paga seguro pero no sale blackjack. gana la mano
    @jugador.apostar
    @jugador.pagar_seguro

    dinero_cobrado = @jugador.entregar_dinero_apuesta_seguro

    dinero_ganado = @dinero_apuesta
    @jugador.cobrar_apuesta(dinero_ganado)
    @jugador.guardar_dinero_apuesta 1

    dinero_que_deberia_tener = @dinero_inicial + @dinero_apuesta - @dinero_apuesta/2

		assert_equal(dinero_que_deberia_tener, @jugador.get_dinero, "El jugador gano y deberia haber cobrado")
    assert_equal(@dinero_apuesta/2, dinero_cobrado, "La banca deberia haber cobrado porque perdio el jugador")

    # me fijo que no quede plata en las apuestas
    @jugador.get_apuestas.each{ |apuesta|
      assert_equal(0, apuesta, "Despues de terminar la mano no deberia haber dinero en las apuestas")
    }

    assert_equal(0, @jugador.get_apuesta_seguro, "Despues de terminar la mano no deberia haber dinero en las apuestas")
	end

  def test_jugador_paga_seguro_si_blackjack_y_pierde
    # paga seguro, sale blackjack y pierde la mano
    @jugador.apostar
    @jugador.pagar_seguro

    dinero_cobrado = @jugador.entregar_dinero_apuesta(1)

    dinero_ganado = @dinero_apuesta
    @jugador.cobrar_apuesta(dinero_ganado)
    @jugador.guardar_dinero_apuesta_seguro

    dinero_que_deberia_tener = @dinero_inicial

		assert_equal(dinero_que_deberia_tener, @jugador.get_dinero, "El jugador gano y deberia haber cobrado")
    assert_equal(@dinero_apuesta, dinero_cobrado, "La banca deberia haber cobrado porque perdio el jugador")

    # me fijo que no quede plata en las apuestas
    @jugador.get_apuestas.each{ |apuesta|
      assert_equal(0, apuesta, "Despues de terminar la mano no deberia haber dinero en las apuestas")
    }

    assert_equal(0, @jugador.get_apuesta_seguro, "Despues de terminar la mano no deberia haber dinero en las apuestas")
	end

end
