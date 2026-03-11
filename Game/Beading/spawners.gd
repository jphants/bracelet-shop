extends Node2D

@export var copies: int = 12
@export var separation: float = 100  # más separación para ver mejor

func _ready() -> void:
	if get_child_count() == 0:
		push_error("No hay hijos para duplicar")
		return

	var original = get_child(0)

	for i in range(copies):
		var new_child = original.duplicate(true)  # duplicar subnodos y recursos
		add_child(new_child)
		new_child.position = original.position + Vector2(separation * i, 0)


		new_child.bead_number = i
		print("Created copy ", i, " at ", new_child.position)
