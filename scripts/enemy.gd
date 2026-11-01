extends CharacterBody2D

@export var health: int = 3
@export var speed: float = 35.0
@export var detection_range: float = 80.0
@onready var player: Node2D = get_tree().get_first_node_in_group("player")
@export var attack_range: float = 18.0


func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy health: %d" % health)
	if health <= 0:

		queue_free()
		print("Enemy died!")

func _physics_process(_delta):
	if player == null:
		return

	var distance = global_position.distance_to(player.global_position)

	if distance < detection_range and distance > attack_range:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()