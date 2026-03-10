extends Node2D

var items = ["item1", "item2", "item3", "item4", "item5"]
var selected_index = 0

var is_mouse_in_selection_area = false
var dragging = false
var success = false

var rope: Rope = null
var drag_handle: RopeHandle = null

@onready var start_area: Area2D = $StartArea
@onready var end_area: Area2D = $EndArea


func _ready() -> void:
	print("Selected: ", items[selected_index])


func _process(delta: float) -> void:

	# mover handle con el mouse
	if dragging and drag_handle != null:
		var mouse_pos = get_global_mouse_position()
		drag_handle.global_position = mouse_pos
		
		# calcular distancia al origen
		var dist = start_area.global_position.distance_to(mouse_pos)
		
		# actualizar longitud del rope
		rope.rope_length = dist + 10

	# Scroll abajo
	if Input.is_action_just_pressed("scroll_down"):
		selected_index = (selected_index + 1) % items.size()
		print("Selected: ", items[selected_index])

	# Scroll arriba
	if Input.is_action_just_pressed("scroll_up"):
		selected_index = (selected_index - 1 + items.size()) % items.size()
		print("Selected: ", items[selected_index])

	# Empezar drag
	if Input.is_action_just_pressed("click") and is_mouse_in_selection_area:
		start_drag()

	# Soltar click
	if Input.is_action_just_released("click"):
		stop_drag()


func start_drag():
	dragging = true
	success = false

	rope = Rope.new()
	rope.global_position = start_area.global_position
	add_child(rope)

	drag_handle = RopeHandle.new()
	drag_handle.global_position = start_area.global_position
	add_child(drag_handle)

	drag_handle.rope_path = rope.get_path()

	print("Started dragging")


func stop_drag():
	dragging = false

	if rope == null or drag_handle == null:
		return

	if success:
		drag_handle.global_position = end_area.global_position
	else:
		drag_handle.queue_free()
		rope.queue_free()

	rope = null
	drag_handle = null


func _on_start_area_mouse_entered() -> void:
	is_mouse_in_selection_area = true


func _on_start_area_mouse_exited() -> void:
	is_mouse_in_selection_area = false


func _on_end_area_mouse_entered() -> void:
	if dragging:
		print("Drag completed!")
		success = true
