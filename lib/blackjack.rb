=begin
%w[ calculadorPagoApuestas carta croupier game juego_persona \
jugador jugadorConservador mazo mockJugador sabot].each{ |file|
	require File.expand_path("../blackjack/#{file}", __FILE__)
=end
%w[blackjack estadistica].each{ |libreria|
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "./#{libreria}"))
}

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "./"))

Dir['blackjack/*.rb'].each { |file|
  require file
}

Dir['estadistica/*.rb'].each { |file|
  require file
}

veces_que_gano_croupier = 0
repeticiones = 1000
dinero_ganado_por_croupier = Array.new
gano_croupier = Array.new

dinero_ganado_por_jugadores = Array.new
ganaron_jugadores = Array.new
(1..4).each{ |nro_jugador|
  dinero_ganado_por_jugadores << Array.new
  ganaron_jugadores << Array.new
}

puts "Jugando..."
(1..repeticiones).each{|repeticion|
  g = Game.new
  dinero_inicial_jugadores = 10000
  dinero_inicial_croupier = g.get_croupier.get_dinero
  (1..4).each{ |jugador|
    g.agregar_jugador(JugadorTramposo.new(dinero_inicial_jugadores, g))
  }
  g.set_cantidad_cartas_para_corte(30)
  g.jugar_ronda
  if g.get_croupier.get_dinero > dinero_inicial_croupier
    gano_croupier << 1
  else
    gano_croupier << 0
  end
  dinero_ganado_por_croupier << g.get_croupier.get_dinero

  g.get_jugadores.each{ |jugador|
    nro_jugador = 0
    if jugador.get_dinero > dinero_inicial_croupier
      ganaron_jugadores[nro_jugador] << 1
    else
      ganaron_jugadores[nro_jugador] << 0
    end

    dinero_ganado_por_jugadores[nro_jugador] << jugador.get_dinero

    nro_jugador += 1
  }
}

puts "Calculando..."
calculador_estadisticas = Estadistica::CalculadorEstadisticas.new

suma = 0
gano_croupier.each { |gano|
  suma += gano
}

puts "Croupier: #{suma.to_f/gano_croupier.size.to_f*100}"
media_dinero_croupier = calculador_estadisticas.media_aritmetica(dinero_ganado_por_croupier)
desvio_dinero_croupier = calculador_estadisticas.desvio_standard(dinero_ganado_por_croupier)
puts "Dinero croupier: media: #{media_dinero_croupier}, desvio: #{desvio_dinero_croupier}"

nro_jugador = 1
(1..4).each{ |nro_jugador|
  suma = 0
  ganaron_jugadores[nro_jugador - 1].each { |gano|
    suma += gano
  }

  puts "Jugador #{nro_jugador} #{suma.to_f/ganaron_jugadores[nro_jugador - 1].size.to_f*100}"
  media_dinero_jugador = calculador_estadisticas.media_aritmetica(dinero_ganado_por_jugadores[nro_jugador - 1])
  desvio_dinero_jugador = calculador_estadisticas.desvio_standard(dinero_ganado_por_jugadores[nro_jugador - 1])
  puts "Dinero Jugador #{nro_jugador} media: #{media_dinero_jugador}, desvio: #{desvio_dinero_jugador}"

  nro_jugador += 1
}

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
