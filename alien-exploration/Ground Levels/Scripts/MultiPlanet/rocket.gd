class_name Rocket
extends CharacterBody2D

## Contains the instance of the interatable scene
@onready var interactable: Interactable = $interactable


## The speed the rocket will ascend at
const SPEED = 10;

## Signal to run the takeoff section in the player script
signal takeoff;
## Signal for when the scene should change to outer space
signal space_scene;

## sets the interact to the launch function and hides the countdown label while setting the flames animations to idle
func _ready():
	interactable.interact = launch;
	$Flames.play("idle");
	$Flames2.play("idle");
	$Countdown.hide();

## Sends the rocketship upwards on a timer to prevent instantaneous movement
func launch() -> void:
	takeoff.emit();
	$Countdown.show();
	## Array that holds the countdown numbers
	var countdown = [5, 4, 3, 2, 1];
	
	for num in countdown:
		$Countdown.text = str("T-", num);
		print("T-", num);
		$LaunchTimer.start();
		await($LaunchTimer.timeout);
	$Countdown.hide();
	print("We have liftoff!");
	
	while(position.y > 0):
		$Flames.play("Takeoff");
		$Flames2.play("Takeoff");
		position.y -= SPEED;
		$FlyTimer.start();
		await($FlyTimer.timeout);

## When the rocket comes into contact with the Area2D collider it emits the signal to change scenes
func _on_change_scene_box_body_entered(_body: Node2D) -> void:
	print("Change box entered");
	space_scene.emit();
	print("Space Scene emitted");
