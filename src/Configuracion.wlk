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
	var piezaActual = self.obtenerPieza()
	// Siguiente pieza para jugar.
	var siguientePieza
	// Tiempo del evento de caida.
	var tiempoCaida = 1010
	
	// Sonidos del juego.
	const sonidoMenu = game.sound("StartMenu.ogg")
	const sonidoJuego = game.sound(self.obtenerSonido())
	const sonidoFinal = game.sound("Determination.ogg")
	
	// Centro de generacion de las piezas.
	method centroGeneracion() = game.at(5, 19)
	// Obtener una pieza al azar.
	method obtenerPieza() = [new Pieza_Z(), new Pieza_I(),  new Pieza_J(), new Pieza_L(), new Pieza_O(), new Pieza_S(), new Pieza_T()].anyOne()
	// Obtener un sonido para el juego al azar.
	method obtenerSonido() = ["OnceUponATime.ogg", "YourBestFriend.ogg", "Heartache.ogg", "BoneTrousle.ogg", "FallenDown.ogg"].anyOne()
	
	// Generar una nueva pieza.
	method generarPieza() {
		piezaActual = siguientePieza
		siguientePieza = self.obtenerPieza()
		// Si se puede generar la pieza, se genera.
		if(tablero.puedeGenerar(piezaActual)) {
			piezaActual.generar()
			hub.mostrarImagen(siguientePieza)
		} else {
			// Si no se puede generar, se termina el juego.
			game.clear()
			hub.cargar()
			// Detenemos el sonido del juego.
			sonidoJuego.stop()
			// Iniciar el sonido para el final del juego.
			sonidoFinal.play()
			// Generar mensaje de 'Fin de juego'.
			hub.mostrarMensaje()
		}
	}
	
	// Generar la primeras piezas.
	method generarPiezaInicial() {
		siguientePieza = self.obtenerPieza()
		self.generarPieza()
	}
	
	// Cargar las configuraciones iniciales.
	method cargar() {
		self.ventana()
		self.teclaEnter()
		
		// Mostrar el menu de bienvenida del juego.
		menu.cargar()
		// Iniciar el sonido para el menu.
		game.schedule(500, {sonidoMenu.play()})
	}
	
	// Cargar las configuraciones del juego.
	method cargarJuego(){
		self.teclasJuego()
		self.iniciarCaida()
		self.iniciarMusica()
	}
	
	// Configurar la informacion de la ventana.
	method ventana(){
		// Dimensiones de la pantalla. 
		game.width(tablero.ancho() + muros.cantLados() + hub.ancho()) // Ancho del tablero + Paredes del tablero + Ancho del Hub.
		game.height(tablero.alto() + muros.cantSuelo()) // Alto del tablero + Piso del tablero.
		game.cellSize(30)
		
		// Imagen de fondo, celda a celda.
		game.boardGround("Background.png")
		
		// Titulo del juego.
		game.title("TETRIS")
	}
	
	// Configurar la tecla ENTER del juego.
	method teclaEnter() {
		// Comenzar o resetear partida.
		keyboard.enter().onPressDo({
			// Si esta el menu habilitado.
			if(menu.estaActivo()) {
				// Ocultar menu.
				menu.eliminar()
				// Cargar el hub.
				hub.cargar()
				// Detenemos el sonido del menu.
				sonidoMenu.stop()
				// Cargar las configuraciones del juego.
				self.cargarJuego()
			}
			
			// Resetear la partida.
			hub.resetear()
			tablero.resetear()
			self.resetearDificultad()
			if(proxima.estaActiva()) proxima.ocultar()
			if(piezaActual.estaActiva()) piezaActual.eliminar()
			
			// Generar las primeras piezas.
			self.generarPiezaInicial()
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
		
		// Bajar la pieza totalmente e incrustarla.
		keyboard.space().onPressDo({tablero.bajarIncrustar(piezaActual) puntaje.incrementar(50)})
		
		// Pausar sonido del juego.
		keyboard.p().onPressDo({if(sonidoJuego.paused()) sonidoJuego.resume() else sonidoJuego.pause()})
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
				proxima.ocultar()
				self.generarPieza()
			}
		})
	}
	
	// Iniciar musica del juego.
	method iniciarMusica() {
		// Loop en el sonido del juego.
		sonidoJuego.shouldLoop(true)
		// Iniciar el sonido para el juego.
		sonidoJuego.play()
	}
}