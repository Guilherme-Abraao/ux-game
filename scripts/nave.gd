extends Area2D

signal hit

@export var SPEED = 500 
var screen_size 

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		pass
		#$AnimatedSprite2D.animation = &"right"
		#$AnimatedSprite2D.flip_v = false
		#$AnimatedSprite2D.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#if velocity.y > 0:
			#rotation = PI
		#else:
			#rotation = 0
		#$AnimatedSprite2D.animation = &"up"
		#$AnimatedSprite2D.flip_v = velocity.y > 0
		


func start(pos):
	position = pos
	rotation = 0
	show()
	$CollisionPolygon2D.disabled = false
#

func _on_nave_body_entered(_body):
	hit.emit()
	$CollisionPolygon2D.set_deferred(&"disabled", true)
