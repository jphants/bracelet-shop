# bead_sprite.gd
extends Sprite2D

@export var atlas_texture: AtlasTexture

var sprite_regions := [
	Rect2(3, 25, 35, 40),
	Rect2(43, 20, 45, 50),
	Rect2(93, 25, 45, 45),
	Rect2(143, 5, 30, 65),
	Rect2(13, 80, 45, 50),
	Rect2(63, 90, 50, 40),
	Rect2(118, 75, 50, 55),
	Rect2(3, 140, 55, 35),
	Rect2(63, 135, 45, 45),
	Rect2(113, 140, 40, 40),
	Rect2(163, 135, 30, 50),
	Rect2(18, 190, 45, 50),
	Rect2(68, 200, 100, 35)
]

func _ready():
	if atlas_texture:
		texture = atlas_texture
		set_sprite(0) # default sprite

func set_sprite(index: int):
	if not atlas_texture:
		return
	if index < 0 or index >= sprite_regions.size():
		push_warning("Sprite index %d out of range!" % index)
		return

	var new_atlas = AtlasTexture.new()
	new_atlas.atlas = atlas_texture.atlas
	new_atlas.region = sprite_regions[index]
	texture = new_atlas
