=begin
%w[ calculadorPagoApuestas carta croupier game juego_persona \
jugador jugadorConservador mazo mockJugador sabot].each{ |file|
	require File.expand_path("../blackjack/#{file}", __FILE__)
=end
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "./blackjack"))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "./"))

Dir['blackjack/*.rb'].each { |file|
  require file
}

veces_que_gano_croupier = 0
repeticiones = 100
(1..repeticiones).each{|repeticion|
  g = Game.new
  dinero_inicial_jugadores = 10000
  dinero_inicial_croupier = g.get_croupier.get_dinero
  (1..4).each{ |jugador|
    g.agregar_jugador(JugadorConservador.new(dinero_inicial_jugadores, 12))
  }
  g.set_cantidad_cartas_para_corte(25)
  g.jugar_ronda
  if g.get_croupier.get_dinero > dinero_inicial_croupier
    veces_que_gano_croupier += 1
  end
}


puts "Veces que gana croupier: #{veces_que_gano_croupier}"
# puts "Croupier: #{g.get_croupier.get_dinero}"

# nro_jugador = 0
# g.get_jugadores.each{|jugador|
#   puts "Jugador #{nro_jugador}: #{jugador.get_dinero}"
#  nro_jugador += 1
# }

module Blackjack
=begin
  def self.transform_file(sourcename, targetname, model)
    source = IO.read(sourcename)
    template = Template.new(source)
    result = template.render(model)
    IO.write(targetname, result)
  end
=end
end
=begin
class NilClass
	def method_missing(*args)
		if args.length == 1
			return self
		else
			super
		end
	end
end
=end
