import wollok.game.*
import piezas.*

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
		game.width(10)
		game.height(20)
		game.cellSize(30)
	}
	
	// Configuracion de las teclas.
	method configTeclas() {
		// TODO: Generar movimiento de las piezas.
		keyboard.up().onPressDo({pieza_Z.moverseHaciaArriba()})
		keyboard.down().onPressDo({pieza_Z.moverseHaciaAbajo()})
		keyboard.left().onPressDo({pieza_Z.moverseHaciaIzquierda()})
		keyboard.right().onPressDo({pieza_Z.moverseHaciaDerecha()})
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
