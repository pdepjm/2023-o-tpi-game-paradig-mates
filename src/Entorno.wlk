import wollok.game.*
import Informacion.*
import Reproductor.*

//////////////////////////////////////////////////////////
// ♦ MENU DEL JUEGO.
//////////////////////////////////////////////////////////
// Menu al entrar al juego.
object menu {
	// Musica del Menu.
	const musica = new Musica(musica = game.sound("Sonidos/StartMenu.ogg"))
	
	// Configuraciones del menu.
	method position() = game.at(0, 0)
	method image() = "Creaciones/Menu.png"
	method mensaje() = new Mensaje(image = "Creaciones/Continuar.png", position = game.at(2,5))
	
	// Consultar si se muestra el menu.
	method estaActivo() = game.hasVisual(self)
	
	// Mostrar un menu de bienvenida.
	method cargar() {
		// Mostrar el menu de bienvenida del juego.
		game.addVisual(self)
		// Iniciar la musica del menu.
		musica.reproducir()
		// Cargar el mensaje 'CONTINUAR' con el efecto de parpadeo.
		self.mensaje().parpadeo()
	}
	
	// Dejar de mostrar menu de bienvenida.
	method ocultar() {
		// Limpiar el juego.
		game.clear()
		// Detener la musica del menu.
		musica.parar()
	}
}

//////////////////////////////////////////////////////////
// ♦ HUB O INTERFAZ DEL JUEGO.
//////////////////////////////////////////////////////////
// HUB del juego o interfaz.
object hub {
	// Musica de Final de Juego.
	const musica = new Musica(musica = game.sound("Sonidos/Determination.ogg"))
	// Puntaje acumulado durante la partida.
	const property puntajeAcumulado = new Contador(position = game.at(18,12))
	// Filas completadas durante la partida.
	const property filasCompletadas = new Contador(position = game.at(17,8))
	// Proxima pieza a ser jugada.
	const property proximaPieza = new Display(position = game.at(13, 8))
	
	// Ancho del HUB.
	method ancho() = 10
	// Obtener los puntos ganados por completar filas.
	method puntosGanados(filasCompletas) = [100, 200, 400, 800].get(filasCompletas.size() - 1)
	// Mensaje al perder partida.	
	method mensaje() = new Mensaje(image = "Creaciones/FinDeJuego.png", position = game.at(2, 10))
	
	// Cargar la interfaz del juego.
	method cargar() {
		// Cargar el puntaje acumulado.
		puntajeAcumulado.cargar()
		// Cargar las filas completadas.
		filasCompletadas.cargar()
	}
	
	// Cargar el display de las piezas siguientes.
	method cargar(pieza) {
		// Establecemos en el display la siguiente pieza.
		proximaPieza.image(pieza.display())
		// Cargar el display de la siguiente pieza.
		proximaPieza.cargar()
	}
	
	// Resetear informacion del hub.
	method resetear() {
		puntajeAcumulado.resetear()
		filasCompletadas.resetear()
	}
	
	// Modificar puntaje obtenido y filas completadas.
	method modificarContadores(filasCompletas) {
		// Incrementar la puntuacion al completar filas.
		self.puntajeAcumulado().incrementar(self.puntosGanados(filasCompletas))
		// Incrementar el contador de filas completadas.
		self.filasCompletadas().incrementar(filasCompletas.size())
	}
	
	// Cargar el final del juego.
	method cargarFinal() {
		// Iniciar el sonido para el final del juego.
		musica.reproducir()
		// Mostrar mensaje de final de partida.
		self.mensaje().parpadeo()
	}
}