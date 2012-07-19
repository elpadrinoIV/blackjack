module Estadistica
  class CalculadorEstadisticas
    def initialize
    end

    def media_aritmetica valores
      self.suma(valores).to_f/valores.size
    end

    def desvio_standard valores
      Math::sqrt(varianza(valores))
    end

    def varianza valores
      media = self.media_aritmetica(valores)
      suma = 0
      valores.each{ |valor|
        suma += (valor.to_f - media)*(valor.to_f - media)
      }
      suma.to_f / (valores.size.to_f - 1.0)
    end

    def suma valores
      suma = 0
      valores.each{ |valor|
        suma += valor
      }
      suma
    end
  end
end
