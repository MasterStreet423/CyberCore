extends Control

func _ready():
	$VBoxContainer/config.connect("pressed", func (): get_tree().change_scene_to_file("res://scenes/configuration.tscn"))
	$VBoxContainer/start.connect("pressed", func (): get_tree().change_scene_to_file("res://scenes/game.tscn"))
	