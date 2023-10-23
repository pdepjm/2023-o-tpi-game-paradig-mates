import wollok.game.*
import Configuracion.*

///////////////////////////////////////////////////////////////////////////////
// Clase para las piezas del Tetris.
///////////////////////////////////////////////////////////////////////////////

class Pieza {
	const property minos = []
	
	// Obtener el mino central de la pieza.
	method minoCentral() = minos.first()
	
	// Para generar nuestra pieza.
	method generarPieza() {
		// Generamos los minos aledanios.
		minos.forEach({mino => game.addVisual(mino)})
	}
	
	// Movimiento de la pieza.
	method moverAbajo(){
		minos.forEach({mino => mino.position(mino.position().down(1))})
	}
	method moverIzquierda(){
		minos.forEach({mino => mino.position(mino.position().left(1))})
	}
	method moverDerecha(){
		minos.forEach({mino => mino.position(mino.position().right(1))})
	}
	
	// Girar la pieza.
	method girarPieza(){
		minos.forEach({mino => mino.position(self.rotarCoordenadas(mino))})
	}
	
	// Rotar coordenadas (Para poder girarla, se utiliza los vectores aprendidos en Algebra)
	method rotarCoordenadas(mino) = game.at(
		mino.position().y() + self.minoCentral().position().x() - self.minoCentral().position().y(),
		- mino.position().x() + self.minoCentral().position().x() + self.minoCentral().position().y()
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

// TODO: No olvidar de buscar los colores definitivos.
// Pieza del tetris (pieza de forma Z)
class Pieza_Z inherits Pieza(minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino(position = config.inicio(), image = "pieza_z.png"),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino(position = config.inicio().up(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().up(1).left(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().right(1), image = "pieza_z.png")
	]) {}

// Pieza del tetris (pieza de forma I)
class Pieza_I inherits Pieza(minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino(position = config.inicio(), image = "pieza_z.png"),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino(position = config.inicio().up(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().down(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().down(2), image = "pieza_z.png")
	]) {}

// Pieza del tetris (pieza de forma J)
class Pieza_J inherits Pieza(minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino(position = config.inicio(), image = "pieza_z.png"),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino(position = config.inicio().up(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().down(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().down(1).left(1), image = "pieza_z.png")
	]) {}

// Pieza del tetris (pieza de forma L)
class Pieza_L inherits Pieza(minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino(position = config.inicio(), image = "pieza_z.png"),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino(position = config.inicio().up(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().down(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().down(1).right(1), image = "pieza_z.png")
	]) {}

// Pieza del tetris (pieza de forma O)
class Pieza_O inherits Pieza(minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino(position = config.inicio(), image = "pieza_z.png"),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino(position = config.inicio().up(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().right(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().up(1).right(1), image = "pieza_z.png")
	]) {override method girarPieza() {}}

// Pieza del tetris (pieza de forma S)
class Pieza_S inherits Pieza(minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino(position = config.inicio(), image = "pieza_z.png"),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino(position = config.inicio().up(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().left(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().up(1).right(1), image = "pieza_z.png")
	]) {}

// Pieza del tetris (pieza de forma T)
class Pieza_T inherits Pieza(minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino(position = config.inicio(), image = "pieza_z.png"),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino(position = config.inicio().up(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().left(1), image = "pieza_z.png"),
		new Mino(position = config.inicio().right(1), image = "pieza_z.png")
	]) {}