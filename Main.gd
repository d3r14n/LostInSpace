extends Node

export(PackedScene) var scene_meteorito
var puntuacion

func _ready():
	randomize()

func nuevo_juego():
	puntuacion = 0
	$HUD.actualizar_puntuacion(puntuacion)
	$HUD.mostrar_mensaje("Preparate")
	get_tree().call_group("meteoritos", "queue_free")
	$Nave.inicio($Position2D_Inicio.position)
	$Timer_Inicio.start()
	$Musica.play()

func fin_de_juego():
	$Timer_Puntuacion.stop()
	$Timer_Meteorito.stop()
	$HUD.mostrar_fin_de_juego()
	$Musica.stop()
	$SonidoMuerte.play()

func _on_Timer_Meteorito_timeout():
	#Crear un nuevo meteoro
	var meteoro = scene_meteorito.instance()
	
	#Escoger una posición al azar con Path2D
	var ubicacion_generador_meteorito = get_node("Path2D/PathFollow2D_GeneradorMeteoritos")
	ubicacion_generador_meteorito.offset = randi()
	
	#Establecer la dirección del meteorito; perpendicular al camino del PathFollow2D_GeneradorMeteoritos
	var direccion = ubicacion_generador_meteorito.rotation + PI / 2
	
	#Establecer la ubicación del meteoro al azar
	meteoro.position = ubicacion_generador_meteorito.position
	
	#Aleatorizar la dirección del meteoro
	direccion += rand_range(-PI / 4, PI / 4)
	meteoro.rotation = direccion
	
	#Seleccionar la velocidad del meteoro
	var velocidad = Vector2(rand_range(150.0, 250.0), 0.0)
	meteoro.linear_velocity = velocidad.rotated(direccion)
	
	#Añadir el meteoro a la escena
	add_child(meteoro)

func _on_Timer_Puntuacion_timeout():
	puntuacion += 1
	$HUD.actualizar_puntuacion(puntuacion)

func _on_Timer_Inicio_timeout():
	$Timer_Meteorito.start()
	$Timer_Puntuacion.start()
