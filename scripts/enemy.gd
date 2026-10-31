extends CharacterBody2D

@export var health: int = 3

func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy health: %d" % health)
	if health <= 0:

		queue_free()
		print("Enemy died!")