extends RigidBody2D

@export var MIN_SPEED:int = 150
@export var MAX_SPEED:int = 250

func _ready():
	$AnimatedSprite2D.play()
	var asteoides_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = asteoides_types.pick_random()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
