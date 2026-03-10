extends Node2D

var can_cut = false
var cutting = false

var start_pos: Vector2
@export var height_threshold := 100.0

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
	start_pos = get_global_mouse_position()
	print("cutting")


func finish_cut():
	cutting = false
	
	var end_pos = get_global_mouse_position()
	var height_diff = start_pos.y - end_pos.y
	
	print("height diff: ", height_diff)

	if height_diff > height_threshold:
		get_tree().change_scene_to_packed(TAPE)
	else:
		print("cut too small")


func _on_area_2d_mouse_entered() -> void:
	can_cut = true


func _on_area_2d_mouse_exited() -> void:
	can_cut = false
