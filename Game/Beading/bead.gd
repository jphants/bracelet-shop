extends Area2D

var dragging := false
var grab_offset := Vector2.ZERO
var velocity := Vector2.ZERO
var current_slot = null

# parámetros ajustables
var follow_speed := 500.0
var damping := 0.85
var rotation_strength := 0.004
var max_rotation := 0.2

var number_bead = 1

func _ready():
	input_pickable = true


func _input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			
			dragging = true
			grab_offset = global_position - get_global_mouse_position()

			# liberar slot si estaba en uno
			if current_slot:
				current_slot.occupied = false
				get_parent().print_slots()
				current_slot = null


func _input(event):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			
			if dragging:
				dragging = false


func _process(delta):

	if dragging:
		
		var target = get_global_mouse_position() + grab_offset
		
		var force = (target - global_position) * follow_speed
		
		velocity += force * delta
		velocity *= damping
		
		global_position += velocity * delta
		
		rotation = clamp(velocity.x * rotation_strength, -max_rotation, max_rotation)
