import wollok.game.*
import Configuracion.*

//////////////////////////////////////////////////////////
// PIEZAS JUGABLES.
//////////////////////////////////////////////////////////
// Molde de las Piezas del tetris (Formado por 4 minos)
class Pieza {
	// Minos que conforman la pieza.
	const property minos = []
	// Mini pieza. // TODO: Necesario?
	const property mini
	
	// Consultar mino central.
	method centro() = minos.first()
	// Consultar si esta la pieza activa en el tablero.
	method estaActiva() = game.hasVisual(self.centro())
	// Obtener la mini pieza.
	method mini() = mini
	
	// Generar pieza en tablero.
	method generar() {
		minos.forEach({mino => game.addVisual(mino)})
	}
	// Eliminar pieza del tablero.
	method eliminar() {
		minos.forEach({mino => game.removeVisual(mino)})
	}
	
	// Mover la pieza hacia una direccion.
	method moverAbajo(){
		minos.forEach({mino => mino.position(mino.position().down(1))})
	}
	method moverIzquierda(){
		minos.forEach({mino => mino.position(mino.position().left(1))})
	}
	method moverDerecha(){
		minos.forEach({mino => mino.position(mino.position().right(1))})
	}
	
	// Girar pieza en sentido horario.
	method girar(){
		minos.forEach({mino => mino.position(self.rotarCoordenadas(mino))})
	}
	
	// Rotar en sentido horario las coordenadas de la posicion de un mino dado.
	method rotarCoordenadas(mino) = game.at(
		mino.position().y() + self.centro().position().x() - self.centro().position().y(),
		- mino.position().x() + self.centro().position().x() + self.centro().position().y()
	)
}

// Pieza I. (Rojo)
class Pieza_I inherits Pieza(mini = "miniI.png", minos = [
	// MINO CENTRAL (Siempre en la primera posicion de la lista)
	new Mino(position = config.centroGeneracion(), image = "red.png"),
	// MINOS ALEDANIOS (Siempre luego del mino central)
	new Mino(position = config.centroGeneracion().up(1), image = "red.png"),
	new Mino(position = config.centroGeneracion().down(1), image = "red.png"),
	new Mino(position = config.centroGeneracion().down(2), image = "red.png")
]) {}
// Pieza J. (Azul)
class Pieza_J inherits Pieza(mini = "miniJ.png", minos = [
	// MINO CENTRAL (Siempre en la primera posicion de la lista)
	new Mino(position = config.centroGeneracion(), image = "blue.png"),
	// MINOS ALEDANIOS (Siempre luego del mino central)
	new Mino(position = config.centroGeneracion().up(1), image = "blue.png"),
	new Mino(position = config.centroGeneracion().down(1), image = "blue.png"),
	new Mino(position = config.centroGeneracion().down(1).left(1), image = "blue.png")
]) {}
// Pieza L. (Naranja)
class Pieza_L inherits Pieza(mini = "miniL.png", minos = [
	// MINO CENTRAL (Siempre en la primera posicion de la lista)
	new Mino(position = config.centroGeneracion(), image = "orange.png"),
	// MINOS ALEDANIOS (Siempre luego del mino central)
	new Mino(position = config.centroGeneracion().up(1), image = "orange.png"),
	new Mino(position = config.centroGeneracion().down(1), image = "orange.png"),
	new Mino(position = config.centroGeneracion().down(1).right(1), image = "orange.png")
]) {}
// Pieza O. (Blanco)
class Pieza_O inherits Pieza(mini = "miniO.png", minos = [
	// MINO CENTRAL (Siempre en la primera posicion de la lista)
	new Mino(position = config.centroGeneracion(), image = "white.png"),
	// MINOS ALEDANIOS (Siempre luego del mino central)
	new Mino(position = config.centroGeneracion().up(1), image = "white.png"),
	new Mino(position = config.centroGeneracion().right(1), image = "white.png"),
	new Mino(position = config.centroGeneracion().up(1).right(1), image = "white.png")
]) {override method girar() {}}
// Pieza S. (Verde)
class Pieza_S inherits Pieza(mini = "miniS.png", minos = [
	// MINO CENTRAL (Siempre en la primera posicion de la lista)
	new Mino(position = config.centroGeneracion(), image = "green.png"),
	// MINOS ALEDANIOS (Siempre luego del mino central)
	new Mino(position = config.centroGeneracion().up(1), image = "green.png"),
	new Mino(position = config.centroGeneracion().left(1), image = "green.png"),
	new Mino(position = config.centroGeneracion().up(1).right(1), image = "green.png")
]) {}
// Pieza T. (Violeta)
class Pieza_T inherits Pieza(mini = "miniT.png", minos = [
	// MINO CENTRAL (Siempre en la primera posicion de la lista)
	new Mino(position = config.centroGeneracion(), image = "purple.png"),
	// MINOS ALEDANIOS (Siempre luego del mino central)
	new Mino(position = config.centroGeneracion().up(1), image = "purple.png"),
	new Mino(position = config.centroGeneracion().left(1), image = "purple.png"),
	new Mino(position = config.centroGeneracion().right(1), image = "purple.png")
]) {}
// Pieza Z. (Celeste)
class Pieza_Z inherits Pieza(mini = "miniZ.png", minos = [
	// MINO CENTRAL (Siempre en la primera posicion de la lista)
	new Mino(position = config.centroGeneracion(), image = "lightblue.png"),
	// MINOS ALEDANIOS (Siempre luego del mino central)
	new Mino(position = config.centroGeneracion().up(1), image = "lightblue.png"),
	new Mino(position = config.centroGeneracion().up(1).left(1), image = "lightblue.png"),
	new Mino(position = config.centroGeneracion().right(1), image = "lightblue.png")
]) {}

//////////////////////////////////////////////////////////
// MINOS.
//////////////////////////////////////////////////////////
// Molde de los minos de las piezas.
class Mino {
	// Posicion del mino.
	var property position
	// Imagen del mino (Depende de la pieza que conforme)
	const property image
}