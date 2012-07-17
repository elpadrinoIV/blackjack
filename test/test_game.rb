require File.dirname(__FILE__) + '/helper.rb'

require 'croupier'
require 'game'
require 'mock_jugador'

class TestGame < Test::Unit::TestCase
	def setup
		@game = Game.new
    @dinero_inicial_jugadores = 10000
		(1..3).each{ |jugador|
			@game.agregar_jugador(MockJugador.new(@dinero_inicial_jugadores))
		}
	end

	def teardown
		# nada...
	end

	def test_repartir_solo_a_los_que_apostaron
		# apuestan los primeros 2, solo deben recibir cartas esos 2, y el croupier
		nro_jugador = 1
		@game.get_jugadores.each { |jugador|
			if (nro_jugador <= 2)
				jugador.apostar
			end

			nro_jugador += 1
		}

		@game.repartir

		@game.get_jugadores.each { |jugador|
			cartas_jugador = jugador.get_juego.get_juegos.first
			apuesta_jugador = jugador.get_apuestas.first
			if (apuesta_jugador > 0)
				assert_equal(2, cartas_jugador.size, "El jugador aposto, deberia haber recibido cartas")
			else
				assert_equal(0, cartas_jugador.size, "El jugador no aposto, no deberia haber recibido cartas")
			end
		}

		cartas_croupier = @game.get_croupier.get_juego.get_juegos.first
		assert_equal(2, cartas_croupier.size, "El croupier deberia haber recibido cartas")
	end

	def test_cuando_termina_la_mano_todo_a_cero
		# se reparte, se juega, se termina la mano. Las apuestas deben quedar todas en 0,
		# ningun jugador debe tener cartas, seguro, etc
		
		@game.get_jugadores.each { |jugador|
			jugador.apostar
		}

		@game.repartir
		@game.fin_mano

		@game.get_jugadores.each { |jugador|
			jugador.get_juego.get_juegos.each{ |juego|
				assert_equal(0, juego.size, "Cuando termina la mano el jugador no debe tener mas cartas")
			}
      
			jugador.get_apuestas.each{ |apuesta|
				assert_equal(0, apuesta, "Cuando termina la mano no hay mas apuestas")
			}

			assert_equal(0, jugador.get_apuesta_seguro, "Cuando termina la mano no hay mas apuestas")
		}

		@game.get_croupier.get_juego.get_juegos.each{ |juego|
			assert_equal(0, juego.size, "Cuando termina la mano el croupier no debe tener mas cartas")
		}
	end

  def test_mano_completa_normal
		# 4 jugadores, la banca se pasa, 3 jugadores no se pasan, 1 se pasa (ganan 3)
    # las cartas que se reparten son:
    #
    #         (16)
    #          6
    #         10
    #
    #  (15)  (19) (11)  (19)
    #   8      9   9    10
    #   7     10   2     9
    #
    # Al finalizar queda:
    #
    #         (23)
    #           6
    #          10
    #           7
    #
    #  (19)  (19) (23)  (19)
    #   8      9   9    10
    #   7     10   2    9
    #   4          4
    #              8

    valores_cartas = [10, 9, 9, 8, 6,
                      9, 2, 10, 7, 10,
                      4, 8,
                      4,
                      7]

    valores_cartas.reverse!

    cartas = Array.new
    valores_cartas.each{ |valor_carta|
      cartas << Carta.new(Mazo::NUMEROS[0], Mazo::PALOS[0], valor_carta)
    }

    dinero_inicial_croupier = @game.get_croupier.get_dinero

    @game.agregar_jugador(MockJugador.new(10000))
    
    @game.reemplazar_cartas_con_estas(cartas)

    @game.jugar_mano

    nro_jugador = 1
		@game.get_jugadores.each{|jugador|
      if (2 != nro_jugador)
        assert_equal(@dinero_inicial_jugadores + 50, jugador.get_dinero, "El jugador #{nro_jugador} deberia haber ganado plata por ganar la mano")
      else
        assert_equal(@dinero_inicial_jugadores - 50, jugador.get_dinero, "El jugador #{nro_jugador} no deberia haber ganado plata por haber perdido la mano")
      end
      
      nro_jugador += 1
    }

    assert_equal(dinero_inicial_croupier -100, @game.get_croupier.get_dinero, "El croupier deberia haber pagado a 3 y cobrado a 1")
	end

  def test_mano_con_aperturas_normales
		# Aperturan todos
    # Jugador 1:  gana 1 pierde 1 (0)
    # Jugador 2: pierde ambos (-100)
    # Jugador 3: gana ambos (+100)
    # Jugador 4: gana 1 empata 1 (+50)
    # las cartas que se reparten son:
    #
    #          6
    #         10
    #
    #   8      9   9    10
    #   8      9   9    10
    #
    # Al finalizar queda:
    #
    #         (18)
    #           6
    #          10
    #           2
    #
    #  (19)(18)  (19)(19)  (24)(23)  (20)(17)
    #   8    8     9   9     9   9    10  10
    #   A   10    10  10     6   6    10   7
    #                        9   8
    #
    valores_cartas = [10, 9, 9, 8, 6,
                      10, 9, 9, 8, 10,
                      10,
                      7,
                      6, 9,
                      6, 8,
                      10,
                      10,
                      11,
                      10,
                      2
                      ]
    
    valores_cartas.reverse!

    cartas = Array.new
    valores_cartas.each{ |valor_carta|
      cartas << Carta.new(Mazo::NUMEROS[0], Mazo::PALOS[0], valor_carta)
    }

    dinero_inicial_croupier = @game.get_croupier.get_dinero

    @game.agregar_jugador(MockJugador.new(10000))

    @game.reemplazar_cartas_con_estas(cartas)

    @game.jugar_mano

    nro_jugador = 1
		@game.get_jugadores.each{|jugador|
      case nro_jugador
      when 1
        assert_equal(@dinero_inicial_jugadores, jugador.get_dinero, "El jugador #{nro_jugador} gana 1 y pierde 1, queda en 0")
      when 2
        assert_equal(@dinero_inicial_jugadores - 100, jugador.get_dinero, "El jugador #{nro_jugador} pierde ambos, -100")
      when 3
        assert_equal(@dinero_inicial_jugadores + 100, jugador.get_dinero, "El jugador #{nro_jugador} gana ambos, +100")
      when 4
        assert_equal(@dinero_inicial_jugadores + 50, jugador.get_dinero, "El jugador #{nro_jugador} gana 1 y empata 1, +50")
      end
      
      nro_jugador += 1
    }

    assert_equal(dinero_inicial_croupier - 50, @game.get_croupier.get_dinero, "El croupier deberia haber pagado a 4 y cobrado a 3")
	end

  def test_mano_con_aperturas_pseudo_blackjack_croupier_sin_blackjack
		# Aperturas con 2 aces y con 2 diez
    # Jugador 1:  apertura con 2 aces, dps saca un 10 y un 2 (no puede seguir pidiendo) (0)
    # Jugador 2: apertura con 2 dieces, dps saca as y (4, 5) (+100)
    # Jugador 3: apertura con 2 aces, dps as y as (no puede seguir pidiendo(-100)
    # Jugador 4: apertura con 2 dieces, se pasa en ambas (-100)
    # las cartas que se reparten son:
    #
    #        (16)
    #          6
    #         10
    #
    #  (20)   (12)   (20)   (12)
    #   10      A     10      A
    #   10      A     10      A
    #
    # Al finalizar queda:
    #
    #         (18)
    #           6
    #          10
    #           2
    #
    #  (23)(24)  (12)(12)  (21)(19)  (21)(13)
    #   10  10     A   A    10  10     A   A
    #    4   5     A   A     A   4    10   2
    #    9   9                   5
    #
    valores_cartas = [11, 10, 11, 10, 6,
                      11, 10, 11, 10, 10,
                      10,
                      2,
                      11,
                      4, 5,
                      11,
                      11,
                      4, 9,
                      5, 9,
                      2
                      ]

    valores_cartas.reverse!

    cartas = Array.new
    valores_cartas.each{ |valor_carta|
      cartas << Carta.new(Mazo::NUMEROS[0], Mazo::PALOS[0], valor_carta)
    }

    dinero_inicial_croupier = @game.get_croupier.get_dinero

    @game.agregar_jugador(MockJugador.new(10000))

    @game.reemplazar_cartas_con_estas(cartas)

    @game.jugar_mano

    nro_jugador = 1
		@game.get_jugadores.each{|jugador|
      case nro_jugador
      when 1
        assert_equal(@dinero_inicial_jugadores, jugador.get_dinero, "El jugador #{nro_jugador} gana 1 y pierde 1, queda en 0 (no vale blackjack en apertura)")
      when 2
        assert_equal(@dinero_inicial_jugadores + 100, jugador.get_dinero, "El jugador #{nro_jugador} gana ambos, +100 (no vale blackjack en apertura)")
      when 3
        assert_equal(@dinero_inicial_jugadores -100, jugador.get_dinero, "El jugador #{nro_jugador} pierde ambos, -100 (no vale blackjack en apertura)")
      when 4
        assert_equal(@dinero_inicial_jugadores - 100, jugador.get_dinero, "El jugador #{nro_jugador} pierde ambos, -100 (no vale blackjack en apertura)")
      end

      nro_jugador += 1
    }

    assert_equal(dinero_inicial_croupier + 100, @game.get_croupier.get_dinero, "El croupier deberia haber pagado a 3 y cobrado a 5")
	end

  def test_mano_con_aperturas_pseudo_blackjack_croupier_con_21
    # Parecido a test_mano_con_aperturas_pseudo_blackjack_croupier_sin_blackjack en donde el croupier empata con los que sacan 21 (no es blackjack)
		# Aperturas con 2 aces y con 2 diez
    # Jugador 1:  apertura con 2 aces, dps saca un 10 y un 2 (no puede seguir pidiendo) (-50)
    # Jugador 2: apertura con 2 dieces, dps saca as y (4, 5) (-50)
    # Jugador 3: apertura con 2 aces, dps as y as (no puede seguir pidiendo(-100)
    # Jugador 4: apertura con 2 dieces, 21 en ambas (0)
    # las cartas que se reparten son:
    #
    #        (16)
    #          6
    #         10
    #
    #  (20)   (12)   (20)   (12)
    #   10      A     10      A
    #   10      A     10      A
    #
    # Al finalizar queda:
    #
    #         (21)
    #           6
    #          10
    #           5
    #
    #  (23)(24)  (12)(12)  (21)(19)  (21)(13)
    #   10  10     A   A    10  10     A   A
    #    A   A     A   A     A   4    10   2
    #                            5
    #
    valores_cartas = [11, 10, 11, 10, 6,
                      11, 10, 11, 10, 10,
                      10,
                      2,
                      11,
                      4, 5,
                      11,
                      11,
                      11,
                      11,
                      5
                      ]

    valores_cartas.reverse!

    cartas = Array.new
    valores_cartas.each{ |valor_carta|
      cartas << Carta.new(Mazo::NUMEROS[0], Mazo::PALOS[0], valor_carta)
    }

    dinero_inicial_croupier = @game.get_croupier.get_dinero

    @game.agregar_jugador(MockJugador.new(10000))

    @game.reemplazar_cartas_con_estas(cartas)

    @game.jugar_mano

    nro_jugador = 1
		@game.get_jugadores.each{|jugador|
      case nro_jugador
      when 1
        assert_equal(@dinero_inicial_jugadores -50, jugador.get_dinero, "El jugador #{nro_jugador} empata 1 y pierde 1, -50 (no vale blackjack en apertura)")
      when 2
        assert_equal(@dinero_inicial_jugadores -50, jugador.get_dinero, "El jugador #{nro_jugador} empata 1 y pierde 1, -50 (no vale blackjack en apertura)")
      when 3
        assert_equal(@dinero_inicial_jugadores -100, jugador.get_dinero, "El jugador #{nro_jugador} pierde ambos, -100 (no vale blackjack en apertura)")
      when 4
        assert_equal(@dinero_inicial_jugadores, jugador.get_dinero, "El jugador #{nro_jugador} empata ambos, queda en 0 (no vale blackjack en apertura)")
      end

      nro_jugador += 1
    }

    assert_equal(dinero_inicial_croupier + 200, @game.get_croupier.get_dinero, "El croupier deberia haber cobrado a 6")
	end

  def test_mano_con_aperturas_pseudo_blackjack_croupier_con_blackjack
    # Parecido a test_mano_con_aperturas_pseudo_blackjack_croupier_con_21 pero ahora el croupier saca blackjack
		# Aperturas con 2 aces y con 2 diez
    # Jugador 1:  apertura con 2 aces, dps saca un 10 y un 2 (no puede seguir pidiendo) (-100)
    # Jugador 2: apertura con 2 dieces, dps saca as y (4, 5) (-100)
    # Jugador 3: apertura con 2 aces, dps as y as (no puede seguir pidiendo(-100)
    # Jugador 4: apertura con 2 dieces, se pasa en ambas (-100)
    # las cartas que se reparten son:
    #
    #        (21)
    #         10
    #          A
    #
    #  (20)   (12)   (20)   (12)
    #   10      A     10      A
    #   10      A     10      A
    #
    # Al finalizar queda:
    #
    #         (21)
    #          10
    #           A
    #
    #  (23)(24)  (12)(12)  (21)(19)  (21)(13)
    #   10  10     A   A    10  10     A   A
    #    A   A     A   A     A   4    10   2
    #                            5
    #
    valores_cartas = [11, 10, 11, 10, 10,
                      11, 10, 11, 10, 11,
                      10,
                      2,
                      11,
                      4, 5,
                      11,
                      11,
                      11,
                      11
                      ]

    valores_cartas.reverse!

    cartas = Array.new
    valores_cartas.each{ |valor_carta|
      cartas << Carta.new(Mazo::NUMEROS[0], Mazo::PALOS[0], valor_carta)
    }

    dinero_inicial_croupier = @game.get_croupier.get_dinero

    @game.agregar_jugador(MockJugador.new(10000))

    @game.reemplazar_cartas_con_estas(cartas)

    @game.jugar_mano

    nro_jugador = 1
		@game.get_jugadores.each{|jugador|
      assert_equal(@dinero_inicial_jugadores -100, jugador.get_dinero, "El jugador #{nro_jugador} pierde, -100 (no vale blackjack en apertura)")
      
      nro_jugador += 1
    }

    assert_equal(dinero_inicial_croupier + 400, @game.get_croupier.get_dinero, "El croupier deberia haber cobrado a 8 (gano con blackjack a todos)")
	end

end
