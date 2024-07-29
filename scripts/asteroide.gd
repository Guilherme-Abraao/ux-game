extends CharacterBody2D

const SPEED = 300.0
const DIRECTION_CHANGE_INTERVAL = 2.0  # Tempo em segundos para mudar a direção

var direction := Vector2.ZERO
var timer := 0.0

# Precarregue a cena do Game Over
@onready var game_over_scene = preload("res://prefabs/game_over.tscn")

func _ready():
	# Inicializa o timer e define uma direção inicial aleatória
	timer = DIRECTION_CHANGE_INTERVAL
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func _physics_process(delta):
	# Atualiza o timer para mudar a direção
	timer -= delta
	if timer <= 0:
		# Altera a direção aleatoriamente
		direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		timer = DIRECTION_CHANGE_INTERVAL

	# Move o asteroide na direção atual e detecta colisões
	var velocity = direction * SPEED * delta
	var collision = move_and_collide(velocity)
	if collision:
		print("Colidiu com algo!")
		
		if collision.collider:  # Verifique se collider existe
			var collided_object = collision.collider
			print("Nome do corpo colidido: ", collided_object.name)
			
			if collided_object.name == "Nave":
				print("Colidiu com a nave!")
				# Carrega a cena do Game Over e muda para ela
				var game_over_instance = game_over_scene.instance()
				get_tree().root.add_child(game_over_instance)
				get_tree().paused = true  # Pausa o jogo
				queue_free()  # Remove o asteroide da cena
		else:
			print("Collider não encontrado.")
