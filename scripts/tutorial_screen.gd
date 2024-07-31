extends Control

func _ready():
	$Sound.play()

func _on_quit_btn_pressed():
	get_tree().change_scene_to_file("res://prefabs/title_screen.tscn")
