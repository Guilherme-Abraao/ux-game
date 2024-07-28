extends Node2D

# Variável para armazenar a cena ou tipo de nó que representa a estrela
@export var estrela_scene: PackedScene 
const SPEED = 600.0
var rng = RandomNumberGenerator.new()
var SPAWN_INTERVAL = rng.randf_range(5.0, 15.0)  # Intervalo de tempo para spawn das estrelas

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
