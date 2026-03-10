extends Node2D
const BEADING = preload("uid://du4kk4o0wtwme")

var can_tape = false
var taping = false

var start_pos: Vector2
@export var distance_threshold := 80.0


func _process(delta: float) -> void:

	# iniciar gesto
	if Input.is_action_just_pressed("click") and can_tape:
		start_tape()

	# terminar gesto
	if Input.is_action_just_released("click") and taping:
		finish_tape()


func start_tape():
	taping = true
	start_pos = get_global_mouse_position()
	print("starting tape")


func finish_tape():
	taping = false
	
	var end_pos = get_global_mouse_position()
	var dist = start_pos.distance_to(end_pos)

	print("drag distance:", dist)

	if dist > distance_threshold:
		tape()
	else:
		print("drag too small")


func tape():
	print("Tape!")
	get_tree().change_scene_to_packed(BEADING)


func _on_area_2d_mouse_entered() -> void:
	can_tape = true


func _on_area_2d_mouse_exited() -> void:
	can_tape = false
