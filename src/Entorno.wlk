import wollok.game.*
import Informacion.*

//////////////////////////////////////////////////////////
// MENU Y HUB DEL JUEGO.
//////////////////////////////////////////////////////////
// Menu al entrar al juego.
object menu {	
	// Configuraciones del menu.
	method position() = game.at(0, 0)
	method image() = "Menu.png"
	// Consultar si se muestra el menu.
	method estaActivo() = game.hasVisual(self)
	
	// Mostrar un menu de bienvenida.
	method cargar() {
		// Mostrar el menu de bienvenida del juego.
		game.addVisual(self)
		// Generar mensaje 'Presionar ENTER para continuar'.
		self.mostrarMensaje()
	}
	
	// Dejar de mostrar menu de bienvenida.
	method eliminar() {
		// Detener el evento del parpadeo de mensaje.
		game.removeTickEvent("ParpadeoMensaje")
		// Si "Presionar enter para continuar" esta activo, se oculta.
		if(mensaje.estaActivo()) mensaje.ocultar()
		// Lo ocultamos.
		game.removeVisual(self)
	}
	
	// Establecer mensaje de inicio de partida.
	method mostrarMensaje() {
		mensaje.image("MensajeMenu.png")
		mensaje.position(game.at(2, 5))
		mensaje.parpadeo()
	}
}

// HUB del juego o interfaz.
object hub {
	// Ancho del HUB.
	method ancho() = 10
	
	// Mostrar informacion del hub.
	method cargar() {
		puntaje.cargar()
		contadorFilas.cargar()
	}
	
	// Resetear informacion del hub.
	method resetear() {
		puntaje.resetear()
		contadorFilas.resetear()
	}
	
	// Establecer mensaje de final de partida.
	method mostrarMensaje() {
		mensaje.image("FinDeJuego.png")
		mensaje.position(game.at(2, 10))
		mensaje.parpadeo()
	}
}