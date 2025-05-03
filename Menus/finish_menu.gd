extends Control

var Ballora = GameState.Ballora
var Bonnie = GameState.Bonnie
var Chica = GameState.Chica
var Foxy = GameState.Foxy
var Golden_plush = GameState.Golden_plush
func _ready() -> void:
	if Ballora:
		$TextureRect/MarginContainer2/PlushiesHolder/Ballora.show()
	if Bonnie:
		$TextureRect/MarginContainer2/PlushiesHolder/Bonnie.show()
	if Chica:
		$TextureRect/MarginContainer2/PlushiesHolder/Chica.show()
	if Foxy:
		$TextureRect/MarginContainer2/PlushiesHolder/Foxy.show()
	if Golden_plush:
		$"TextureRect/MarginContainer2/PlushiesHolder/Golden-plush".show()

func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_play_pressed() -> void:
	$AnimationPlayer.play("Fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://loor.tscn")
	
