$LOAD_PATH << File.dirname(__FILE__)
require 'Carta'
require 'Mazo'
require 'Sabot'

sabot = Sabot.new 1
sabot.mezclar
cartas = sabot.getCartas

puts cartas.size
cartas.each { |carta|
#	 puts carta.print
}

num = 1
while !sabot.getCartas.empty?
	carta_espiada = sabot.mirarProximasCartas 2
	puts carta_espiada
	carta = sabot.obtenerSiguienteCarta
	puts "#{num}\t#{carta.print}"
	num += 1
end
