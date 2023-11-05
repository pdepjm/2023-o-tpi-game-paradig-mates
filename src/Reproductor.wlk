import wollok.game.*

//////////////////////////////////////////////////////////
// ♦ MUSICA DEL JUEGO.
//////////////////////////////////////////////////////////

// Molde para la Musica del juego.
class Musica {
	const musica
	
	// Saber si la musica esta pausada.
	method estaPausada() = musica.paused()
	
	// Iniciar musica.
	method reproducir() {
		if(not musica.played()){
		// Loopear musica.
		musica.shouldLoop(true)
		// Reproducir musica.
		game.schedule(5, {=> musica.play()})
		}
	}
	
	// Detener musica.
	method parar() {
		if(musica.played()) musica.stop()
	}
	
	// Pausar musica.
	method pausar() {
		if(musica.played()) musica.pause()
	}
	
	// Reanudar musica.
	method reanudar() {
		if(musica.paused()) musica.resume()
	}
}