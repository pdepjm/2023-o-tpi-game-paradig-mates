import wollok.game.*

//////////////////////////////////////////////////////////
// ♦ INFORMACIONES DE LA PARTIDA.
//////////////////////////////////////////////////////////
// Molde para los contadores de texto mostradas en el HUB.
class Contador {
	// Contador del juego.
	var contador = 0
	
	// Configuraciones del puntaje acumulado.
	const property position
	method textColor() = "FFFFFF"
	method text() = contador.toString()
	
	// Cargar el puntaje acumulado.
	method cargar() {
		// Mostrar visualmente el puntaje acumulado.
		game.addVisual(self)
	}
	
	// Incrementar el valor numerico en pantalla.
	method incrementar(valor) {
		contador = contador + valor
	}
	
	// Resetear informacion.
	method resetear() {
		contador = 0
	}
}

// Molde para los displays de imagenes mostradas en el HUB.
class Display {
	// Configuraciones de la proxima pieza a generar.
	const property position
	var property image = ""
	
	// Consultar si esta la pieza activa en el tablero.
	method estaActivo() = game.hasVisual(self)
	
	// Cargar la proxima pieza.
	method cargar() {
		game.addVisual(self)
	}
	
	// Ocultar la proxima pieza.
	method ocultar() {
		game.removeVisual(self)
	}
}

// Molde para los Mensajes.
class Mensaje {
	// Configuraciones del mensaje.
	const property position
	const property image
	
	// Saber si esta activo.
	method estaActivo() = game.hasVisual(self)
	
	// Cargar mensaje.
	method cargar() {
		game.addVisual(self)
	}
	
	// Ocultar mensaje.
	method ocultar() {
		game.removeVisual(self)
	}
	
	// EFECTO VISUAL: Parpadeo en mensaje.
	method parpadeo() {
		game.onTick(500, "Parpadeo mensaje", {
			if(self.estaActivo()) self.ocultar() else self.cargar()
		})
	}
}