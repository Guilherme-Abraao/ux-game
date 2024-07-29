extends CharacterBody2D

# Variables to control the asteroid's speed and direction
var speed: float = 100.0
var direction: Vector2

# Function to set the asteroid's initial direction
func set_direction(new_direction: Vector2):
	direction = new_direction.normalized()

func _process(delta):
	var viewport_size = get_viewport().size
	
	# Move the asteroid based on the direction and speed
	velocity = direction * speed
	move_and_slide()
	
	# Check if the asteroid is out of bounds
	if position.x > 1150.0 or position.y > 620.0:
		queue_free()  # Remove the asteroid from the scene

# Handle collisions with the spacecraft
func _on_Asteroid_body_entered(body):
	if body.name == "nave":
		print("COLIDIU")
		queue_free()  # Remove the asteroid

func _on_area_2d_body_entered(body):
	queue_free()
	print("COLIDIU")
