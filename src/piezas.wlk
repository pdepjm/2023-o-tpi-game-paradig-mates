import wollok.game.*

///////////////////////////////////////////////////////////////////////////////
// Piezas del Tetris.
///////////////////////////////////////////////////////////////////////////////

object pieza {
	// Para generar nuestra pieza.
	method generarPieza(minoCentral, minosAledanios) {
		// Generamos el mino nucleo.
		game.addVisual(minoCentral)
		// Generamos los minos aledanios.
		minosAledanios.forEach({mino => game.addVisual(mino)})
	}
	
	// Movimiento de la pieza.
	method moverAbajo(minoCentral, minosAledanios){
		minoCentral.position(minoCentral.position().down(1))
		minosAledanios.forEach({mino => mino.position(mino.position().down(1))})
	}
	method moverIzquierda(minoCentral, minosAledanios){
		minoCentral.position(minoCentral.position().left(1))
		minosAledanios.forEach({mino => mino.position(mino.position().left(1))})
	}
	method moverDerecha(minoCentral, minosAledanios){
		minoCentral.position(minoCentral.position().right(1))
		minosAledanios.forEach({mino => mino.position(mino.position().right(1))})
	}
	
	// Girar la pieza.
	method girarPieza(minoCentral, minosAledanios){
		minosAledanios.forEach({mino => mino.position(self.rotarCoordenadas(mino.position(), minoCentral))})
	}
	
	// Rotar coordenadas (Para poder girarla, se utiliza los vectores aprendidos en Algebra)
	method rotarCoordenadas(coordenada, minoCentral) = game.at(
		coordenada.y() + minoCentral.position().x() - minoCentral.position().y(),
		- coordenada.x() + minoCentral.position().x() + minoCentral.position().y()
	)
}

// Pieza del tetris (pieza de forma Z)
object pieza_Z {
	// Mino central o cuadradito nucleo de la pieza.
	const minoCentral = new Mino(position = game.at(4,18), image = "pieza_z.png")	
	// Lista de los minos no centrales de la pieza.
	const minosAledanios = [
		new Mino(position = minoCentral.position().right(1), image = "pieza_z.png"),
		new Mino(position = minoCentral.position().up(1), image = "pieza_z.png"),
		new Mino(position = minoCentral.position().up(1).left(1), image = "pieza_z.png")
	]
	
	// Generar nuestra pieza.
	method generarPieza() {
		pieza.generarPieza(minoCentral, minosAledanios)
	}
	
	// Movimiento de la pieza (Izquierda, Abajo, Derecha)
	method moverAbajo(){
		pieza.moverAbajo(minoCentral, minosAledanios)
	}
	method moverIzquierda(){
		pieza.moverIzquierda(minoCentral, minosAledanios)
	}
	method moverDerecha(){
		pieza.moverDerecha(minoCentral, minosAledanios)
	}
	// Girar la pieza en sentido horario.
	method girarPieza(){
		pieza.girarPieza(minoCentral, minosAledanios)
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
// Mino o Cuadradito de pieza.
///////////////////////////////////////////////////////////////////////////////

// Sabemos que todas las piezas estan formadas por 4 minos (Cuadraditos)
class Mino {
	// Posicion del Mino.
	var property position
	// Imagen del Mino.
	const property image
}