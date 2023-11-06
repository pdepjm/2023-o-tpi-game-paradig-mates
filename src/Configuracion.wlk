import wollok.game.*
import Entorno.*
import Informacion.*
import Piezas.*
import Reproductor.*
import Tablero.*

//////////////////////////////////////////////////////////
// CONFIGURACIONES.
//////////////////////////////////////////////////////////
// Configuraciones del juego.
object config {
	// Pieza actual en juego.
	var piezaActual
	// Siguiente pieza para jugar.
	var piezaSiguiente
	// Tiempo del evento de caida.
	var tiempoCaida = 1500
	
	// Sonidos del juego.
	const musica = new Musica(musica = game.sound(self.obtenerSonido()))
	
	// Centro de generacion de las piezas.
	method centroGeneracion() = game.at(5, 19)
	// Obtener una pieza al azar.
	method obtenerPieza() = [new Pieza_Z(), new Pieza_I(),  new Pieza_J(), new Pieza_L(), new Pieza_O(), new Pieza_S(), new Pieza_T()].anyOne()
	// Obtener un sonido para el juego al azar.
	method obtenerSonido() = ["Sonidos/OnceUponATime.ogg", "Sonidos/YourBestFriend.ogg", "Sonidos/Heartache.ogg", "Sonidos/BoneTrousle.ogg", "Sonidos/FallenDown.ogg"].anyOne()
	
	// Generar una nueva pieza.
	method generarPieza() {
		// Obtener la pieza a ser jugada.
		piezaActual = piezaSiguiente
		// Obtener la pieza siguiente a ser jugada.
		piezaSiguiente = self.obtenerPieza()
		
		// Comprobar si se puede generar.
		if(piezaActual.puedeGenerar()) {
			// Si se puede generar, cargar en el tablero la pieza jugable.
			piezaActual.generar()
			// Cargar en el HUB la pieza siguiente a ser jugada.
			hub.cargar(piezaSiguiente)
		} else {
			// Si no se puede generar, se termina el juego.
			game.clear()
			// Cargar los contadores del HUB.
			hub.cargar()
			// Detener el sonido del juego.
			musica.parar()
			// Cargar el Final del Juego.
			hub.cargarFinal()
		}
	}
	
	// Generar las primeras piezas.
	method generarPiezaInicial() {
		// Obtener la pieza siguiente a ser jugada.
		piezaSiguiente = self.obtenerPieza()
		// Generar la primera pieza.
		self.generarPieza()
	}
	
	// Cargar las configuraciones iniciales del juego.
	method cargar() {
		// Cargar las propiedades de la ventana.
		self.ventana()
		// Cargar la funcionalidad para la tecla de 'CONTINUAR'.
		self.continuar()
		// Cargar el Menu del juego.
		menu.cargar()
	}
	
	// Cargar las configuraciones del juego.
	method cargarJuego() {
		// Iniciar musica del juego.
		musica.reproducir()
		// Cargar la funcionalidad de los controles del jugar.
		self.controles()
		// Generar las primeras piezas.
		self.generarPiezaInicial()
		// Iniciar la caida de las piezas.
		self.iniciarCaida()
	}
	
	// Configurar la informacion de la ventana.
	method ventana(){
		// Dimensiones de la pantalla. 
		game.width(tablero.ancho() + muros.cantLados() + hub.ancho()) // Ancho del tablero + Paredes del tablero + Ancho del Hub.
		game.height(tablero.alto() + muros.cantSuelo()) // Alto del tablero + Piso del tablero.
		game.cellSize(30)
		
		// Imagen de fondo, celda a celda.
		game.boardGround("Creaciones/Background.png")
		
		// Titulo del juego.
		game.title("TETRIS")
	}
	
	// Cargar la funcionalidad para la tecla de 'CONTINUAR'.
	method continuar() {
		// Funcionalidad para comenzar la partida.
		keyboard.enter().onPressDo({
			// Ocultar el Menu del juego.
			menu.ocultar()
			// Cargar la interfaz del juego.
			hub.cargar()
			// Cargar las configuraciones del juego.
			self.cargarJuego()
		})
	}
	
	// Configurar las teclas del juego.
	method controles() {
		// Movimiento de pieza.
		keyboard.down().onPressDo({if(piezaActual.puedeMover(abajo)) {piezaActual.mover(abajo) hub.puntajeAcumulado().incrementar(10)}})
		keyboard.left().onPressDo({if(piezaActual.puedeMover(izquierda)) piezaActual.mover(izquierda)})
		keyboard.right().onPressDo({if(piezaActual.puedeMover(derecha)) piezaActual.mover(derecha)})
		
		// Rotacion de pieza.
		keyboard.up().onPressDo({if(piezaActual.puedeRotar(horario)) piezaActual.rotar(horario)})
		
		// Reiniciar partida.
		keyboard.enter().onPressDo({
			// Resetear el hub.
			hub.resetear()
			// Resetear la interfaz del juego.
			tablero.resetear()
			// Resetar el tiempo de Caida.
			self.resetearDificultad()
			// Resetear Piezas.
			if(hub.proximaPieza().estaActiva()) hub.proximaPieza().ocultar()
			if(piezaActual.estaActiva()) piezaActual.eliminar()
			self.generarPiezaInicial()
		})
		
		// Bajar la pieza totalmente e incrustarla.
		keyboard.space().onPressDo({piezaActual.bajarIncrustar() hub.puntajeAcumulado().incrementar(50)})
		
		// Pausar sonido del juego.
		keyboard.p().onPressDo{if(musica.estaPausada()) musica.reanudar() else musica.pausar()}
	}
	
	// Iniciar la caida de piezas.
	method iniciarCaida() {
		// Iniciamos caida de piezas.
		self.caidaPiezas()
		// Cada 20 segundos, se aumenta la dificultad.
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
		tiempoCaida = 1500
		self.iniciarCaida()
	}
	
	// Configurar la caida de las piezas.
	method caidaPiezas() {
		game.onTick(tiempoCaida, "CaidaPiezas", {
			// Comprobar si se puede bajar la pieza.
			if(piezaActual.puedeMover(abajo)) {
				// Si puede bajar, baja.
				piezaActual.mover(abajo)
			} else {
				// Si no puede bajar, se incrusta la pieza y se genera una nueva.
				tablero.incrustar(piezaActual)
				hub.proximaPieza().ocultar()
				self.generarPieza()
			}
		})
	}
}