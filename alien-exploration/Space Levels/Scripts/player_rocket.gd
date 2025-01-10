class_name PlayerRocket
extends CharacterBody2D

## Contains the speed of the player rocket
const SPEED: float = 300.0

## Holds the direction to be compared to the mouse position to calculate velocity
var direction;
## Holds the player's mouse position
var mouse_position;

## Sets the physics process to true
func _ready() -> void:
	set_physics_process(true);

## Gets the global position of the mouse and tells the object to turn to it
func _process(delta: float) -> void:
	mouse_position = get_global_mouse_position();
	self.look_at(mouse_position);

## Checks the players input and accelerates or decelerates if a key is pressed or released
func _physics_process(delta: float) -> void:
	mouse_position = get_global_mouse_position();
	if(Input.is_action_pressed("up")):
		direction = (mouse_position - position).normalized();
		velocity = (direction * SPEED);
	elif(Input.is_action_just_released("up")):
		print(velocity);
		while(velocity.x != 0 or velocity.y != 0):
			if(velocity.x > 10):
				velocity.x -=10;
			elif(velocity.x < -10):
				velocity.x += 10;
			else:
				velocity.x = 0;
			if(velocity.y > 10):
				velocity.y -=10;
			elif(velocity.y < -10):
				velocity.y += 10;
			else:
				velocity.y = 0;
			$DecelerationTimer.start();
			await($DecelerationTimer.timeout);
	if(Input.is_action_pressed("down")):
		direction = (mouse_position - position).normalized();
		velocity = (direction * -SPEED);
	elif(Input.is_action_just_released("down")):
		print(velocity);
		while(velocity.x != 0 or velocity.y != 0):
			if(velocity.x > 10):
				velocity.x -=10;
			elif(velocity.x < -10):
				velocity.x += 10;
			else:
				velocity.x = 0;
			if(velocity.y > 10):
				velocity.y -=10;
			elif(velocity.y < -10):
				velocity.y += 10;
			else:
				velocity.y = 0;
			$DecelerationTimer.start();
			await($DecelerationTimer.timeout);
		
	move_and_slide();
