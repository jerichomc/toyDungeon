extends CharacterBody2D

@export var speed: float = 80.0 #set speed variable to 80.0

@onready var sprite: Sprite2D = $Sprite2D #sets the sprite variable to the Sprite2D node in the scene
@onready var sword_hitbox: Area2D = $SwordHitBox #sets the sword_hitbox variable to the SwordHitBox node in the scene
@onready var attack_timer: Timer = $AttackTimer #sets the attack_timer variable to the AttackTimer node in the scene

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

	elif direction.x < 0: #if the player is moving left, set the sprite to the side texture and flip it horizontally
		sprite.texture = side_texture
		sprite.flip_h = true

	if Input.is_action_just_pressed("attack") and attack_timer.is_stopped():
		sword_hitbox.monitoring = true
		attack_timer.start()
		print("Attack!")

	# Move the player
	move_and_slide()


func _on_attack_timer_timeout() -> void:
	sword_hitbox.monitoring = false
	print("Attack finished!")
