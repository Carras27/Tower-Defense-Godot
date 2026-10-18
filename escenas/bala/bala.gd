extends Area2D

var speed: float = 180.0
var damage: float = 30.0
var direction: Vector2

# Fija la direccion de la bala hacia el objetivo.
func set_target_position(target_pos: Vector2):
	look_at(target_pos)
	direction = (target_pos - global_position).normalized()

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemigos"):
		body.take_damage(damage)
		queue_free()

func _on_vida_timeout():
	queue_free()
