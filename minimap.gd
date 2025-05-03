extends CanvasLayer
@onready var player_body: CharacterBody2D = get_tree().get_current_scene().get_node("Player/CharacterBody2D")
@onready var levels_tilemap: TileMapLayer = get_tree().get_current_scene().get_node("Levels/TileMapLayer")
@onready var pointer_texture: Texture2D = preload("res://Assets/pointer.png")
@onready var sub_viewport = $SubViewportContainer/SubViewport
@onready var camera2d     = sub_viewport.get_node("Camera2D")
var pointer_sprite: Sprite2D
func _ready() -> void:
	var mini_map_tilemap = levels_tilemap.duplicate(true)
	sub_viewport.add_child(mini_map_tilemap)

	pointer_sprite = Sprite2D.new()
	pointer_sprite.texture = pointer_texture
	pointer_sprite.centered = true
	pointer_sprite.scale = Vector2(1, 1) 
	sub_viewport.add_child(pointer_sprite)
	camera2d.make_current()
func _process(delta: float) -> void:
	if player_body and pointer_sprite:
		pointer_sprite.global_position = player_body.global_position
		pointer_sprite.rotation = player_body.rotation
		camera2d.global_position = player_body.global_position
