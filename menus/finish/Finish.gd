extends Node2D

@onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	$Label.text = "Score " + str(player_vars.score)

func _on_play_again_pressed():
	get_tree().change_scene_to_file("res://scenes/gauntlet/Gauntlet.tscn")

func _on_quit_pressed():
	get_tree().quit()
