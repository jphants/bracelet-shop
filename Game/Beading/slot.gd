extends Area2D

var occupied: bool = false
var bead_inside: Area2D = null  # bead temporal dentro del área
var placed_bead: Area2D = null  # bead realmente colocado
var bead_type: int = -1         # tipo del bead colocado

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _process(delta):
	if bead_inside and Input.is_action_just_released("click") and not occupied:
		# “snap” del bead al slot
		bead_inside.global_position = global_position
		occupied = true
		placed_bead = bead_inside  # ahora este bead está colocado
		bead_type = bead_inside.bead_type
		print("Slot ahora tiene bead type:", bead_type)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bead"):
		bead_inside = area

func _on_area_exited(area: Area2D) -> void:
	# solo reseteamos si el bead que sale es el colocado
	if area == placed_bead:
		placed_bead = null
		occupied = false
		bead_type = -1
	# si un bead temporal sale, no hacemos nada
	if area == bead_inside:
		bead_inside = null
