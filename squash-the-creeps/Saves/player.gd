extends CharacterBody3D

#how fast the player moves in meters per second
@export var speed = 14;
#the downward acceleration when in the air, in meters per second squared
@export var fall_acceleration = 75;

#Vertical impulse applied to the character upon jumping in meters per second
@export var jump_impulse = 20;
#Vertical impulse applied to the character upon bouncing over a mob in 
#meters per second
@export var bounce_impulse = 16;

var target_velocity = Vector3.ZERO;

#Emitted when the player is hit by a mob
signal hit;

func _physics_process(delta: float) -> void:
	#local variable to store direction
	var direction = Vector3.ZERO;
	
	#check for movement and update direction accordingly
	if(Input.is_action_pressed("move_right")):
		direction.x += 1;
	if(Input.is_action_pressed("move_left")):
		direction.x -= 1;
	if(Input.is_action_pressed("move_back")):
		direction.z += 1;
	if(Input.is_action_pressed("move_forward")):
		direction.z -= 1;
	
	if(direction != Vector3.ZERO):
		direction = direction.normalized();
		#Setting the basis property affects the rotation of the node
		$Pivot.basis = Basis.looking_at(direction);
	if(direction != Vector3.ZERO):
		$AnimationPlayer.speed_scale = 4;
	else:
		$AnimationPlayer.speed_scale = 1;
	#Ground Velocity
	target_velocity.x = direction.x * speed;
	target_velocity.z = direction.z * speed;
	
	#Vertical Velocity
	if(not is_on_floor()): #if isnt on the floor, fall
		target_velocity.y = target_velocity.y - (fall_acceleration * delta);
	
	#Jumping
	if(is_on_floor() and Input.is_action_pressed("jump")):
		target_velocity.y = jump_impulse;
	
	#Moving the character
	velocity = target_velocity;
	move_and_slide();
	
	#Iterate through all collisions that occured this frame
	for index in range(get_slide_collision_count()):
		#We get one of the collisions with the player
		var collision = get_slide_collision(index);
		
		#if the collision is with the ground
		if(collision.get_collider() == null):
			continue;
		
		#if the collision is with a mob
		if(collision.get_collider().is_in_group("mob")):
			var mob = collision.get_collider();
			#we check that we are hitting it from above
			if(Vector3.UP.dot(collision.get_normal()) > 0.1):
				#if so we squash it and bounce
				mob.squash();
				target_velocity.y = bounce_impulse;
				#prevent further duplicate calls
				break;
	$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse;

func die():
	hit.emit();
	queue_free();
	
func _on_mob_detector_body_entered(body: Node3D) -> void:
	die();
