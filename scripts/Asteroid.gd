extends Node2D

const SPEED = 100.0
var velocity = Vector2.ZERO

# Exporta a cena do asteroide para ser configurada no editor
@export var asteroid_scene: PackedScene

func _ready():
	randomize()
	# Definir uma velocidade aleatória
	var angle = randf() * PI * 2
	velocity = Vector2(cos(angle), sin(angle)) * SPEED

func _physics_process(delta):
	position += velocity * delta

	# Verificar limites da tela e reposicionar se necessário
	if position.x < 0:
		position.x = get_viewport_rect().size.x
	elif position.x > get_viewport_rect().size.x:
		position.x = 0

	if position.y < 0:
		position.y = get_viewport_rect().size.y
	elif position.y > get_viewport_rect().size.y:
		position.y = 0
