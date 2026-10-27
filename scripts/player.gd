extends CharacterBody2D

@export var speed: float = 80.0 #set speed variable to 80.0

@onready var sprite: Sprite2D = $Sprite2D #sets the sprite variable to the Sprite2D node in the scene

var front_texture = preload("res://assets/original/redKnight/redKnightFront.png")
var back_texture = preload("res://assets/original/redKnight/redKnightBack.png") #preload("res://assets/original/redKnight/redKnightBack.png")
var side_texture = preload("res://assets/original/redKnight/redKnightSide.png")

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# Calculate movement velocity
	velocity = direction * speed

	# Change sprite based on movement direction
	if direction.y < 0:
		sprite.texture = back_texture
		sprite.flip_h = false

	elif direction.y > 0:
		sprite.texture = front_texture
		sprite.flip_h = false

	elif direction.x > 0:
		sprite.texture = side_texture
		sprite.flip_h = false

	elif direction.x < 0:
		sprite.texture = side_texture
		sprite.flip_h = true

	# Move the player
	move_and_slide()
