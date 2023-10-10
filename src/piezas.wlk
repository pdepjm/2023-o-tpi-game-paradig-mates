import wollok.game.*

///////////////////////////////////////////////////////////////////////////////
// Piezas del Tetris.
///////////////////////////////////////////////////////////////////////////////

// Pieza del tetris (pieza de forma Z)
object pieza_Z {
	const mino_1 = new Mino(ejeX = 3, ejeY = 19, imagen = "pieza_z.png")
	const mino_2 = new Mino(ejeX = 4, ejeY = 19, imagen = "pieza_z.png")
	const mino_3 = new Mino(ejeX = 4, ejeY = 18, imagen = "pieza_z.png")
	const mino_4 = new Mino(ejeX = 5, ejeY = 18, imagen = "pieza_z.png")
	
	const minos = [mino_1, mino_2, mino_3, mino_4]
	
	// Para generar nuestra pieza.
	method generarPieza() {
		minos.forEach({mino => game.addVisual(mino)})
	}
	
	// Movimiento de la pieza.
	method moverseHaciaArriba(){
		minos.forEach({mino => mino.position(mino.position().up(1))})
	}
	method moverseHaciaAbajo(){
		minos.forEach({mino => mino.position(mino.position().down(1))})
	}
	method moverseHaciaIzquierda(){
		minos.forEach({mino => mino.position(mino.position().left(1))})
	}
	method moverseHaciaDerecha(){
		minos.forEach({mino => mino.position(mino.position().right(1))})
	}
}
// Pieza del tetris (pieza de forma I)
object pieza_I {
	// Para generar nuestra pieza.
	method generarPieza() {
		// TODO: Implementar con la clase Mino.
	}
}

// Pieza del tetris (pieza de forma J)
object pieza_J {
	// Para generar nuestra pieza.
	method generarPieza() {
		// TODO: Implementar con la clase Mino.
	}
}

// Pieza del tetris (pieza de forma L)
object pieza_L {
	// Para generar nuestra pieza.
	method generarPieza() {
		// TODO: Implementar con la clase Mino.
	}
}

// Pieza del tetris (pieza de forma O)
object pieza_O {
	// Para generar nuestra pieza.
	method generarPieza() {
		// TODO: Implementar con la clase Mino.
	}
}

// Pieza del tetris (pieza de forma S)
object pieza_S {
	// Para generar nuestra pieza.
	method generarPieza() {
		// TODO: Implementar con la clase Mino.
	}
}

// Pieza del tetris (pieza de forma T)
object pieza_T {
	// Para generar nuestra pieza.
	method generarPieza() {
		// TODO: Implementar con la clase Mino.
	}
}

///////////////////////////////////////////////////////////////////////////////
// Clase
///////////////////////////////////////////////////////////////////////////////

// Sabemos que todas las piezas estan formadas por 4 minos (Cuadraditos)
class Mino {
	var property ejeX
	var property ejeY
	var property imagen
	var property position = game.at(ejeX, ejeY)
	
	method image() = imagen
}