import wollok.game.*

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
	// Generar nuestro tablero del tetris.
	method generarTablero() {
		// Imagen del tablero (Se aplica la imagen cuadrado a cuadrado)
		game.ground("background.png")
	}
}