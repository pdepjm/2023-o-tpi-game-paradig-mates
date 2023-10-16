import wollok.game.*
import piezas.*
import tablero.*

object config {	
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
	method configTeclas() {
		// Generar el giro de las piezas.
		keyboard.up().onPressDo({pieza_Z.girarPieza()})
		
		// Generar movimiento de las piezas.
		keyboard.down().onPressDo({pieza_Z.moverAbajo()})
		keyboard.left().onPressDo({pieza_Z.moverIzquierda()})
		keyboard.right().onPressDo({pieza_Z.moverDerecha()})
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
