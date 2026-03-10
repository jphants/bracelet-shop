extends RigidBody2D

var dragging := false
var grab_offset := Vector2.ZERO
var velocity := Vector2.ZERO

# parámetros ajustables
var stiffness := 300.0
var damping := 12.0
var rotation_strength := 0.004
var max_rotation := 1


func _ready():
	input_pickable = true


func _input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			gravity_scale = 0
			dragging = true
			grab_offset = global_position - get_global_mouse_position()


func _input(event):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			gravity_scale = 1
			dragging = false


func _physics_process(delta):

	if dragging:
		var target = get_global_mouse_position() + grab_offset
		
		var force = (target - global_position) * stiffness
		
		velocity += force * delta
		velocity *= 1.0 - damping * delta
		
		global_position += velocity * delta
		
		rotation = clamp(velocity.x * rotation_strength, -max_rotation, max_rotation)
