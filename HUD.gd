extends CanvasLayer

signal inicio_juego

func mostrar_mensaje(texto):
	$Label_Mensaje.text = texto
	$Label_Mensaje.show()
	$Timer_Mensaje.start()
	
func mostrar_fin_de_juego():
	mostrar_mensaje("Fin Del Juego")
	#Esperamos a que el timer termine
	yield($Timer_Mensaje, "timeout")
	
	$Label_Mensaje.text = "Lost In Space"
	$Label_Mensaje.show()
	
	#Hacemos un Timer de una sola ocasión y esperamos su finalizacion
	yield(get_tree().create_timer(1), "timeout")
	$Button_Inicio.show()

func actualizar_puntuacion(puntuacion):
	$Label_Puntuacion.text = str(puntuacion)

func _on_Timer_Mensaje_timeout():
	$Label_Mensaje.hide()

func _on_Button_Inicio_pressed():
	$Button_Inicio.hide()
	emit_signal("inicio_juego")
