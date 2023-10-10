import wollok.game.*

///////////////////////////////////////////////////////////////////////////////
// Piezas del Tetris.
///////////////////////////////////////////////////////////////////////////////

// Pieza del tetris (pieza de forma Z)
object pieza_Z {
	const mino_1 = new Mino(ejeX = 0, ejeY = 1, imagen = "pieza_z.png")
	const mino_2 = new Mino(ejeX = 1, ejeY = 1, imagen = "pieza_z.png")
	const mino_3 = new Mino(ejeX = 1, ejeY = 0, imagen = "pieza_z.png")
	const mino_4 = new Mino(ejeX = 2, ejeY = 0, imagen = "pieza_z.png")
	
	// Para generar nuestra pieza. // TODO: Probar si se puede optimizar mejor
	method generarPieza() {
		game.addVisual(mino_1)
		game.addVisual(mino_2)
		game.addVisual(mino_3)
		game.addVisual(mino_4)
	}
	
	// Movimiento de pieza.
	method moverseHaciaArriba(){
		mino_1.position(mino_1.position().up(1))
		mino_2.position(mino_2.position().up(1))
		mino_3.position(mino_3.position().up(1))
		mino_4.position(mino_4.position().up(1))
	}
	method moverseHaciaAbajo(){
		mino_1.position(mino_1.position().down(1))
		mino_2.position(mino_2.position().down(1))
		mino_3.position(mino_3.position().down(1))
		mino_4.position(mino_4.position().down(1))
	}
	method moverseHaciaIzquierda(){
		mino_1.position(mino_1.position().left(1))
		mino_2.position(mino_2.position().left(1))
		mino_3.position(mino_3.position().left(1))
		mino_4.position(mino_4.position().left(1))
	}
	method moverseHaciaDerecha(){
		mino_1.position(mino_1.position().right(1))
		mino_2.position(mino_2.position().right(1))
		mino_3.position(mino_3.position().right(1))
		mino_4.position(mino_4.position().right(1))
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