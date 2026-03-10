extends Node2D

const FINAL_DISPLAY = preload("uid://dd1cyoi2hoxu1")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(FINAL_DISPLAY)
	pass # Replace with function body.
