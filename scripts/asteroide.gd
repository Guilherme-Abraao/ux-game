extends Area2D

var speed: float = 300.0
var direction: Vector2

func set_direction(new_direction: Vector2):
	direction = new_direction.normalized()

func _ready():
	# Definir a posição inicial fora da tela
	set_initial_position()
	# Conectar o sinal body_entered ao método _on_body_entered usando Callable
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	# Atualiza a posição do asteroide de acordo com a direção e a velocidade
	position += direction * speed * delta 

	# Checa se o asteroide saiu dos limites da tela
	var viewport_size = get_viewport().size
	if position.x > viewport_size.x or position.y > viewport_size.y or position.x < 0 or position.y < 0:
		queue_free()

func set_initial_position():
	var viewport_size = get_viewport().size
	var edge = randi() % 4  # Escolhe aleatoriamente um dos quatro lados da tela

	match edge:
		0:
			# Lado esquerdo
			position.x = -100
			position.y = randf() * viewport_size.y
		1:
			# Lado direito
			position.x = viewport_size.x + 100
			position.y = randf() * viewport_size.y
		2:
			# Parte superior
			position.x = randf() * viewport_size.x
			position.y = -100
		3:
			# Parte inferior
			position.x = randf() * viewport_size.x
			position.y = viewport_size.y + 100

	# Configura uma direção aleatória em direção à tela
	var target_x = viewport_size.x / 2
	var target_y = viewport_size.y / 2
	set_direction(Vector2(target_x - position.x, target_y - position.y))

func _on_body_entered(body: Node):
	if body and body.name == "nave":  # Verifique se 'body' não é nulo e se é a nave
		print("Colisão com a nave detectada!")
		get_tree().change_scene_to_file("res://prefabs/game_over.tscn")
	else:
		print("Nenhuma colisão válida detectada.")
