require 'game'
require 'jugador'

class JugadorTramposo < Jugador
  attr_accessor :dinero_apuesta
	def initialize dinero, game
		super(dinero)
		@game = game
    @dinero_apuesta = 50
	end

	def pedir_carta?
    if !super
      return false
    end

    # pido si no me paso
    proxima_carta = @game.get_sabot.mirar_proximas_cartas(1)[0]
    suma_posible = self.suma_si_agrego_estas_cartas([proxima_carta])

		if (suma_posible <= 21)
      true
    else
      @juego.plantar
      @juego.sigue_en_juego?
    end

	end

	def aperturar?
    @juego.puede_aperturar?
	end

  def duplicar?
    if @juego.puede_duplicar?
      # si gana seguro, duplica, si pierde seguro, no duplica.
      # si quedan dudas, no esta definido, pero pongamosle que no duplica

      # si el croupier tiene menos de 17, no se que puede pasar, asi que
      # por las dudas no duplica
      if @game.get_croupier.get_juego.valor(1) < 17
        return false
      end

      proxima_carta = @game.get_sabot.mirar_proximas_cartas(1)[0]
      
      suma_croupier = @game.get_croupier.get_juego.valor(1)
      suma_posible = self.suma_si_agrego_estas_cartas([proxima_carta])
      
      suma_posible > suma_croupier
    else
      false
    end
  end

	def pagar_seguro?
		@game.get_croupier.get_juego.tiene_blackjack?
	end

  def apostar
    @apuestas_juegos[0] = @dinero_apuesta
    @dinero -= @dinero_apuesta
  end

  def suma_si_agrego_estas_cartas cartas
    juego_posible = JuegoPersona.new
    @juego.get_juegos[0].each { |carta|
      juego_posible.agregar_carta(carta.clone)
    }

    cartas.each{ |carta|
      juego_posible.agregar_carta(carta.clone)
    }

    return juego_posible.valor(1)
  end
end