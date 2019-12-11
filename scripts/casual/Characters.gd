extends Area2D

export (int) var velCharacter 	# Velocidad de movimiento del personaje
var movCharacter = Vector2()	# Coordenadas de movimiento (x,y)
signal hitCharacter				# Señal que se emitirá cuando resiva un colisionador

func _ready(): 	# Inicio del uso del personaje
	show()		# Muestra el personaje

"""
	Sistema de movimiento
	W A S D / ↑ ← ↓ →
	
	Se ejecuta en el proceso delta, pues se tiene
	que efectuar en cada fotograma.
	Cada pulsación de la tecla mueve el personaje
	a un fragmento en el eje x o y, y luego se
	devuelve a 0 el desplazamiento para evitar
	un constante movimiento. (Ver comentario # :1)
"""

func _process(delta):
	movCharacter = Vector2()
	if Input.is_action_pressed("ui_up"):	# W / ↑
		movCharacter.y -= 1
	if Input.is_action_pressed("ui_down"):	# S / ↓
		movCharacter.y += 1
	if Input.is_action_pressed("ui_left"):	# A / ←
		movCharacter.x -= 1
	if Input.is_action_pressed("ui_right"): # D / →
		movCharacter.x += 1
	if movCharacter.length() > 0: # :1
		movCharacter = movCharacter.normalized() * velCharacter # Verifica si se está moviendo
	position += movCharacter * delta # Actualizar y mantener el movimiento con la velocidad

"""
	Sistema de colisiones
	
	\\ _on_Characters_body_entered
		Esta función emitirá una señal la cual
		será usada para representar cuando otro
		colisionador golpea al jugador.
		
	\\ _show_Character
		Función que se usa para mostrar el
		personaje del escenario en sus
		coordenadas Vector2(x,y).
		
	\\ _hide_Character	
		Función que se usa para ocultar el
		personaje del escenario en sus
		coordenadas Vector2(x,y).
"""

func _on_Characters_body_entered(body): # Colisión del personaje
	emit_signal("hitCharacter")
	$Collision_C.disabled = true
	
func _show_Character(positionCharacter): # Mostrar el personaje
	position = positionCharacter
	show()

func _hide_Character(positionCharacter): # Ocultar personaje
	position = positionCharacter
	hide()
	$Collision_C.disabled = true