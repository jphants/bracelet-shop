extends Node2D

@export var copies: int = 22       # cuántas veces quieres duplicar
@export var separation: float = 50 # separación en píxeles entre duplicados

func _ready() -> void:
	# Guardamos los hijos originales en una lista para no modificar mientras iteramos
	var original_children = []
	for child in get_children():
		original_children.append(child)

	for i in range(1, copies + 1):
		for child in original_children:
			# Duplicar el nodo
			var new_child = child.duplicate() # duplicado simple (no deep copy)
			add_child(new_child)

			# Moverlo a la derecha
			new_child.position = child.position + Vector2(separation * i, 0)
