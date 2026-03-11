extends Node2D
@onready var slots: Node2D = $Slots

var children_list := []

func _ready() -> void:
	for child in slots.get_children():
		children_list.append(child)

func get_beads():
	var line := []

	for child in children_list:
		line.append(child.bead_type)
	
	return line

func _process(delta: float) -> void:
	var line := []

	for child in children_list:
		line.append(child.bead_type)
