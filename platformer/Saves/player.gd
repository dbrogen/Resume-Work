extends CharacterBody2D


const SPEED: float = 300.0
const JUMP_VELOCITY: float = -600.0
const JUMP_IMPULSE:float = -400;

var direction;
var enemies_stomped: int;

signal end_of_game;
signal add_to_score;
signal victory;

func move(direction):
	if(direction == -1):
		$AnimatedSprite2D.flip_h = true;
	elif(direction == 1):
		$AnimatedSprite2D.flip_h = false;
		
	if direction:
		velocity.x = direction * SPEED;
		$AnimatedSprite2D.play("Walk");
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED);
		$AnimatedSprite2D.play("Idle");

#Handles the jump
func jump():
	velocity.y = JUMP_VELOCITY;
	#$AnimatedSprite2D.play("Jump");
	

func _input(event):
	if(Input.is_action_just_pressed("jump") and is_on_floor()):
		jump();
	if(event.is_action("move_left") or event.is_action("move_right")):
		direction = Input.get_axis("move_left", "move_right");
		move(direction);


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if((velocity.y > 0) and (not is_on_floor())):
		$AnimatedSprite2D.play("Fall");
	elif ((velocity.y < 0) and (not is_on_floor())):
		$AnimatedSprite2D.play("Jump");
	else:
		$AnimatedSprite2D.play(("Idle"));
		
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Player Died");
	end_of_game.emit();
	if(velocity.y != get_gravity().y):
		hide();
		set_process_input(false);


func _on_land_enemy_stomped() -> void:
	enemies_stomped += 1;
	velocity.y = JUMP_IMPULSE;
	print("Enemies stomped: " + str(enemies_stomped));
	add_to_score.emit();


func _on_end_level_1_body_entered(body: Node2D) -> void:
	print("End of Level 1");
	global_position.x -= 1000;
	global_position.y += 600;


func _on_end_level_2_body_entered(body: Node2D) -> void:
	print("End of Level 2");
	global_position.y += 800;


func _on_outof_bounds_body_entered(body: Node2D) -> void:
	global_position = Vector2(54,420);


func _on_lava_body_entered(body: Node2D) -> void:
	hide();
	set_process_input(false);
	end_of_game.emit();


func _on_swimming_enemy_stomped() -> void:
	enemies_stomped += 1;
	velocity.y = JUMP_IMPULSE;
	print("Enemies stomped: " + str(enemies_stomped));
	add_to_score.emit();


func _on_win_box_body_entered(body: Node2D) -> void:
	victory.emit();
