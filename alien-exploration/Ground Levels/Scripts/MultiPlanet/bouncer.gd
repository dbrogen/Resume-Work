class_name Bouncer
extends Area2D

## Flips the enemy's direction and sprite orientation
func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Enemy")):
		if(body.direction == 1):
			body.direction = -1;
			body.animated_sprite_2d.flip_h = true;
		else:
			body.direction = 1;
			body.animated_sprite_2d.flip_h = false;
