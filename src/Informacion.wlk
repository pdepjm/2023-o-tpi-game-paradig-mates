import wollok.game.*

//////////////////////////////////////////////////////////
// INFORMACIONES DE LA PARTIDA.
//////////////////////////////////////////////////////////
// Clase abstracta de la informacion de texto mostrada.
class InformacionTexto {
	// Informacion a mostar en el HUB.
	var contador = 0
	// Posicion del contador.
	const property position
	// Valor maximo del contador.
	const contadorMaximo
	
	// Configuracion del texto a mostrar.
	method textColor() = "FFFFFF"
	method text() = contador.toString()
	
	// Mostrar informacion en el HUB.
	method cargar() {
		game.addVisual(self)
	}
	
	// Incrementar el valor numerico en pantalla.
	method incrementar(valor) {
		// Si llega al valor maximo, se resetea.
		if(contador + valor > contadorMaximo) self.resetear()
		contador = contador + valor
	}
	
	// Resetear informacion.
	method resetear() {
		contador = 0
	}
}

// Clase abstracta de la informacion de imagen mostrada.
class InformacionImagen {
	// Configuraciones del mensaje.
	var property image = null
	
	// Consultar si esta la pieza activa en el tablero.
	method estaActiva() = game.hasVisual(self)
	
	// Mostrar mensaje animado.
	method cargar() {
		game.addVisual(self)
	}
	
	// Ocultar mensaje.
	method ocultar() {
		game.removeVisual(self)
	}
}

// Puntaje obtenido.
object puntaje inherits InformacionTexto(
	contadorMaximo = 999999999,
	position = game.at(18, 12)
) {}

// Filas completadas.
object filas inherits InformacionTexto(
	contadorMaximo = 10000,
	position = game.at(17, 8)
) {}

// Proxima pieza a generar.
object proxima inherits InformacionImagen {	
	// Consultar la posicion.
	method position() = game.at(13, 8)
}

// Mensaje "Presionar ENTER para continuar" y "Fin de juego".
object mensaje inherits InformacionImagen {
	var property position = null
	
	// Configurar el parpadeo del mensaje.
	method parpadeo() {
		game.onTick(500, "ParpadeoMensaje", {if(self.estaActiva()) self.ocultar() else self.cargar()})
	}
}