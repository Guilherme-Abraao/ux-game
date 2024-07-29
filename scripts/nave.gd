extends CharacterBody2D

const SPEED = 1000.0
var hud_node

func _ready():
	hud_node = get_node("../HUD/control")

func _physics_process(delta):
	# Get the input direction and handle the movement.
	var direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	if direction != Vector2.ZERO:
		velocity = direction.normalized() * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _on_area_2d_body_entered(body):
	print("COLIDIU")
	
	if hud_node && hud_node.vidaAtual > 0:
		hud_node.vidaAtual = hud_node.vidaAtual - 1
