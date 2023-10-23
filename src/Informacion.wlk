import wollok.game.*

//////////////////////////////////////////////////////////
// INFORMACION DE LA PARTIDA.
//////////////////////////////////////////////////////////

// Puntaje.
object puntaje {
	// Puntaje acumulado.
	var puntajeAcumulado = 0
	
	// Configuraciones del puntaje.
	method position() = game.at(18, 12)
	method textColor() = "FFFFFF"
	method puntajeMaximo() = 999999999
	method text() = puntajeAcumulado.toString()
	
	// Mostrar puntaje acumulado.
	method cargar() {
		game.addVisual(self)
	}
	
	// Incrementar puntaje.
	method incrementar(valor) {
		// Si llega al puntaje maximo, se resetea.
		if(puntajeAcumulado + valor > self.puntajeMaximo()) self.resetear()
		puntajeAcumulado += valor
	}
	
	// Resetear puntaje.
	method resetear() {
		puntajeAcumulado = 0
	}
}

// Nivel de juego.
object nivel {
	// Nivel actual.
	var nivelActual = 1
	
	// Configuraciones del nivel actual.
	method position() = game.at(15, 8)
	method textColor() = "FFFFFF"
	method text() = nivelActual.toString()
	
	// Mostrar nivel actual.
	method cargar() {
		game.addVisual(self)
	}
	
	// Incrementar nivel.
	method incrementar() {
		nivelActual ++
	}
	
	// Resetear puntaje.
	method resetear() {
		nivelActual = 1
	}
}

// Mensaje "Presionar enter para continuar" del menu.
object mensaje {
	// Configuraciones del mensaje.
	var property image = "MensajeMenu.png"
	var property position = game.at(2, 5)
	// Consultar si se muestra el mensaje.
	method estaActivo() = game.hasVisual(self)
	
	// Mostrar mensaje animado.
	method cargar() {
		game.addVisual(self)
	}
	// Ocultar mensaje.
	method ocultar() {
		game.removeVisual(self)
	}
}