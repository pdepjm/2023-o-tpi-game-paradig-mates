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
	// Saber si hay un objeto en una posicion determinada.
	method hayMinoEn(posicion) = (self.posicionesOcupadas()).contains(posicion)
	
	// Generar nuestro tablero del tetris.
	method generarTablero() {
		// Imagen del tablero (Se aplica la imagen cuadrado a cuadrado)
		game.ground("background.png")
		
		// TODO: Pintar tablero inicial (Solo para pruebas)
		self.mostrarMinosOcupados()
	}
	
	method incrustarPieza(pieza) {
		// Agregamos la pieza a la lista
		self.agregarMinosOcupados(pieza)
		// TODO: Verificamos si existe linea completa (Si existe se elimina y se bajan las superiores)
		
		// Mostramos los minos ocupados.
		self.mostrarMinosOcupados()
	}
	
	// Agregar los minos de la pieza a los minos ocupados.
	method agregarMinosOcupados(pieza) {
		pieza.minos().forEach({mino => minosOcupados.add(mino)})
	}
	
	// Mostrar/pintar los minos ocupados en tablero.
	method mostrarMinosOcupados() {
		minosOcupados.forEach({mino => game.addVisual(mino)})
	}
}