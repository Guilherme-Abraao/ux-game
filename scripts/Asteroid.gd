extends Node2D

const SPEED = 600.0
var velocity = Vector2.ZERO

@export var asteroid_scene: PackedScene

func _ready():
	randomize()
	spawn()

func spawn():
	# Definir uma velocidade aleatória
	var viewport_size = get_viewport_rect().size
	var angle = randf() * PI * 2
	
	velocity = Vector2(cos(angle), sin(angle)) * SPEED
	position = Vector2(randf_range(0, viewport_size.x), randf_range(0, viewport_size.y))

func _physics_process(delta):
	position += velocity * delta

	# Verificar limites da tela e reposicionar se necessário
	if position.x < 0 or position.x > get_viewport_rect().size.x or position.y < 0 or position.y > get_viewport_rect().size.y:
		spawn()
