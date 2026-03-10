extends Node2D

var can_cut = false
var cutting = false
const TAPE = preload("uid://b6ajcfqfh5a6e")


func _process(delta: float) -> void:

	# empezar preparación de corte
	if Input.is_action_just_pressed("click") and can_cut:
		start_cutting()

	# ejecutar corte
	if Input.is_action_just_released("click") and cutting:
		finish_cut()


func start_cutting():
	cutting = true
	print("cutting") # aquí animación de preparar


func finish_cut():
	cutting = false
	print("cut") # aquí animación de cortar
	get_tree().change_scene_to_packed(TAPE)


func _on_area_2d_mouse_entered() -> void:
	can_cut = true


func _on_area_2d_mouse_exited() -> void:
	can_cut = false
