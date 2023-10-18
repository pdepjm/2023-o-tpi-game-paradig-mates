import wollok.game.*
import piezas.*

/* ¿Cómo se genera el tablero en Wollok?
	- n -> Max. Columnas.
	- m -> Max. Filas.
	
	↑ +Y (Aumentan las Y)

	+-------+-------+-------+-------+-------+	→ +X (Aumentan las X)
	| (0,m)	| (1,m)	| (2,m)	| ...	| (n,m)	|
	+-------+-------+-------+-------+-------+
	| ...	| ...	| ...	| ...	| ...	|
	+-------+-------+-------+-------+-------+
	| (0,2)	| (1,2)	| (2,2)	| ...	| (n,2)	|
	+-------+-------+-------+-------+-------+
	| (0,1)	| (1,1)	| (2,1)	| ...	| (n,1)	|
	+-------+-------+-------+-------+-------+
	| (0,0) | (1,0)	| (2,0)	| ...	| (n,0)	|
	+-------+-------+-------+-------+-------+
	
	En nuestro caso, el tablero original del tetris posee: 20 filas y 10 columnas.
*/

object tablero {
	// Dimensiones tablero.
	const property largo = 10
	const property alto = 20
	// Minos ocupados en tablero.
	const minosOcupados = []
	
	// Obtener las posiciones del tablero ocupados por minos.
	method posicionesOcupadas() = minosOcupados.map({mOcupados => mOcupados.position()})
	// Saber si hay un mino en una posicion determinada.
	method hayMinoEn(posicion) = (self.posicionesOcupadas()).contains(posicion)
	// Saber si una posicion esta dentro de los limites.
	method dentroMargenDerecho(numero) = numero < largo - 1
	method dentroMargenIzquierdo(numero) = numero > 0
	method dentroMargenAbajo(numero) = numero > 0
	method dentroMargenArriba(numero) = numero < alto - 1
	
	// Generar nuestro tablero del tetris.
	method generarTablero() {
		// Imagen del tablero (Se aplica la imagen cuadrado a cuadrado)
		game.ground("background.png")
	}
	
	method incrustarPieza(pieza) {
		// Removemos los minos ocupados.
		minosOcupados.forEach({mino => game.removeVisual(mino)})
		// Agregamos la pieza a la lista.
		self.agregarMinosOcupados(pieza)
		// Verificamos si existe linea completa (Si existe se elimina y se bajan las superiores)
		self.eliminarLinea()
		// Mostramos los minos ocupados.
		self.mostrarMinosOcupados()
	}
	
	// TODO: Eliminar linea y bajar minos superiores.
	method eliminarLinea() {
		// Obtener las filas completas.
		
		// Eliminar fila completas
		
		// Bajar minos superiores.
		
		// Sumar puntos
		
	}
	
	// Agregar los minos de la pieza a los minos ocupados.
	method agregarMinosOcupados(pieza) {
		pieza.minos().forEach({mino => minosOcupados.add(new Mino(position = mino.position(), image = mino.image()))})
	}
	
	// Mostrar/pintar los minos ocupados en tablero.
	method mostrarMinosOcupados() {
		minosOcupados.forEach({mino => game.addVisual(mino)})
	}
	
	// Saber si puede moverse a un Lugar.
	method puedeMoverAbajo(pieza) = (pieza.minos()).all({mino =>
		self.dentroMargenAbajo(mino.position().y()) and not self.hayMinoEn(mino.position().down(1))
	})
	method puedeMoverArriba(pieza) = (pieza.minos()).all({mino =>
		self.dentroMargenArriba(mino.position().y()) and not self.hayMinoEn(mino.position().up(1))
	})
	method puedeMoverDerecha(pieza) = (pieza.minos()).all({mino =>
		self.dentroMargenDerecho(mino.position().x()) and not self.hayMinoEn(mino.position().right(1))
	})
	method puedeMoverIzquierda(pieza) = (pieza.minos()).all({mino =>
		self.dentroMargenIzquierdo(mino.position().x()) and not self.hayMinoEn(mino.position().left(1))
	})
	// Saber si puede rotar a un Lugar.
	method puedeRotar(pieza) = (pieza.minos()).all({mino =>
		self.dentroMargenAbajo(pieza.rotarCoordenadas(mino).y() + 1) and
		self.dentroMargenArriba(pieza.rotarCoordenadas(mino).y() - 1) and
		self.dentroMargenIzquierdo(pieza.rotarCoordenadas(mino).x() + 1) and
		self.dentroMargenDerecho(pieza.rotarCoordenadas(mino).x() - 1) and
		not self.hayMinoEn(pieza.rotarCoordenadas(mino))
	})
}

///////////////////////////////////////////////////////////////////////////////
// Borde del Tablero.
///////////////////////////////////////////////////////////////////////////////
// TODO: No olvidar de buscar los colores definitivos.
// Pieza del tetris (pieza de forma Z)
object bordeTablero {
	
}