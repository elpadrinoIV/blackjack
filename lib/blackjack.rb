require './game.rb'
require './jugadorConservador.rb'

game = Game.new

(1..3).each{ |j|
	game.agregarJugador(JugadorConservador.new(10000, 12))
}

game.repartir

cartas_croupier = game.getCroupier.getJuego.getJuegos.first
puts "Cartas croupier: #{cartas_croupier[0].print} - #{cartas_croupier[1].print}"

nro_jugador = 1
game.getJugadores.each{ |jugador|
	cartas_jugador = jugador.getJuego.getJuegos.first
	puts "Cartas jugador nro #{nro_jugador} (#{cartas_jugador.size}): #{cartas_jugador[0].print} - #{cartas_jugador[1].print}"
	nro_jugador += 1
}
	
