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
	// Minos ocupados en tablero.
	const minosOcupados = [new Mino(position = game.at(3, 0), image = "pieza_z.png"), new Mino(position = game.at(8, 0), image = "pieza_z.png")] // TODO: limpiar luego.
	
	// Obtener las posiciones del tablero ocupados por minos.
	method posicionesOcupadas() = minosOcupados.map({mOcupados => mOcupados.position()})
	
	// Generar nuestro tablero del tetris.
	method generarTablero() {
		// Imagen del tablero (Se aplica la imagen cuadrado a cuadrado)
		game.ground("background.png")
		
		// TODO: Pintar tablero inicial (Solo para pruebas)
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