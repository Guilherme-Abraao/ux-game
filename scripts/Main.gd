extends Node

@export var asteroide_scene: PackedScene
var score

func _ready():
	new_game()

func new_game():
	get_tree().call_group(&"asteroides", &"queue_free")	
	score = 0
	$nave.start($StartPosition.position)
	$StartTimer.start()
	$Music.play()	


func game_over():
	
	if score > Globals.pontuacao_maxima:
		Globals.pontuacao_maxima = score
		
	$Music.stop()
	$ScoreTimer.stop()
	$AsteroideTimer.stop()
	$DeathSound.play()
	$nave.hide()
	await $DeathSound.finished
	get_tree().change_scene_to_file("res://prefabs/game_over.tscn")


func _on_start_timer_timeout():
	$AsteroideTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_asteroide_timer_timeout():
	
	var asteroide = asteroide_scene.instantiate()
#
	var asteroide_spawn_location = get_node(^"AsteroidePath/AsteoirdeSpawnLocation")
	asteroide_spawn_location.progress = randi()

	var direction = asteroide_spawn_location.rotation + PI / 2
	
	asteroide.position = asteroide_spawn_location.position

	direction += randf_range(-PI / 4, PI / 4)
	asteroide.rotation = direction

	var velocity = Vector2(randf_range(asteroide.MIN_SPEED, asteroide.MAX_SPEED), 0.0)
	asteroide.linear_velocity = velocity.rotated(direction)

	add_child(asteroide)
