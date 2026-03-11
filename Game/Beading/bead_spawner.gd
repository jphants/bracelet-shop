# bead_spawner.gd
extends Area2D

const BEAD = preload("uid://comtdmaadesj5")

@export var bead_number: int = 0
@export var spawn_cooldown: float = 1.0

var beads_inside := 0
var can_spawn := true

func _ready():
	spawn_bead()
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	if area.is_in_group("bead"):
		beads_inside += 1

func _on_area_exited(area):
	if area.is_in_group("bead"):
		beads_inside -= 1
		if beads_inside <= 0:
			start_cooldown()

func start_cooldown():
	if not can_spawn:
		return
	can_spawn = false
	await get_tree().create_timer(spawn_cooldown).timeout
	if beads_inside == 0:
		spawn_bead()
	can_spawn = true

func spawn_bead():
	var bead = BEAD.instantiate()
	get_parent().add_child.call_deferred(bead)
	bead.global_position = global_position
	# safely set bead type after instantiation
	bead.call_deferred("set_bead_type", bead_number)
