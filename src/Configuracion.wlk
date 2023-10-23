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
	// TODO: Pieza almacenada.
	
	// var piezaAlmacenada.
	var tiempoCaida = 1000
	
	// Centro de generacion de las piezas.
	method centroGeneracion() = game.at(5, 19)
	// Obtener una pieza al azar.
	method obtenerPieza() = [new Pieza_Z(), new Pieza_I(),  new Pieza_J(), new Pieza_L(), new Pieza_O(), new Pieza_S(), new Pieza_T()].anyOne()
	
	// Generar una nueva pieza.
	method generarPieza() {
		piezaActual = self.obtenerPieza()
		// Si se puede generar, se genera.
		if(tablero.puedeGenerar(piezaActual)) piezaActual.generar() else {
			// Si no se puede generar, se termina el juego.
			game.clear()
			puntaje.cargar()
			nivel.cargar()
			// Generar mensaje de 'JUEGO FINALIZADO'.
			mensaje.image("FinDeJuego.png")
			mensaje.position(game.at(2, 10))
			self.parpadeoMensaje()
		}
	}
	
	// Cargar las configuraciones iniciales.
	method cargarConfigInicial() {
		self.ventana()
		self.teclaEnter()
		// Generar mensaje 'Presionar ENTER para continuar'
		mensaje.image("MensajeMenu.png")
		self.parpadeoMensaje()
	}
	
	// Cargar las configuraciones del juego.
	method cargarConfigJuego(){
		self.teclasJuego()
		self.caidaPiezas()
		// self.aumentoDeNivel()
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
	
	// Configurar las teclas del menu.
	method teclaEnter() {
		// Comenzar o resetear partida.
		keyboard.enter().onPressDo({
			// Si esta el menu habilitado.
			if(menu.estaActivo()) {
				// Detener el evento de "Presionar enter para continuar".
				game.removeTickEvent("ParpadeoMensaje")
				// Ocultar menu.
				menu.ocultar()
				// Si "Presionar enter para continuar" esta activo, se oculta.
				if(mensaje.estaActivo()) mensaje.ocultar()
				
				// Cargar la informacion del hub.
				puntaje.cargar()
				nivel.cargar()
				
				// Cargar las configuraciones del juego.
				self.cargarConfigJuego()
			}
			
			// Resetear la partida.
			puntaje.resetear()
			nivel.resetear()
			tablero.resetear()
			if(piezaActual.estaActiva()) piezaActual.eliminar()
			
			// Generar la primera pieza.
			self.generarPieza()
		})
	}
	
	// Configurar el parpadeo del mensaje "Presionar enter para continuar".
	method parpadeoMensaje() {
		game.onTick(500, "ParpadeoMensaje", {if(mensaje.estaActivo()) mensaje.ocultar() else mensaje.cargar()})
	}
	
	// Configurar las teclas del juego.
	method teclasJuego() {
		// TODO: Movimiento de pieza.
		keyboard.down().onPressDo({if(tablero.puedeBajar(piezaActual)) {piezaActual.moverAbajo() puntaje.incrementar(10)}})
		// keyboard.s()
		keyboard.left().onPressDo({if(tablero.puedeIzquierda(piezaActual)) piezaActual.moverIzquierda()})
		// keyboard.a()
		keyboard.right().onPressDo({if(tablero.puedeDerecha(piezaActual)) piezaActual.moverDerecha()})
		// keyboard.d()
		
		// TODO: Rotacion de pieza.
		keyboard.up().onPressDo({if(tablero.puedeRotar(piezaActual)) piezaActual.girar()})
		// keyboard.w()
		
		// TODO: Incrustar pieza.
		// keyboard.space()
		
		// TODO: Guardar pieza.
		// keyboard.e()
		
		// Aumentar nivel de dificultad.
		keyboard.p().onPressDo({
			nivel.incrementar()
		})
	}
	
	// Configurar la caida de las piezas.
	method caidaPiezas() {
		game.onTick(tiempoCaida, "CaidaPiezas", {
			// Comprobar si se puede bajar la pieza.
			if(tablero.puedeBajar(piezaActual)) {
				// Si puede bajar, baja.
				piezaActual.moverAbajo()
			} else {
				// Si no puede bajar, se incrusta y se genera una nueva.
				tablero.incrustar(piezaActual)
				self.generarPieza()
			}
		})
	}
	
	// Configurar aumento de nivel.
	method aumentoDeNivel() {
		game.onTick(1000, "AumentarDificultad", {
			tiempoCaida -= 100
			nivel.incrementar()
		})
	}	
}