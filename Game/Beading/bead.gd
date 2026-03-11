# bead.gd
extends Area2D

# Drag & jiggle
var dragging := false
var grab_offset := Vector2.ZERO
var velocity := Vector2.ZERO
var follow_speed := 500.0
var damping := 0.85
var rotation_strength := 0.004
var max_rotation := 0.2

var current_slot = null

@export var bead_type: int = 0
@export var sprite_2d: Sprite2D # assign in inspector to your Sprite2D node
static var dragging_bead: Area2D = null
func _ready():
	input_pickable = true
	# set the sprite safely
	set_bead_type(bead_type)

func set_bead_type(number: int):
	bead_type = number
	if sprite_2d:
		sprite_2d.set_sprite(number)
	else:
		push_error("Sprite2D not assigned in bead")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if dragging_bead == null:
				dragging = true
				dragging_bead = self
				grab_offset = global_position - get_global_mouse_position()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			if dragging:
				dragging = false
				dragging_bead = null

func _process(delta):
	if dragging:
		var target = get_global_mouse_position() + grab_offset
		var force = (target - global_position) * follow_speed
		velocity += force * delta
		velocity *= damping
		global_position += velocity * delta
		rotation = clamp(velocity.x * rotation_strength, -max_rotation, max_rotation)
