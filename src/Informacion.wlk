import wollok.game.*

//////////////////////////////////////////////////////////
// INFORMACION DE LA PARTIDA.
//////////////////////////////////////////////////////////
// TODO: Desarrollar clase abstracta 'Informacion'.
class Informacion {
	
}

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

// Filas completadas.
object contadorFilas {
	// Cantidad de filas completadas.
	var contador = 0
	
	// Configuraciones del contador de filas completadas.
	method position() = game.at(17, 8)
	method textColor() = "FFFFFF"
	method text() = contador.toString()
	
	// Mostrar cantidad de filas completadas.
	method cargar() {
		game.addVisual(self)
	}
	
	// Incrementar contador.
	method incrementar(valor) {
		contador = contador + valor
	}
	
	// Resetear contador.
	method resetear() {
		contador = 0
	}
}

// Proxima pieza a generar. // TODO: Hacer test.
object proxima {
	// Configuraciones de la proxima pieza.
	var property image = null
	// Consultar la posicion.
	method position() = game.at(13, 8)
	
	// Mostrar proxima pieza.
	method cargar(pieza) {
		image = pieza.mini()
		game.addVisual(self)
	}
	
	// Ocultar proxima pieza.
	method ocultar() {
		game.removeVisual(self)
	}
}

// Mensaje "Presionar enter para continuar" y "Fin de juego".
object mensaje {
	// Configuraciones del mensaje.
	var property image = null
	var property position = null
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
	
	// Configurar el parpadeo del mensaje.
	method parpadeo() {
		game.onTick(500, "ParpadeoMensaje", {if(self.estaActivo()) self.ocultar() else self.cargar()})
	}
}