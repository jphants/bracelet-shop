extends Node2D
const BEADING = preload("uid://du4kk4o0wtwme")

var can_tape = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click") and can_tape:
		tape()


func tape():
	print("Tape!") # aquí luego pones la animación o lógica
	get_tree().change_scene_to_packed(BEADING)


func _on_area_2d_mouse_entered() -> void:
	can_tape = true


func _on_area_2d_mouse_exited() -> void:
	can_tape = false
