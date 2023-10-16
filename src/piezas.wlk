import wollok.game.*
import configuraciones.*
import tablero.*

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
		if(self.puedeMoverAbajo()) minos.forEach({mino => mino.position(mino.position().down(1))})
	}
	method moverIzquierda(){
		if(self.puedeMoverIzquierda()) minos.forEach({mino => mino.position(mino.position().left(1))})
	}
	method moverDerecha(){
		if(self.puedeMoverDerecha()) minos.forEach({mino => mino.position(mino.position().right(1))})
	}
	
	// Girar la pieza.
	method girarPieza(){
		if(self.puedeRotar()) minos.forEach({mino => mino.position(self.rotarCoordenadas(mino))})
	}
	
	// Rotar coordenadas (Para poder girarla, se utiliza los vectores aprendidos en Algebra)
	method rotarCoordenadas(mino) = game.at(
		mino.position().y() + self.minoCentral().position().x() - self.minoCentral().position().y(),
		- mino.position().x() + self.minoCentral().position().x() + self.minoCentral().position().y()
	)
	
	// Saber si puede moverse a un Lugar.
	method puedeMoverAbajo() = minos.all({
		mino => mino.position().y() > 0 && !tablero.hayMinoEn(mino.position().down(1))
	})
	method puedeMoverDerecha() = minos.all({
		mino => (mino.position().x()) < config.largo() - 1 && !tablero.hayMinoEn(mino.position().right(1))
	})
	method puedeMoverIzquierda() = minos.all({
		mino => (mino.position().x()) > 0 && !tablero.hayMinoEn(mino.position().left(1))
	})
	
	// Saber si puede rotar.
	method puedeRotar() = true // TODO: Falta implementar.
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
	minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino(position = game.at(4, 18), image = "pieza_z.png"),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino(position = game.at(3, 19), image = "pieza_z.png"),
		new Mino(position = game.at(4, 19), image = "pieza_z.png"),
		new Mino(position = game.at(5, 18), image = "pieza_z.png")
	]
)
	
// Pieza del tetris (pieza de forma I)
// const pieza_I

// Pieza del tetris (pieza de forma J)
// const pieza_J

// Pieza del tetris (pieza de forma L)
// const pieza_L

// Pieza del tetris (pieza de forma O)
const pieza_O = new Pieza(
	minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino(position = game.at(4, 10), image = "pieza_z.png"),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino(position = game.at(4, 11), image = "pieza_z.png"),
		new Mino(position = game.at(5, 11), image = "pieza_z.png"),
		new Mino(position = game.at(5, 10), image = "pieza_z.png")
	]
)

// Pieza del tetris (pieza de forma S)
// const pieza_S

// Pieza del tetris (pieza de forma T)
// const pieza_T