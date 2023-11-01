import wollok.game.*
import Entorno.*

//////////////////////////////////////////////////////////
// TABLERO DE JUEGO.
//////////////////////////////////////////////////////////
// Parte del tablero jugable.
object tablero {
	// Minos acumulados.
	const property minosAcumulados = []
	
	// Dimensiones jugables.
	method ancho() = 10
	method alto() = 20
	
	// Saber si un mino esta dentro de los limites jugables.
	method esValida(posicion) = posicion.x().between(1, self.ancho()) and posicion.y().between(1, self.alto())
	// Saber si hay un mino en una posicion determinada.
	method hayMinoEn(posicion) = self.posicionesOcupadas().contains(posicion)
	
	// Saber si una pieza se puede mover a una determinada posicion.
	method puedeBajar(pieza) = pieza.minos().all({mino => self.esValida(mino.position().down(1)) and not self.hayMinoEn(mino.position().down(1))})
	method puedeDerecha(pieza) = pieza.minos().all({mino => self.esValida(mino.position().right(1)) and not self.hayMinoEn(mino.position().right(1))})
	method puedeIzquierda(pieza) = pieza.minos().all({mino => self.esValida(mino.position().left(1)) and not self.hayMinoEn(mino.position().left(1))})
	// Saber si una pieza puede rotar en sentido horario.
	method puedeRotar(pieza) = pieza.minos().all({mino => self.esValida(pieza.rotarCoordenadas(mino)) and not self.hayMinoEn(pieza.rotarCoordenadas(mino))})
	// Saber si se puede generar una pieza en una posicion determinada.
	method puedeGenerar(pieza) = pieza.minos().all({mino => not self.hayMinoEn(mino.position())})
	
	// Obtener las posiciones de los minos acumulados.
	method posicionesOcupadas() = minosAcumulados.map({mino => mino.position()})
	// Obtener las filas que estan completas.
	method filasCompletas(posiciones) = (0..self.alto()).filter({fila => posiciones.filter({posicion => posicion.y() == fila}).size() == self.ancho()})
	// Obtener la cantidad de posiciones que va a bajar un mino por completar filas.
	method cantidadBajar(mino, filasCompletas) = filasCompletas.count({fila => mino.position().y() > fila})
	
	// Agregar los minos de una pieza dada a la lista de minos acumulados.
	method agregarMinosDe(pieza) {
		minosAcumulados.addAll(pieza.minos())
	}
	
	// Incrustar los minos de una pieza en el tablero.
	method incrustar(pieza) {
		// Agregamos la pieza a la lista.
		self.agregarMinosDe(pieza)
		// Reproducir sonido al incrustar.
		game.sound("Sonidos/Incrustar.wav").play()
		// Eliminar filas completadas y bajar las filas superiores.
		self.eliminarFilas()
	}
	
	// Eliminar filas que estan completas.
	method eliminarFilas() {
		// Obtener una lista con las filas completas.
		const filasCompletas = self.filasCompletas(self.posicionesOcupadas())
		
		// Si hay filas completas.
		if(not filasCompletas.isEmpty()) {
			// Eliminar las filas completas.
			minosAcumulados.forEach({mino => 
				if(filasCompletas.contains(mino.position().y())) {
					// Eliminar filas completas.
					minosAcumulados.remove(mino)
					game.removeVisual(mino)
				}
				// Bajar filas superiores.
				mino.position(mino.position().down(self.cantidadBajar(mino, filasCompletas)))
			})
			
			// Modificar puntaje obtenido y filas completadas.
			hub.modificarContadores(filasCompletas)
			// Reproducir sonido al eliminar filas.
			game.sound("Sonidos/EliminarFila.wav").play()
		}
	}
	
	// Resetear tablero.
	method resetear() {
		minosAcumulados.forEach({mino => game.removeVisual(mino)})
		minosAcumulados.clear()
	}
	
	// Bajar la pieza totalmente e incrustarla.
	method bajarIncrustar(pieza) {
		if(self.puedeBajar(pieza)){
			pieza.moverAbajo()
			self.bajarIncrustar(pieza)
		}
	}
}

// Muros delimitantes.
object muros{
	// Cantidad de minos / Espesor del muro.
	method cantLados() = 2 // Lado derecho y Lado Izquierdo.
	method cantSuelo() = 1 // Suelo.
	
}