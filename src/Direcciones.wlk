import wollok.game.*

//////////////////////////////////////////////////////////
// ♦ DIRECCIONES.
//////////////////////////////////////////////////////////
object izquierda {
	// Obtener una posicion a la izquierda.
	method posicion(origen) = origen.left(1)
}

object abajo {
	// Obtener una posicion abajo.
	method posicion(origen) = origen.down(1)
}

object derecha {
	// Obtener una posicion a la derecha.
	method posicion(origen) = origen.right(1)
}

//////////////////////////////////////////////////////////
// ♦ SENTIDOS.
//////////////////////////////////////////////////////////

object horario {
	// Obtener una posicion rotada en sentido horario.
	method posicion(origen, centro) = game.at(
		- origen.y() + centro.x() + centro.y(),
		origen.x() - centro.x() + centro.y()
	)
}

object antiHorario {
	// Obtener una posicion rotada en sentido anti-horario.
	method posicion(origen, centro) = game.at(
		origen.y() + centro.x() - centro.y(),
		- origen.x() + centro.x() + centro.y()
	)
}