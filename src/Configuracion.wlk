import wollok.game.*
import Entorno.*
import Informacion.*
import Piezas.*
import Tablero.*

//////////////////////////////////////////////////////////
// CONFIGURACIONES.
//////////////////////////////////////////////////////////
// Configuraciones del juego.
object config {
	// Pieza actual en juego.
	var piezaActual = new Pieza_Z()
	// TODO: Proxima pieza.
	var siguientePieza
	
	// Tiempo del evento de caida.
	var tiempoCaida = 1010
	
	// Centro de generacion de las piezas.
	method centroGeneracion() = game.at(5, 19)
	// Obtener una pieza al azar.
	method obtenerPieza() = [new Pieza_Z(), new Pieza_I(),  new Pieza_J(), new Pieza_L(), new Pieza_O(), new Pieza_S(), new Pieza_T()].anyOne()
	
	// Generar una nueva pieza.
	method generarPieza() {
		piezaActual = siguientePieza
		siguientePieza = self.obtenerPieza()
		// Si se puede generar, se genera.
		if(tablero.puedeGenerar(piezaActual)) {
			piezaActual.generar()
			proxima.cargar(siguientePieza) // TODO: esto va aca?
		} else {
			// Si no se puede generar, se termina el juego.
			game.clear()
			hub.cargar()
			// Generar mensaje de 'Fin de juego'.
			hub.establecerMensaje()
		}
	}
	
	// Cargar las configuraciones iniciales.
	method cargarConfigInicial() {
		self.ventana()
		self.teclaEnter()
		// Generar mensaje 'Presionar ENTER para continuar'.
		menu.establecerMensaje()
	}
	
	// Cargar las configuraciones del juego.
	method cargarConfigJuego(){
		self.teclasJuego()
		self.iniciarCaida()
	}
	
	// Configurar la informacion de la ventana.
	method ventana(){
		// Dimensiones de la pantalla. 
		game.width(tablero.ancho() + muros.cantLados() + hub.ancho()) // Ancho del tablero + Paredes del tablero + Ancho del Hub.
		game.height(tablero.alto() + muros.cantSuelo()) // Alto del tablero + Piso del tablero.
		game.cellSize(30)
		
		// Imagen de fondo, celda a celda.
		game.boardGround("Background2.png") // TODO: Si queda esta, cambiar nombre y borrar el otro.
		
		// Titulo del juego.
		game.title("TETRIS")
	}
	
	// Configurar las teclas del menu.
	method teclaEnter() {
		// Comenzar o resetear partida.
		keyboard.enter().onPressDo({
			// Si esta el menu habilitado.
			if(menu.estaActivo()) {
				// Detener el evento del parpadeo de mensaje.
				game.removeTickEvent("ParpadeoMensaje")
				// Ocultar menu.
				menu.ocultar()
				
				// Cargar el hub.
				hub.cargar()
				// Cargar las configuraciones del juego.
				self.cargarConfigJuego()
			}
			
			// Resetear la partida.
			hub.resetear()
			tablero.resetear()
			self.resetearDificultad()
			if(piezaActual.estaActiva()) piezaActual.eliminar()
			
			// Generar la primera pieza.
			siguientePieza = self.obtenerPieza() // TODO: Esto va aca?
			self.generarPieza()
		})
	}
	
	// Configurar las teclas del juego.
	method teclasJuego() {
		// Movimiento de pieza.
		keyboard.down().onPressDo({if(tablero.puedeBajar(piezaActual)) {piezaActual.moverAbajo() puntaje.incrementar(10)}})
		keyboard.left().onPressDo({if(tablero.puedeIzquierda(piezaActual)) piezaActual.moverIzquierda()})
		keyboard.right().onPressDo({if(tablero.puedeDerecha(piezaActual)) piezaActual.moverDerecha()})
		
		// Rotacion de pieza.
		keyboard.up().onPressDo({if(tablero.puedeRotar(piezaActual)) piezaActual.girar()})
		
		// Bajar totalmente la pieza e incrustarla.
		keyboard.space().onPressDo({tablero.bajarIncrustar(piezaActual) puntaje.incrementar(50)})
	}
	
	// Iniciar la caida de piezas.
	method iniciarCaida() {
		// Iniciamos caida de piezas.
		self.caidaPiezas()
		// Cada x tiempo, se aumenta la dificultad.
		game.onTick(20000, "AumentarDificultad", {
			// Detener el evento de la caida de piezas.
			game.removeTickEvent("CaidaPiezas")
			// Aceleramos tiempo de caida.
			tiempoCaida = 100.max(tiempoCaida - 100)
			// Iniciamos el evento de la caida de piezas.
			self.caidaPiezas()
		})
	}
	// Resetear dificultad de juego.
	method resetearDificultad() {
		game.removeTickEvent("AumentarDificultad")
		game.removeTickEvent("CaidaPiezas")
		tiempoCaida = 1010
		self.iniciarCaida()
	}
	
	// Configurar la caida de las piezas.
	method caidaPiezas() {
		game.onTick(tiempoCaida, "CaidaPiezas", {
			// Comprobar si se puede bajar la pieza.
			if(tablero.puedeBajar(piezaActual)) {
				// Si puede bajar, baja.
				piezaActual.moverAbajo()
			} else {
				// Si no puede bajar, se incrusta la pieza y se genera una nueva.
				tablero.incrustar(piezaActual)
				proxima.ocultar() //TODO: esto va aca?
				self.generarPieza()
			}
		})
	}
}