extends Area2D

signal golpe

export var velocidad = 400 #Velocidad en pixeles en la que se moverá la nave. Defecto 400

var tamano_pantalla #Tamaño de la pantalla

func _ready():
	tamano_pantalla = get_viewport_rect().size
	hide()

func _process(delta):
	var movimiento = Vector2.ZERO #Velocidad de movimiento de la nave
	
	if Input.is_action_pressed("player_move_right"):
		movimiento.x += 1
	if Input.is_action_pressed("player_move_left"):
		movimiento.x -= 1
	if Input.is_action_pressed("player_move_down"):
		movimiento.y += 1
	if Input.is_action_pressed("player_move_up"):
		movimiento.y -= 1
	
	if movimiento.length() > 0:
		movimiento = movimiento.normalized() * velocidad
		$AnimatedSprite.animation = "mover"
	
	position += movimiento * delta
	position.x = clamp(position.x, 0, tamano_pantalla.x)
	position.y = clamp(position.y, 0, tamano_pantalla.y)
	
	if movimiento.y == 0 && movimiento.x > 0: #Derecha
		$AnimatedSprite.rotation = PI / 2
	if movimiento.y == 0 && movimiento.x < 0: #Izquierda
		$AnimatedSprite.rotation = -PI / 2
	if movimiento.y > 0 && movimiento.x == 0: #Abajo
		$AnimatedSprite.rotation = PI
	if movimiento.y < 0 && movimiento.x == 0: #Arriba
		$AnimatedSprite.rotation = 0
	if movimiento.y > 0 && movimiento.x > 0: #Abajo-Derecha
		$AnimatedSprite.rotation = 3 * PI / 4
	if movimiento.y > 0 && movimiento.x < 0: #Abajo-Izquierda
		$AnimatedSprite.rotation = -3 * PI / 4
	if movimiento.y < 0 && movimiento.x > 0: #Arriba-Derecha
		$AnimatedSprite.rotation = PI / 4
	if movimiento.y < 0 && movimiento.x < 0: #Arriba-Izquierda
		$AnimatedSprite.rotation = -PI / 4

func _on_Nave_body_entered(_body):
	hide() #La Nave desaparece al chocar
	emit_signal("golpe")
	$CollisionShape2D.set_deferred("disabled", true)
	
func inicio(pos):
	if pos != null:
		position = pos
	else:
		position.x = tamano_pantalla.x / 2
		position.y = tamano_pantalla.y / 2
		
	show()
	$CollisionShape2D.disabled = false
