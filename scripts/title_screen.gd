extends Control

func _ready():
	$Sound.play()

func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_credits_btn_pressed():
	get_tree().change_scene_to_file("res://prefabs/tutorial_screen.tscn")


func _on_quit_btn_pressed():
	get_tree().quit()
