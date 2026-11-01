extends CharacterBody2D

@export var health: int = 3
@export var speed: float = 35.0
@export var detection_range: float = 80.0
@onready var player: Node2D = get_tree().get_first_node_in_group("player")
@export var attack_range: float = 18.0
@onready var attack_timer: Timer = $AttackTimer


func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy health: %d" % health)
	if health <= 0:

		queue_free()
		print("Enemy died!")

func _physics_process(_delta):
	if player == null:
		return

	if player.is_dead:
		velocity = Vector2.ZERO
		return

	var distance = global_position.distance_to(player.global_position)

	if distance <= attack_range:
		if player.is_dead:
			return
		if attack_timer.is_stopped():
			attack_timer.start()
			player.take_damage(1) # call the take_damage function on the player with 1 damage
			print("Enemy attacked the player!")
	elif distance < detection_range and distance > attack_range:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()