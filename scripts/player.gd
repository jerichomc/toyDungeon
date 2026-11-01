extends CharacterBody2D

@export var speed: float = 70.0 # set speed variable to 70.0

var facing_direction: Vector2 = Vector2.DOWN

@onready var sprite: Sprite2D = $Sprite2D # sets the sprite variable to the Sprite2D node in the scene
@onready var sword_hitbox: Area2D = $SwordPivot/SwordHitBox # sets the sword_hitbox variable to the SwordHitBox node in the scene
@onready var attack_timer: Timer = $AttackTimer # sets the attack_timer variable to the AttackTimer node in the scene
@onready var sword_pivot: Node2D = $SwordPivot # sets the sword_pivot variable to the SwordPivot node in the scene
@onready var sword_sprite: Sprite2D = $SwordPivot/SwordSprite # sets the sword_sprite variable to the SwordPivot node in the scene

var front_texture = preload("res://assets/original/redKnight/redKnightFront.png")
var back_texture = preload("res://assets/original/redKnight/redKnightBack.png") # preload("res://assets/original/redKnight/redKnightBack.png")
var side_texture = preload("res://assets/original/redKnight/redKnightSide.png")

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			facing_direction = Vector2(sign(direction.x), 0)
		else:
			facing_direction = Vector2(0, sign(direction.y))

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

	elif direction.x < 0: # if the player is moving left, set the sprite to the side texture and flip it horizontally
		sprite.texture = side_texture
		sprite.flip_h = true

	if Input.is_action_just_pressed("attack") and attack_timer.is_stopped():
		sword_pivot.position = facing_direction * 6 # position the sword pivot in front of the player based on facing direction


		var base_rotation: float = 0.0

		if facing_direction == Vector2.DOWN:
			base_rotation = 180.0
		elif facing_direction == Vector2.UP:
			base_rotation = 0.0
		elif facing_direction == Vector2.RIGHT:
			base_rotation = 90.0
		elif facing_direction == Vector2.LEFT:
			base_rotation = 270.0

		sword_pivot.rotation_degrees = base_rotation - 45.0

		sword_sprite.visible = true
		sword_hitbox.monitoring = true

		var swing_tween = create_tween()
		swing_tween.tween_property(
			sword_pivot,
			"rotation_degrees",
			base_rotation + 45.0,
			0.2
		)
		attack_timer.start()
		print("Attack started!")

	# Move the player
	move_and_slide()


func _on_attack_timer_timeout() -> void:
	sword_hitbox.monitoring = false # turn off hitbox when timer expires
	sword_sprite.visible = false
	print("Attack finished!")


func _on_sword_hit_box_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("enemies"):
		body.take_damage(1) # call the take_damage function on the enemy with 1 damage
