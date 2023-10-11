import wollok.game.*

///////////////////////////////////////////////////////////////////////////////
// Piezas del Tetris.
///////////////////////////////////////////////////////////////////////////////

// Pieza del tetris (pieza de forma Z)
object pieza_Z {
	// Mino Nucleo o cuadradito central de la pieza.
	const minoCentral = new Mino(ejeX = 4, ejeY = 18, imagen = "pieza_z.png")
	// Mino no nucleo o cuadradito no central de la pieza.
	var property mino_1 = new Mino(ejeX = 3, ejeY = 19, imagen = "pieza_z.png")
	var property mino_2 = new Mino(ejeX = 4, ejeY = 19, imagen = "pieza_z.png")
	var property mino_3 = new Mino(ejeX = 5, ejeY = 18, imagen = "pieza_z.png")
	
	// Lista de los cuadradistos no centrales de la pieza.
	const minosAledanios = [mino_1, mino_2, mino_3]
	
	// Para generar nuestra pieza.
	method generarPieza() {
		// Generamos el mino nucleo.
		game.addVisual(minoCentral)
		// Generamos los minos aledanios.
		minosAledanios.forEach({mino => game.addVisual(mino)})
	}
	
	// Movimiento de la pieza. // TODO: Son controles para prueba.
	method moverseHaciaAbajo(){
		minoCentral.position(minoCentral.position().down(1))
		minosAledanios.forEach({mino => mino.position(mino.position().down(1))})
	}
	method moverseHaciaIzquierda(){
		minoCentral.position(minoCentral.position().left(1))
		minosAledanios.forEach({mino => mino.position(mino.position().left(1))})
	}
	method moverseHaciaDerecha(){
		minoCentral.position(minoCentral.position().right(1))
		minosAledanios.forEach({mino => mino.position(mino.position().right(1))})
	}
	
	// Girar la pieza. // TODO: Son controles para prueba.
	method girarPieza(){
		minosAledanios.forEach({mino => mino.position(self.rotarCoordenadas(mino.position()))})
	}
	
	// Rotar coordenadas.
	method rotarCoordenadas(coordenada) = game.at(coordenada.y() + minoCentral.position().x() - minoCentral.position().y(), -coordenada.x() + minoCentral.position().x() + minoCentral.position().y())
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
// Mino o Cuadradito de pieza.
///////////////////////////////////////////////////////////////////////////////

// Sabemos que todas las piezas estan formadas por 4 minos (Cuadraditos)
class Mino {
	var property ejeX
	var property ejeY
	var property imagen
	var property position = game.at(ejeX, ejeY)
	
	method image() = imagen
}