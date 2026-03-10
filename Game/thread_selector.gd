extends Node2D

var items = ["item1", "item2", "item3", "item4", "item5"]
var selected_index = 0

var is_mouse_in_selection_area = false
var dragging = false

@onready var start_area: Area2D = $StartArea
@onready var end_area: Area2D = $EndArea

func _ready() -> void:
	print("Selected: ", items[selected_index])

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scroll_down"):
		selected_index = (selected_index + 1) % items.size()
		print("Selected: ", items[selected_index])
		
	if Input.is_action_just_pressed("scroll_up"):
		selected_index = (selected_index - 1 + items.size()) % items.size()
		print("Selected: ", items[selected_index])
	# Start drag
	if Input.is_action_just_pressed("click") and is_mouse_in_selection_area:
		dragging = true
		print("Started dragging")

	# Stop drag if mouse released
	if Input.is_action_just_released("click"):
		dragging = false


func _on_start_area_mouse_entered() -> void:
	is_mouse_in_selection_area = true

func _on_start_area_mouse_exited() -> void:
	is_mouse_in_selection_area = false


func _on_end_area_mouse_entered() -> void:
	if dragging:
		print("Drag completed!")
		dragging = false
