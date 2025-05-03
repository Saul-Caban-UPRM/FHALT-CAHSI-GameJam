extends Node2D
@onready var player = get_node("res://Scenes/player.tscn")

func _process(_delta):
	global_position = player.global_position
