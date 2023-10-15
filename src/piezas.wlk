import wollok.game.*

///////////////////////////////////////////////////////////////////////////////
// Clase para las piezas del Tetris.
///////////////////////////////////////////////////////////////////////////////

class Pieza {
	const minoCentral
	const minosAledanios = []
	
	// Para generar nuestra pieza.
	method generarPieza() {
		// Generamos el mino nucleo.
		game.addVisual(minoCentral)
		// Generamos los minos aledanios.
		minosAledanios.forEach({mino => game.addVisual(mino)})
	}
	
	// Movimiento de la pieza.
	method moverAbajo(){
		minoCentral.position(minoCentral.position().down(1))
		minosAledanios.forEach({mino => mino.position(mino.position().down(1))})
	}
	method moverIzquierda(){
		minoCentral.position(minoCentral.position().left(1))
		minosAledanios.forEach({mino => mino.position(mino.position().left(1))})
	}
	method moverDerecha(){
		minoCentral.position(minoCentral.position().right(1))
		minosAledanios.forEach({mino => mino.position(mino.position().right(1))})
	}
	
	// Girar la pieza.
	method girarPieza(){
		minosAledanios.forEach({mino => mino.position(self.rotarCoordenadas(mino.position()))})
	}
	
	// Rotar coordenadas (Para poder girarla, se utiliza los vectores aprendidos en Algebra)
	method rotarCoordenadas(coordenada) = game.at(
		coordenada.y() + minoCentral.position().x() - minoCentral.position().y(),
		- coordenada.x() + minoCentral.position().x() + minoCentral.position().y()
	)
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

///////////////////////////////////////////////////////////////////////////////
// Forma de las Piezas.
///////////////////////////////////////////////////////////////////////////////

// Pieza del tetris (pieza de forma Z)
const pieza_Z = new Pieza(
	minoCentral = new Mino(position = game.at(4, 18), image = "pieza_z.png"),
	minosAledanios = [
		new Mino(position = game.at(3, 19), image = "pieza_z.png"),
		new Mino(position = game.at(4, 19), image = "pieza_z.png"),
		new Mino(position = game.at(5, 18), image = "pieza_z.png")
	]
)
	
// Pieza del tetris (pieza de forma I)
// const pieza_Z

// Pieza del tetris (pieza de forma J)
// const pieza_J

// Pieza del tetris (pieza de forma L)
// const pieza_L

// Pieza del tetris (pieza de forma O)
// const pieza_O

// Pieza del tetris (pieza de forma S)
// const pieza_S

// Pieza del tetris (pieza de forma T)
// const pieza_T