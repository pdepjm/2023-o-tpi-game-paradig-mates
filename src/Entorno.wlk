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
		game.addVisual(self)
	}
	
	// Dejar de mostrar menu de bienvenida.
	method ocultar() {
		game.removeVisual(self)
		// Si "Presionar enter para continuar" esta activo, se oculta.
		if(mensaje.estaActivo()) mensaje.ocultar()
	}
	
	// Establecer mensaje de inicio de partida.
	method establecerMensaje() {
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
	method establecerMensaje() {
		mensaje.image("FinDeJuego.png")
		mensaje.position(game.at(2, 10))
		mensaje.parpadeo()
	}
	
	// TODO: Generar en el hub un espacio para ver la pieza acumulada.
}