import wollok.game.*

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
	}
}

// HUB del juego o entorno.
object hub {
	// Ancho del HUB.
	method ancho() = 10
	
	// TODO: Generar en el hub un espacio para ver la pieza acumulada.
}