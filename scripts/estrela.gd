extends Node2D

# Variável para armazenar a cena ou tipo de nó que representa a estrela
@export var estrela_scene: PackedScene 
const SPEED = 600.0
var rng = RandomNumberGenerator.new()
var SPAWN_INTERVAL = rng.randf_range(5.0, 15.0)  # Intervalo de tempo para spawn das estrelas

# Define the path to the asteroid scene
var asteroid_scene: PackedScene = load("res://scenes/asteroide.tscn")
var spawn_rate: float = 0.6

# Function to spawn an asteroid
func spawn_asteroid():
	var asteroid_instance = asteroid_scene.instantiate()
	add_child(asteroid_instance)

	# Set a random position for the asteroid within the viewport
	var viewport_size = get_viewport().size
	var spawn_position = Vector2(randf_range(0, viewport_size.x), randf_range(0, viewport_size.y))
	asteroid_instance.position = spawn_position

	# Set a random direction for the asteroid to move downwards
	var direction = Vector2(randf_range(0, 6), randf_range(0, 6))
	asteroid_instance.set_direction(direction)

func _on_body_entered(body: Node2D):
	$anim.play("collect")

func _on_animated_sprite_2d_animation_finished():
	queue_free()
	
# Chamado quando o nó entra na árvore de cena pela primeira vez
func _ready():
	randomize()
	# Cria e configura o timer
	var timer = Timer.new()
	timer.wait_time = SPAWN_INTERVAL
	timer.one_shot = false  # Faz o timer repetir
	timer.autostart = true
	timer.connect("timeout", _on_Timer_timeout)
	add_child(timer)
	
	# Set up a timer to spawn asteroids at regular intervals
	var timerAsteroide = Timer.new()
	add_child(timerAsteroide)
	timerAsteroide.wait_time = spawn_rate
	timerAsteroide.connect("timeout", Callable(self, "spawn_asteroid"))
	timerAsteroide.start()

# Chamado quando o timer expira
func _on_Timer_timeout():
	print("Timer expired, spawning stars...")
	spawnStars()

func spawnStars():
	var estrela = estrela_scene.instantiate()  # Instancia a estrela
	var viewport_size = get_viewport_rect().size
	var angle = randf() * PI * 2
	#estrela.velocity = SPEED
	#estrela.linear_velocity = Vector2(cos(angle), sin(angle)) * SPEED
	estrela.position = Vector2(randf_range(0, viewport_size.x), randf_range(0, viewport_size.y))
	add_child(estrela)
