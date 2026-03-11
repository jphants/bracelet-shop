extends Area2D

var occupied = false
var bead_inside = null

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _process(delta):

	if bead_inside and Input.is_action_just_released("click") and not occupied:
		bead_inside.global_position = global_position
		occupied = true


func _on_area_entered(area):

	if area.is_in_group("bead"):
		bead_inside = area


func _on_area_exited(area):

	if area == bead_inside:
		bead_inside = null
		occupied = false
