import wollok.game.*
import piezas.*
import tablero.*

object config {
	// Pieza actual a mover.
	var piezaActual
	// Tiempo de evento automatico (Bajar pieza e incrustar) // TODO: Bajar el tiempo de caida al pasar el tiempo.
	const tiempo = 1000
	
	// Establecer el centro de generacion de las piezas.
	method inicio() = game.at(4, 18)
	// Generar pieza al azar.
	method obtenerPieza() = [new Pieza_Z(), new Pieza_I(),  new Pieza_J(), new Pieza_L(), new Pieza_O(), new Pieza_S(), new Pieza_T()].anyOne()
	
	// Generar pieza.
	method generarPieza() {
		piezaActual = self.obtenerPieza()
		piezaActual.generarPieza()
	}
	
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
	method configTeclas() { // TODO: Los 'and' en los ifs generan algo de lag entre las acciones. Quizas se soluciona colocando un borde.
		// Generar el giro de las piezas.
		keyboard.up().onPressDo({if(tablero.puedeRotar(piezaActual)) piezaActual.girarPieza()})
		
		// Generar movimiento de las piezas.
		keyboard.down().onPressDo({if(tablero.puedeMoverAbajo(piezaActual)) piezaActual.moverAbajo()})
		keyboard.left().onPressDo({if(tablero.puedeMoverIzquierda(piezaActual)) piezaActual.moverIzquierda()})
		keyboard.right().onPressDo({if(tablero.puedeMoverDerecha(piezaActual)) piezaActual.moverDerecha()})
	}
	
	// Configuracion de colisiones.
	method configColisiones() {
		// TODO: Generar colisiones para finalizar la partida, es decir perder (Aparece una pieza sobre otra)
	}
	
	// Configuracion de eventos automaticos.
	method configEventosAutomaticos() {
		// Hacer que las piezas bajen cada x tiempo.
		game.onTick(tiempo, "Bajar pieza e incrustar", {self.bajarIncrustar()})
	}

	// Evento automatico (Bajar pieza e incrustar)
	method bajarIncrustar() {
		// Comprobar si se puede bajar la pieza.
		if(tablero.puedeMoverAbajo(piezaActual)) {
			// Si se puede, se baja.
			piezaActual.moverAbajo()
		} else {
			// Si no se puede, se incrusta y se genera una nueva.
			tablero.incrustarPieza(piezaActual)
			self.generarPieza()
		}
	}
}