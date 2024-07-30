extends Area2D

var speed: float = 100.0
var direction: Vector2

func set_direction(new_direction: Vector2):
	direction = new_direction.normalized()

func _ready():
	# Conectar o sinal body_entered ao método _on_body_entered usando Callable
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	# Atualiza a posição do asteroide de acordo com a direção e a velocidade
	position += direction * speed * delta

	# Checa se o asteroide saiu dos limites da tela
	var viewport_size = get_viewport().size
	if position.x > viewport_size.x or position.y > viewport_size.y:
		queue_free()

func _on_body_entered(body: Node):
	if body and body.name == "nave":  # Verifique se 'body' não é nulo e se é a nave
		print("Colisão com a nave detectada!")
		get_tree().change_scene_to_file("res://prefabs/game_over.tscn")
	else:
		print("Nenhuma colisão válida detectada.")
