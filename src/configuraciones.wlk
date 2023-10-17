import wollok.game.*
import piezas.*
import tablero.*

object config {
	// Pieza actual a mover. // TODO: property?
	var property piezaActual = self.obtenerPieza()
	
	// Establecer el centro de generacion.
	method inicio() = game.at(4, 18)
	// Generar pieza al azar.
	method obtenerPieza() = [pieza_Z, pieza_I, pieza_J, pieza_L, pieza_O, pieza_S, pieza_T].anyOne()
	
	// Cargamos todas las configuraciones necesarias (Ventana, Teclas, Colisiones y Eventos automaticos)
	method cargarConfiguraciones() {
		self.configVentana()
		self.configTeclas()
		self.configColisiones()
		self.configEventosAutomaticos()
	}
	
	// Configuracion de la ventana del juego.
	method configVentana() {
		// Titulo del juego.
		game.title("TETRIS: ALGO") // TODO: Pensar un buen nombre para el juego.
		// Dimensiones del tablero.
		game.width(tablero.largo())
		game.height(tablero.alto())
		game.cellSize(30)
	}
	
	// Configuracion de las teclas.
	method configTeclas() { // TODO: Los 'and' en los ifs generan algo de lag entre las acciones.
		// Generar el giro de las piezas.
		keyboard.up().onPressDo({if(tablero.puedeRotar(piezaActual)) piezaActual.girarPieza()})
		
		// Generar movimiento de las piezas.
		keyboard.down().onPressDo({if(tablero.puedeMoverAbajo(piezaActual)) piezaActual.moverAbajo()})
		keyboard.left().onPressDo({if(tablero.puedeMoverIzquierda(piezaActual)) piezaActual.moverIzquierda()})
		keyboard.right().onPressDo({if(tablero.puedeMoverDerecha(piezaActual)) piezaActual.moverDerecha()})
	}
	
	// Configuracion de colisiones.
	method configColisiones() {
		// TODO: Generar colisiones.
	}
	
	// Configuracion de eventos automaticos.
	method configEventosAutomaticos() {
		// TODO: Hacer que las piezas bajen cada x tiempo.
	}
}
