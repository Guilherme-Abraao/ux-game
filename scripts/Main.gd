extends Node2D

# Exporta a cena do asteroide para ser configurada no editor
export(PackedScene) var asteroide
const ASTEROID_SPAWN_INTERVAL = 2.0

func _ready():
	var spawn_timer = $SpawnTimer
	spawn_timer.wait_time = ASTEROID_SPAWN_INTERVAL
	spawn_timer.connect("timeout", self, "_on_spawn_timer_timeout")
	spawn_timer.start()

func _on_spawn_timer_timeout():
	if AsteroidScene:
		var asteroid = AsteroidScene.instance()
		add_child(asteroid)
		asteroid.position = Vector2(
			randi() % int(get_viewport_rect().size.x),
			randi() % int(get_viewport_rect().size.y)
		)
