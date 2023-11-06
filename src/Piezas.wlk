import wollok.game.*
import Configuracion.*
import Tablero.*

//////////////////////////////////////////////////////////
// PIEZAS JUGABLES.
//////////////////////////////////////////////////////////
// Clase abstracta de las Piezas del tetris (Formado por 4 minos)
class Pieza {
	// Minos que conforman la pieza.
	const property minos = []
	// Mini pieza para el HUB.
	const property display
	
	// Consultar mino central.
	method centro() = minos.first()
	// Consultar si esta la pieza activa en el tablero.
	method estaActiva() = game.hasVisual(self.centro())
	// Saber si se puede generar.
	method puedeGenerar() = minos.all({mino => not tablero.hayMinoEn(mino.position())})
	
	// Saber si se puede mover a una posicion determinada.
	method puedeMover(direccion) = not minos.any{mino => 
		tablero.movimientoInvalido(direccion.posicion(mino.position()))
	}
	// Saber si se puede rotar en sentido horario.
	method puedeRotar(sentido) = not minos.any({mino =>
		tablero.movimientoInvalido(sentido.posicion(mino.position(), self.centro().position()))
	})
	
	// Generar pieza en tablero.
	method generar() {
		minos.forEach({mino => game.addVisual(mino)})
	}
	// Eliminar pieza del tablero.
	method eliminar() {
		minos.forEach({mino => game.removeVisual(mino)})
	}
	
	// Mover los minos de la pieza en una direccion dada.
	method mover(direccion) {
		minos.forEach{mino => mino.mover(direccion)}
	}
	// Rotar la pieza en un sentido dado.
	method rotar(sentido) {
		minos.forEach({mino => mino.rotar(sentido, self.centro().position())})
	}
	// Bajar totalmente e incrustarla.
	method bajarIncrustar() {
		// Comprobar si puede bajar.
		if(self.puedeMover(abajo)){
			// Si puede bajar, baja.
			self.mover(abajo)
			// Recursividad.
			self.bajarIncrustar()
		}
	}
}

// Pieza I. (Rojo)
class Pieza_I inherits Pieza(
	display = "Piezas/miniI.png",
	minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino_I(position = config.centroGeneracion()),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino_I(position = config.centroGeneracion().up(1)),
		new Mino_I(position = config.centroGeneracion().down(1)),
		new Mino_I(position = config.centroGeneracion().down(2))
	]){}
// Pieza J. (Azul)
class Pieza_J inherits Pieza(
	display = "Piezas/miniJ.png",
	minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino_J(position = config.centroGeneracion()),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino_J(position = config.centroGeneracion().up(1)),
		new Mino_J(position = config.centroGeneracion().down(1)),
		new Mino_J(position = config.centroGeneracion().down(1).left(1))
	]) {}
// Pieza L. (Naranja)
class Pieza_L inherits Pieza(
	display = "Piezas/miniL.png",
	minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino_L(position = config.centroGeneracion()),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino_L(position = config.centroGeneracion().up(1)),
		new Mino_L(position = config.centroGeneracion().down(1)),
		new Mino_L(position = config.centroGeneracion().down(1).right(1))
	]) {}
// Pieza O. (Blanco)
class Pieza_O inherits Pieza(
	display = "Piezas/miniO.png",
	minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino_O(position = config.centroGeneracion()),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino_O(position = config.centroGeneracion().up(1)),
		new Mino_O(position = config.centroGeneracion().right(1)),
		new Mino_O(position = config.centroGeneracion().up(1).right(1))
	]) {override method rotar(sentido) {}}
// Pieza S. (Verde)
class Pieza_S inherits Pieza(
	display = "Piezas/miniS.png",
	minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino_S(position = config.centroGeneracion()),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino_S(position = config.centroGeneracion().up(1)),
		new Mino_S(position = config.centroGeneracion().left(1)),
		new Mino_S(position = config.centroGeneracion().up(1).right(1))
	]) {}
// Pieza T. (Violeta)
class Pieza_T inherits Pieza(
	display = "Piezas/miniT.png",
	minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino_T(position = config.centroGeneracion()),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino_T(position = config.centroGeneracion().up(1)),
		new Mino_T(position = config.centroGeneracion().left(1)),
		new Mino_T(position = config.centroGeneracion().right(1))
	]) {}
// Pieza Z. (Celeste)
class Pieza_Z inherits Pieza(
	display = "Piezas/miniZ.png",
	minos = [
		// MINO CENTRAL (Siempre en la primera posicion de la lista)
		new Mino_Z(position = config.centroGeneracion()),
		// MINOS ALEDANIOS (Siempre luego del mino central)
		new Mino_Z(position = config.centroGeneracion().up(1)),
		new Mino_Z(position = config.centroGeneracion().up(1).left(1)),
		new Mino_Z(position = config.centroGeneracion().right(1))
	]) {}

//////////////////////////////////////////////////////////
// MINOS.
//////////////////////////////////////////////////////////
// Clase abstracta para los minos de las piezas.
class Mino {
	// Posicion del mino en tablero.
	var property position
	
	// Mover mino hacia una direccion determinada.
	method mover(direccion) {
		position = direccion.posicion(position)
	}
	
	// Rotar mino alrededor del centro y en un sentido determinado.
	method rotar(sentido, centro) {
		position = sentido.posicion(position, centro)
	}
}

// Molde Mino I. (Rojo)
class Mino_I inherits Mino {
	// Establecer la imagen del mino.
	method image() = "Minos/red.png"
}
// Molde Mino J. (Azul)
class Mino_J inherits Mino {
	// Establecer la imagen del mino.
	method image() = "Minos/blue.png"
}
// Molde Mino L. (Naranja)
class Mino_L inherits Mino {
	// Establecer la imagen del mino.
	method image() = "Minos/orange.png"
}
// Molde Mino O. (Blanco)
class Mino_O inherits Mino {
	// Establecer la imagen del mino.
	method image() = "Minos/white.png"
}
// Molde Mino S. (Verde)
class Mino_S inherits Mino {
	// Establecer la imagen del mino.
	method image() = "Minos/green.png"
}
// Molde Mino T. (Violeta)
class Mino_T inherits Mino {
	// Establecer la imagen del mino.
	method image() = "Minos/purple.png"
}
// Molde Mino Z. (Celeste)
class Mino_Z inherits Mino {
	// Establecer la imagen del mino.
	method image() = "Minos/lightblue.png"
}

//////////////////////////////////////////////////////////
// DIRECCIONES.
//////////////////////////////////////////////////////////
object izquierda {
	// Obtener una posicion a la izquierda.
	method posicion(origen) = origen.left(1)
}

object abajo {
	// Obtener una posicion abajo.
	method posicion(origen) = origen.down(1)
}

object derecha {
	// Obtener una posicion a la derecha.
	method posicion(origen) = origen.right(1)
}

object horario {
	// Obtener una posicion rotada en sentido horario.
	method posicion(origen, centro) = game.at(
		origen.y() + centro.x() - centro.y(),
		- origen.x() + centro.x() + centro.y()
	)
}

object antiHorario {
	// Obtener una posicion rotada en sentido anti-horario.
	method posicion(origen, centro) = game.at(
		- origen.y() + centro.x() - centro.y(),
		origen.x() + centro.x() + centro.y()
	)
}