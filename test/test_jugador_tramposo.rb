require File.dirname(__FILE__) + '/helper.rb'

require 'jugador_tramposo'
require 'game'

class TestJugadorTramposo < Test::Unit::TestCase
	def setup
    @game = Game.new
		@jugador = JugadorTramposo.new(1000, @game)
    @game.agregar_jugador(@jugador)
	end

	def teardown
		# nada...
	end

	def test_debe_pedir_si_no_se_pasa_con_la_siguiente_carta
		#
    # Croupier      10   6  (16)
    #
    # Jugador       10    6  (16)
    # Siguiente carta: 4 (debe pedir)

    valores_cartas = [10, 10, 6, 6, 4]

    valores_cartas.reverse!

    cartas = Array.new
    valores_cartas.each{ |valor_carta|
      cartas << Carta.new(Mazo::NUMEROS[0], Mazo::PALOS[0], valor_carta)
    }

    @game.reemplazar_cartas_con_estas(cartas)

    @game.repartir

    assert(@jugador.pedir_carta?, "El jugador debe pedir carta porque no se pasa si pide otra")
	end

	def test_debe_plantar_si_se_pasa_con_la_siguiente_carta
    #
    # Croupier      10   6  (16)
    #
    # Jugador       10    6  (16)
    # Siguiente carta: 8 (no debe pedir)

    valores_cartas = [10, 10, 6, 6, 8]

    valores_cartas.reverse!

    cartas = Array.new
    valores_cartas.each{ |valor_carta|
      cartas << Carta.new(Mazo::NUMEROS[0], Mazo::PALOS[0], valor_carta)
    }

    @game.reemplazar_cartas_con_estas(cartas)

    @game.repartir

    assert(false == @jugador.pedir_carta?, "El jugador no debe pedir carta porque se pasa si pide otra")
	end

	def test_debe_pagar_seguro_si_croupier_tiene_blackjack
    #
    # Croupier      A   10  (21)
    #
    # Jugador       10    6  (16)
    # Siguiente carta: 3

    valores_cartas = [10, 11, 6, 10, 3]

    valores_cartas.reverse!

    cartas = Array.new
    valores_cartas.each{ |valor_carta|
      cartas << Carta.new(Mazo::NUMEROS[0], Mazo::PALOS[0], valor_carta)
    }

    @game.reemplazar_cartas_con_estas(cartas)

    @game.repartir

    assert(@jugador.pagar_seguro?, "El jugador debe pagar seguro porque el croupier tiene blackjack")
	end

  def test_no_debe_pagar_seguro_si_croupier_no_tiene_blackjack
    #
    # Croupier      A   8  (19)
    #
    # Jugador       10    6  (16)
    # Siguiente carta: 3

    valores_cartas = [10, 11, 6, 8, 3]

    valores_cartas.reverse!

    cartas = Array.new
    valores_cartas.each{ |valor_carta|
      cartas << Carta.new(Mazo::NUMEROS[0], Mazo::PALOS[0], valor_carta)
    }

    @game.reemplazar_cartas_con_estas(cartas)

    @game.repartir

    assert(false == @jugador.pagar_seguro?, "El jugador no debe pagar seguro porque el croupier no tiene blackjack")
	end

  def test_debe_duplicar_si_le_gana_al_croupier_y_croupier_tiene_17_o_mas
    # si el croupier tiene 17 o mas (no puede pedir carta) y duplicando le gana, debe duplicar
    #
    # Croupier      10   7  (21)
    #
    # Jugador       6    5  (11)
    # Siguiente carta: 9 (debe duplicar porque gana)

    valores_cartas = [6, 10, 5, 7, 9]

    valores_cartas.reverse!

    cartas = Array.new
    valores_cartas.each{ |valor_carta|
      cartas << Carta.new(Mazo::NUMEROS[0], Mazo::PALOS[0], valor_carta)
    }

    @game.reemplazar_cartas_con_estas(cartas)

    @game.repartir

    assert(@jugador.duplicar?, "El jugador debe duplicar porque gana seguro")
  end

  def test_no_debe_duplicar_si_no_le_gana_al_croupier_y_croupier_tiene_17_o_mas
    # si el croupier tiene 17 o mas (no puede pedir carta) y duplicando no le gana, no debe duplicar
    #
    # Croupier      10   7  (21)
    #
    # Jugador       6    5  (11)
    # Siguiente carta: 4 (no debe duplicar porque pierde)

    valores_cartas = [6, 10, 5, 7, 4]

    valores_cartas.reverse!

    cartas = Array.new
    valores_cartas.each{ |valor_carta|
      cartas << Carta.new(Mazo::NUMEROS[0], Mazo::PALOS[0], valor_carta)
    }

    @game.reemplazar_cartas_con_estas(cartas)

    @game.repartir

    assert(false == @jugador.duplicar?, "El jugador no debe duplicar porque pierde seguro")
  end
end
