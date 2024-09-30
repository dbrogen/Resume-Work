extends CharacterBody3D

#Minimum speed of the mob in meters per second
@export var min_speed = 10;
#Maximum speed of the mob in meters per second
@export var max_speed = 18;

#emitted when player jumps on mob
signal squashed;

func _physics_process(delta: float) -> void:
	move_and_slide();

#Called from the main scene
func initialize(start_position, player_position):
	#Position mob by placing at start_position
	#rotate towards player_position to look at player
	look_at_from_position(start_position, player_position, Vector3.UP);
	
	#Rotate mob randomly between -45 and +45 degrees
	#so that it doesn't move directly at the player
	rotate_y(randf_range(-PI / 4, PI / 4));
	
	#Calculate random speed (integer)
	var random_speed = randi_range(min_speed, max_speed);
	
	#Calculate a forward velocity that represents the speed
	velocity = Vector3.FORWARD * random_speed;
	
	#Rotate the velocity vector based on the y rotation in order to move
	#where the mob is looking
	velocity = velocity.rotated(Vector3.UP, rotation.y);
	
	$AnimationPlayer.speed_scale = random_speed / min_speed;


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free();

func squash():
	squashed.emit();
	queue_free();
	
